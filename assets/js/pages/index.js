import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import Button from '../components/Button'
import Input from '../components/Input';
import Main from '../components/Main'
import { store } from '../store';

export default () => {
  const [login, setLogin] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  
  const history = useHistory();

  const handleClick = () => {
    const { permanent_token } = store;

    setLoading(true);

    fetch('/auth',  {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'permanent-token': permanent_token
      },
      body: JSON.stringify({ login, password })
    })
      .then(data => data.json())
      .then(data => {
        setLoading(false);
        store.user_token = data.user_token;
        history.push('/lk');
      })
      .catch(err => {
        console.log(err);
        setLoading(false);
      });
  }

  return (
    <Main>
      <span className='text-gretting-title'>Вход в БАНК</span>
      <Input required text="ЛОГИН" onChange={(e) => setLogin(e.target.value)} />
      <Input required text="ПАРОЛЬ" type="password" onChange={(e) => setPassword(e.target.value)}/>
      <Button onClick={handleClick} disabled={!login || !password || loading}>
        Войти
      </Button>
    </Main>
)};
