require('dotenv').config()

const express = require('express')
const app = express()
const port = process.env.PORT || 3000

app.get('/', (req, res) => {
  res.send('Welcome to the PixelArtAvenue API !')
})

app.listen(port, () => {
  console.log(`Server listening on ${port}`)
})