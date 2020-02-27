# my electro...

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
