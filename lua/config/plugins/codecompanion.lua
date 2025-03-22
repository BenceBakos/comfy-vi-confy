local M = {}

-- Define key mapping constant
vim.g.key_codecompanion_prompt = '<space>aa'

function M.setup()
  require("codecompanion").setup({
    popup_input = {
      prompt = "🤖 ",
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    chat = {
      welcome_message = "Welcome to CodeCompanion! I have access to your current buffer context.",
      question_header = "## Question",
      answer_header = "## Answer",
    },
    llms = {
      anthropic = {
        model = "claude-3-sonnet-20240229",
      },
    },
    context = {
      strategy = "buffer", -- Always use current buffer as context
    },
    actions = {
      -- Enable automatic file writing when prompted to change file content
      auto_execute = true,
      -- Keep explanations short when changing files
      short_explanations = true,
      auto_review = true,
    },
    workflows = {
      tdd = {
        name = "TDD Workflow",
        description = "A TDD workflow to develop features based on specifications",
        prompt = [[
You're an expert software developer tasked with implementing features using Test-Driven Development (TDD).

Read the specifications I provide, then follow this process:
1. WRITE TESTS: Create comprehensive tests that validate the specifications
2. CONFIRM TESTS: Ensure the tests are complete and accurate before proceeding
3. IMPLEMENT FEATURES: Write the minimal code needed to make the tests pass
4. REFACTOR: Improve the code while maintaining passing tests
5. ITERATE: Continue this cycle until all specifications are met

When I provide specifications:
- Analyze them thoroughly 
- Write clear, focused tests that verify each requirement
- Check if the tests are good before implementing
- Write the simplest implementation that passes the tests
- Run the tests to verify your implementation
- Refactor as needed while keeping tests passing

You can execute commands to run tests and check functionality.
Keep explanations brief and focused on the development process.
        ]],
      },
    },
  })
end

return M