# my electro
Quick electron getting started guide...

## create

```bash
mkdir my-electro
cd my-electro
npm init -y
npm i -ED electron
touch index.html
touch main.js # app main entry point
```

## update

your `package.json` file:

```json
{
  "main": "main.js",
  "scripts": {
    "start": "electron ."
  }
}
```

## run

```bash
npm start
```

## release

### build

_install packager_

```bash
npm i -ED electron-packager
```

_add scripts_

```bash
vi package.json
```

```json
{
  "scripts": {
    "start": "electron .",
    "build": "npm-run-all package:*",
    "package:mac": "  electron-packager . electron-tutorial-app --overwrite --asar --platform=darwin --arch=x64 --prune=true --out=dist  --version-string.CompanyName=daggerok --version-string.FileDescription=UA --version-string.ProductName=\"MyElectro\"",
    "package:linux": "electron-packager . electron-tutorial-app --overwrite --asar --platform=linux  --arch=x64 --prune=true --out=dist  --version-string.CompanyName=daggerok --version-string.FileDescription=UA --version-string.ProductName=\"MyElectro\""
    "zip": "for i in `ls dist` ; do zip -d dist/$i > dist/$i.zip ; done"
  }
}
```

_build apps_

```bash
npm run build
```

_package apps_

```bash
npm run zip
```

_test archives_

```bash
unzip dist/electron-tutorial-app-darwin-x64.zip -d dist/app  
```

### prepare

```bash
git add .
git commit -am ...
```

### perform using node

```bash
npm version patch
#npm version patch -m "Message..."
git push origin --tags
```

### perform using [github-release.sh](github-release.sh) script

```bash
GITHUB_TOKEN=abcd123... ./github-release.sh "Message..."
## or:
# ./github-release.sh "Message..." abcd123...
```
