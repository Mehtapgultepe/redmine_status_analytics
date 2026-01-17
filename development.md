# 🛠️ Kurulum ve Yapılandırma (Development Guide)

Bu doküman, **Redmine Status Analytics Plugin** geliştirme sürecine başlamadan önce
macOS üzerinde gerekli bağımlılıkların, veritabanı ortamının ve Redmine altyapısının
nasıl hazırlandığını adım adım açıklamaktadır.

---

##  Sistem Gereksinimleri (Ruby & MySQL)

Geliştirme ortamı için öncelikle Ruby ve MySQL kurulumu yapılmalıdır.

###  Ruby Kurulumu (rbenv ile)

```bash
rbenv install 3.2.2
rbenv global 3.2.2
```

Ruby sürümünü kontrol edin:

```bash
ruby -v
```

---

###  MySQL Kurulumu ve Servis Başlatma

```bash
brew install mysql
brew services start mysql
```

---

##  Veritabanı Oluşturma

MySQL sunucusuna bağlanarak Redmine için gerekli veritabanı ve kullanıcıyı oluşturun.

###  MySQL Konsoluna Giriş

```bash
mysql -u root -p
```

###  SQL Komutları

```sql
CREATE DATABASE redmine CHARACTER SET utf8mb4;

CREATE USER 'redmine'@'localhost'
IDENTIFIED BY 'my_password';

GRANT ALL PRIVILEGES ON redmine.*
TO 'redmine'@'localhost';

EXIT;
```

---

##  Redmine Kaynak Kodunu İndirme

Güncel Redmine sürümünü GitHub üzerinden klonlayın:

```bash
cd ~
git clone https://github.com/redmine/redmine.git
cd redmine
```

---

##  Veritabanı Bağlantı Ayarları

Örnek veritabanı yapılandırma dosyasını kopyalayın:

```bash
cp config/database.yml.example config/database.yml
```

Dosyayı düzenleyerek kullanıcı adı ve şifre bilgilerini girin:

```bash
open -e config/database.yml
```

---

##  Bağımlılıkların Yüklenmesi ve İlk Kurulum

###  Gerekli Gem Paketlerinin Yüklenmesi

(PostgreSQL ve SQLite hariç tutulmuştur)

```bash
bundle install --without postgresql sqlite
```

###  Güvenlik Anahtarı Oluşturma

```bash
bundle exec rake generate_secret_token
```

###  Veritabanı Tablolarını Oluşturma

```bash
bundle exec rake db:migrate
```

###  Varsayılan Verileri Yükleme (Dil: ing)

```bash
bundle exec rake redmine:load_default_data
```

---

## ▶️dSunucuyu Başlatma

Kurulum tamamlandıktan sonra Redmine sunucusunu başlatın:

```bash
bundle exec rails server
```

🌐 Tarayıcıdan erişim:
**[http://localhost:3000](http://localhost:3000)**

---

##  Eklenti Geliştirme (Plugin Generation)

Redmine Status Analytics Plugin için temel eklenti iskeleti aşağıdaki komutla oluşturulmuştur:

```bash
bundle exec rails generate redmine_plugin redmine_status_analytics
```

Bu işlem sonrasında eklenti,
`redmine/plugins/redmine_status_analytics` dizini altında oluşturulur.

---
