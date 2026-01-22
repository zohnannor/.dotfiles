call plug#begin('~/.vim/plugged')

set nocompatible              " be iMproved, required
filetype off                  " required

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
" Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'jiangmiao/auto-pairs'
autocmd FileType rust let b:AutoPairs = AutoPairsDefine({'<': '>'})  " Adding < > pairs
let g:AutoPairsMultilineClose = 0  " Do not remove whitespaces between quotes if they are on the different lines and the first one is closed

Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'beauwilliams/focus.nvim'
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" colorschemes
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required


colorscheme material
let g:lightline = { 'colorscheme': 'material_vim' }
let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1

set encoding=utf-8                " Set encoding
scriptencoding utf-8

" set cc=80                         " 80th column is filled
set number                        " Line numbers on the left
set nowrap                        " No word wrap
" Changed only insert mode cursor shape (you need to specify cursor shape for every mode)
set guicursor=v-c-sm:block,i-ci-ve:ver25,n-r-cr-o:hor20
set tabstop=4                     " Tabs will look like 4 spaces
set shiftwidth=4                  " 4 spaces for non-TAB indent
set softtabstop=4                 " <Tab> will place spaces to this value
set expandtab                     " 4 spaces instead of <Tab>
set previewheight=5               "  Make preview window small
set lazyredraw                    " Don't redraw screen while running macros
set scrolloff=5                   " Don't let the cursor to go too close to the first or last line
set numberwidth=4                 " The width of the number column
" Highlight trailing whitespaces (88 is dark red)
set relativenumber                " Relative line numbers 
set cursorline                    " Highlight current line

" set fillchars+=vert:\             " Don't show pipes in vertical splits
set grepprg=rg\ --color=never     " Use ripgrep as grep tool
set backspace=indent,eol,start    " Backspace over everything in insert mode
set hidden                        " Don't unload buffers when leaving them

syntax on
set cindent
set smarttab
set smartindent

set noshowmode
set laststatus=2                  " Always show the status line
set linebreak                     " Don't break lines in the middle of words
" Doesn't work for some reason:
set listchars=tab:▸\
set listchars+=extends:❯
set listchars+=nbsp:␣
set listchars+=precedes:❮
set listchars+=trail:·
set list                          " Show some more characters

set hlsearch
set incsearch
set termguicolors

" Mappings

" True Vim Mode!!!!!!!!!!!!!!!!!
" Except those 2, or instead mouse would not work :(
" noremap <Left> <Nop>
" noremap <Down> <Nop>
" noremap <Right> <Nop>
" noremap <Up> <Nop>

" Disable Ex mode key
noremap Q <Nop>

" Make Y work as "yank to the end of line"
nnoremap Y y$

" In the case of linewrap, make k/j work as expected
nnoremap j gj
nnoremap k gk

" Save on ctrl-s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Save file with sudo by doing :w!!
cmap w!! w !sudo tee % >/dev/null;

" source this file
noremap <silent> <C-r> <Esc>:source ~/.config/nvim/init.vim<CR>

" To copy/paste from VIM to the clipboard
vnoremap <silent> <C-c> "+y
vnoremap <silent> <C-x> "+d
inoremap <silent> <C-v> <Esc>:set paste<CR>i<C-R>+<Esc>:set nopaste<CR>i

map <Space> <Nop>
let mapleader="\<Space>"

" Quickly insert semicolon at end of line
noremap <leader>; maA;<esc>`a

" Quickly insert comma at end of line
noremap <leader>, maA,<esc>`a

" Select all using Ctrl + A
noremap <silent> <C-a> <esc>ggVG

" (Un)comment on ctrl-/
nnoremap <silent> <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap <silent> <C-_> :call nerdcommenter#Comment('x', 'toggle')<CR>

lua << EOF
local lspconfig = require('lspconfig')

require('rust-tools').setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
  },
  server = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          autoreload = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          overrideCommand = {
              "cargo",
              "clippy",
              "--message-format=json",
              "--",
              "-W",
              "clippy::all",
              "-W",
              "clippy::pedantic",
              "-W",
              "clippy::nursery",
              "-W",
              "clippy::cargo",
              "-W",
              "rustdoc::all",
              "--target-dir",
              "~/.local/rust-analyzer-target-dir",
          },
          -- command = "clippy",
          enable = true,
        },
        completion = {
          autoimport = {
            enable = true,
          },
        },
        diagnostics = {
          disabled = {"macro-error"},
        },
        inlayHints = {
          chainingHints = true,
          chainingHintsSeparator = "‣ ",
          enable = true,
          typeHints = true,
          typeHintsSeparator = "‣ ",
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}


EOF


colorscheme material " idk why it does not apply without this
