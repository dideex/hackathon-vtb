import React from 'react';
import { getClassName } from '../utils/getClassName';

const classes = {
  text: 'input-text'
};

const Input = ({ type = 'text', ...props }) => (
  <input 
    type={type}
    {...props}
    className={getClassName(classes[type])}
  />
);

export default Input;
