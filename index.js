const express = require('express');
const app = express();
const PORT = process.env.PORT || 80

app.get('/', (req, res) => {
  res.send('Hello from Simple Node App!');
});


app.get('/health', (req, res) => {
  res.status(200).send('OKK');
});

app.listen(PORT, () => {
  console.log(`Server is runner on port ${PORT}`);
});
