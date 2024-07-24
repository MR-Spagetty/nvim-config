return {
  projects_config_filepath = vim.fs.normalize(vim.fn.stdpath "data" .. "/cd-project.nvim.json"),
  project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
  choice_format = "both", -- optional, you can switch to "name" or "path"
  projects_picker = "telescope", -- optional, you can switch to `telescope`
  -- do whatever you like by hooks
  hooks = {
    {
      callback = function(dir)
        vim.notify("Switched to: " .. dir)
      end,
    },
  },
}
