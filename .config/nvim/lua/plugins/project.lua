return {
  "ahmedkhalf/project.nvim",
  opts = {
    manual_mode = true,
    detection_methods = { "pattern" },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = { ".git", "package-lock.json", "yarn.lock", "lazy-lock.json" },
  },
}
