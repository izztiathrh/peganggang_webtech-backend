<?php
// Add to your existing allowed_origins array
$allowed_origins = [
    'http://localhost:8080',
    'http://127.0.0.1:8080',
    'http://localhost:5173',
    'https://peganggang-webtech-backend.onrender.com',  // Your Render URL
    'https://your-frontend-domain.vercel.app'           // Your frontend URL
];

// Auto-detect production URL
if (isset($_SERVER['HTTP_HOST'])) {
    $current_host = $_SERVER['HTTP_HOST'];
    if (strpos($current_host, 'onrender.com') !== false) {
        $allowed_origins[] = 'https://' . $current_host;
    }
}

// Rest of your existing CORS code...
?>