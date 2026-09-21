# nandlars

Eine statische, deutschsprachige persönliche Website für Musik, Bücher & Kultur, Fotografie sowie Orte und Reisen. Sie ist bewusst als ruhiges, erweiterbares Grundgerüst angelegt – alte Joomla-Inhalte werden nicht übernommen.

## Lokal starten

Es werden keine Build-Tools oder Abhängigkeiten benötigt. Im Projektordner:

```bash
python3 -m http.server 8080
```

Danach [http://localhost:8080](http://localhost:8080) öffnen. Ein lokaler Server ist wichtig, damit sich die Website wie beim späteren Hosting verhält.

## Struktur

```text
├── index.html          Startseite mit Themenbereichen
├── archive.html        bewusst leere, später erweiterbare Archivübersicht
├── impressum.html      vor Veröffentlichung zu vervollständigende Vorlage
├── assets/
│   ├── css/main.css    Design und responsive Layouts
│   └── js/main.js      zugängliche mobile Navigation
└── deploy/s3-sync.sh   optionaler Upload-Helfer für später
```

Neue Artikel können zunächst als eigene HTML-Dateien angelegt und von `archive.html` verlinkt werden. Bilder gehören sinnvollerweise in `assets/images/`; pro Bild bitte einen aussagekräftigen Alternativtext verwenden. Bei wachsendem Archiv kann die vorhandene Struktur ohne Framework in eine daten- oder generatorbasierte Lösung überführt werden.

## Späteres AWS-Deployment (S3 + CloudFront)

Es wurden **keine AWS-Ressourcen, DNS- oder Domain-Einstellungen** angelegt bzw. geändert. Die Datei `deploy/s3-sync.sh` ist nur eine opt-in Hilfe für den späteren Upload.

Vorgesehener Ablauf:

1. Einen privaten S3-Bucket in der gewünschten AWS-Region erstellen und die statischen Dateien hochladen.
2. Eine CloudFront-Distribution mit dem S3-Bucket als Origin Access Control (OAC) einrichten; HTTPS erzwingen und eine Standardfehlerseite auf `index.html` umleiten, falls eine Single-Page-Variante folgt.
3. Eine restriktive Bucket-Policy verwenden, die nur diese CloudFront-Distribution lesen lässt.
4. Erst nach Prüfung einen bestehenden Domainnamen in der DNS-Verwaltung auf CloudFront zeigen lassen und ein ACM-Zertifikat in `us-east-1` verwenden.
5. Nach Inhaltsänderungen `./deploy/s3-sync.sh <bucket-name>` ausführen und anschließend gezielt CloudFront invalidieren.

Vor dem ersten Livegang bitte Impressum, Datenschutz, Kontaktadresse, Bildrechte und die `example.com`-Adresse in `index.html` prüfen und ersetzen.
