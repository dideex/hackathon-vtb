import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header from './components/Header';
import HomePage from './pages';
import PrivateRoute from './PrivateRoute';
import Fingerprint2 from '@fingerprintjs/fingerprintjs';
import store from './store';

// if (window.requestIdleCallback) {
//   requestIdleCallback(function () {
//       Fingerprint2.get(function (components) {
//         console.log(JSON.stringify(components));

//         fetch('/init_fingerpring',  {
//           method: 'POST',
//           headers: {
//             'Content-Type': 'application/json;charset=utf-8'
//           },
//           body: JSON.stringify(user)
//         })
//       })
//   })

// } else {
//   setTimeout(function () {
//     requestIdleCallback(function () {
//       Fingerprint2.get(function (components) {
//         console.log((components || []).reduce((accum, { value }) => accum + (Array.isArray(value) ? value.flat(2).join() : value), ''));
//       })
//   })

//   }, 500)
// }

export default class Root extends React.Component {
  state = {
    auth: false,
  };

  async componentDidMount() {
    const { permament_token } = await fetch('/init_session',  {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8'
      },
      body: JSON.stringify({ token: window.__TOKEN__ })
    }).then(data => data.json());

    store.permament_token = permament_token;

    requestIdleCallback(function () {
      const finger_token = localStorage.getItem('finger_token');

      Fingerprint2.get(components => {
        const finger_print = (components || []).reduce((accum, { value }) => accum + (Array.isArray(value) ? value.flat(2).join() : value), '');

        fetch('/init_fingerpring',  {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
            permament_token
          },
          body: JSON.stringify({ finger_token, finger_print })
        })
        .then(data => data.json())
        .then(data => {
          localStorage.setItem('finger_token', data.finger_token);
        })
      });
    })
  }

  render() {
    return (
      <>
        <Header />
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={HomePage} />
            <PrivateRoute auth={this.state.auth} path="/lk" component={() => null} />
          </Switch>
        </BrowserRouter>
      </>
    );
  }
}
