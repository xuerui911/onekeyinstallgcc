#!/bin/sh
echo "安装依赖（包括低版本gcc）"
yum install -y  gcc-c++  glibc-static gcc bzip2 wget tmux
yum groupinstall -y 'Development tools'

echo "从阿里云下载源码包到当前用户家目录"
wget -P ~/ https://mirrors.aliyun.com/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz

echo "进入家目录并解压"
cd ~ && tar zxf gcc-10.2.0.tar.gz

echo "配置依赖项"

echo "cd gcc-10.2.0"
cd gcc-10.2.0

echo "gmp-6.1.0.tar.bz国内很可能下载失败，预先手动下载"
wget https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2

echo "执行contrib/download_prerequisites，此处要下载其它依赖项，请耐心等待"
contrib/download_prerequisites

echo "configure安装目录到/usr目录并生成Makefile"
configure --prefix=/usr/ --enable-checking=release --enable-languages=c,c++ --disable-multilib

echo "执行make && make install"
make && make install

echo "排除yum/dnf包管理器中gcc，防止编译安装的高版本gcc被yum安装gcc覆盖"
echo "exclude=gcc" >> /etc/yum.conf

source /etc/profile

echo "请输入gcc -v查看gcc是否成功，若成功会显示gcc版本10.2.0"
