@echo off
echo ������JDK�İ�װ·����
set /p path_jdk=
setx "JAVA_HOME" "%path_jdk%" /m
setx "JRE_HOME" "%path_jdk%\jre" /m
setx "CLASSPATH" ".;%%JAVA_HOME%%\lib;%%JAVA_HOME%%\lib\tools.jar;" /m
setx "PATH" "%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;%PATH%" /m
echo ���óɹ��������쳣����ϵ��libangbang@egova.com.cn
pause
