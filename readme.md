# listen2me

为Dice!编写的Lua脚本，用于mml作曲试听。
此分支为Windows版本。

```json
{
    "mod":"listen2me",
    "author":"简律纯",
    "ver":"1.1.2",
    "dice_build":612,
    "brief":"使用mml作曲",
    "comment":"",
    "helpdoc":{
        "listen2me":"【listen2me[Windows]】\n使用mml语言进行作曲\nhttps://github.com/cypress0522/listen2me"
    }
}
```

- [X] Windows 版本
- [ ] Linux 版本

# 参考

- [http://hpc.jp/~mml2mid](http://hpc.jp/~mml2mid)
- [https://man.archlinux.org/man/timidity.cfg.5](https://man.archlinux.org/man/timidity.cfg.5)
- [https://man.archlinux.org/man/community/timidity++/timidity.1.en](https://man.archlinux.org/man/community/timidity++/timidity.1.en)

# 音源下载

> [Musescore](https://musescore.org/zh-hans/%e7%94%a8%e6%88%b7%e6%89%8b%e5%86%8c/soundfont-%e9%9f%b3%e8%89%b2%e5%ba%93) 提供的三个常见音色库

- FluidR3_GM.sf2 (未压缩大小 141 MB)
下载 [Fluid-soundfont.tar.gz](http://www.musescore.org/download/fluid-soundfont.tar.gz)

- GeneralUser_GS_1.44-MuseScore.sf2 (未压缩大小 29.8 MB)
下载 [GeneralUser_GS_1.44-MuseScore.zip](http://www.schristiancollins.com/soundfonts/GeneralUser_GS_1.44-MuseScore.zip) (承蒙 S. Christian Collins 而提供)

- TimGM6mb.sf2 (未压缩大小 5.7 MB)
下载 [modified TimGM6mb.sf2](http://mscore.svn.sourceforge.net/viewvc/mscore/trunk/mscore/share/sound/TimGM6mb.sf2) (承蒙 Tim Brechbill 而提供)

> [FluidSynth](https://github.com/FluidSynth/fluidsynth/wiki/SoundFont) 提供的音源下载网站

  * [Polyphone Soundfont Collection](https://www.polyphone-soundfonts.com/download-soundfonts) - A collection of Soundfonts on the Polyphone website
  * [Hammersound](http://www.hammersound.net/) - A nice resource for downloading free SoundFont instrument files.
  * [Magic Sound Font, version 2.0](http://www.personalcopy.com/sfarkfonts1.htm) (68 MB)
  * [Arachno SoundFont, version 1.0](http://www.arachnosoft.com/main/download.php?id=soundfont-sf2) (148MB)
  * [TimGM6mb](http://sourceforge.net/p/mscore/code/HEAD/tree/trunk/mscore/share/sound/TimGM6mb.sf2?format=raw) (6 MB)
  * [MuseScore_General.sf2](ftp://ftp.osuosl.org/pub/musescore/soundfont/MuseScore_General/MuseScore_General.sf2) (208 MB)
  * [Timbres Of Heaven GM_GS_XG_SFX V 3.4](http://midkar.com/soundfonts/) (246 MB)
  * [Sonatina Symphonic Orchestra](http://ftp.osuosl.org/pub/musescore/soundfont/Sonatina_Symphonic_Orchestra_SF2.zip) (503 MB uncompressed)
  * [Aegean Symphonic Orchestra v2.5 universal](https://sites.google.com/view/hed-sounds/aegean-symphonic-orchestra) (350 MB)
  * [Salamander C5 Light](https://sites.google.com/view/hed-sounds/salamander-c5-light) (25 MB)
  
# 日志

> 此日志写的比工程文件要晚那么一点。

***

<details>
<summary>2022年10月9日 实现了timidity.cfg的自动写入。</summary>
<h5>新增</h5>
1. <i>mml2mid.lua</i> 新增了对<i>timidity</i>音源的检测。
2.<i>mml2mid.lua</i> 新增<i>_FRAMWORK</i>配置项，判断框架类型。
3.<i>mml2mid.lua</i> 新增mml语法报错检测和输出(如果你看得懂那会很有帮助就是了)。
<h5>修复</h5>
1. 修复了因<i>timidity.cfg</i>参数<b>dir</b>固定而无法输出有声音的音频问题。
</details>

***

<details>
<summary>2022年10月8日 初步框架版本编写完毕。</summary>
<h5>新增</h5>
1. <i>mml2mid.lua</i> 新增一些配置项。
2. 新增了对 <i>timidity.cfg</i> 的查询功能。
<h5>删减</h5>
1. 改动了部分语法。
</details>

***

<details>
<summary>2022年10月2日 准备套壳，已经实现mml转mid，mid转wav，下一阶段将会编写脚本使其脚本化。</summary>
<h5>新增</h5>
1. 添加<i>timidity</i>，放弃了原本直接发送<i>midi</i>序列的方式(这样<i>Go-cqhttp</i>会发不出语音)，在发送语音前会对<i>*.mid</i>文件进行转码再发送。
<h5>修复</h5>
1. 修复了一些bug。
</details>

***

> 2022年10月9日21点