#!/bin/bash

DEFAULTPATH=.
TEMPLATESPATH=./templates
KNOWNSTYLES="lncs|ieee|acm|elsevier"
PREFIX=${DEFAULTPATH}

usage="$(basename "$0") [-h] [-s STYLE] [-u URL] PROJECT_NAME -- Setup a new latex project

where:
    -h, -help, --help       show this help text
    -s, --style             select/download an existing style among ieee | lncs | acm
    -u, --url               an URL where a style should be downloaded
    -c, --clean             clean existing style dir for PROJECT_NAME
    -d                      gives the directory where the project should be found/created
    PROJECT_NAME            chains which need to be compiled and/or deployed
"

# Options evaluations should use getopts instead for portability?
OPTS=$( getopt -o u:s:d:ch -l url:,style:,clean,help -- "$@" )
[ $? != 0 ] && exit 2

eval set -- "$OPTS"
while true ; do
    case "$1" in
        -s|--style)
            STYLE=$2
            [[ ! ${STYLE} =~ ${KNOWNSTYLES} ]] && {
              echo "Incorrect options provided, target must be [${KNOWNSTYLES}]"
              exit 3
            }
            shift 2
            ;;
        -u|--url)
            URL=$2
            shift 2
            ;;
        -c|--clean)
            CHANGESTYLE=true
            shift
            ;;
        -d)
            PREFIX=$2
            PREFIX=${PREFIX%/}
            shift 2
            ;;
        -h|--help)
            echo "$usage";
            exit 5
            ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

if [ "$#" -lt 1 ]; then
  echo "Missing project name."
  echo "$usage"
  exit 1
fi

NAME="$1"
PROJPATH=${PREFIX}/${NAME}

# Create project hierarchie
mkdir -p ${PROJPATH}/{imgs,styles}

STYLEDIR=${PROJPATH}/styles
[ -z ${CHANGESTYLE} ] || {
  echo "Cleaning style dir"
  rm -r ${STYLEDIR}/*
}

[ -z ${STYLE} ] || {
  case ${STYLE} in
    lncs)
      URL="ftp://ftp.springer.de/pub/tex/latex/llncs/latex2e/llncs2e.zip"
      ;;
    ieee)
      URL="http://www.ieee.org/documents/IEEEtran.zip"
      ;;
    acm)
      URL="http://www.acm.org/publications/article-templates/sig-alternate-05-2015.cls http://www.acm.org/publications/article-templates/acmcopyright.sty"
      ;;
    elsevier)
      URL="https://www.elsevier.com/__data/assets/file/0007/56842/elsarticle-template.zip"
      ;;
    *)
      echo "Unknown style ${STYLE}"
      exit 3
      ;;
  esac
}

[ -z ${URL} ] || {
  wget -P ${STYLEDIR} $URL
  [ ${URL: -4} == ".zip" ] && unzip ${STYLEDIR}/$(basename $URL) -d ${STYLEDIR}
}

[ -z ${CHANGESTYLE} ] || {
  exit 6
}

# Copy template files and filter vars
cp ${TEMPLATESPATH}/Makefile ${PROJPATH}/
sed 's/#PROJNAME#/'${NAME}'/g' ${TEMPLATESPATH}/template.tex > ${PROJPATH}/${NAME}.tex
touch ${PROJPATH}/${NAME}.bib

echo "
Your project ${NAME} is set at this location: $(readlink -f ${PROJPATH})
If you used a pre-existing style/template read the call for paper details."
