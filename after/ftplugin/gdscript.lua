vim.lsp.start({
  name = "godot",
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
  root_dir = vim.fs.root(0, { "project.godot", ".git" }),
  on_attach = function(_, _)
    print("Godot LSP connected")
  end,
})
