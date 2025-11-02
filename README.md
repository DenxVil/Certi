# Certi

A repository containing multiple applications:

## 1. Certificate Filler (Web App)

A simple web-based application that allows you to upload a certificate image, add text fields by clicking on the image, and then download the customized certificate.

## 2. SYNAPSE Fest iOS App

A comprehensive iOS application for the SYNAPSE Intercollege Fest at MAMC Delhi. Browse events, view details, and register directly from the app. See [SynapseFest/README.md](SynapseFest/README.md) for details.

---

## Certificate Filler

## Features

- **Upload Certificate**: Upload any certificate image (PNG, JPG, etc.)
- **Click to Add Text**: Click anywhere on the certificate to add a text field
- **Live Preview**: See your text appear on the certificate as you type
- **Download**: Download the completed certificate as a PNG image
- **Responsive Design**: Works on desktop and mobile devices

## How to Use

1. **Upload Your Certificate**
   - Click on "Upload Certificate Image" and select your certificate file
   - The certificate will appear in the canvas area

2. **Add Text Fields**
   - Click anywhere on the certificate image where you want to place text
   - A text input field will appear below the canvas
   - Each click creates a new text field at the clicked location

3. **Enter Your Text**
   - Type into the text input fields
   - Your text will appear on the certificate in real-time
   - You can add multiple text fields at different locations

4. **Remove Fields (Optional)**
   - Click the "Remove" button next to any text field to delete it
   - Or use "Clear All Fields" to remove all text fields at once

5. **Download Your Certificate**
   - Click "Download Certificate" to save the completed certificate as a PNG file

## Deployment

This application is designed to work on GitHub Pages. Simply enable GitHub Pages in your repository settings and point it to the main branch.

## Technologies Used

- HTML5 Canvas for image manipulation
- Vanilla JavaScript (no dependencies)
- CSS3 for styling
- Responsive design with mobile support

## Local Development

To run locally, simply open `index.html` in a web browser. No build process or server required.

## Projects in This Repository

### Certificate Filler (Web)
- Location: Root directory (`index.html`, `script.js`, `style.css`)
- Type: Web Application
- Purpose: Certificate customization tool

### SYNAPSE Fest iOS App
- Location: `SynapseFest/` directory
- Type: iOS Application (Swift/SwiftUI)
- Purpose: Event management app for MAMC Delhi's intercollege fest
- Features:
  - 8 comprehensive fest events across 6 categories
  - Event details with dates, venues, and registration links
  - Category-based filtering
  - Professional UI with gradient design
  - Azure integration ready
- Documentation: [SynapseFest/README.md](SynapseFest/README.md)
- Azure Guide: [SynapseFest/AZURE_INTEGRATION.md](SynapseFest/AZURE_INTEGRATION.md)

## License

This project is open source and available under the MIT License.