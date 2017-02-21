const Random = require('./random');

const TextMessages = {
  SHORT: (id) => `Short message [${id}]`,
  MEDIUM: (id) => `Medium message with id [${id}]\nMedium message with id [${id}]`,
  LONG: (id) => `A very long message with id [${id}]\nA very long message with id [${id}]\nA very long message with id [${id}]`
};

module.exports = (id) => {
  switch (Random(1, 3)) {
  case 1: return TextMessages.SHORT(id);
  case 2: return TextMessages.MEDIUM(id);
  case 3: return TextMessages.LONG(id);
  default: break;
  }
};
