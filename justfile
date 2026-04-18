set shell := ["bash", "-lc"]

default:
    @just --list

mod build

clean:
  latexmk -C build/main-en.tex
  latexmk -C build/main-jp.tex
  rm -f out/main.pdf out/main-jp.pdf out/main.aux out/main-jp.aux out/main.bbl out/main-jp.bbl out/main.blg out/main-jp.blg out/main.fdb_latexmk out/main-jp.fdb_latexmk out/main.fls out/main-jp.fls out/main.log out/main-jp.log out/main.out out/main-jp.out out/main.synctex.gz out/main-jp.synctex.gz out/main.xdv out/main-jp.xdv
