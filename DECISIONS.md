# Teknik Kararlar

## Chart.js

Grafik kütüphanesi ararken Chart.js ve Recharts'a baktım. Recharts React gerektiriyor, Redmine'de React kullanmak gereksiz karmaşıklık yaratırdı. Chart.js CDN ile direkt eklenebiliyor, Rails ile entegrasyonu daha basit oldu.

## DataTables

İş listesini sıralanabilir yapmak için önce kendi JavaScript kodumu yazmayı düşündüm ama DataTables'ın bunu çok daha temiz çözdüğünü gördüm. Mevcut tabloya tek satır ekliyorsun, hem sıralama hem arama geliyor. MIT lisanslı ve açık kaynak.

## Durum sürelerini controller'da hesaplamak

Bunu veritabanında hesaplatmak yerine Ruby'de yapmayı tercih ettim. Redmine'in journal tablosu zaten zaman damgalarını tutuyor, iki kayıt arasındaki farkı almak yeterliydi. Ayrı bir migration yazmadan mevcut yapıyla çalışmak daha mantıklı geldi.

## N+1 sorgu ve Zaman Karmaşıklığı

Başta fark etmedim. Küçük veriyle test ettiğimde sorun görünmüyordu. Sonradan her döngü adımında veritabanına gidildiğini anlayınca `includes()` ekledim. Projedeki kayıt sayısı arttıkça performansın düşmemesi için gerekli.

Controller'daki döngü yapısı iç içe üç döngüden oluşuyor — issue'lar, journal'lar ve detail'lar. Zaman karmaşıklığı **O(n × m × k)** — n issue sayısı, m journal sayısı, k detail sayısı. m ve k pratikte küçük sabit değerler olduğundan gerçekte **O(n)** gibi davranıyor.

`includes()` eklemeden önce her döngü adımında SQL sorgusu açılıyordu — bu Big-O değerini değiştirmiyor ama veritabanı bağlantı maliyeti sabit faktörü çok büyütüyordu. `includes()` ile veri bir kerede belleğe alındığından döngüler bellekte çalışıyor, gerçek dünya performansı önemli ölçüde iyileşti.

## json_escape

View'da `html_safe` kullanıyordum, sonradan bunun XSS açığı oluşturduğunu fark ettim. Issue başlığına script kodu yazılırsa tarayıcıda çalışırdı. Rails'in `json_escape` helper'ı bunu önlüyor.

## Modal

Lifecycle detayı için ayrı sayfa açmak istemedim. Kullanıcı listeye bakıyor, bir işe tıklıyor, detayı görüyor — aynı sayfada kalması daha kullanışlı.

## D3.js

Bar chart'ları başta Chart.js ile yazmıştım. Sonradan D3.js ile yeniden yazdım. Chart.js kullanıma hazır grafikler sunuyor, D3 ise SVG üzerinde tam kontrol sağlıyor — eksen, bar boyutu, renk, pozisyon gibi her şeyi kendin belirliyorsun. Bu esneklik daha fazla öğrenme gerektiriyor ama görsel üzerinde çok daha fazla kontrol sağlıyor. MIT lisanslı ve açık kaynak.
