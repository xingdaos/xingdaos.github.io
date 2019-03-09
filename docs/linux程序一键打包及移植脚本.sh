#!/usr/bin/env bash

echo 本程序运行完成后，只需要将新生成的tar.gz包拷贝至新系统解压即可，之后运行解压出的install.sh脚本即可完成程序移植

# 获取需要打包的程序
echo 请输入需要打包的程序：
read soft
echo 正在打包中 … …

# 创建打包目录
mkdir ${soft}

# 获取程序及配置文件
whereis ${soft} | cut -d ' ' -f 2- > ${soft}/${soft}.conf

# 获取依赖
whereis ${soft} | cut -d ' ' -f 2 | xargs ldd | cut -d '>' -f 2 | cut -d '(' -f 1 >> ${soft}/${soft}.conf

# 格式化打包文件目录
sed -i 's/[[:space:]]/\n/g' ${soft}/${soft}.conf
sed -i '/^\s*$/d' ${soft}/${soft}.conf

# 打包程序、依赖
tar -chPzvf ${soft}/${soft}.gz -T ${soft}/${soft}.conf > /dev/null

# 生成安装脚本
cat > ${soft}/${soft}-install.sh << EOF
#!/usr/bin/env bash

# 定义soft变量
soft=${soft}

EOF
cat >> ${soft}/${soft}-install.sh << 'EOF'
# 创建临时目录，并解压至临时目录
mkdir ${soft}
tar -xzvPf ${soft}.gz -C ${soft} > /dev/null

# 遍历目录，输出文件及对应目录
function getdir(){
    for element in `ls $1`
    do
        dir_or_file=$1/$element
        if [ -d $dir_or_file ]
        then
            getdir $dir_or_file
        else
            echo ${dir_or_file#$dir/} >> dir_file.conf
            dirname ${dir_or_file#$dir/$soft} >> dir_name.conf
        fi
    done
}
# 调用getdir函数，遍历目录
dir=$(pwd)
getdir $dir/$soft

# 移动相应的文件去相应的目录
paste dir_file.conf dir_name.conf | awk '{system("mv -n "$1" "$2)}'

# 删除临时文件和临时目录
rm -fr ${soft} dir_file.conf dir_name.conf mv.conf
echo 移植成功
EOF

# 打包安装脚本
tar -czvf ${soft}.gz ${soft}/${soft}.gz ${soft}/${soft}-install.sh > /dev/null
echo 打包成功

# 删除临时文件
rm -fr ${soft}
