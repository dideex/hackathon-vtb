
import React, { useEffect } from 'react'
import Button from '../components/Button'
import Input from '../components/Input';
import Main from '../components/Main'
import { store } from '../store';

const PHONE = 'phone;'

export default () => {
  useEffect(() => {
    const { permanent_token, user_token } = store;

    fetch('/me', {
      type: 'GET',
      headers: {
        'permanent-token': permanent_token,
        user_token,
      },
    })
  }, []);

  const handleClick = () =>{
    const { permanent_token, user_token } = store;

    fetch('/me', {
      type: 'GET',
      headers: {
        'permanent-token': permanent_token,
        user_token,
      },
    });
  };

  return (
    <Main>
        <span className='text-gretting-title'>Вход в БАНК</span>
        <Input required text='ТЕЛЕФОН' />
        <Input required type='number' text='СУММА' />
        <Button onClick={handleClick}>главная кнопка</Button>
    </Main>
)};
