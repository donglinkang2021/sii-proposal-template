$pdf_mode = 5;
$ENV{'MKTEXTFM'} = '0';
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
# Keep PDF, SyncTeX, and auxiliary files together, matching LaTeX Workshop.
$out_dir = 'output';
# latexmk detects biblatex's .bcf and runs Biber, then repeats XeLaTeX.
# Both main.tex and example.tex use this recipe; no manual BibTeX step.
$clean_ext .= ' synctex.gz';
