@ECHO OFF
SET BASENAME=%1
SET SUFFIX=%2
ECHO BASENAME=%BASENAME%
ECHO SUFFIX=%SUFFIX%
IF EXIST %BASENAME% RMDIR /S /Q %BASENAME%
lilypond-book --output=%BASENAME% --pdf %BASENAME%.%SUFFIX%
if %errorlevel% neq 0 EXIT /B %errorlevel%
CD /D %BASENAME%
pdflatex --synctex=1 %BASENAME%.tex

if %errorlevel% neq 0 EXIT /B %errorlevel%
COPY %BASENAME%.pdf ..\

:ENDING