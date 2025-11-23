" ------------------------------------------------------------------------
"define <leader> key
let mapleader=";"
" set theruntime path to include Vundle and initialize
set hidden
set autochdir
set clipboard^=unnamed " This sets the clipboard as the default register. Useful for copy paste from tmux

set nocompatible " This tells vim not to act like it predecessor vi
syntax enable " enables syntax highlighting
filetype plugin indent on    " identify the kind of filetype automatically

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ap/vim-buftabline'
Plugin 'tikhomirov/vim-glsl'
Plugin 'morhetz/gruvbox'
Plugin 'terryma/vim-multiple-cursors'
"u can use <C-n>to select the var with samename
"<C-x> to skip current var
"<C-p> move to previous var
"<A-n> sele all var with same name match current line
"<Esc> to escape
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tpope/vim-eunuch'
":Delete: Delete a buffer and the file on disk simultaneously.
":Unlink: Like :Delete, but keeps the now empty buffer.
":Move: Rename a buffer and the file on disk simultaneously.
":Rename: Like :Move, but relative to the current file's containing directory.
":Chmod: Change the permissions of the current file.
":Mkdir: Create a directory, defaulting to the parent of the current file.
":Cfind: Run find and load the results into the quickfix list.
":Clocate: Run locate and load the results into the quickfix list.
":Lfind/:Llocate: Like above, but use the location list.
":Wall: Write every open window. Handy for kicking off tools like guard.
":SudoWrite: Write a privileged file with sudo.
":SudoEdit: Edit a privileged file with sudo.
Plugin 'kien/ctrlp.vim'
Plugin 'python-mode/python-mode'
Plugin 'airblade/vim-gitgutter'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call vundle#end()            " required
"##################################
"gitgutter setting
let g:gitgutter_terminal_reports_focus = 0
let g:gitgutter_enable = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_async = 0
let g:gitgutter_max_signs = 500

"python-mode setting
let g:pymod_python = 'python'
let g:pymode = 1
let g:pymode_paths = ['/home/simileciwh/catkin_new/devel/lib/python2.7/dist-packages', '/home/simileciwh/ROS_Library/cartographer/install_isolated/lib/python2.7/dist-packages', '/home/simileciwh/catkin_ws/devel/lib/python2.7/dist-packages', '/opt/ros/melodic/lib/python2.7/dist-packages', '/usr/lib/python2.7', '/usr/lib/python2.7/plat-x86_64-linux-gnu', '/usr/lib/python2.7/lib-tk', '/usr/lib/python2.7/lib-old', '/usr/lib/python2.7/lib-dynload', '/home/simileciwh/.local/lib/python2.7/site-packages', '/usr/local/lib/python2.7/dist-packages', '/usr/lib/python2.7/dist-packages', '/usr/lib/python2.7/dist-packages/gtk-2.0', '/usr/lib/python2.7/dist-packages/wx-3.0-gtk3']
let g:pymode_options = 1
let g:pymode_options_colorcolumn = 1
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
"let g:pymode_virtualenv = 1
"run python with ";+r"
let g:pymode_run = 1
"bind keys of run 
let g:pymode_run_bind = '<leader>r'
" set breakpoin with ";+b"
let g:pymode_breakpoint = 1
"bind keys of breakpoint
let g:pymode_breakpoint_bind = '<leader>b'
" mannually set breakpoint cmd
let g:pymode_breakpoint_cmd = ''
" turn on code checking 
let g:pymode_lint = 1
"check code on every save if file has been modified
let g:pymode_link_on_write = 1
"check code when editing 
let g:pymode_lint_on_fly = 0
"show error message if cursor placed st the error line
let g:pymode_lint_message = 1
"default code checkers
let g:pymode_lint_checkers = ['pyflakes','pep8','mccabe']
"skip errors and warnings
"let g:pymode_lint_ignore = ["W"]
"go to definition with ";+g"
"let g:pymode_rope_goto_definition_bind = '<leader>g'
" turn on pymode syntax
let g:pymode_syntax = 1
"enable all python highlights
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 0
"turn on code completion support 
let g:pymode_rope_completion = 1
let g:pymode_rope_completion_on_dot = 1
"keymap for autocomplete
let g:pymode_rope_completion_bind = '<C-Space>'




"##################################
"ctrlp setting
"let g:ctrl_map = '<leader>p'
let g:ctrl_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)'

"---------------------------------------------------------------------
"POWERLINE SETTING
set rtp+=/home/simileciwh/.local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256
let g:Powerline_symbols= "fancy"
"---------------------------------------------------------------------
" prevent vim from giving a warning it the swp file is open 
set shortmess=A
"set foldmethod=syntax
au BufReadPost *.launch set syntax=html
set cursorline
set history=1000
set encoding=utf8
set ignorecase
set incsearch
set tabstop=4
set shiftwidth=4
set cursorline
set relativenumber
set nobackup
set nowritebackup
set noswapfile
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"cancel arrow keys to move 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

set virtualedit=onemore

" -----------------------------------------------------------------------------------------
"set laststatus=0
" -----------------------------------------------------------------------------------------
" This sets the color scheme
set background=dark
colorscheme gruvbox

" -----------------------------------------------------------------------------------------
" wrapping lines when arrows are pressed
set whichwrap+=<,>,h,l,[,]

" -----------------------------------------------------------------------------------------
" scrolling up and down multiple lines atonce
:nmap <c-j> +3
:vmap <c-j> +3
:nmap <c-k> -3
:vmap <c-k> -3
:nmap <c-Up> -3
:nmap <c-Down> +3 
:vmap <c-Up> -3
:nmap <c-Down> +3 

" -----------------------------------------------------------------------------------------
" autocomplete 
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/bundle/YouCompleteMe/ycm_extra_conf/.ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf = '$HOME/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
set backspace=indent,eol,start

" -----------------------------------------------------------------------------------------
" other editor settings
set number
set mouse=a
set tabstop=4
set shiftwidth=4

" setting indent markers-------------------------------------------------------------------
set listchars=tab:\|\ 
set list
" -----------------------------------------------------------------------------------------
" Nerd Tree file manager
let g:NERDTreeWinSize=60 
map <C-f> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1 " closes upon opening a file in nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" -----------------------------------------------------------------------------------------
" navigates to the next buffer
:nmap <c-n> :bnext<CR>
:nmap <c-b> :bprev<CR>
:ab Wq :wq
:ab W :w
:ab WQ :wq
:ab Q :q
:set guitablabel=%t  " show only the file name an not the path 
:au FocusLost * :wa  " save when focus is lost (not sure if this is working. Test)

" start the terminal in the given path by typing :t on the minibuffer
:ab t :!urxvt -bg black --geometry 85x47+683+0&\|<CR> 
" -----------------------------------------------------------------------------------------
"use sh to run load_multiple_robots.shuse sh to run load_multiple_robots.shuse sh to run load_multiple_robots.shuse sh to run load_multiple_robots.sh press // fuse sh to run load_multiple_robots.shor comment using nerd commenter
nmap // <leader>c<space>
vmap // <leader>c<space>

" -----------------------------------------------------------------------------------------
" toggling between insert, normal and visual mode upon triple key press
:imap vv <Esc>v
:nmap vv <Esc>v
:imap <c-l> <Esc>la
:nmap <c-l> e
:nmap <c-h> b
:nmap <C-Right> e
:imap <c-x><c-x> <Esc>:update<CR>\|<Esc>:!rxvt-unicode -bg black --geometry 85x47+683+0 -e sh -c "make && make run; bash"&<CR>\|<CR>  
:nmap <c-x><c-x> :update<CR>\|<Esc>:!rxvt-unicode -bg black --geometry 85x47+683+0 -e sh -c "make && make run; bash"&<CR>\|<CR>
":imap <c-x><c-x> <Esc>:update<CR>\|<Esc>:"make && make run"<CR>  
":nmap <c-x><c-x> :update<CR>\|<Esc>:"make && make run"<CR>
" ------------------------------------------------------------------------------
" UltiSnips stuff 
let g:UltiSnipsExpandTrigger = "<fn>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"
let g:UltiSnipsSnippetDirectories = ['/$HOME/config_files/nvim/UltiSnips', 'UltiSnips']
" -------------------------------------------------------------------------------
" latex stuff 
filetype plugin on
filetype indent on
let g:tex_flavor='latex'

" -------------------------------------------------------------------------------
"changes cursor color between insert mode and normal mode
if &term =~ "xterm\\|urxvt"
" use an orange cursor in insert mode
let &t_SI = "\<Esc>]12;green\x7"
" use a red cursor otherwise
let &t_EI = "\<Esc>]12;red\x7"
silent !echo -ne "\033]12;red\007"
" reset cursor when vim exits
autocmd VimLeave * silent !echo -ne "\033]112\007"
" use \003]12;gray\007 for gnome-terminal and urxvt up to version 9.21
endif

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
\ execute("normal `\"") |
\ endif

" add header comments for .h .c .hpp .cpp .mk .sh new file
" auto call SetTitle func
autocmd BufNewFile *.[ch],*.hpp,*.cpp,*.mk,*.sh,*.py exec ":call SetTitle()"
" add comment for cpp
func SetComment_ch()
	call setline(1,"/*================================================================")
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." * Ltd. All rights reserved.")
	call append(line(".")+1, "*   ")
	call append(line(".")+2, "*   File name   : ".expand("%:t"))
	call append(line(".")+3, "*   Author      : simileciWH")
	call append(line(".")+4, "*   Email       : simileci.wh.32@outlook.com")
	call append(line(".")+5, "*   Created date: ".strftime("%F %T"))
	call append(line(".")+6, "*   Description : code is far away from bugs with the god animal protecting")
	call append(line(".")+7, "*")
	call append(line(".")+8, "*===============================================================*/")
	call append(line(".")+9, "")
	call append(line(".")+10, "")
endfunc

func SetComment_sh()
	call setline(4,"#__Filename__ : ".expand("%:t"))
	call setline(5,"#__Auther__   : simileciwh")
	call setline(6,"#Email        : simileci.wh.32@outlook.com")
	call setline(7,"#Created date : ".strftime("%F %T"))
	call setline(8,"# code is far away from bugs with the god animal protecting")
	call setline(9,"#    I love animals. I have a lovely doggy!")
	call setline(10,"#              ┏┓     ┏┓")
	call setline(11,"#             ┏┛┻━━━━━┛┻┓")
	call setline(12,"#             ┃    ☃    ┃")
	call setline(13,"#             ┃  ┳┛  ┗┳ ┃")
	call setline(14,"#             ┃     ┻   ┃")
	call setline(15,"#             ┗━┓     ┏━┛")
	call setline(16,"#               ┃     ┗━━━┓")
	call setline(17,"#               ┃   神兽保佑  ┣┓")
	call setline(18,"#               ┃   永无BUG!   ┏┛")
	call setline(19,"#               ┗┓┓┏━━┳┓┏┛")
	call setline(20,"#                ┃┫┫  ┃┫┫")
	call setline(21,"#                ┗┻┛  ┗┻┛")
endfunc 

" SetTitle func, add comment
func SetTitle()
	if &filetype == 'make'
		call setline(1,"")
		call setline(2,"")
		call setline(3,"")
		call SetComment_sh()
		call setline(22,"")
		exe "normal G"

	elseif &filetype == 'sh'
		call setline(1,"#! /bin/bash")
	    call setline(2,"")
		call setline(3,"")
		call SetComment_sh()
		call setline(22,"")
        exe "normal G"
        
	elseif &filetype == 'python'
	    call setline(1,"#!/usr/bin/env python")
	    call setline(2,"#-*- coding: utf-8 -*-")
	    call setline(3,"\"\"\"")
		call SetComment_sh()
		call setline(22,"\"\"\"")
	    exe "normal G"

	else
		call SetComment_ch()
		if expand("%:e") == 'hpp'
			call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
			call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
			call append(line(".")+12, "#ifdef __cplusplus")
			call append(line(".")+13, "extern \"C\"")
			call append(line(".")+14, "{")
			call append(line(".")+15, "#endif")
			call append(line(".")+16, "")
			call append(line(".")+17, "#ifdef __cplusplus")
			call append(line(".")+18, "}")
			call append(line(".")+19, "#endif")
			call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

		elseif expand("%:e") == 'h'
			call append(line(".")+10, "#pragma once")

		elseif &filetype == 'c'
			call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")

		elseif &filetype == 'cpp'
			call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")

		endif

	endif
endfunc
