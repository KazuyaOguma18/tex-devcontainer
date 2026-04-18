set shell := ["bash", "-lc"]

default:
  @just build en

jp:
  mkdir -p out
  TEXINPUTS="$PWD/project//:" BIBINPUTS="$PWD/project//:" LATEXMK_ENGINE=pdflatex latexmk -jobname=main-jp build/main-jp.tex

en:
  mkdir -p out
  TEXINPUTS="$PWD/project//:" BIBINPUTS="$PWD/project//:" LATEXMK_ENGINE=pdflatex latexmk -jobname=main build/main-en.tex
