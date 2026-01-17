Redmine Status Analytics Plugin
Bu eklenti, Redmine üzerindeki projelerde Issue (İş) durum analizini yapar ve süreçlerin verimliliğini ölçmek için grafiksel raporlar sunar.

Bu proje, staj başvurusu kapsamında açık kaynaklı olarak geliştirilmiştir.

Özellikler
Proje Bazlı Modül: Eklenti, proje ayarlarından istendiği zaman açılıp kapatılabilir.

Durum Analizi: Bir iş seçildiğinde, hangi durumda ne kadar süre kaldığını hesaplar.

Görsel Raporlama: Verileri karmaşık tablolar yerine anlaşılır grafiklerle sunar.

Açık Kaynak: Kodlar tamamen şeffaftır; incelenebilir, geliştirilebilir ve özelleştirilebilir.

💻 Geliştirme Ortamı
Bu proje Apple Silicon (M2) işlemcili bir MacBook üzerinde, aşağıdaki konfigürasyonla geliştirilmiştir:

Bileşen	Sürüm / Detay
İşletim Sistemi	macOS (Apple Silicon)
Redmine	Latest Development Version
Ruby	3.2.2
Veritabanı	MySQL

Hızlı Kurulum
Bu eklentiyi mevcut Redmine kurulumunuza entegre etmek için aşağıdaki adımları izleyin.

1. Eklentiyi İndirin

Redmine ana dizininizdeki plugins klasörüne gidin ve projeyi klonlayın. (Klasör adının redmine_status_analytics olması önemlidir)

Bash
cd redmine/plugins
git clone https://github.com/mehtapgultepe/redmine-status-analytics-plugin.git redmine_status_analytics
2. Bağımlılıkları Kurun ve Veritabanını Güncelleyin

Redmine ana dizinine geri dönün ve gerekli gem paketlerini yükleyip veritabanı göçünü (migration) başlatın.

Bash
cd ..
bundle install
bundle exec rake redmine:plugins:migrate RAILS_ENV=development
3. Redmine'i Başlatın

Sunucuyu yeniden başlatarak eklentiyi aktif hale getirin.

Bash
bundle exec rails server