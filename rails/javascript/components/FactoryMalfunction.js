import React from "react";
import PropTypes from "prop-types";

import Alert from "react-bootstrap/Alert";

function FactoryMalfunction(props) {
  const message = props.message || "Something went wrong";
  return (
    <Alert variant="danger">
      {message}
    </Alert>
  );
}

FactoryMalfunction.propTypes = {
  message: PropTypes.string,
};

export default FactoryMalfunction;
