# SVN

## 常用命令

```
svn checkout http://路径(目录或文件的全路径)       简写: svn co xxxx
svn update
svn diff (文件名)

svn add 文件名
svn commit -m "提交信息"

svn　delete　文件名 
svn　ci　-m　“删除备注信息文本”

svn　help         全部功能选项
svn　help　ci     具体功能的说明
```


```
svn checkout http://路径(目录或文件的全路径)       简写: svn co xxx
svn add file
svn commit -m "xxxx"                            简写: svn ci
svn lock -m "xxxx" xxx
svn unlock xxx
svn update -r 版本号 xxx       更新到某个版本
svn update [xxx]                更新[某个文件]    简写: svn up

```