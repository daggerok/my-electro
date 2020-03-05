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

```bash
npm i -ED electron-packager
echo "release-builds/" >> .gitignore
npm run package-mac
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
