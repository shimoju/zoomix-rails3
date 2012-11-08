Zoomix : Always by your side.
======

Zoomixはネット上の動画をテレビ感覚で楽しめる新しい動画サービスです。

あなたのTwitterタイムライン上に流れてきた動画を自動的に再生してくれます。つまり、Zoomixはあなたの身近な情報を凝縮した自分専用チャンネルなのです。

…というのを目指しています。


Setup (Local)
-------------

### Install

```shell
git clone https://github.com/shimoju/zoomix.git zoomix
cd zoomix
bundle install --without production
rake db:migrate
cp config/settings.yml config/settings.local.yml
```

### Edit config/settings.local.yml

```yaml
secret_token: random_chars_for_signed_cookie(>=30 chars)
twitter:
  key: your_twitter_consumer_key
  secret: your_twitter_consumer_secret
crypt:
  salt_length: 32
  stretching: 10000
  password: your_password
```

### Start server

```shell
rails s
```

Open `http://localhost:3000/`

### Use Guard

Run `rake db:test:prepare` or `rake spec`

```shell
guard
```


License
-------

Copyright © 2012 dbsh5th Web Apllication Team