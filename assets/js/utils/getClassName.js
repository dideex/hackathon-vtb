export const getClassName = (...args) =>
  args.reduce((accum, curr) => (typeof curr === 'string' ? `${accum} ${curr}` : accum), '');