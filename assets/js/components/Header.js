import React from 'react';

const Header = () => {
  console.log(' LOG ___ window ', window.__TOKEN__)
  return (
    <header>
      <section className="container">
        <nav role="navigation">
        </nav>
        <a href="http://phoenixframework.org/" className="phx-logo">
          <img src="/images/phoenix.png" alt="Phoenix Framework Logo" />
        </a>
      </section>
    </header>
  );
};

export default Header;
