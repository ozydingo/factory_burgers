import React from "react";

import PropTypes from "prop-types";

import Col from "react-bootstrap/Col";
import Form from "react-bootstrap/Form";

function AttributeRow(props) {
  return (
    <Form.Row>
      <Col>
        <Form.Label>Attribute Name</Form.Label>
        <Form.Control
          as="select"
          disabled={props.disabled}
          name={`attributes[][name]`}
          className="form-control"
          value={props.attribute.name}
          onChange={event => props.onChangeName(event)}
        >
          <option value={props.attribute.name}>{props.attribute.name}</option>
          {props.children}
        </Form.Control>
      </Col>
      <Col>
        <Form.Label>Value</Form.Label>
        <input
          disabled={props.disabled || !props.attribute.name}
          name={`attributes[][value]`}
          className="form-control"
          value={props.attribute.value}
          onChange={event => props.onChangeValue(event)}
        />
      </Col>
    </Form.Row>
  );
}

AttributeRow.propTypes = {
  attribute: PropTypes.shape({
    name: PropTypes.string,
    value: PropTypes.string,
  }),
  children: PropTypes.node,
  disabled: PropTypes.bool,
  onChangeName: PropTypes.func.isRequired,
  onChangeValue: PropTypes.func.isRequired,
};

export default AttributeRow;
