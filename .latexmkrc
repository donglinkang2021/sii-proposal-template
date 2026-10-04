$pdf_mode = 5;
$ENV{'MKTEXTFM'} = '0';
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
# Keep PDF, SyncTeX, and auxiliary files together, matching LaTeX Workshop.
$out_dir = 'output';
$clean_ext .= ' synctex.gz';
