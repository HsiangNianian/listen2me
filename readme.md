# listen2me

[![](https://img.shields.io/github/last-commit/cypress0522/listen2me)](https://github.com/cypress0522/listen2me/commits/Windows-Version)[![](https://img.shields.io/github/issues/cypress0522/listen2me)](https://github.com/cypress0522/listen2me/issues)[![](https://img.shields.io/github/issues-pr/cypress0522/listen2me)](https://github.com/cypress0522/listen2me/pulls)[![](https://img.shields.io/github/v/release/cypress0522/listen2me?include_prereleases)](https://github.com/cypress0522/listen2me/releases)

此分支为Windows版本。

listen2me是为Dice!编写的Lua脚本，用于mml(Music Macro Language)作曲试听。

如果在使用过程中遇到了困难，欢迎到原仓库提交[issue](https://github.com/cypress0522/listen2me/issues/new)；如果在使用过程中修改出更有意思的玩法，也欢迎到原仓库提交[PR](https://github.com/cypress0522/listen2me/pulls)。

```json
{
    "mod":"listen2me",
    "author":"简律纯",
    "ver":"1.1.8",
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

# 安装

- Dice版本2.6.5beta12(624+)以上安装方法:

  1. 在 `./DiceQQ/conf/mod/source.list`文件内（没有mod文件夹和这文件就新建）输入 `https://ssjskfjdj.netlify.app/Module/`。
  2. 使用 `.system load`命令重载bot，这样做的目的是为了让步骤1里的远程地址生效。
  3. 对bot发送 `.mod get listen2me`命令，等待安装。
  4. 回到第二步，这样做的目的是为了让mod被加载。
  5. Enjoy Your Self!
- Dice版本2.6.4b(612+)以上安装方法：

  1. 浏览器访问 `https://github.com/ssJSKFJDJ/listen2me`并点击绿色按钮 `Code`下的 `Download Zip`按钮下载仓库压缩包。
  2. 解压压缩包，将里面的文件和文件夹全部丢进 `./DiceQQ/mod/`文件夹内。
  3. 使用 `.system load`命令重载。
  4. Enjoy Your Self!

# 配置

[使用功能模块前先根据注释内容修改合适的配置](https://github.com/cypress0522/listen2me/blob/Windows-Version/script/mml2mid.lua)

```lua
--------------------settings---------------------
settings = {
    _FRAMWORK = "Gocq", -- "Mirai",
    -- 框架名称,必填,可选参数:'Mirai'或'Gocq'(默认).

    _ONEFILE = false, -- os.date("%A"),
    -- 是否将每次的乐谱记录在同一个文件内.

    _WARNING = 18,
    -- 音频文件过多报警上限,未填时默认18

    _AUTOCLR = 21,
    -- 音频文件自动清理，未填时默认21

    _SUBNAME = ".mp3", -- ".wav",
    -- 规定输出格式,填写mp3时需要安装ffmpeg.

    _UPLOAD = true, -- false,
    -- 是否在发出语音同时上传mid文件(仅限Gocq).
    -- 对应下参数_APIPORT.

    _APIPORT = 15700 -- nil
    -- Gocq 本地 API 端口,填nil时将自动搜寻,若报错请自行填入.
}
```

# 指令

一般指令格式:`l2m>[opt=clr|mml|...]

- 清理缓存
  成功执行一次mml命令后会在 `./project/`生成这几样东西:

  1. fileName.mid
  2. fileName.mml
  3. fileName.mp3|wav

  这些就是所谓的缓存，一次生成三个，因此才有了 `_WARNING`和 `_AUTOCLR`配置——但要注意的是，这些配置的存在只是为了那些不会主动的清理的人罢了，如果你比较勤快那么我想除了添加 `_ONEFILE`配置项外，你一定会经常使用 `l2m>clr`指令去清理这些缓存的。
- 生成曲谱
  指令格式:`l2m>[mml]`，由于mml语法过于繁琐因此在这里不一一赘述，只是做几个示例，日后会写专门的文档系统介绍此功能模块的mml语法。

  1. 单轨示例

  ```mml
  l2m>A cdefgab
  ```

  2. 多轨示例

  ```mml
  l2m>
  A l8d+>d+d+d+d4<a+4>cc<a+g+a+2d+>d+d+d+d4.<a+b+2g+4a+4d+>d+d+fd4<a+4>cl16d+f8.d+<a+4.&a+gfl8d+>d+d+gfd+dl16<a+>d+4.&d+cdd+8dd+8.<a+8>fgf2gg8.fd+f8cd+4&d+<a+8>gg8.fd+f8d+<a+4.&a+>gg8.fd+f8cd+4d+d+8dd8.cc8.<a+a+8.>cd+g+8.g8.fd+f8cd+4&d+<a+8>dd8d+8f<a+8ga+8>f8d+d+8.<a+a+8g+gg+8>d+d+2<a+a+8g+gg+8>ff4.&fd+8d+8df8d+2.

  B /*M 0  */  <c8g8>d+4<<g8>d8a+4/*M 1  */  <g+8>d+8<a+4>d+4d4/*M 2  */  c8g8>d+4<<g8>d8a+4/*M 3  */  <g+8>d+8>c8<d+8<g+8>d+8<a+8b8/*M 4  */  >c8g8>d+8<g8<g8>d8a+8d8/*M 5  */  <g+8>d+8<a+4>d+8a+8d4/*M 6  */  c8g8>d+8<g8<g8>d8a+8d8/*M 7  */  <g+8>d+8>c8.<<a+16b4g+4/*M 8  */  a+8>f8a+4<<a+2/*M 9  */  >g+8>d+8>c8<d+8<g+8>d8a+8d8/*M 10 */  <g8>d+8a+8d+8c8g8>d8d+8/*M 11 */  <<f8>g8>d+8<g+8<a+8>f8>d8<a+8/*M 12 */  <d+8a+8>d+8<a+8>c+8<a+8>c+8<<a+8/*M 13 */  >g+8>d+8>c8<d+8<g+8>d8a+8d8/*M 14 */  <g8>d8.<g8.>c4<d8d+8/*M 15 */  f8>c8g+8c8<g8>d+8a+8d+8/*M 16 */  <g+8>d+8>c8<d+16.<<a+32o4d2/*M 17 */  <<d+16a+16>g16g+16a+8.<d+4.&d+16d+8
  ```

# 音源

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

# 参考

- [http://hpc.jp/~mml2mid](http://hpc.jp/~mml2mid)
- [https://man.archlinux.org/man/timidity.cfg.5](https://man.archlinux.org/man/timidity.cfg.5)
- [https://man.archlinux.org/man/community/timidity++/timidity.1.en](https://man.archlinux.org/man/community/timidity++/timidity.1.en)
- 

# 日志

> 此日志写的比工程文件要晚那么一点。

---

<details>
<summary>2022年10月29日 发现了几个bug，更新了readme。</summary>
<h5>issue</h5>
1.<i>mml2mid.lua</i><b>timidity</b>线程问题，速度过快会导致timidity错误。
<h5>新增</h5>
1.<i>readme.md</i>新增指令介绍。
</details>

---

<details>
<summary>2022年10月13日 完善Gocq上传群文件机制。</summary>
<h5>新增</h5>
1.<i>mml2mid.lua</i><b>_UPLOAD</b>与<b>_APIPORT</b>完善，预期功能已实现。
<h5>改动</h5>
1.<i>mml2mid.lua</i>原本注释的<b>_WARNING</b>配置项现已恢复原有功能。
<br/>
2.<i>mml2mid.lua</i>配置项<b>_AUTOCLR</b>默认上限提高。
</details>

---

<details>
<summary>2022年10月11日 新增配置项。</summary>
<h5>新增</h5>
1.<i>mml2mid.lua</i>新增<b>_UPLOAD</b>与<b>_APIPORT</b>配置，详细使用说明见脚本。
</details>

---

<details>
<summary>2022年10月9日 实现了timidity.cfg的自动写入。</summary>
<h5>新增</h5>
1. <i>mml2mid.lua</i> 新增了对<i>timidity</i>音源的检测。
<br/>
2.<i>mml2mid.lua</i> 新增<i>_FRAMWORK</i>配置项，判断框架类型。
<br/>
3.<i>mml2mid.lua</i> 新增mml语法报错检测和输出(如果你看得懂那会很有帮助就是了)。
<h5>修复</h5>
1. 修复了因<i>timidity.cfg</i>参数<b>dir</b>固定而无法输出有声音的音频问题。
</details>

---

<details>
<summary>2022年10月8日 初步框架版本编写完毕。</summary>
<h5>新增</h5>
1. <i>mml2mid.lua</i> 新增一些配置项。
<br/>
2. 新增了对 <i>timidity.cfg</i> 的查询功能。
<h5>删减</h5>
1. 改动了部分语法。
</details>

---

<details>
<summary>2022年10月2日 准备套壳，已经实现mml转mid，mid转wav，下一阶段将会编写脚本使其脚本化。</summary>
<h5>新增</h5>
1. 添加<i>timidity</i>，放弃了原本直接发送<i>midi</i>序列的方式(这样<i>Go-cqhttp</i>会发不出语音)，在发送语音前会对<i>*.mid</i>文件进行转码再发送。
<h5>修复</h5>
1. 修复了一些bug。
</details>

***

2022年10月29日08点38分
