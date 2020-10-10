// assets/js/app.tsx

import 'phoenix_html';

import React from 'react';
import ReactDOM from 'react-dom';
import Root from './Root';
import '../css/app.css';

// This code starts up the React app when it runs in a browser. It sets up the routing
// configuration and injects the app into a DOM element.
ReactDOM.render(<Root />, document.getElementById('react-app'));
