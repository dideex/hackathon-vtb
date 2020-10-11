import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header from './components/Header';
import HomePage from './pages';
import PrivateRoute from './PrivateRoute';
import Fingerprint2 from '@fingerprintjs/fingerprintjs';
import { store } from './store';
import { proofOfConcept } from './utils/proofOfConcept';

export default class Root extends React.Component {
  state = {
    auth: false,
  };

  componentDidMount() {
    requestIdleCallback(async function() {
      const { hash } = await fetch('/pow', {
        method: 'GET',
      }).then(data => data.json());

      await fetch('/init_pow', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify({ hash: proofOfConcept(20, hash) })
      })

      const { permament_token } = await fetch('/init_session',  {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify({ token: window.__TOKEN__ })
      }).then(data => data.json());

      store.permament_token = permament_token;


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
        <img src="/images/logo.svg" alt="" className="logo" />
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
