# SVN

## 常用命令


```
1. 检出
    svn checkout/co http://路径(目录或文件的全路径) --username 用户名 --password 密码

2. 导出一个干净的不带.svn文件夹的目录树
    svn export [-r 版本号] http://路径(目录或文件的全路径) --username 用户名

3. 添加新文件
    svn add 文件名

4. 提交
    svn commit/ci -m "提交备注信息文本" [--no-unclock] 文件名
    注释: 保持锁就用–no-unlock

5. 更新文件
    svn update
    svn update 文件名
    svn update -r 修正版本 文件名

6. 删除文件
    svn delete svn://路径(目录或文件的全路径) -m "删除备注信息文本"

7. 加锁/解锁
    svn lock -m "加锁备注信息文本" [--force] 文件名
    svn unlock 文件名

8. 比较差异
    svn diff 文件名
    svn diff -r 修正版本号m:修正版本号n 文件名

9. 查看文件或者目录状态
    svn status/st 文件名
    参数:
        ?: 不在svn的控制中
        M: 内容被修改
        C: 发生冲突
        A: 预定加入到版本库
        K: 被锁定

10. 查看日志
    svn log 文件名

11. 查看文件详细信息
    svn info 文件名

12. svn帮助
    svn help        # 全部功能选项
    svn help ci     # 具体功能的说明

13. 查看版本库下的文件和目录列表
    svn list/ls svn://路径(目录或文件的全路径)

14. 恢复本地修改
    svn revert 文件名

15. 解决冲突
    svn resolved        # 移除冲突的相关文件，然后让path可以再次提交

16. 不checkout而查看输出特定文件或url的内容
    svn cat http://文件全路径

19. 查看svn版本
    svn --version

20. 新建分支branchs，在分支上继续开发
    svn mkdir branches 
    svn copy svn://server/trunk svn://server/branches/ep -m “init ep”

21. 该版本完成，打tag，发布版本
    svn mkdir tags 
    svn copy svn://server/trunk svn://server/tags/release-1.0 -m “1.0 released”

18. 合并内容到分支
    svn merge branchA branchB

22. 代码库URL变更
    svn switch (sw)     # 更新工作副本至不同的URL

23. 创建纳入版本控制下的新目录
    svn mkdir newdir 
    例如：
        svn mkdir -m “Making a new dir.” svn://localhost/test/newdir

```
