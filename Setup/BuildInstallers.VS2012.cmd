@echo off

cd /d "%~p0"

set msbuild="%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
set project=..\GitExtensions.VS2012.sln
set nuget=..\.nuget\nuget.exe
set SkipShellExtRegistration=1

set msbuildparams=/p:Configuration=Release /t:Rebuild /nologo /v:m

%nuget% install ..\Plugins\BackgroundFetch\packages.config -OutputDirectory ..\packages

%msbuild% %project% /p:Platform="Any CPU" %msbuildparams%
IF ERRORLEVEL 1 EXIT /B 1
%msbuild% %project% /p:Platform=x86 %msbuildparams%
IF ERRORLEVEL 1 EXIT /B 1
%msbuild% %project% /p:Platform=x64 %msbuildparams%
IF ERRORLEVEL 1 EXIT /B 1

call MakeInstallers.bat