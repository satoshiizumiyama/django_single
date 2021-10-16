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
nginxとuwsgiの連携  
nginx.confとuwsgi_paramsの2つの設定ファイルを作成し、/etc/nginx/conf.d/と/etc/nginx/にそれぞれコピーする  
nginxをserverコマンドで起動  
settings.pyでSTATIC_ROOTを設定  
python manage.py collectstaticで設定したパスにstaticを作成する  
djangoのプロジェクト内部でuwsgi --socket :8001 --module mysite.wsgi --py-autoreload 1 --logto /tmp/mylog.logを実行(app.wsgiのappはプロジェクト名に依存)  
chdirを使えば実行するパスは調整できる。プロジェクトのルートになるよう調整  
  
学習ポイント
app_nginx.confのupstreamのserverに別ipアドレスを指定すればnginxとuwsgiを別コンテナで動かすことができる  
staticのパスはsettings.pyの他にapp_nginx.confでそろえる必要がある  
  
参考サイト  
https://www.sejuku.net/blog/28751  
https://qiita.com/kenkono/items/6221ad12670d1ae8b1dd  

