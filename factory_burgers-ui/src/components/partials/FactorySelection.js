import React from "react";

import PropTypes from "prop-types";

import Form from "react-bootstrap/Form";

import { factoryShape } from "data/testing/shapes";

function displayName(blueprint, owner) {
  if (owner) {
    return `${blueprint.association} (${blueprint.factory.name}, ${blueprint.factory.class_name})`;
  } else {
    return `${blueprint.factory.name} (${blueprint.factory.class_name})` ;
  }
}

function FactorySelection(props) {
  const { options, label, value, onChange, owner } = props;
  return (
    <Form.Group controlId="factories.FactorySelect">
      <Form.Label>{label}</Form.Label>
      <input
        name="factory"
        list="factories"
        autoComplete="off"
        className="form-control"
        value={value}
        onChange={onChange}
      />
      <datalist id="factories">
        {options.map(blueprint => (
          <option key={displayName(blueprint, owner)} value={blueprint.factory.name}>
            {displayName(blueprint, owner)}
          </option>
        ))}
      </datalist>
    </Form.Group>
  );
}

FactorySelection.propTypes = {
  options: PropTypes.arrayOf(
    PropTypes.shape({
      factory: factoryShape.isRequired,
      association: PropTypes.string,
    })
  ).isRequired,
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  label: PropTypes.string,
  owner: PropTypes.shape({
    type: PropTypes.string,
    id: PropTypes.any,
  }),
};

export default FactorySelection;
