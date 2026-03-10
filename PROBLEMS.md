# Yaşadığım Problemler ve Çözümleri

## 1. Dosya Uzantısı Sorunu

`status_analytics_controller.rb` dosyasını nano ile oluştururken kaydetmeden çıktım. nano dosyayı `.save` uzantısıyla kaydetti — `status_analytics_controller.rb.save` oldu. Ruby `.rb` uzantılı dosyaları okuduğu için bu dosyayı görmezden geldi, sanki kodu hiç yazmamışım gibi davrandı.

`mv` komutuyla dosyanın ismini düzelterek çözdüm:

```bash
mv status_analytics_controller.rb.save status_analytics_controller.rb
```

---

## 2. jQuery Çakışması

DataTables'ı entegre ederken tarayıcı konsolunda `TypeError: $ is not a function` hatası aldım. Redmine kendi jQuery'sini zaten yüklüyor, CDN'den ayrıca jQuery çağırınca ikisi çakıştı.

`$` yerine `jQuery` kullanarak ve önce jQuery'nin tanımlı olup olmadığını kontrol ederek çözdüm:

```javascript
if (typeof jQuery !== 'undefined') {
  jQuery('#analyticsTable').DataTable({ ... });
}
```

---

## 3. Sözdizimi ve Tırnak Çakışması

Issue başlıklarını `onclick` içinde JavaScript'e aktarırken `Unexpected EOF` hatası aldım. Başlıkta boşluk veya özel karakter olunca HTML attribute'u bozuluyordu.

`json_escape` ile veriyi encode ederek çözdüm — bu sayede özel karakterler güvenli hale geldi ve aynı zamanda XSS açığı da kapandı.

```erb
onclick='showIssueDetail(<%= json_escape(is[:subject].to_json) %>, <%= json_escape(is[:lifecycle].to_json) %>)'>
```
