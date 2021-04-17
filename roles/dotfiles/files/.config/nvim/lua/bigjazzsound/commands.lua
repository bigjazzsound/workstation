local M = {}

M.git_po = function()
  local job = require('plenary.job')
  local output = {}
  job:new({
    command = 'git',
    args = { 'po' },
    on_stderr = function(_, line)
      table.insert(output, line)
    end,
    on_stdout = function(_, line)
      table.insert(output, line)
    end,
  }):sync()

  return output
end

M.terraform_validate = function()
  local job = require('plenary.job')
  local output = job:new({'terraform', 'validate', '-json' }):sync()

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
    vim.fn.setqflist(qflist, 'r')
    print(string.format("%d errors or warnings detected", #qflist))
  else
    print("No errors or warnings detected")
    vim.fn.setqflist({}, 'r')
  end

end

M.open_win = function(text)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
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

-- TODO - figure out how to consistently get authenticated with the Spotify API
-- https://accounts.spotify.com/en/authorize?client_id=d94e23075223431db646be5712b49f46&redirect_uri=http:%2F%2Fcraigjamesfielder.com%2F&response_type=code&scope=user-read-currently-playing
-- curl -d client_id="${SPOTIFY_CLIENT_ID}" -d client_secret="${SPOTIFY_CLIENT_SECRET}" -d grant_type=authorization_code -d code="${SPOTIFY_CODE}" -d redirect_uri="http://craigjamesfielder.com/" https://accounts.spotify.com/api/token
-- .access_token

local get_spotify_token = function()
  local client_id = os.getenv("SPOTIFY_CLIENT_ID")
  local client_secret = os.getenv("SPOTIFY_CLIENT_SECRET")
  local output = require('plenary.job'):new {
    command = 'curl',
    args = {
      '-s', '-X', 'POST',
      '-d', 'client_id='..client_id,
      '-d', 'client_secret='..client_secret,
      '-d', 'grant_type=client_credentials',
      "https://accounts.spotify.com/api/token"
    },
  }:sync()

  local json = vim.fn.json_decode(output)

  return json.access_token
end

M.query_spotify = function()
  -- TODO - error handling
  -- Do a primary request to get what is playing
  local token = os.getenv("SPOTIFY_ACCESS_TOKEN")
  local current_track = require('plenary.job'):new {
    command = 'curl',
    args = {
      '-s', '-X', 'GET',
      '-H', 'Content-Type: application/json',
      '-H', 'Authorization: Bearer '..token,
      "https://api.spotify.com/v1/me/player/currently-playing?market=US"
    },
  }:sync()

  local track_context = vim.fn.json_decode(current_track).context.href

  -- Do a secondary request to get the album or playlist of the current track
  local output = require('plenary.job'):new {
    command = 'curl',
    args = {
      '-s', '-X', 'GET',
      '-H', 'Content-Type: application/json',
      '-H', 'Authorization: Bearer '..token,
      track_context.."?market=US"
    },
  }:sync()

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
  pickers:new {
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
      end
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', foo)
      map('n', '<CR>', foo)
      return true
    end
  }:find()
end

return M
