" change make (that build the file) to use shellcheck
" set makeprg=shellcheck\ -f\ gcc\ %
" set to call make on postsave
" au BufWritePost *.sh :silent make | TroubleRefresh


