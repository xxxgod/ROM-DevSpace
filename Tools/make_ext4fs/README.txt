# make_ext4fs
ROM editor tools

linux环境解包打包

环境要求：Ubuntu
此处以system.img和userdata.img打包为例,基于谷歌源码编译的工具使用方法和命令。

1.转换格式
在解包过程中，system或者userdata镜像文件经常以两种格式出现：raw和sparse。

一种是raw ext4 image，即经常说的raw image，使用file观察它：
其特点是完整的ext4分区镜像（包含很多全零的无效填充区），可以直接使用mount进行挂载，因此比较大。

$ file system.img
system.img: Linux rev 1.0 ext4 filesystem data, UUID=57f8f4bc-abf4-655f-bf67-946fc0f9f25b (extents) (large files)
信息非常明确了。

另一种是sparse ext4 image，即经常说的simg，使用file观察它：
$ file system.img
system.img: data
如果格式为data，需要从data格式转成ext4格式，也就是raw格式，如下

> simg2img system.img system.img.ext4 //转换格式
> mkdir tmp //新建临时文件夹
> sudo mount -o loop system.img.ext4 tmp 将ext4文件挂载到tmp目录

2.常规打包：
先ls -l system.img.ext4看大小，假设是1073741824，这个参数后边用到。(此处l是英文字母L)

> ./make_ext4fs -s -l 2684354560  -a system new_system.img ./tmp

3.安卓5.0以及5.0以上版本打包，需注意：

命令如下：
$ ./make_ext4fs -s -T 1421464178 -S file_contexts -l 1073741824 -a system new_system.img system/

或者：
./make_ext4fs -s  -S file_contexts -l 2048M -a system new_system.img system/

命令参数说明：
// -s 表示安静处理，不输出动作，可以不带该参数
// -T 表示Unix时间戳，对system.img中的文件设置修改时间，执行“
date +%s”获取某个时间点的时间戳,也可以直接不用-T 1421464178 ；
// -S 表示sepolicy 的file_contexts，把该文件放到此目录下，文件取自官方system/root路径或者卡刷包自带（解压内核，在内核里面）
// -l 表示最大的文件大小（受限于分区大小）；可以ls -l 当前转格式出来的system大小、单位也可以为MB
// -a 表示Android的mount点，比如system、userdata、recovery；
// oksystem.img 表示输出文件名；
// system/ 表示输入目录，该目录下有framework、app、bin等目录；

上述的simg2img和make_ext4fs是android自带的工具，如果有android源码而且编译通过的话， 这些工具可以在/out/host/linux-x86/bin中找到。
