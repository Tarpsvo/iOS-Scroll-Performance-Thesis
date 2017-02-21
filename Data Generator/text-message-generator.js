const Random = require('./random');

const TextMessages = {
  SHORT: (id) => `Short msg with id [${id}]`,
  MEDIUM: (id) => `Medium message with id [${id}]\n--Medium message with id [${id}] --`,
  LONG: (id) => `Long message with id [${id}]\n---Long message with id [${id}]---\nLong message with id [${id}]`
};

module.exports = (id) => {
  switch (Random(1, 3)) {
  case 1: return TextMessages.SHORT(id);
  case 2: return TextMessages.MEDIUM(id);
  case 3: return TextMessages.LONG(id);
  default: break;
  }
};
