import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header from './components/Header';
import HomePage from './pages';
import LkPage from './pages/Lk';
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
      const { data: { permanent_token } } = await fetch('/init_session',  {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify({ token: window.__TOKEN__ })
      }).then(data => data.json());

      store.permanent_token = permanent_token;


      const finger_token = localStorage.getItem('finger_token');

      Fingerprint2.get(async components => {
        const finger_print = (components || []).reduce((accum, { value }) => accum + (Array.isArray(value) ? value.flat(2).join() : value), '');

        await fetch('/init_fingerpring',  {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
            'permanent-token': permanent_token
          },
          body: JSON.stringify({ finger_token, finger_print })
        })
        .then(data => data.json())
        .then(data => {
          localStorage.setItem('finger_token', data.finger_token);
        });

        const { data: { hash } } = await fetch('/pow', {
          method: 'GET',
          headers: {
            'permanent-token': permanent_token
          }
        }).then(data => data.json());
  
        await fetch('/pow', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
            'permanent-token': permanent_token
          },
          body: JSON.stringify({ nonce: String(proofOfConcept(20, hash)) })
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
            <PrivateRoute auth={this.state.auth} path="/lk" component={LkPage} />
          </Switch>
        </BrowserRouter>
      </>
    );
  }
}
