# KVAN2daform

Dit project is opgezet als een eenvoudige statische GitHub Pages-site.

## Live bron

De live homepage voor `www.archiefdag.nl` hoort uit deze bestanden te komen:

- `index.html`
- `CNAME`
- `img/`

Alleen `index.html` in de root is de actieve landingspagina die via Codex aangepast moet worden.

## Archief

Verouderde of dubbele pagina's staan in:

- `oud/`

Daar staan alleen archiefkopieen en die worden niet gebruikt als actieve publicatiebron.

## Werkwijze

1. Pas alleen `index.html` in de root aan.
2. Laat `CNAME` ongewijzigd op `www.archiefdag.nl` staan, tenzij het domein echt verandert.
3. Bewaar oude varianten alleen in `oud/`.
4. Draai voor publicatie: `powershell -ExecutionPolicy Bypass -File .\validate.ps1`
5. Controleer daarna in de browser of de homepage overeenkomt met de aangepaste root-`index.html`.

Zie ook `DEPLOY_CHECKLIST.md`.
