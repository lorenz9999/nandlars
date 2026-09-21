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

Vor dem ersten Livegang bitte Impressum, Datenschutz, Kontaktadresse, Bildrechte und die `example.com`-Adresse in `index.html` prüfen und ersetzen.


## Terraform und automatisches Deployment

Die Konfiguration unter `infrastructure/` erstellt bei einem späteren, manuell gestarteten `terraform apply` einen privaten und verschlüsselten S3-Bucket, eine CloudFront-Distribution mit OAC und Standard-HTTPS-Zertifikat, die strikt auf diese Distribution begrenzte S3-Leserichtlinie sowie eine GitHub-OIDC-Deploy-Rolle. Es wurden keine AWS-Ressourcen, keine DNS- oder Route-53-Einträge und kein eigener Domainname angelegt.

Vor `terraform apply`:

1. `cd infrastructure` und `cp terraform.tfvars.example terraform.tfvars` ausführen.
2. In `terraform.tfvars` `github_repository` auf `OWNER/nandlars` setzen; `aws_region` und `bucket_name_prefix` bei Bedarf anpassen.
3. Terraform mit einem AWS-Principal starten, der S3-, CloudFront- und IAM-Ressourcen erstellen darf: `terraform init`, `terraform plan`, dann nach Prüfung `terraform apply`. Für Teams sollte zuvor ein gemeinsames, abgesichertes Terraform-Backend gewählt werden.
4. Die Outputs als GitHub Actions **Repository variables** eintragen: `AWS_REGION` (der gewählte Regionswert), `AWS_ROLE_TO_ASSUME` (`github_actions_role_arn`), `S3_BUCKET_NAME` (`website_bucket_name`) und `CLOUDFRONT_DISTRIBUTION_ID` (`cloudfront_distribution_id`).

Danach führt jeder Push auf `main` den OIDC-basierten Upload nach S3 und eine CloudFront-Invalidierung aus. Es sind keine langlebigen AWS-Schlüssel in GitHub erforderlich. Bis alle vier Variablen gesetzt sind, wird der Workflow-Job übersprungen. Die vorläufige öffentliche Adresse liefert der Output `cloudfront_url`.
