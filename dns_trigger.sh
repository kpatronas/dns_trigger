#!/bin/bash

BASE_PATH=$HOME"/dns_track/"
DOMAIN=''
NAMESERVER=''
TYPE='ANY
'
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -b|--basepath)
      BASE_PATH="$2"
      shift
      shift
      ;;
    -d|--domain)
      DOMAIN="$2"
      shift
      shift
      ;;
    -n|--nameserver)
      NAMESERVER="$2"
      shift
      shift
      ;;
    -t|--type)
      TYPE="$2"
      shift
      shift
      ;;
  esac
done

if [ -z "${BASE_PATH}" ];
then
    echo "`date +"%Y-%m-%dT%H:%M:%S"` - Exiting: basepath is empty";
    exit -1;
fi

if [ -z "${DOMAIN}" ];
then
    echo "`date +"%Y-%m-%dT%H:%M:%S"` - Exiting: domain is empty";
    exit -1;
fi

mkdir -p $BASE_PATH

if test -f "$BASE_PATH$DOMAIN"; then
 mv $BASE_PATH$DOMAIN $BASE_PATH$DOMAIN"_previous"
fi

if [ -z "${NAMESERVER}" ];
then
    dig $DOMAIN $TYPE | grep -v -e "^$\|^;" | awk '{ print substr($0, index($0,$4)) }' | tr '\t' , > $BASE_PATH$DOMAIN
else
    dig $DOMAIN $TYPE @$NAMESERVER | grep -v -e "^$\|^;" | awk '{ print substr($0, index($0,$4)) }' | tr '\t' , > $BASE_PATH$DOMAIN
fi

if test -f $BASE_PATH$DOMAIN"_previous"; then
diff <(sort $BASE_PATH$DOMAIN) <(sort $BASE_PATH$DOMAIN"_previous")
