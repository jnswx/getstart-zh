#!/bin/sh
#
TARGET=${1}
SRCDIR=${BASEDIR}/../source; export SRCDIR
BUILDBASE=/usr/local/src
BUILDDIR=${BUILDBASE}/getstart; export BUILDDIR
mkdir -p ${BUILDBASE} && cd ${BUILDBASE} || exit 1
# BE CAREFUL WITH THIS ONE !!!
rm -rf ${BUILDDIR} && cp -pr ${SRCDIR} ${BUILDDIR}
cd ${BUILDDIR} || exit 1
#
HTLATEX='mk4ht htlatex'
PDFLATEX=pdflatex

# Cleanup everything that is considered not to be present here.
cleanup () {
  rm -f *.pdf *.html *.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg \
  *.in *.ind *.lg *.css *.log *.out *.tid *.tmp *.toc *.xref *.gif
}

buildpdf() {
  CYCLE=1
  while [ ${CYCLE} -ne 2 ]; do
    ${PDFLATEX} ${SOURCE}\.tex
    CYCLE=`expr ${CYCLE} + 1`
  done
  if  [ ${SOURCE} = "getstart" ]; then
    makeindex ${SOURCE}
    ${PDFLATEX} ${SOURCE}\.tex
  fi
}