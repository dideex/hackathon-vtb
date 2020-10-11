import hash from 'hash.js';

export function proofOfConcept(complexity, prefix) {
  let nonce = 0;

  do {
    nonce += 1;
    const _hash = sha256(`${prefix}:${nonce}`);
    if (checkComplexity(_hash, complexity)) {
      return nonce;
    }
  } while (true);
}

function checkComplexity(hash, complexity) {
  let off = 0;
  let i;
  for (i = 0; i <= complexity - 8; i += 8, off++) {
    if (hash[off] !== 0) return false;
  }

  const mask = 0xff << (8 + i - complexity);
  return (hash[off] & mask) === 0;
}

function sha256(source) {
  return hash.sha256().update(source).digest();
}
