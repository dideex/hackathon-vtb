
import React, { useEffect, useState } from 'react'
import Button from '../components/Button'
import Input from '../components/Input';
import Main from '../components/Main'
import { store } from '../store';
import { getClassName } from '../utils/getClassName';

const PHONE = 'phone;'

export default () => {
  const [phone, setPhone] = useState('');
  const [value, setValue] = useState('');
  const [phoneError, setPhoneError] = useState(false);
  const [valueError, setValueError] = useState(false);
  const [complete, setComplete] = useState(false);

  useEffect(() => {
    const { permanent_token, user_token } = store;

    fetch('/me', {
      method: 'GET',
      headers: {
        'permanent-token': permanent_token,
        user_token,
      },
    })
  }, []);

  const handleClick = e => {
    if (phone.length < 11) {
      setPhoneError(true);
      return;
    } else {
      setPhoneError(false);
    }

    if (!Number(value)) {
      setValueError(true);
      return;
    } else {
      setValueError(false);
    }

    const { permanent_token, user_token } = store;

    fetch('/make_payment', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'permanent-token': permanent_token,
        user_token,
      },
      body: JSON.stringify({ amount: Number(value), phone })
    }).then(() => setComplete(true));
  };

  const handleChangePhone = e => {
    setPhone(e.target.value.replace(/\D/g, ''));
  };

  const handleChangeValue = e => {
    setValue(e.target.value.replace(/\D/g, ''));
  };

  return (
    <Main>
        <div className={getClassName('wrapper', complete && 'wrapper-disabled')}>
          <span className='text-payments'>Перевод по номеру телефона</span>
          <Input 
            required 
            text='ТЕЛЕФОН' 
            onChange={handleChangePhone} 
            value={phone} 
            className={getClassName(phoneError && 'input-error')} 
            maxlength={11}
          />
          <span className={getClassName('text-error', phoneError && 'text-error-open')}>Номер должен состоять из 11 цифр</span>
          <Input 
            required 
            text='СУММА' 
            onChange={handleChangeValue} 
            value={value} 
            className={getClassName(valueError && 'input-error')} 
          />
          <span className={getClassName('text-error', valueError && 'text-error-open')}>Сумма должна быть больше 0</span>
          <Button onClick={handleClick}>Перевести деньги</Button>
        </div>
        <span className={getClassName('text-info', complete && 'text-info-complete')}>
          <img src="/images/info.svg" alt="" className="image-info" />
          Перевод совершен
        </span>
    </Main>
)};
