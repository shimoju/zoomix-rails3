# encoding: UTF-8

module Crypt
  module_function

  # ランダムなバイト列を生成してsaltとする
  def generate_salt(length = Settings.crypt.salt_length)
    OpenSSL::Random.random_bytes(length)
  end

  # パスワードとsaltをもらい、鍵とIV(Initialization Vector)をPKCS#5に従って生成して返す
  # パスワードはとりあえず一つを使い回す形。十分な長さにする
  # パスワードを都度変えても管理の負担が増えない方法があったらそうする
  # OpenSSL::Cipher#pkcs5_keyivgenは非推奨とのこと
  def generate_key_and_iv(cipher, salt, password)
    # ハッシュ関数の繰り返し（ストレッチ）回数
    stretching = Settings.crypt.stretching
    # 各暗号方式のkeyとIVの長さを足した分だけ生成する
    length = cipher.key_len + cipher.iv_len
    digest = 'sha256'
    key_and_iv = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, stretching, length, digest)
    # 結果からkey、ivの長さ分切り取る
    key = key_and_iv[0, cipher.key_len]
    iv = key_and_iv[cipher.key_len, cipher.iv_len]
    return key, iv
  end

  # 暗号化、復号化
  def encrypt(data, salt, password = Settings.crypt.password)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key, cipher.iv = generate_key_and_iv(cipher, salt, password)
    cipher.update(data) + cipher.final
  end

  def decrypt(encrypted_data, salt, password = Settings.crypt.password)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.decrypt
    cipher.key, cipher.iv = generate_key_and_iv(cipher, salt, password)
    cipher.update(encrypted_data) + cipher.final
  end
end
