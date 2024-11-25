// Obtener unidades educativas
async function loadUnits() {
    try {
        const response = await fetch('/unidades-educativas');
        const data = await response.json();
        const select = document.querySelector('select[name="unidadEducativa"]');
        
        data.unidades.forEach(unit => {
            const option = document.createElement('option');
            option.value = unit.nombre;
            option.textContent = unit.nombre;
            select.appendChild(option);
        });
    } catch (error) {
        console.error('Error loading units:', error);
    }
}

// Obtener precio del kit
async function fetchProductPrice(modelName) {
    try {
        const response = await fetch(`/precio-kit/${modelName}`);
        const data = await response.json();
        return data.precio || '0.00';
    } catch (error) {
        console.error('Error fetching product price:', error);
        return '0.00';
    }
}

// Actualizar detalles del producto
async function updateProductDetails() {
    const urlParams = new URLSearchParams(window.location.search);
    const productName = urlParams.get('nombre_modelo_kit');
    
    if (productName) {
        try {
            const productPrice = await fetchProductPrice(productName);
            document.getElementById('product-name').innerText = productName;
            document.getElementById('product-price').innerText = `Precio: $${productPrice}`;
            
            // Asignar el precio al campo oculto
            document.getElementById('product-price-hidden').value = productPrice;
        } catch (error) {
            console.error('Error updating product details:', error);
        }
    }
}

// Enviar datos del formulario
async function submitForm(event) {
    event.preventDefault();

    const formData = new FormData(event.target);
    const unidadEducativa = formData.get('unidadEducativa');

    const data = {
        cedula: formData.get('cedula'),
        nombre: formData.get('nombre'),
        direccion: formData.get('direccion'),
        telefono: formData.get('telefono'),
        correo: formData.get('correo'),
        unidadEducativa: unidadEducativa,
        nombreKit: document.getElementById('product-name').innerText,
        monto: document.getElementById('product-price-hidden').value // Asegúrate de que este campo está presente
    };

    try {
        const response = await fetch('/comprar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });

        if (response.ok) {
            alert('Compra realizada con éxito');
            window.location.href = 'productos.html';
        } else {
            alert('Error en la compra');
        }
    } catch (error) {
        console.error('Error submitting form:', error);
        alert('Error en la compra');
    }
}

window.onload = () => {
    loadUnits();
    updateProductDetails();

    const form = document.getElementById('purchase-form');
    if (form) {
        form.addEventListener('submit', submitForm);
    }
};
