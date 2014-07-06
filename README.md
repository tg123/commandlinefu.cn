[commandlinefu.cn](http://commandlinefu.cn)
==================

打造 中文版的 http://commandlinefu.com

贡献你的力量
------------

 > [@titikaka723 写的github初学者贡献参考手册](http://c.blog.sina.com.cn/profile.php?blogid=605b307f890007kg)

 * 下载代码

```
$ git clone https://github.com/tg123/commandlinefu.cn.git
cd commandlinefu.cn
```

 * 寻找一个没有翻译的文件 (会调用你的 $EDITOR 来编辑这个文件) 

```
./tools/translateone.sh
```

 * 调用脚本set_translator_weibo_and_show.sh删除`hide:true`，并将`weibo: ''`替换成你的微博用户名

```
./tools/set_translator_weibo_and_show.sh 你的微博用户名
```

* 还可以创建$HOME/.commandlinefu/weibo.conf，保存你的微博用户名，以后调用set_translator_weibo_and_show.sh的时候，就可以省略用户名了

```
mkdir ~/.commandlinefu && echo "weibo_id" > ~/.commandlinefu/weibo.conf
./tools/set_translator_weibo_and_show.sh
```

* 可以添加pre-commit钩子脚本，在没有运行set_translator_weibo_and_show.sh就commit的情况下，出错并提醒自己

```
cp tools/pre-commit .git/hooks/
sudo chmod u+x .git/hooks/pre-commit
```

* 创建自己发现或总结的命令

```
./tools/create_cmd.py
```

 * 翻译参考

```
$ git diff _data/head_n_20_filename_tail.yaml
diff --git a/_data/head_n_20_filename_tail.yaml b/_data/head_n_20_filename_tail.yaml
index b5d0efe..970e1a8 100644
--- a/_data/head_n_20_filename_tail.yaml
+++ b/_data/head_n_20_filename_tail.yaml
@@ -1,8 +1,7 @@
 commandlinefu_id: 7044
 translator:
-  weibo: ''
-hide: true
+  weibo: tgic
 command: |-
   head -n 20 <filename> | tail
 summary: |-
-  Print all the lines between 10 and 20 of a file
+  输出文件的10到20行
```
  
 * 说明 

  1. `weibo: tgic` 会在页面显示出 `@tgic` 翻译
  1. 删除 `hide: true` 自动构建程序会知道你已经翻译了这个文件
  1. 内容就是 summary 编译成汉语就好了 当然命令你也可以修改

 * 发送你的 `pull request`
 

实现原理
--------

安装需要的软件 **ruby 需要 > 1.9.2**

```
gem install jekyll nokogiri json
```

网站使用 [jekyll](http://jekyllrb.com/) 构建. **需要至少1.3**

可以通过运行

```
jekyll build
```

在本地构建你的网站

### 依赖的插件
 * [Sitemap.xml Generator by Michael Levin](https://github.com/kinnetica/jekyll-plugins)
 * [Jekyll + lunr.js by Ben Smith](https://github.com/slashdotdash/jekyll-lunr-js-search)

关于使用commandlinefu.com内容
-----------------------------

commandlinefu.com 站长 David Winterbottom :

> You're welcome to re-publish the commandlinefu content.


授权(public domain)
-------------------
