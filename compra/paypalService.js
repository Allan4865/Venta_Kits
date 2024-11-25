const axios = require('axios');

// Generar token de acceso
async function generateAccessToken() {
    const response = await axios({
        url: 'https://api-m.sandbox.paypal.com/v1/oauth2/token',
        method: 'post',
        data: 'grant_type=client_credentials',
        auth: {
            username: process.env.PAYPAL_CLIENT_ID, 
            password: process.env.PAYPAL_SECRET 
        }
    });

    return response.data.access_token;
}

// Crear la orden
const createOrder = async (orderData) => {
    try {
        const accessToken = await generateAccessToken(); // Obtener el token de acceso

        // Verificar que orderData y orderData.amount existan
        if (!orderData || !orderData.amount) {
            throw new Error('Order data or amount is missing');
        }

        const response = await axios.post(
            'https://api-m.sandbox.paypal.com/v2/checkout/orders',
            {
                intent: 'CAPTURE',
                purchase_units: [
                    {
                        amount: {
                            currency_code: 'USD',
                            value: orderData.amount,
                        },
                    },
                ],
                application_context: {
                    return_url: 'http://localhost:3001/complete-order',
                    cancel_url: 'http://localhost:3001/cancel-order',
                    shipping_preference: 'NO_SHIPPING',
                    user_action: 'PAY_NOW',
                    brand_name: 'Tu Marca',
                },
            },
            {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${accessToken}`,
                },
            }
        );

        return response.data;
    } catch (error) {
        console.error('Error creating order:', error.response?.data || error.message);
        throw error;
    }
};

// Capturar el pago de la orden
const capturePayment = async (orderId) => {
    try {
        const accessToken = await generateAccessToken(); // Obtener el token de acceso

        const response = await axios({
            url: `https://api-m.sandbox.paypal.com/v2/checkout/orders/${orderId}/capture`,
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + accessToken
            }
        });

        return response.data;
    } catch (error) {
        console.error('Error capturing payment:', error.response?.data || error.message);
        throw error;
    }
};

module.exports = {
    createOrder,
    capturePayment,
};
