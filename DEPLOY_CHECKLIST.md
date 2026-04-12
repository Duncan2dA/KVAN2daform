# Deploy Checklist

Gebruik deze checklist voordat je publiceert of live controleert.

## Voor publicatie

1. Werk alleen in `index.html` in de root.
2. Controleer dat oude of dubbele pagina's alleen in `oud/` staan.
3. Controleer dat `CNAME` exact `www.archiefdag.nl` bevat.
4. Draai `powershell -ExecutionPolicy Bypass -File .\validate.ps1`.
5. Controleer visueel de pagina in een browser.

## Na publicatie

1. Open `https://www.archiefdag.nl/` in een gewone browser.
2. Controleer of de belangrijkste kopregel en eventdata overeenkomen met de root-`index.html`.
3. Controleer of het formulier zichtbaar is en geen layoutproblemen heeft.
4. Als live iets anders toont, controleer dan eerst cache/CDN en daarna pas de repo-structuur.
