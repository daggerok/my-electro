const { app, BrowserWindow } = require('electron');

function createWindow() {
  // Create the browser window.
  let win = new BrowserWindow({
    width: 300,
    height: 150,
    webPreferences: {
      nodeIntegration: true
    }
  });

  // and load the index.html of the app.
  win.loadFile('index.html');
}

app.whenReady().then(createWindow);
