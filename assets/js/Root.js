import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header from './components/Header';
import HomePage from './pages';
import LkPage from './pages/Lk';
import PrivateRoute from './PrivateRoute';
import Fingerprint2 from '@fingerprintjs/fingerprintjs';
import { store } from './store';
import { proofOfConcept } from './utils/proofOfConcept';
import Demo from './components/Demo';

export default class Root extends React.Component {
  state = {
    auth: false,
    result: null,
    response: '',
  };

  app_token = async () => {
    const {
      data: { permanent_token },
    } = await fetch('/init_session', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
      },
      body: JSON.stringify({ token: window.__TOKEN__ }),
    }).then((data) => data.json());

    store.permanent_token = permanent_token;
    this.setState({ result: !!permanent_token, response: JSON.stringify({ data: { permanent_token } }) });
  }

  finger_print = async () => {
    const finger_token = localStorage.getItem('finger_token') || '';

    Fingerprint2.get(async (components) => {
      const finger_print = (components || []).reduce(
        (accum, { value }) => accum + (Array.isArray(value) ? value.flat(2).join() : value),
        ''
      );

      await fetch('/init_fingerpring', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'permanent-token': store.permanent_token,
        },
        body: JSON.stringify({ finger_token, finger_print }),
      })
        .then((data) => data.json())
        .then((res) => {
          if (res.error) {
            this.setState({ result: false, response: JSON.stringify(res) });
            return null;
          }
          localStorage.setItem('finger_token', res.data.finger_token);
          this.setState({ result: !!res.data.finger_token, response: JSON.stringify(res) });
        });
      // .catch((_) => this.setState({ result: false, response: { error: 'permission_denied' } }));
    });
  }

  pow = async () => {
    const pow = await fetch('/pow', {
      method: 'GET',
      headers: {
        'permanent-token': store.permanent_token,
      },
    }).then((data) => data.json());

    if (!(pow.data && pow.data.hash)) {
      this.setState({ result: false, response: JSON.stringify(pow) });
      return null;
    }
    const res = await fetch('/pow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'permanent-token': store.permanent_token,
      },
      body: JSON.stringify({ nonce: String(proofOfConcept(20, pow.data.hash)) }),
    }).then((data) => data.json());

    this.setState({ result: res.data && res.data.result == 'ok', response: JSON.stringify(res) });
  }

  me = async () => {
    const { permanent_token, user_token } = store;

    const res = await fetch('/me', {
      method: 'GET',
      headers: {
        'permanent-token': permanent_token,
        user_token,
      },
    }).then((d) => d.json());

    this.setState({ result: !res.error, response: JSON.stringify(res) });
  }

  get bgc() {
    if (this.state.result === null) {
      return 'transparent';
    } else if (this.state.result) {
      return 'green';
    } else {
      return 'red';
    }
  }

  render() {
    return (
      <>
        <Header />
        <img src="/images/logo.svg" alt="" className="logo" />
        <Demo 
          color={this.bgc} 
          app_token={this.app_token} 
          finger_print={this.finger_print} 
          pow={this.pow} 
          me={this.me} 
          response={this.state.response}
        />
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
