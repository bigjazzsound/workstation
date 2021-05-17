-- TODO - still testing this
-- local jira_auth = os.getenv("JIRA_USER")..':'..os.getenv("JIRA_PASSWORD")
local jira_url = os.getenv "JIRA_URL"

-- local spec = {}

-- local curl = {
--   flags = {'-s', '-u', jira_auth },
--   auth = { '-H', 'Content-Type: application/json' },
--   headers = {},
--   data = {},
-- }

-- spec.base = {
--   'curl', '-s', '-X', 'POST',
--   '-u', jira_auth,
--   '-H', 'Content-Type: application/json',
--   '--data', vim.fn.json_encode({
--     jql = 'project = "SYS" AND status in ("Open")',
--     maxResults = 100,
--     fields = {"summary", "status", "creator", "issuetype", "project", "description", "comment"},
--   }),
--   string.format('%s/rest/api/latest/search', jira_url),
-- }

local daedalus = require "daedalus"
local specs = require "daedalus.specs"
local helpers = require "daedalus.helpers"

local spec = specs.define {
  ["*"] = {
    url = jira_url,
    auth_basic = helpers.auth.basic("$JIRA_USER", "$JIRA_PASSWORD"),
    headers = {
      ["Content-Type"] = "application/json",
    },
    handler = function(value)
      return value
    end,
    method = "post",
  },
  list_open = {
    path = "/rest/api/latest/search",
    payload = {
      jql = 'project = "SYS" AND status in ("Open")',
      maxResults = "100",
      fields = { "summary", "status", "creator", "issuetype", "project", "description" },
    },
  },
  -- issues = {
  --   path = "/issues",
  --   handler = issues_handler -- you can override global definitions per-api route
  -- },
  -- create_issue = {
  --   path = "/repos/${owner}/${repo}/issues",
  --   method = "post",
  -- }
}

local client = daedalus.make_client(spec)

return client
