import React from 'react';
import { getClassName } from '../utils/getClassName';

const classes = {
  text: 'input-text'
};

let id = 0;
const getId = () => id++;

const Input = ({ text, type = 'text', ...props }) => (
  <div className="input">
    <input 
      type={type}
      {...props}
      className={getClassName(classes[type])}
    />
    <label>{text}</label>
  </div>
);

export default Input;
