import React, { useState } from 'react';

const Demo = ({ color, app_token, finger_print, pow, me, response }) => {
  const [open, setOpen] = useState(false);

  return (
    <>
      <button 
        className='button'
        onClick={() => setOpen(state => !state)}
        style={{ 
          opacity: open ? 1 : 0.4, 
          marginBottom: '10px'
        }}
      >
        DevTools
      </button>
      {open && ( 
        <div 
          style={{ 
            width: '100vw', 
            height: '100vh', 
            position: "absolute",
            left: 0,
            top: 0,
            zIndex: 2,
          }} 
          onClick={() => setOpen(false)} 
        />)}
      {open && ( 
        <div className='demo'>
          <div className="flag" style={{ backgroundColor: color }}>
            {' '}
          </div>
          <br />
          <button className="button" onClick={() => app_token()}>
            check app token
          </button>
          <br />
          <button className="button" onClick={() => finger_print()}>
            check fingerprint
          </button>
          <br />
          <button className="button" onClick={() => pow()}>
            check proof of work
          </button>
          <br></br>
          <hr></hr>
          <button className="button" onClick={() => me()}>
            Internal api
          </button>
          <h2>{response}</h2>
        </div>
      )}
    </>
)};

export default Demo;
