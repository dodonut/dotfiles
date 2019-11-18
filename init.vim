" call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
    set shiftwidth=4
    set autoread "detect when a file is changed
    set history=1000 " change vim history to 1000 commands
    set textwidth=120 " 120 columns

    set backspace=indent,eol,start "make backspace work like we are used to

    " does not work on linux, see later
    "let ctrl-c copy on other programs and 'y' yank on vim
    "let 'y' on vim and ctrl-v on other programs
    " set clipboard=unnamed
	set background=dark
	" Searching
    set ignorecase " case insensitive
    set smartcase " case sensitive if expression contains capital letter
    set hlsearch "highlight search results
    set incsearch "set incremental search, like modern browsers
    set magic " for regex

    " error bells
    set noerrorbells " remove default audio notification on error 
    set visualbell " add a visual bell instead of audio bell
" }}} 

" Appearence {{{
    set number " show line numbers
	set relativenumber "show the relative number
    set wrap " turn on line wrapping
    set wrapmargin=8 " start wrapped lines 8 columns ahead
    set linebreak " set soft wrapping
    set showbreak=... " show visual symbol on wrapping
    set autoindent " automatically set indent of new line
    set ttyfast " update screen redrawing
    " not currently working
    " set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff "set some features for diff of files
    set wildmenu " enhanced command line completition
    set hidden " current buffer can be put into background
    set showcmd "show incomplete commands
    set noshowmode " dont't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title "set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of seconds to blink
    set updatetime=300
    set signcolumn=yes " to draw sign column
    set shortmess+=c " dont give completition messages

	" tab control
	nnoremap <A-c> :tabnew<cr>
	nnoremap <A-l> :tabNext<cr>
	nnoremap <A-h> :tabprevious<cr>
	nnoremap <A-d> :tabclose<cr>

	filetype on
    filetype plugin on
	filetype indent on
    set encoding=UTF-8

    "Tab control
    set smarttab "tab respects 'tabstop', 'shiftwidth' and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 "edit as if the tabs are 4 characters wide
    set shiftwidth=4 " number of spaces to use for a indent and unindent
    set shiftround "round indent to a multiple of 'shiftwidth'

    "Code Folding settings
    set foldmethod=syntax "fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 "deepest fold is 10 levels
    set nofoldenable " dont't fold by default
    set foldlevel=1

    " toogle invisible characters
    " set list
    " set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    " set showbreak=↪

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

        " enable 24 bit color support if supported
    if (has("termguicolors"))
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

	"General Mappings {{{
		
		let mapleader = ','

		" remap esc
		inoremap jk <esc>

		" shortcut to save
		nmap <leader>, :w<cr>

		" set paste toggle
		set pastetoggle=<leader>v

		" edit ~/.config/nvim/init.vim
		map <leader>ev :e! ~/.config/nvim/init.vim<cr>
		map <leader>sv :source ~/.config/nvim/init.vim<cr>
	
		" clear highlighted search
		noremap <space> :set hlsearch! hlsearch?<cr>

		" activate spell-checking alternatives
		nmap ;s :set invspell spelllang=en<cr>

		" markdown to html
		nmap <leader>md :%!markdown --html4tags <cr>

		"remove extra whitespace
		nmap <leader><space> :%s/\s\+$<cr>
		nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

		" buffer control
		nnoremap <leader>d :bdelete<cr>
		nnoremap <leader>bd :%bdelete<cr>
		nnoremap <leader>n :bnext<cr>
		nnoremap <leader>p :bnext<cr>

		nnoremap ; :

		"keep visual selection when indenting/outdenting
		vmap < <gv
		vmap > >gv

		" switch between current and last buffer
		nmap <leader>. <c-^>

		"enable . comand in visual mode
		vnoremap . :normal .<cr>

        " scroll the viewport faster
        nnoremap <C-e> 8<C-e>
        nnoremap <C-y> 8<C-y>

        " moving up and down work as you would expect
        nnoremap <silent> j gj
        nnoremap <silent> k gk
        nnoremap <silent> ^ g^
        nnoremap <silent> $ g$

        " helpers for dealing with other people's code
        nmap \t :set ts=4 sts=4 sw=4 noet<cr>
        nmap \s :set ts=4 sts=4 sw=4 et<cr>
	"}}}

" General Functionality {{{
    Plug 'tpope/vim-commentary' " easy commenting motions
    Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
    Plug 'scrooloose/nerdcommenter' "comment
	Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
	Plug 'jiangmiao/auto-pairs' "Autoclose parens, and stuff 
	Plug 'bling/vim-airline' "better status line
	" Plugin Settings {
  " Airline {
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif

		let g:airline#extensions#tabline#enabled = 1
		let g:airline#extensions#tabline#buffer_idx_mode = 1
		let g:airline#extensions#tabline#fnamemod = ':t'
		let g:airline#extensions#tabline#left_sep = ''
		let g:airline#extensions#tabline#left_alt_sep = ''
		let g:airline#extensions#tabline#right_sep = ''
		let g:airline#extensions#tabline#right_alt_sep = ''
		let g:airline#extensions#tabline#formatter = 'default'
		let g:airline_section_y = '%t'
		let g:airline_skip_empty_sections = 1

		" unicode symbols
		let g:airline_left_sep = '»'
		let g:airline_left_sep = '▶'
		let g:airline_right_sep = '«'
		let g:airline_right_sep = '◀'
		let g:airline_symbols.crypt = '🔒'
		let g:airline_symbols.linenr = '␊'
		let g:airline_symbols.linenr = '␤'
		let g:airline_symbols.linenr = '¶'
		let g:airline_symbols.maxlinenr = '☰'
		let g:airline_symbols.maxlinenr = ''
		let g:airline_symbols.branch = '⎇'
		let g:airline_symbols.paste = 'ρ'
		let g:airline_symbols.paste = 'Þ'
		let g:airline_symbols.paste = '∥'
		let g:airline_symbols.spell = 'Ꞩ'
		let g:airline_symbols.notexists = '∄'
		let g:airline_symbols.whitespace = 'Ξ'

  " }j
	let g:airline_powerline_fonts = 1
	Plug 'kien/ctrlp.vim' "ctrlp fuzzy finding
	Plug 'tpope/vim-fugitive' "git wrapper
	Plug 'zchee/deoplete-go' "better go autocomplete
	Plug 'ervandew/supertab'
	Plug 'fatih/vim-go', {'do':':GoUpdateBinaries'}
    " autocomplete
    "Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins' }
	" Syntastic 
		Plug 'scrooloose/syntastic'
		let g:syntastic_check_on_open = 1
		let g:syntastic_check_on_wq = 0
	Plug 'buoto/gotests-vim' " vim-go crutch to help generate tests for Golang 
	Plug 'Shougo/deoplete.nvim' " AutoComplete
     
    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
		Plug 'Xuyuanp/nerdtree-git-plugin' "visualy modified for git on nerdtree
		Plug 'ryanoasis/vim-devicons'
		"set guifont=DroidSansMono\ Nerd\ Font\ Mono\ 11
		Plug 'jdkanani/vim-material-theme'
		" Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction
        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <leader>f :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
		let g:NERDTreeGitStatusWithFlags=1

    " }}}


    " Language-Specific Configuration {{{
    " html / templates {{{
        Plug 'mattn/emmet-vim' " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'gregsexton/MatchTag', { 'for': 'html' } " match tags in html, similar to paren support

    " }}}


call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    else
        let g:onedark_termcolors=16
        let g:onedark_terminal_italics=1
        colorscheme material-theme
    endif
    syntax on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333

    " make comments and HTML attributes italic
    highlight Comment cterm=italic term=italic gui=italic
    highlight htmlArg cterm=italic term=italic gui=italic
    highlight xmlAttrib cterm=italic term=italic gui=italic
    " highlight Type cterm=italic term=italic gui=italic
    highlight Normal ctermbg=none
" }}}

" vim:set foldmethod=marker foldlevel=0
