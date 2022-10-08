# listen2me

为Dice!编写的Lua脚本，用于mml作曲试听。
此分支为Windows版本。

```json
{
    "mod":"listen2me",
    "author":"简律纯",
    "ver":"1.0.2",
    "dice_build":612,
    "brief":"使用mml作曲",
    "comment":"",
    "helpdoc":{
        "listen2me":"【listen2me - winVer】\n使用mml语言进行作曲\nhttps://github.com/cypress0522/listen2me"
    }
}
```

- [x] Windows 版本
- [ ] Linux 版本

# 参考

- <http://hpc.jp/~mml2mid>
- <https://man.archlinux.org/man/timidity.cfg.5>
- <https://man.archlinux.org/man/community/timidity++/timidity.1.en>

# 日志

>此日志写的比工程文件要晚那么一点。

<details>
<summary>2022年10月8日</summary>
<b>初步框架版本编写完毕。</b>
<h5>新增</h5>
1. <i>mml2mid.lua</i> 新增一些配置项。
2. 新增了对 <i>timidity.cfg</i> 的查询功能.
<h5>删减</h5>
1. 改动了部分语法.
</details>

***

<details>
<summary>2022年10月2日</summary>
<b>准备套壳，已经实现mml转mid，mid转wav，下一阶段将会编写脚本使其脚本化。</b>
<h5>新增</h5>
1. 添加<i>timidity</i>，放弃了原本直接发送<i>midi</i>序列的方式(这样<i>Go-cqhttp</i>会发不出语音)，在发送语音前会对<i>*.mid</i>文件进行转码再发送。
<h5>修复</h5>
1. 修复了一些bug
</details>