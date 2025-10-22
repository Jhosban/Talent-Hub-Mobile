const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Configuración de Smartcar
const clientId = process.env.CLIENT_ID;
const clientSecret = process.env.CLIENT_SECRET;
const redirectUri = process.env.REDIRECT_URI;
const smartcarAuthUrl = 'https://connect.smartcar.com/oauth/authorize';
const smartcarTokenUrl = 'https://auth.smartcar.com/oauth/token';

// Ruta de inicio de sesión
app.get('/login', (req, res) => {
  const authUrl = `${smartcarAuthUrl}?response_type=code&client_id=${clientId}&redirect_uri=${redirectUri}&scope=read_vehicle_info`;
  res.redirect(authUrl);
});

// Ruta de callback
app.post('/callback', async (req, res) => {
  const { code } = req.body;

  try {
    const response = await axios.post(smartcarTokenUrl, {
      grant_type: 'authorization_code',
      client_id: clientId,
      client_secret: clientSecret,
      code,
      redirect_uri: redirectUri,
    });

    res.json(response.data); // Devuelve tokens al cliente
  } catch (error) {
    console.error('Error al intercambiar el código:', error.response.data);
    res.status(500).json({ error: 'Error al intercambiar el código' });
  }
});

// Ruta para obtener información del vehículo
app.get('/vehicle', async (req, res) => {
  const { accessToken } = req.headers;

  try {
    const vehicleResponse = await axios.get(
      'https://api.smartcar.com/v1.0/vehicles',
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      }
    );

    res.json(vehicleResponse.data);
  } catch (error) {
    console.error('Error al obtener información del vehículo:', error.response.data);
    res.status(500).json({ error: 'Error al obtener información del vehículo' });
  }
});

// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
