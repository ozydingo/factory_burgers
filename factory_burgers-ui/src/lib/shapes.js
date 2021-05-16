import PropTypes from 'prop-types';

const attributesShape = PropTypes.shape({
  name: PropTypes.string.isRequired,
});

const traitsShape = PropTypes.shape({
  name: PropTypes.string.isRequired,
});

const factoryShape = PropTypes.shape({
  attributes: PropTypes.arrayOf(attributesShape),
  name: PropTypes.string.isRequired,
  traits: PropTypes.arrayOf(traitsShape),
});

export {
  attributesShape,
  factoryShape,
  traitsShape,
};
