#  Redmine Status Analytics Plugin

**Redmine Status Analytics Plugin**, Redmine projelerindeki *Issue (İş)* süreçlerini analiz ederek, işlerin hangi durumda ne kadar süre kaldığını ölçen ve bu verileri **grafiksel raporlar** halinde sunan bir eklentidir.

Bu proje, **staj başvurusu kapsamında** açık kaynak olarak geliştirilmiştir ve süreç verimliliğini artırmaya yönelik analizler sunmayı amaçlar.

---

##  Özellikler

###  Proje Bazlı Modül

* Eklenti, **proje ayarları** üzerinden kolayca aktif veya pasif hale getirilebilir.
* Her proje için bağımsız olarak kullanılabilir.

###  Durum Süre Analizi

* Seçilen bir işin, **hangi durumda ne kadar süre kaldığı** otomatik olarak hesaplanır.
* Süreç darboğazlarının tespit edilmesine yardımcı olur.

###  Görsel Raporlama

* Karmaşık tablolar yerine, **anlaşılır ve sade grafikler** ile veri sunumu.
* Süreç performansını hızlıca analiz etme imkânı.

###  Açık Kaynak

* Tüm kodlar şeffaftır.
* İncelenebilir, geliştirilebilir ve ihtiyaca göre özelleştirilebilir.

---

## 💻 Geliştirme Ortamı

Bu proje, **Apple Silicon (M2)** işlemcili bir MacBook üzerinde aşağıdaki ortamda geliştirilmiştir:

| Bileşen         | Sürüm / Detay              |
| --------------- | -------------------------- |
| İşletim Sistemi | macOS (Apple Silicon)      |
| Redmine         | Latest Development Version |
| Ruby            | 3.2.2                      |
| Veritabanı      | MySQL                      |

---

##  Hızlı Kurulum

Mevcut Redmine kurulumunuza eklentiyi entegre etmek için aşağıdaki adımları izleyin.

### 1️⃣ Eklentiyi İndirin

Redmine ana dizinindeki `plugins` klasörüne gidin ve projeyi klonlayın.
 **Klasör adının `redmine_status_analytics` olması gerekmektedir.**

```bash
cd redmine/plugins
git clone https://github.com/mehtapgultepe/redmine-status-analytics-plugin.git redmine_status_analytics
```

---

### 2️⃣ Bağımlılıkları Kurun ve Veritabanını Güncelleyin

Redmine ana dizinine dönerek gerekli gem paketlerini yükleyin ve migration işlemini çalıştırın:

```bash
cd ..
bundle install
bundle exec rake redmine:plugins:migrate RAILS_ENV=development
```

---

### 3️⃣ Redmine’i Başlatın

Sunucuyu yeniden başlatarak eklentiyi aktif hale getirin:

```bash
bundle exec rails server
```

---

## 📘 Detaylı Kurulum

Geliştirme ortamına özel, daha ayrıntılı kurulum ve yapılandırma adımları için
**`development.md`** dosyasını inceleyebilirsiniz.
