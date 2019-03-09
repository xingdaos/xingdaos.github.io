@echo off
echo 请输入JDK的安装路径：
set /p path_jdk=
setx "JAVA_HOME" "%path_jdk%" /m
setx "JRE_HOME" "%path_jdk%\jre" /m
setx "CLASSPATH" ".;%%JAVA_HOME%%\lib;%%JAVA_HOME%%\lib\tools.jar;" /m
setx "PATH" "%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;%PATH%" /m
echo 设置成功，如有异常请联系：libangbang@egova.com.cn
pause
