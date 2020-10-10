
import React, { useEffect } from 'react'
import Button from '../components/Button'
import Input from '../components/Input';
import Main from '../components/Main'
import store from '../store';

const PHONE = 'phone;'

export default () => {
  useEffect(() => {
    const { permament_token, user_token } = store;

    fetch('/me', {
      type: 'GET',
      headers: {
        permament_token,
        user_token,
      },
    })
  }, []);

  return (
    <Main>
      <form>
        <label for={PHONE}>Телефон</label><Input required id={PHONE} />
        <Button type='submit'>главная кнопка</Button>
      </form>
    </Main>
)};
