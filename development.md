Kurulum ve Yapılandırma
Bu proje geliştirilmeye başlanmadan önce, macOS üzerinde gerekli bağımlılıklar ve veritabanı ortamı aşağıdaki adımlarla hazırlanmıştır.

1. Sistem Gereksinimleri (Ruby & MySQL)

Öncelikle Ruby ortamı ve veritabanı sunucusu kurulur.

Bash
# Ruby'yi kur ve sürümü sabitle
rbenv install 3.2.2
rbenv global 3.2.2

# MySQL'i kur ve servisi başlat
brew install mysql
brew services start mysql
2. Veritabanı Oluşturma

MySQL sunucusuna bağlanıp Redmine için gerekli veritabanı ve kullanıcı izinleri tanımlanır.

Bash
# MySQL konsoluna giriş yap
mysql -u root -p
MySQL konsolu açıldıktan sonra aşağıdaki SQL komutlarını çalıştırın:

SQL
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'my_password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
EXIT;
3. Redmine Kaynak Kodunu İndirme

GitHub üzerinden güncel Redmine sürümü indirilir.

Bash
cd ~
git clone https://github.com/redmine/redmine.git
cd redmine
4. Veritabanı Bağlantı Ayarları

Örnek ayar dosyası kopyalanır ve düzenlenir.

Bash
cp config/database.yml.example config/database.yml

# Dosyayı metin editörü ile açıp şifre/kullanıcı bilgilerini girin
open -e config/database.yml
5. Bağımlılıkların Yüklenmesi ve Kurulum

Gerekli Ruby kütüphaneleri (gem) yüklenir ve veritabanı tabloları oluşturulur.

Bash
# Gereksiz veritabanı sürücülerini hariç tutarak kurulum yap
bundle install --without postgresql sqlite

# Güvenlik anahtarını oluştur
bundle exec rake generate_secret_token

# Veritabanı tablolarını oluştur (Migration)
bundle exec rake db:migrate

# Varsayılan verileri yükle (Dil seçimi: tr)
bundle exec rake redmine:load_default_data
6. Sunucuyu Başlatma

Kurulum tamamlandıktan sonra uygulama sunucusu ayağa kaldırılır.

Bash
bundle exec rails server
Erişim: Tarayıcınızda http://localhost:3000 adresine giderek kontrol edebilirsiniz.

7. Eklenti Geliştirme (Plugin Generation)

Proje için gerekli eklenti iskeleti aşağıdaki komutla oluşturulmuştur.

Bash
bundle exec rails generate redmine_plugin redmine_status_analytics