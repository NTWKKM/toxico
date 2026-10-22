import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = 3000;

app.use('/pdfs', express.static(path.join(__dirname, 'pdfs')));
app.use('/docs', express.static(path.join(__dirname, 'docs')));
// Backward-compatible root fallback for PDFs and docs only (without exposing server.js/package.json)
app.use(express.static(path.join(__dirname, 'pdfs')));
app.use(express.static(path.join(__dirname, 'docs')));

app.get(['/', '/index.html'], (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.use((req, res) => {
  if (path.extname(req.path)) {
    res.status(404).end();
    return;
  }
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});

