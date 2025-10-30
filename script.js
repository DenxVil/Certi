// State management
let certificateImage = null;
let canvas = null;
let ctx = null;
let textFields = [];
let fieldCounter = 0;

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    canvas = document.getElementById('certificate-canvas');
    ctx = canvas.getContext('2d');
    
    // Set up event listeners
    document.getElementById('certificate-upload').addEventListener('change', handleImageUpload);
    canvas.addEventListener('click', handleCanvasClick);
    document.getElementById('download-btn').addEventListener('click', downloadCertificate);
    document.getElementById('clear-btn').addEventListener('click', clearAllFields);
    
    // Disable buttons initially
    updateButtonStates();
});

// Handle certificate image upload
function handleImageUpload(event) {
    const file = event.target.files[0];
    if (!file) return;
    
    // Validate file type
    if (!file.type.startsWith('image/')) {
        alert('Please upload a valid image file.');
        event.target.value = '';
        return;
    }
    
    const reader = new FileReader();
    reader.onload = function(e) {
        const img = new Image();
        img.onload = function() {
            certificateImage = img;
            
            // Set canvas size to match image
            canvas.width = img.width;
            canvas.height = img.height;
            
            // Show canvas
            canvas.classList.add('loaded');
            
            // Draw the image
            redrawCanvas();
            updateButtonStates();
        };
        img.src = e.target.result;
    };
    reader.readAsDataURL(file);
}

// Handle clicks on the canvas to add text fields
function handleCanvasClick(event) {
    if (!certificateImage) return;
    
    const rect = canvas.getBoundingClientRect();
    const scaleX = canvas.width / rect.width;
    const scaleY = canvas.height / rect.height;
    
    // Get click position relative to canvas
    const x = (event.clientX - rect.left) * scaleX;
    const y = (event.clientY - rect.top) * scaleY;
    
    // Create a new text field
    createTextField(x, y);
}

// Create a new text input field
function createTextField(x, y) {
    fieldCounter++;
    const fieldId = `field-${fieldCounter}`;
    
    const textField = {
        id: fieldId,
        x: x,
        y: y,
        text: '',
        fontSize: 30,
        fontFamily: 'Arial',
        color: '#000000'
    };
    
    textFields.push(textField);
    
    // Create the input element in the DOM
    const textInputsContainer = document.getElementById('text-inputs');
    const inputGroup = document.createElement('div');
    inputGroup.className = 'text-input-group';
    inputGroup.id = `input-group-${fieldId}`;
    
    inputGroup.innerHTML = `
        <label>Field ${fieldCounter} (x: ${Math.round(x)}, y: ${Math.round(y)})</label>
        <input 
            type="text" 
            id="${fieldId}" 
            placeholder="Enter text here"
            data-field-id="${fieldId}"
        >
        <button onclick="removeTextField('${fieldId}')">Remove</button>
    `;
    
    textInputsContainer.appendChild(inputGroup);
    
    // Add event listener for text input
    const input = document.getElementById(fieldId);
    input.addEventListener('input', function(e) {
        updateFieldText(fieldId, e.target.value);
    });
    
    // Focus on the new input
    input.focus();
    
    updateButtonStates();
}

// Update the text for a specific field
function updateFieldText(fieldId, text) {
    const field = textFields.find(f => f.id === fieldId);
    if (field) {
        field.text = text;
        redrawCanvas();
    }
}

// Remove a text field
function removeTextField(fieldId) {
    // Remove from array
    textFields = textFields.filter(f => f.id !== fieldId);
    
    // Remove from DOM
    const inputGroup = document.getElementById(`input-group-${fieldId}`);
    if (inputGroup) {
        inputGroup.remove();
    }
    
    // Redraw canvas
    redrawCanvas();
    updateButtonStates();
}

// Redraw the canvas with the certificate and all text fields
function redrawCanvas() {
    if (!certificateImage) return;
    
    // Clear canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    // Draw certificate image
    ctx.drawImage(certificateImage, 0, 0);
    
    // Draw all text fields
    textFields.forEach(field => {
        if (field.text) {
            ctx.font = `${field.fontSize}px ${field.fontFamily}`;
            ctx.fillStyle = field.color;
            ctx.textBaseline = 'middle';
            ctx.fillText(field.text, field.x, field.y);
        }
    });
}

// Download the certificate with text
function downloadCertificate() {
    if (!certificateImage) return;
    
    // Try toBlob first, fallback to toDataURL for older browsers
    if (canvas.toBlob) {
        canvas.toBlob(function(blob) {
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.download = 'certificate.png';
            link.href = url;
            link.click();
            URL.revokeObjectURL(url);
        });
    } else {
        // Fallback for older browsers
        const url = canvas.toDataURL('image/png');
        const link = document.createElement('a');
        link.download = 'certificate.png';
        link.href = url;
        link.click();
    }
}

// Clear all text fields
function clearAllFields() {
    // Clear array
    textFields = [];
    
    // Clear DOM
    const textInputsContainer = document.getElementById('text-inputs');
    textInputsContainer.innerHTML = '';
    
    // Reset counter
    fieldCounter = 0;
    
    // Redraw canvas
    redrawCanvas();
    updateButtonStates();
}

// Update button states based on current state
function updateButtonStates() {
    const downloadBtn = document.getElementById('download-btn');
    const clearBtn = document.getElementById('clear-btn');
    
    const hasImage = certificateImage !== null;
    const hasFields = textFields.length > 0;
    
    downloadBtn.disabled = !hasImage;
    clearBtn.disabled = !hasFields;
}
