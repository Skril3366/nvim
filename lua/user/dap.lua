-------------------------------------------------------------------------------
------------------- Debugging Adapter Protocol configuration  -----------------
-------------- see https://github.com/mfussenegger/nvim-dap -------------------
-------------------------------------------------------------------------------

local ok, dap = pcall(require, 'dap')
if not ok then
    print("DAP failed to run")
    return
end

-------------------------------------------------------------------------------
----------------------- UI configuration and enhancements  --------------------
-------------- see https://github.com/rcarriga/nvim-dap-ui --------------------
-------------- and https://github.com/theHamsta/nvim-dap-virtual-text ---------
-------------------------------------------------------------------------------

-- Virtual text displayed on top of the code
local ok, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not ok then
    print("Dap Virtual Text failed to run")
    return
end

dap_virtual_text.setup({})

-- Pretty UI for DAP
local ok, dapui = pcall(require, 'dapui')
if not ok then
    print("DapUI failed to run")
    return
end

dapui.setup({})

-- Automatically open and close dapui when called
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

-------------------------------------------------------------------------------
----------------------- Language specific configurations  ---------------------
-------------------------------------------------------------------------------

-- Scala
dap.configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "Run",
        metals = {
            runType = "run",
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test File",
        metals = {
            runType = "testFile",
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
            runType = "testTarget",
        },
    },
}

-- Rust, C++ and C
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/opt/llvm/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Go lang
local ok, dap_go = pcall(require, 'dap-go')
if not ok then
    print("DapGo failed to run")
    return
end
dap_go.setup()
