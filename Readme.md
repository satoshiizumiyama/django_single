docker build -t django_tutorial .
docker run -it -p 8888:8888 image_id /bin/bash
で動作確認。追加で行うコマンドは
django-admin startproject mysite
cd mysite
python manage.py runserver 0.0.0.0:8888
ポイントはdockerの影響かは不明だがrunserverを実行する時に0.0.0.0を指定しないとアクセスできないこと

参考サイト
https://qiita.com/homines22/items/2730d26e932554b6fb58
https://qiita.com/ryoma_kochi/items/55d015ed9cb0a61b55a6

以下注意点だったが、Dockerfileの書き方を変えたらかってに直った。build中は古いまま(だから絶対パスでpipしてる)
pyenvを使用しているためdjango-adminのパスを通さないといけないこと
export PATH="$PATH:/root/.pyenv/versions/3.8.5/bin"
