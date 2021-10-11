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
  
参考サイト  
https://qiita.com/homines22/items/2730d26e932554b6fb58  
https://qiita.com/ryoma_kochi/items/55d015ed9cb0a61b55a6  
https://yuki.world/django-vscode-debug/  

以下注意点だったが、Dockerfileの書き方を変えたらかってに直った。build中は古いまま(だから絶対パスでpipしてる)  
pyenvを使用しているためdjango-adminのパスを通さないといけないこと  
export PATH="$PATH:/root/.pyenv/versions/3.8.5/bin"  
