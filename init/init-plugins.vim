"======================================================================
"
" init-plugins.vim -
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['tags', 'airline', 'ale', 'echodoc', 'spaceline', 'vim-buffet']
	let g:bundle_group += ['coc.nvim']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" 终端相关
Plug 'skywind3000/asyncrun.vim'


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	Plug 'mh21/errormarker.vim'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	Plug 'skywind3000/vim-preview'
endif
	" 默认显示 startify
	let g:startify_disable_at_vimenter = 1
	let g:startify_session_dir = '~/.vim/session'

	" 使用 <space>ha 清除 errormarker 标注的错误
	noremap <silent><space>ha :RemoveErrorMarkers<cr>

"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" 快速文件搜索
	Plug 'Yggdroot/LeaderF'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" 文件浏览器，代替 netrw
	Plug 'justinmk/vim-dirvish'

	" 括号引号选择，默认快捷键为enter
	Plug 'gcmt/wildfire.vim'

	" 可以用字符包裹选中片段，默认快捷键为大写S，更改快捷键为cs
	Plug 'tpope/vim-surround'

	" 图标库
	Plug 'ryanoasis/vim-devicons'
"----------------------------------------------------------------------
	" CTRL+p 打开文件模糊匹配
	let g:Lf_ShortcutF = '<c-p>'

	" ALT+n 打开 buffer 模糊匹配
	let g:Lf_ShortcutB = '<m-n>'

	" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
	noremap <c-n> :LeaderfMru<cr>

	" ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
	noremap <m-p> :LeaderfFunction!<cr>

	" ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
	noremap <m-P> :LeaderfBufTag!<cr>

	" ALT+n 打开 buffer 列表进行模糊匹配
	noremap <m-n> :LeaderfBuffer<cr>

	" ALT+m 全局 tags 模糊匹配
	noremap <m-m> :LeaderfTag<cr>

	" 最大历史文件保存 2048 个
	let g:Lf_MruMaxFiles = 2048

	" ui 定制
	let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

	" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
	let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
	let g:Lf_WorkingDirectoryMode = 'Ac'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_CacheDirectory = expand('~/.vim/cache')

	" 显示绝对路径
	let g:Lf_ShowRelativePath = 0

	" 隐藏帮助
	let g:Lf_HideHelp = 1

	" 模糊匹配忽略扩展名
	let g:Lf_WildIgnore = {
				\ 'dir': ['.svn','.git','.hg'],
				\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
				\ }

	" MRU 文件忽略扩展名
	let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
	let g:Lf_StlColorscheme = 'powerline'

	" 禁用 function/buftag 的预览功能，可以手动用 p 预览
		let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

	" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
	let g:Lf_NormalMap = {
			\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
			\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
			\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
			\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
			\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
			\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
			\ }
"----------------------------------------------------------------------
" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
" 比默认的纯按照字母排序更友好点。
"----------------------------------------------------------------------
function! s:setup_dirvish()
	if &buftype != 'nofile' && &filetype != 'dirvish'
		return
	endif
	if has('nvim')
		return
	endif
	" 取得光标所在行的文本（当前选中的文件名）
	let text = getline('.')
	if ! get(g:, 'dirvish_hide_visible', 0)
		exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
	endif
	" 排序文件名
	exec 'sort ,^.*[\/],'
	let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
	" 定位到之前光标处的文件
	call search(name, 'wc')
	noremap <silent><buffer> ~ :Dirvish ~<cr>
	noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
	autocmd!
	autocmd FileType dirvish call s:setup_dirvish()
augroup END

endif
"----------------------------------------------------------------------
" devicons 图标
let g:webdevicons_enable = 1	" 载入插件
let g:webdevicons_enable_startify = 1	" 在vim-startify上显示

"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

	" 提供 ctags/gtags 后台数据库自动更新功能
	Plug 'ludovicchabant/vim-gutentags'

	" 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
	" 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
	Plug 'skywind3000/gutentags_plus'

	" 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
	let g:gutentags_project_root = ['.root']
	let g:gutentags_ctags_tagfile = '.tags'

	" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
	let g:gutentags_cache_dir = expand('~/.cache/tags')

	" 默认禁用自动生成
	let g:gutentags_modules = []

	" 如果有 ctags 可执行就允许动态生成 ctags 文件
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif

	" 如果有 gtags 可执行就允许动态生成 gtags 数据库
	if executable('gtags') && executable('gtags-cscope')
		let g:gutentags_modules += ['gtags_cscope']
	endif

	" 设置 ctags 的参数
	let g:gutentags_ctags_extra_args = []
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

	" 使用 universal-ctags 的话需要下面这行，请反注释
	" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	" 禁止 gutentags 自动链接 gtags 数据库
	let g:gutentags_auto_add_gtags_cscope = 0
endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
	Plug 'w0rp/ale'

	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'

	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1

	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif

	" 允许 airline 集成
	let g:airline#extensions#ale#enabled = 1

	" 编辑不同文件类型需要的语法检查器
	let g:ale_linters = {
				\ 'c': ['gcc', 'cppcheck'],
				\ 'cpp': ['gcc', 'cppcheck'],
				\ 'python': ['flake8', 'pylint'],
				\ 'lua': ['luac'],
				\ 'go': ['go build', 'gofmt'],
				\ 'java': ['javac'],
				\ 'javascript': ['eslint'],
				\ }


	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
	function s:lintcfg(name)
		let conf = s:path('tools/conf/')
		let path1 = conf . a:name
		let path2 = expand('~/.vim/linter/'. a:name)
		if filereadable(path2)
			return path2
		endif
		return shellescape(filereadable(path2)? path2 : path1)
	endfunc

	" 设置 flake8/pylint 的参数
	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

	" 如果没有 gcc 只有 clang 时（FreeBSD）
	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif
endif


"----------------------------------------------------------------------
" echodoc 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	Plug 'Shougo/echodoc.vim'
	set noshowmode
	let g:echodoc#enable_at_startup = 1
endif


"----------------------------------------------------------------------
" coc.nvim相关
"----------------------------------------------------------------------
if index(g:bundle_group, 'coc.nvim') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = [
		\ 'coc-pyright',
		\ 'coc-clangd',
		\ 'coc-json',
		\ 'coc-vimlsp',
		\ 'coc-lists',
		\ 'coc-marketplace']

	" 使用tab键来选择补全选项
	inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" 使用enter确认补全
	" Make <CR> auto-select the first completion item and notify coc.nvim to
	" format on enter, <cr> could be remapped by other vim plugin
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	" 用 'K' 显示文档
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction

	" 多光标
	nnoremap <leader>crw :CocCommand document.renameCurrentWord
	nmap <silent> <leader>crk <Plug>(coc-cursors-word)

	" 持有光标时突出显示符号及其引用.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" 重命名
	nmap <leader>rn <Plug>(coc-rename)

	" 跳转到相同定义函数处
	nmap <silent> <leader>gd <Plug>(coc-definition)
	nmap <silent> <leader>gy <Plug>(coc-type-definition)
	nmap <silent> <leader>gi <Plug>(coc-implementation)
	nmap <silent> <leader>gr <Plug>(coc-references)

	" Mappings for CoCList
	" Manage extensions.
	" nnoremap <silent><nowait> <space>t  :<C-u>CocList extensions<cr>
	" Show commands.
	" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" call CocLsit marketplace
	" nnoremap <silent><nowait> <space>m  :<C-u>CocList marketplace<CR>
endif

"----------------------------------------------------------------------
" spaceline 状态栏
"----------------------------------------------------------------------
if index(g:bundle_group, 'spaceline') >= 0
	Plug 'glepnir/spaceline.vim'
	let g:spaceline_seperate_style = 'none'
	let g:spaceline_colorscheme = 'space'
	let g:spaceline_custom_vim_status =  {"n": "Normal ","V":"Visual ","v":"Visual ","\<C-v>": "V-BLOCK ","i":"Insert ","R":"Replace ","s":"Select ","t":"Terminal ","c":"Command ","!":"SE"}
	let g:spaceline_diagnostic_tool = 'ale'
	let g:spaceline_diagnostic_oksign = "⚡"
	let g:spaceline_diagnostic_errorsign = '●'
	let g:spaceline_diagnostic_warnsign = '●'
	let g:spaceline_custom_diff_icon =  ['','','']
	let g:spaceline_diff_tool = 'vim-signify'
	" one char wide solid vertical bar This is default
	let g:spaceline_scroll_chars = [
		\  ' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇'
		\  ]
endif

"----------------------------------------------------------------------
" vim-buffet tabline功能
"----------------------------------------------------------------------
if index(g:bundle_group, 'vim-buffet') >= 0
	Plug 'bagrat/vim-buffet'

	" 设置为0，只有在打开多个缓冲区或选项卡时才会显示表格行
	let g:buffet_always_show_tabline = 1

	" 设置为1，在选项卡行中的缓冲区和选项卡之间使用电力线分隔符
	let g:buffet_powerline_separators = 1

	" 设置为1，在每个缓冲区名称之前显示索引。索引对于在缓冲区之间快速切换很有用
	let g:buffet_show_index = 1

	" <Plug>BuffetSwitch提供的最大数量。如果该选项设置为0，则映射将被禁用
	let g:buffet_max_plug = 10

	" 如果设置为1并vim-devicons安装了插件，则在表格中显示每个缓冲区的文件类型图标。
	let g:buffet_use_devicons = 1

	let g:buffet_new_buffer_name = '*'
	let g:buffet_modified_icon = '+'
	let g:buffet_tab_icon = "\uf00a"
	let g:buffet_left_trunc_icon = "\uf0a8"
	let g:buffet_right_trunc_icon = "\uf0a9"
	let g:buffet_hidden_buffers = ['terminal', 'quickfix']

	" 颜色调节
	function! g:BuffetSetCustomColors()
		hi! BuffetCurrentBuffer cterm=NONE ctermbg=53 ctermfg=8 guibg=#5D4D7A guifg=#000000
	endfunction
endif
"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()


