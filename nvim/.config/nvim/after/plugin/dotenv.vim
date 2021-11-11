function! s:env(var) abort
  return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

" :Dotenv ../test/dev.env
" let test = s:env('TEST')

