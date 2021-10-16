docker build -t django_tutorial .  
docker run -it -p 8888:8888 image_id /bin/bash  
で動作確認。追加で行うコマンドは  
django-admin startproject mysite  
cd mysite  
python manage.py runserver 0.0.0.0:8888  
dockerの影響かは不明だがrunserverを実行する時に0.0.0.0を指定しないとアクセスできないことに注意  
  
2021/10/7  
remote containerを使ってvscode上で作業できるように修正(今まではviで編集等やっていた)  
.devcontainerを新規作成  
launch.jsonを新規作成  
Dockerfileのrootユーザだったものをvscodeユーザに修正  
ポイントは以下  
最初、launch.jsonのconfiguration対象としてpythonやdjangoが認識されなかった.  
　devcontaienrのextensionが重要。django(フレームワーク)だけでなくpython(元なる言語)を入れることで解決(手動は反映させる必要が多分ある)  
デバッガがpython(のパス)を認識しなかった。launch.jsonやsetting.jsonでpythonのパスを指定してもうまくいかない。  
　結局vscodeのpython:Select Interpret ("Ctrl+Shift+p"で設定可能)でpythonパスを指定をすることで解決  
  
2021/10/16  
apacheを使って起動するように修正(apache、django間の連携はmod_wsgiを利用)  
requirements.txtにmod_wsgi追加  
devcontainerにポートを追加(8000はdjangoのデフォルトのポート)  
apacheの設定ファイルをsettingフォルダに追加  
Dockerfileに必要なパッケージのインストール。設定ファイルのコピー、設定の反映コマンドを実行を追加(本当はapache2ctl restartもしたいがうまくいかなかった)  
ポイントは以下  
・mod_wsgiのpip installがうまくいかなかった。aptでapache-devを入れることと、pyenvのインストール時に環境変数を使うことで解決  
・参考サイトでは設定ファイルにpythonパスを追記していたが、pythonのバーチャル環境では当然問題になる(レスポンスがかえって来ない)  
　今回は書かない方法で対処。書きたい場合はmod_wsgi-express install-moduleに書いてあるパスを書く  
  
学習ポイント
・開発ツールのパッケージ名はubuntuとcentosで違う。ubuntuは~-dev。centosは~-devel  
　そして、利用するだけならともかく、何かしら手を加えるならdev系統パッケージは入れたほうがよい  
・perlのエラーが出る時、aptでlocales-allを使うとエラーが解消した  
・pipを使ってinstallする時に、gcc(共有ライブラリ)を使うことがある。pyenvはデフォルトだとそれが失敗することがある(共有ライブラリを使えないっぽい)  
　PYTHON_CONFIGURE_OPTS="--enable-shared"を追加することで解決する  
・apacheに機能を追加する時には/etc/apache2/site-available等にconfファイルを追加することで可能となる  
　場合によっては競合を起こすものもあるので、それはa2dissiteコマンドで止める(有効にするにはa2ensiteコマンド)  

参考サイト  
https://qiita.com/homines22/items/2730d26e932554b6fb58  
https://qiita.com/ryoma_kochi/items/55d015ed9cb0a61b55a6  
https://yuki.world/django-vscode-debug/
https://qiita.com/itisyuu/items/dafa535adc8197208af1  

以下注意点だったが、Dockerfileの書き方を変えたらかってに直った。build中は古いまま(だから絶対パスでpipしてる)  
pyenvを使用しているためdjango-adminのパスを通さないといけないこと  
export PATH="$PATH:/root/.pyenv/versions/3.8.5/bin"  
