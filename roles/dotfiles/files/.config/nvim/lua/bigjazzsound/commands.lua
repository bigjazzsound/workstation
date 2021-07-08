local M = {}
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local jira_auth = function()
  local user = os.getenv "JIRA_USER" or nil
  local pass = os.getenv "JIRA_PASSWORD" or nil
  if user and pass then
    return user .. ":" .. pass
  else
    return
  end
end

local jira_url = os.getenv "JIRA_URL" or nil

M.git_po = function()
  local job = require "plenary.job"
  local output = {}
  job
    :new({
      command = "git",
      args = { "po" },
      on_stderr = function(_, line)
        table.insert(output, line)
      end,
      on_stdout = function(_, line)
        table.insert(output, line)
      end,
    })
    :sync()

  return output
end

M.terraform_validate = function()
  local job = require "plenary.job"
  local output = job:new({ "terraform", "validate", "-json" }):sync()

  local json = vim.fn.json_decode(output)

  if json.valid == false then
    local qflist = {}
    local type = {
      error = "E",
      warning = "W",
    }
    for _, diagnostic in ipairs(json.diagnostics) do
      table.insert(qflist, {
        filename = diagnostic.range.filename,
        lnum = diagnostic.range.start.line,
        col = diagnostic.range.start.column,
        text = diagnostic.detail,
        type = type[diagnostic.severity],
      })
    end
    vim.fn.setqflist(qflist, "r")
    vim.cmd [[lua require "telescope.builtin".quickfix()]]
  else
    print "No errors or warnings detected"
    vim.fn.setqflist({}, "r")
  end
end

M.open_win = function(text)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local width = vim.api.nvim_get_option "columns"
  local height = vim.api.nvim_get_option "lines"
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  local longest = 0
  for _, line in pairs(text) do
    if #line > longest then
      longest = #line
    end
  end
  local win = vim.api.nvim_open_win(bufnr, false, {
    relative = "editor",
    style = "minimal",
    width = longest + 5,
    height = #text + 5,
    row = height - 5,
    col = width - 3,
    anchor = "SE",
    focusable = false,
  })
  vim.api.nvim_buf_set_lines(bufnr, 0, #text, false, text)
  vim.defer_fn(function()
    vim.api.nvim_win_close(win, false)
  end, 3000)
end

M.query_todoist = function()
  local api_key = os.getenv "TODOIST_API_KEY"
  local job = require("plenary.job")
    :new({
      command = "curl",
      args = {
        "-s",
        "-X",
        "GET",
        "-H",
        "Authorization: Bearer " .. api_key,
        "https://api.todoist.com/rest/v1/tasks?filter=today",
      },
    })
    :sync()

  local nodate = {}
  local tasks = {}
  local timediff = 4
  for _, task in pairs(vim.fn.json_decode(job)) do
    if task.due.datetime then
      local _, _, _, hour, minute, _ = task.due.datetime:match "^(%d%d%d%d)-(%d%d)-(%d%d)T(%d%d):(%d%d):(%d%d)Z"
      if tonumber(hour) < 12 then
        if tonumber(hour) < timediff then
          task.hour = tonumber(hour) + 12 - timediff
          task.meridian = "PM"
        else
          task.hour = tonumber(hour) - timediff
          task.meridian = "AM"
        end
      else
        task.hour = tonumber(hour) - 12 - timediff
        task.meridian = "PM"
      end
      task.minute = minute
      table.insert(tasks, task)
    else
      task.hour = 24
      task.minute = 0
      table.insert(nodate, task)
    end
  end
  table.sort(tasks, function(a, b)
    return a.due.datetime < b.due.datetime
  end)

  for _, value in pairs(nodate) do
    value.meridian = "PM"
    table.insert(tasks, value)
  end

  pickers
    :new({
      results_title = "Tasks",
      finder = finders.new_table {
        results = tasks,
        entry_maker = function(entry)
          return {
            display = string.format("[%02d:%02d%s] %s", entry.hour, entry.minute, entry.meridian, entry.content),
            value = entry.content,
            ordinal = entry.content,
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
    })
    :find()
end

M.query_open = function()
  local output = require("plenary.job")
    :new({
      "curl",
      "-s",
      "-X",
      "POST",
      "-u",
      jira_auth,
      "-H",
      "Content-Type: application/json",
      "--data",
      vim.fn.json_encode {
        jql = 'project = "SYS" AND status in ("Open")',
        maxResults = 100,
        fields = { "summary", "status", "creator", "issuetype", "project", "description", "comment" },
      },
      string.format("%s/rest/api/latest/search", jira_url),
    })
    :sync()

  pickers
    :new({
      results_title = "Open issues",
      finder = finders.new_table {
        results = vim.fn.json_decode(output).issues,
        entry_maker = function(entry)
          local value = string.format("[%s] %s", entry.key, entry.fields.summary)
          local separator = "--------------------------------------------------------------------------------"
          local preview = {
            "Creator: " .. entry.fields.creator.displayName,
            "Status: " .. entry.fields.status.statusCategory.name,
            "Resolution: " .. entry.fields.status.name,
            "Description:",
            "",
          }

          for _, line in ipairs(vim.split(entry.fields.description, "\n")) do
            table.insert(preview, line)
          end

          table.insert(preview, "")

          for _, comment in ipairs(entry.fields.comment.comments) do
            table.insert(preview, separator)
            table.insert(preview, "")
            table.insert(preview, comment.author.displayName .. ":")
            table.insert(preview, "")
            for _, line in ipairs(vim.split(comment.body, "\n")) do
              table.insert(preview, line)
            end
            table.insert(preview, "")
          end

          table.insert(preview, separator)

          return {
            display = value,
            value = entry.key,
            ordinal = value,
            description = entry.fields.description,
            preview = preview,
            id = entry.key,
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry, status)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, entry.preview)
        end,
      },
    })
    :find()
end

M.query_jira = function()
  local output = require("plenary.job")
    :new({
      command = "curl",
      args = {
        "-s",
        "-X",
        "POST",
        "-u",
        os.getenv "JIRA_USER" .. ":" .. os.getenv "JIRA_PASSWORD",
        "-H",
        "Content-Type: application/json",
        "--data",
        vim.fn.json_encode {
          jql = 'assignee = currentUser() AND status in ("In Progress", "Selected for Development", "TO DO", Review)',
          maxResults = 100,
          fields = { "summary", "status", "creator", "issuetype", "project", "description" },
        },
        string.format("%s/rest/api/latest/search", jira_url),
      },
    })
    :sync()

  local json = vim.fn.json_decode(output)

  local open_issue_in_browser = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    os.execute(string.format(
      "%s %s/browse/%s",
      (function()
        if vim.fn.has "mac" == 1 then
          return "open"
        else
          return "xdg-open"
        end
      end)(),
      jira_url,
      entry.id
    ))
  end

  local assign = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    local output = require("plenary.job")
      :new({
        command = "curl",
        args = {
          "-v",
          "-s",
          "-o",
          "/dev/null",
          "-s",
          "-X",
          "PUT",
          "-u",
          os.getenv "JIRA_USER" .. ":" .. os.getenv "JIRA_PASSWORD",
          "-H",
          "Content-Type: application/json",
          "--data",
          vim.fn.json_encode {
            fields = {
              assignee = {
                name = "craig.fielder",
              },
            },
          },
          string.format("%s/rest/api/latest/issue/%s", jira_url, entry.id),
        },
      })
      :sync()
    P(output)
  end

  local transition = {}
  transition.todo = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    local output = require("plenary.job")
      :new({
        command = "curl",
        args = {
          "-s",
          "-X",
          "POST",
          "-u",
          os.getenv "JIRA_USER" .. ":" .. os.getenv "JIRA_PASSWORD",
          "-H",
          "Content-Type: application/json",
          "--data",
          vim.fn.json_encode {
            transition = {
              id = "121",
            },
            fields = {
              assignee = {
                name = "craig.fielder",
              },
            },
          },
          string.format("%s/rest/api/latest/issue/%s/transitions", jira_url, entry.id),
        },
      })
      :sync()
  end

  local jira = {}

  jira.open_comments = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local current_entry = action_state.get_selected_entry()
    local get_comments = function()
      local output = require("plenary.job")
        :new({
          "curl",
          "-s",
          "-X",
          "GET",
          "-u",
          jira_auth,
          "-H",
          "Content-Type: application/json",
          string.format("%s/rest/api/latest/issue/%s/comment", jira_url, current_entry.id),
        })
        :sync()

      return vim.fn.json_decode(output)
    end

    local comments = get_comments()

    pickers
      :new({
        results_title = "Comments for " .. current_entry.id,
        finder = finders.new_table {
          results = comments.comments,
          entry_maker = function(entry)
            return {
              display = entry.author.displayName,
              value = entry.author.displayName,
              ordinal = entry.author.displayName,
              body = entry.body,
            }
          end,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        previewer = previewers.new_buffer_previewer {
          define_preview = function(self, entry)
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.split(entry.body, "\n"))
          end,
        },
      })
      :find()
  end

  pickers
    :new({
      results_title = "My issues",
      finder = finders.new_table {
        results = vim.fn.json_decode(output).issues,
        entry_maker = function(entry)
          local value = string.format("[%s] %s", entry.key, entry.fields.summary)
          local preview = {
            "Creator: " .. entry.fields.creator.displayName,
            "Status: " .. entry.fields.status.statusCategory.name,
            "Resolution: " .. entry.fields.status.name,
            "Description:",
            "",
          }

          for _, line in ipairs(vim.split(entry.fields.description, "\n")) do
            table.insert(preview, line)
          end

          table.insert(preview, "")

          return {
            display = value,
            value = entry.key,
            ordinal = value,
            description = entry.fields.description,
            preview = preview,
            id = entry.key,
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry, status)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, entry.preview)
        end,
      },
      attach_mappings = function(_, map)
        map("i", "<C-o>", open_issue_in_browser)
        map("n", "<C-o>", open_issue_in_browser)
        map("i", "<C-y>", transition.todo)
        map("n", "<C-y>", transition.todo)
        map("i", "<C-a>", assign)
        map("n", "<C-a>", assign)
        map("i", "<CR>", jira.open_comments)
        map("n", "<CR>", jira.open_comments)
        return true
      end,
    })
    :find()
end

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

-- TODO - figure out how to consistently get authenticated with the Spotify API
-- https://accounts.spotify.com/en/authorize?client_id=d94e23075223431db646be5712b49f46&redirect_uri=http:%2F%2Fcraigjamesfielder.com%2F&response_type=code&scope=user-read-currently-playing
-- curl -d client_id="${SPOTIFY_CLIENT_ID}" -d client_secret="${SPOTIFY_CLIENT_SECRET}" -d grant_type=authorization_code -d code="${SPOTIFY_CODE}" -d redirect_uri="http://craigjamesfielder.com/" https://accounts.spotify.com/api/token
-- .access_token

local get_spotify_token = function()
  local client_id = os.getenv "SPOTIFY_CLIENT_ID"
  local client_secret = os.getenv "SPOTIFY_CLIENT_SECRET"
  local output = require("plenary.job")
    :new({
      command = "curl",
      args = {
        "-s",
        "-X",
        "POST",
        "-d",
        "client_id=" .. client_id,
        "-d",
        "client_secret=" .. client_secret,
        "-d",
        "grant_type=client_credentials",
        "https://accounts.spotify.com/api/token",
      },
    })
    :sync()

  local json = vim.fn.json_decode(output)

  return json.access_token
end

M.query_spotify = function()
  -- TODO - error handling
  -- Do a primary request to get what is playing
  local token = os.getenv "SPOTIFY_ACCESS_TOKEN"
  local current_track = require("plenary.job")
    :new({
      command = "curl",
      args = {
        "-s",
        "-X",
        "GET",
        "-H",
        "Content-Type: application/json",
        "-H",
        "Authorization: Bearer " .. token,
        "https://api.spotify.com/v1/me/player/currently-playing?market=US",
      },
    })
    :sync()

  local track_context = vim.fn.json_decode(current_track).context.href

  -- Do a secondary request to get the album or playlist of the current track
  local output = require("plenary.job")
    :new({
      command = "curl",
      args = {
        "-s",
        "-X",
        "GET",
        "-H",
        "Content-Type: application/json",
        "-H",
        "Authorization: Bearer " .. token,
        track_context .. "?market=US",
      },
    })
    :sync()

  local json = vim.fn.json_decode(output)
  -- P(json)

  local source = function(source)
    local tracks = {}
    if source.type == "playlist" then
      for _, track in ipairs(source.tracks.items) do
        table.insert(tracks, {
          name = track.track.name,
          artist = track.track.artists[1].name,
          duration = {
            minutes = math.floor(track.track.duration_ms / 60000),
            seconds = math.floor(track.track.duration_ms / 1000 % 60),
          },
          album = track.track.album.name,
        })
      end
    else
      string.format("%s - %s", json.artists[1].name, json.name)
      for _, track in ipairs(source.tracks.items) do
        table.insert(tracks, {
          name = track.track.name,
          duration = {
            minutes = math.floor(track.track.duration_ms / 60000),
            seconds = math.floor(track.track.duration_ms / 1000 % 60),
          },
          album = track.track.album.name,
        })
      end
    end
    return tracks
  end

  local current = source(json)

  -- TODO make this play the selected track
  local foo = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    -- TODO - play the track
    print(entry.value)
  end

  -- P(source(json))

  -- TODO - this handles albums. I'm not sure how if it will work with a playlist
  -- TODO - split entry by album, track length, etc. Ex. https://github.com/nvim-telescope/telescope.nvim/pull/754/files
  pickers
    :new({
      results_title = "Tracks",
      finder = finders.new_table {
        results = current,
        entry_maker = function(entry)
          -- local display = string.format("[%02d] %s [%02d:%02d]", entry.track_number, entry.name, minutes, seconds)
          local display = string.format("%s [%02d:%02d]", entry.name, entry.duration.minutes, entry.duration.seconds)
          return {
            display = display,
            value = display,
            ordinal = display,
            href = entry.href,
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(_, map)
        map("i", "<CR>", foo)
        map("n", "<CR>", foo)
        return true
      end,
    })
    :find()
end

return M
