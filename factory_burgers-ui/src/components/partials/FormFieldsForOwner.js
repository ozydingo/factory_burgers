import React from "react";

import PropTypes from 'prop-types';

import Form from "react-bootstrap/Form";

function FormFieldsForOwner(props) {
  const { association, owner } = props;

  return (
    <>
      <Form.Group controlId="factories.OwnerType">
        <Form.Control
          type="hidden"
          value={(owner && owner.type) || ""}
          name="owner_type"
        />
      </Form.Group>
      <Form.Group controlId="factories.OwnerId">
        <Form.Control
          type="hidden"
          value={(owner && owner.id) || ""}
          name="owner_id"
        />
      </Form.Group>
      <Form.Group controlId="factories.OwnerReflection">
        <Form.Control
          type="hidden"
          value={association || ""}
          name="owner_association"
        />
      </Form.Group>
    </>
  );
}

FormFieldsForOwner.propTypes = {
  association: PropTypes.string,
  owner: PropTypes.shape({
    type: PropTypes.string,
    id: PropTypes.any,
  }),
};

export default FormFieldsForOwner;
