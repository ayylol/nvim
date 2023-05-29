" Auto compilation
function Compile()
    !biber %:r
    !pdflatex -shell-escape %
    !rm %:r.{log,aux}
endfunc

autocmd BufWritePost * silent call Compile()
"autocmd BufWritePost * call Compile()

" Show pdf
nnoremap <silent><leader>' :!zathura %:r.pdf &<CR>

