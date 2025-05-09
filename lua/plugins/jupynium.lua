
-- jupynium.lua

-- Plugin setup using lazy.nvim
return {
    -- Jupynium plugin setup
    {
        "kiyoon/jupynium.nvim",
        config = function()
            -- Configure Jupynium here
            require('jupynium').setup({
                -- Jupyter kernel setup
                kernel = 'python3', -- Default kernel
                -- Specify the path to your python environment (optional)
                python_path = os.getenv("HOME") .. "/.virtualenvs/jupynium/bin/python", -- Optional: Use a virtualenv

                -- Custom build command, you can choose based on your environment
                build_cmd = "pip3 install --user .", -- You can adjust this if you use a different method (e.g., conda or uv)
            })
        end
    },

    -- Optional: nvim-notify for notifications
    {
        "rcarriga/nvim-notify",
        config = function()
            -- Set up nvim-notify
            require("notify").setup({
                stages = "fade",  -- Notification fade effect
                timeout = 1500,   -- Timeout for notifications (in milliseconds)
            })
        end
    },

    -- Optional: dressing.nvim for UI enhancements for kernel selection
    {
        "stevearc/dressing.nvim",
        config = function()
            -- Configure dressing.nvim for enhanced UI
            require('dressing').setup({
                input = { -- Customize input UI (like :JupyniumKernelSelect)
                    relative = 'editor',
                    border = 'single',
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                },
            })
        end
    }
}
