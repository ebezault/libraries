@echo off
REM set up a CVS tree to build when there's no autotools
REM $Revision$
REM $Date$

REM create ca-bundle.h
echo /* This file is generated automatically */ >lib\ca-bundle.h

REM create hugehelp.c
copy src\hugehelp.c.cvs src\hugehelp.c

REM create Makefile
copy Makefile.dist Makefile