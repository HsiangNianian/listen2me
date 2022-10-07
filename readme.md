# listen2me

为Dice!编写的Lua脚本，用于mml作曲试听。
此分支为Windows版本。

```json
{
    "mod":"listen2me",
    "author":"简律纯",
    "ver":"1.0.0",
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

# 更新日志

>此日志写的比工程文件要晚那么一点。

<details>
<summary>2022年10月8日</summary>
<b>初步框架版本编写完毕。</b>
<h5>新增</h5>
1. `mml2mid.lua` 新增一些配置项。
2. 新增了对 `timidity.cfg` 的查询功能.
<h5>删减</h5>
1. 改动了部分语法.
</details>