const express = require('express');
const path = require('path');
const { Pool } = require('pg');
const fetch = require('node-fetch');
const bodyParser = require('body-parser');

const app = express();
const port = 3001; // Cambia el puerto si es necesario

// Configuración para servir archivos estáticos desde la carpeta 'site'
app.use(express.static(path.join(__dirname)));

// Ruta para servir index.html al acceder a la raíz
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Middleware para parsear datos de formularios URL-encoded
app.use(express.urlencoded({ extended: true }));

// Middleware para parsear datos JSON
app.use(express.json());
app.use(bodyParser.json());

// Configuración de la base de datos
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'venta-kits',
    password: '123',
    port: 5432,
});

// Conexión a la base de datos
pool.connect()
    .then(() => console.log('Conectado a la base de datos'))
    .catch(err => console.error('Error al conectar a la base de datos', err.stack));

// Ruta para obtener unidades educativas
app.get('/unidades-educativas', async (req, res) => {
    try {
        const result = await pool.query('SELECT nombre FROM unidad_educativa');
        res.json({ unidades: result.rows });
    } catch (err) {
        console.error('Error fetching units:', err);
        res.status(500).json({ error: 'Error fetching units' });
    }
});

// Obtener precio del kit
app.get('/precio-kit/:nombre', async (req, res) => {
    const nombre = req.params.nombre;
    try {
        const result = await pool.query('SELECT precio FROM modelo_kit WHERE nombre = $1', [nombre]);
        if (result.rows.length > 0) {
            res.json({ precio: result.rows[0].precio });
        } else {
            res.status(404).json({ error: 'Kit not found' });
        }
    } catch (err) {
        console.error('Error fetching kit price:', err);
        res.status(500).json({ error: 'Error fetching kit price' });
    }
});

app.post('/comprar', async (req, res) => {
    const { cedula, nombre, direccion, telefono, correo, unidadEducativa, nombreKit } = req.body;

    try {
        // Obtener el número de unidad educativa
        const unidadResult = await pool.query('SELECT numero_ue FROM unidad_educativa WHERE nombre = $1', [unidadEducativa]);
        const numeroUE = unidadResult.rows.length > 0 ? unidadResult.rows[0].numero_ue : null;

        // Obtener el precio del kit
        const precioResult = await pool.query('SELECT precio FROM modelo_kit WHERE nombre = $1', [nombreKit]);
        const precioKit = precioResult.rows.length > 0 ? precioResult.rows[0].precio : null;

        if (!precioKit) {
            return res.status(400).json({ error: 'El precio del kit no está disponible.' });
        }

        // Insertar la compra en la tabla 'compra_kit'
        await pool.query(
            `INSERT INTO compra_kit (cedula_cliente, nombre_cliente, direccion, telefono, correo, numero_ue, nombre_kit, monto)
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
            [cedula, nombre, direccion, telefono, correo, numeroUE, nombreKit, precioKit]
        );

        // Actualizar la columna 'total_vendido' en la tabla 'modelo_kit'
        await pool.query(
            `UPDATE modelo_kit
             SET total_vendido = total_vendido + 1
             WHERE nombre = $1`,
            [nombreKit]
        );

        res.status(200).json({ message: 'Compra realizada con éxito' });
    } catch (err) {
        console.error('Error processing purchase:', err);
        res.status(500).json({ error: 'Error processing purchase' });
    }
});

app.get('/productos', async (req, res) => {
    try {
      const result = await pool.query(`
        SELECT 
          num_kit,
          nombre, 
          precio, 
          curso, 
          descripcion, 
          subtitulo, 
          url_imagen 
        FROM modelo_kit
      `);
      
      
  
      if (result.rows.length > 0) {
        res.json({ productos: result.rows });
      } else {
        res.status(404).json({ error: 'No se encontraron productos.' });
      }
    } catch (err) {
      console.error('Error al obtener productos:', err);
      res.status(500).json({ error: 'Error al obtener productos' });
    }
  });
  

/** 
app.post('/create-order', async (req, res) => {
    try {
        const { amount } = req.body; // Asegúrate de que 'amount' esté incluido en el cuerpo de la solicitud
        if (!amount) {
            return res.status(400).json({ error: 'Amount is required' });
        }

        const orderData = await createOrder({ amount });
        res.json(orderData); // Devuelve los datos de la orden (incluyendo el ID)
    } catch (error) {
        console.error('Error creating order:', error);
        res.status(500).json({ error: 'Error creating order' });
    }
});

// Ruta para manejar la captura del pago
app.post('/capture-order', async (req, res) => {
    try {
        const { orderID } = req.body;
        const captureResult = await capturePayment(orderID);
        res.json(captureResult);
    } catch (error) {
        console.error('Error capturing payment:', error);
        res.status(500).json({ error: 'Error capturing payment' });
    }
});

// Ruta para manejar la redirección después de completar el pago
app.get('/complete-order', (req, res) => {
    // Aquí puedes mostrar una página de confirmación o redirigir al usuario
    res.send('Pago completado. Gracias por su compra.');
});

// Ruta para manejar la redirección en caso de cancelación
app.get('/cancel-order', (req, res) => {
    // Aquí puedes mostrar una página de cancelación o redirigir al usuario
    res.send('Pago cancelado. Puede intentar nuevamente.');
});
**/

// Inicia el servidor
app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
