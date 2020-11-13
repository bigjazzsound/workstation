-- TODO - rather than create the table with the words and definitions, it would probably be smarter
-- to show the word, then fold the text where the definition is

-- flashcard plugin
local function make_flashcards()
  local cards = {}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, 0)
  local header = false
  for _, line in ipairs(lines) do
    if vim.startswith(line, "# ") then
      -- if the line is an h1 then discard it and all lines until an h2 or less
      header = true
    end
    if vim.startswith(line, "##") then
      table.insert(cards, {
        key = line,
        value = {}
      })
      header = false
    end
    if not vim.startswith(line, "##") and not header then
      table.insert(cards[#cards]["value"], line)
    end
  end

  return cards
end

local function study_flashcards(cards)
  for _, item in ipairs(cards) do
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {item["key"]})
    -- pretty the answer text to separate it from the question
    for _, val in pairs({"", "====================================================================================================", ""}) do
      table.insert(item["value"], 1, val)
    end
    vim.api.nvim_buf_set_var(buf, "answer", item["value"])
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", [[:lua vim.api.nvim_put(vim.b.answer, "l", "p", false)<CR>]], DEFAULT_KEYMAP)
    vim.api.nvim_buf_set_keymap(buf, "n", "n", ":bnext<CR>", DEFAULT_KEYMAP)
    vim.api.nvim_buf_set_keymap(buf, "n", "p", ":bprevious<CR>", DEFAULT_KEYMAP)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":quit<CR>", DEFAULT_KEYMAP)
  end

  vim.api.nvim_buf_delete(0, {})

  -- tally user score and show results
end

local cards = make_flashcards()
return study_flashcards(cards)
