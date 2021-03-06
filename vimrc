" .vimrc - jeanluc chasseriau
"
" TODO:
" - using <leader>:
"   - proper binding for switching tabs
"   - bind :tabnew
" - find how to have addons managed 'a la' addons-manager outside of its directory
" - checkout vim-scala from hubert, which is forked from derek wyatt
"   https://github.com/behaghel/vim-scala
" - fork vim-addon-known-repository

" General
" ---------------------------------------------------------
" ---------------------------------------------------------
" ---------------------------------------------------------

" vim only
set nocompatible 

" enable filetype, plugin and syntax support {{{1
" This means 
filetype indent plugin on | syn on

" allow buffers to go in background without saving etc.
set hidden

" backspace
" same as :set bs=2
set backspace=indent,eol,start

" wrapp!
set wrap

" set tabspace and space word
" use :retab to reformat tab
set expandtab
set ts=2
set sw=2

" line number
set nu
" auto-indent
set ai
" scrolloffset: minimum 5 lines visible above and below the cursor
set scrolloff=5
" abreviate messages to minimum
set shortmess=at

" statusline
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%(%F%m%r%)\ %=\ %([l:%l/%L\ c:%v\ o:%o]%)\ %([%p%%]%)
"set statusline+=%{fugitive#statusline()}
set statusline=%(%F%m%r%)\ %=\ %{fugitive#statusline()}\ %([l:%l/%L\ c:%v\ o:%o]%)\ %([%p%%]%)
set laststatus=2

set ruler

" highlight search
set hls

" spell checking
set spelllang=en_gb
set spellfile=~/.vim/spell/spell.en.utf-8.add

" spell check in mutt
" for event BufNewFile,BufRead, opening a file in directory, set ...
" use /var/folders/+0 -> macosx /tmp/mutt* -> linux?
autocmd BufNewFile,BufRead /var/folders/+O/* setfiletype mail
autocmd BufNewFile,BufRead /var/folders/+O/* set autoindent expandtab textwidth=110 spell

" syntax & color

" terminal color = 256 or 88 ?
set t_Co=256

set cursorline

" Avoid beeping when ESC is pressed
set visualbell

" Avoid vim to redrawing screen during complex operations: smoother experience
set lazyredraw

" Plugin/Context specific
" ---------------------------------------------------------
" ---------------------------------------------------------
" ---------------------------------------------------------

" myaddons
" let myaddon_scala_path = expand('$HOME') . '/.vim/myaddons/scala'
" exec 'set runtimepath+='.myaddon_scala_path

" CommandT (may be more generic)
set wildignore+=*/target/*,*.o,*.obj,.git,*.class,*.jar,*.jpg,*.png,*.gif,*.csym,.idea

" limit width to 120 and force new line (very annoying!)
" set textwidth=120
" display a column of color
" set colorcolumn=132
" hi ColorColumn ctermbg=darkcyan

" TheNERDTree
let NERDTreeWinSize=50

" Key mapping
" ---------------------------------------------------------
" ---------------------------------------------------------
" ---------------------------------------------------------

let mapleader=","

" tabs shortcuts (move to next/prev tab)
" :tabnew -> new tab
noremap <leader>p :tabp<CR>
noremap <leader>n :tabn<CR>

noremap <leader>d :NERDTreeToggle<CR>

" command windows shortcuts (move to next/prev error in command window (copen))
" :copen -> new command/search window
" map <C-e>n :cnext<CR>
" map <C-e>p :cprev<CR>

" buffers shortcuts (move to next/prev buffer)
" map <C-k> :bprevious<CR>
" map <C-l> :bnext<CR>

" foreign plugins tlib {{{1

" this is from tlib. I highly recommend having a look at that library.
" Eg its plugin tmru (most recently used files) provides the command
" TRecentlyUsedFiles you can map to easily:
noremap <leader>r :TRecentlyUsedFiles<cr>

" simple glob open based on tlib's List function (similar to TCommand or fuzzy
" plugin etc)
noremap <leader>go :exec 'e '. fnameescape(tlib#input#List('s','select file', split(glob(input('glob pattern, curr dir:','**/*')),"\n") ))<cr>


" gitv plugin
" ---------------------------------------------------------
nmap <leader>gV :Gitv --all<cr>
nmap <leader>gv :Gitv! --all<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gs :Gstatus<cr>
"vmap <leader>gV :Gitv! --all<cr>

cabbrev git Git

" Plugins
" ---------------------------------------------------------
" ---------------------------------------------------------
" ---------------------------------------------------------

" Vim Addons Manager
" https://github.com/MarcWeber/vim-addon-manager

fun SetupVAM()
	" YES, you can customize this vam_install_path path and everything still works!
	let vam_install_path = expand('$HOME') . '/.vim/addons'
	exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

	" * unix based os users may want to use this code checking out VAM
	" * windows users want to use http://mawercer.de/~marc/vam/index.php
	"   to fetch VAM, VAM-known-repositories and the listed plugins
	"   without having to install curl, unzip, git tool chain first
	" -> BUG [4] (git-less installation)
	if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
		" I'm sorry having to add this reminder. Eventually it'll pay off.
		call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
		exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
		" VAM run helptags automatically if you install or update plugins
		exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
	endif

	" Example drop git sources unless git is in PATH. Same plugins can
	" be installed form www.vim.org. Lookup MergeSources to get more control
	" let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  let g:vim_addon_manager = {}
  let g:vim_addon_manager.plugin_sources = {}
  let g:vim_addon_manager.plugin_sources['envim'] = {"type": "git", "url": "git://github.com/jlc/envim.git", "branch" : "master"}
  let g:vim_addon_manager.plugin_sources['ensime'] = {"type": "git", "url": "git://github.com/aemoncannon/ensime.git", "branch" : "scala-2.9"}
  let g:vim_addon_manager.plugin_sources['ensime-common'] = {"type": "git", "url": "git://github.com/jlc/ensime-common.git", "branch" : "master"}
  let g:vim_addon_manager.plugin_sources['vim-async-beans'] = {"type": "git", "url": "git://github.com/jlc/vim-async-beans.git", "branch" : "master"}
  let g:vim_addon_manager.plugin_sources['vim-addon-async'] = {"type": "git", "url": "git://github.com/jlc/vim-addon-async.git", "branch" : "master"}
  let g:vim_addon_manager.plugin_sources['vim-scala-behaghel'] = {'type': 'git', 'url': 'git://github.com/behaghel/vim-scala.git'}
  
	let plugins = [
    \ 'tlib', 'tmru', 'Decho', 'gnupg%3645',
    \ 'fugitive', 'gitv', 'Command-T',
    \ 'The_NERD_Commenter',
    \ 'The_NERD_tree',
    \ 'Solarized',
    \ 'ctrlp',
    \ 'vim-scala-behaghel',
    \ ]

    " \ 'envim',
    " \ 'vim-async-beans',
    " \ 'vim-addon-async',
    " \ 'rainbow_parentheses',
    " \ 'snipmate', 'snipmate-snippets',
    " 'envim'
    " 'vim-addon-mw-utils', 
    " 'vim-addon-signs',  'vim-addon-completion', 'vim-addon-json-encoding', 

	call vam#ActivateAddons(plugins,{'auto_install' : 0})

	" call vam#ActivateAddons(['tlib', 'tmru', 'Decho', 'gnupg3645', 'fugitive', 'gitv', 'Command-T', 'rainbow_parentheses', 'vim-addon-mw-utils', 'snipmate', 'snipmate-snippets', 'vim-addon-signs', 'vim-addon-async', 'vim-addon-completion', 'vim-addon-json-encoding', 'vim-scala-behaghel', 'ensime', 'ensime-common', 'envim'],{'auto_install' : 0})

    " with vim-addon-scala
	" call vam#ActivateAddons(['tlib', 'tmru', 'gnupg3645', 'fugitive', 'gitv', 'Command-T', 'vim-addon-actions', 'vim-addon-sbt', 'vim-addon-mw-utils', 'vim-addon-scala'],{'auto_install' : 0})
    "
    " with CSApprox
	" call vam#ActivateAddons(['tlib', 'tmru', 'gnupg3645', 'fugitive', 'gitv', 'Command-T', 'CSApprox'],{'auto_install' : 0})
	
	" guicolorsheme, CSApprox : Allow conversion from gui colors to terminal colors (CSApprox is more robbust)


	" sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
	" where 'pluginA' could be "git://" "github:YourName" or "snipmate-snippets" see vam#install#RewriteName()
	" also see section "5. Installing plugins" in VAM's documentation
	" which will tell you how to find the plugin names of a plugin
endf
call SetupVAM()

"
" solarized
" 
syntax on
set background=dark

let g:solarized_termtrans=1
let g:solarized_termcolors=256

colorscheme solarized " elflord

" vimdiff colors
" we may add ctermbg=xxx - orange: 9 - magenta: 5
highlight DiffAdd term=reverse cterm=bold ctermfg=5
highlight DiffChange term=reverse cterm=bold ctermfg=5
highlight DiffText term=reverse cterm=bold ctermfg=5
highlight DiffDelete term=reverse cterm=bold ctermfg=5

"
" ctrlp
"

" c: the directory of the current file - r: nearest current ancestor containing .git, .hg...etc. - a: ... - 0 or '': disable
" default 'ra'
let g:ctrlp_working_path_mode = ''


finish


