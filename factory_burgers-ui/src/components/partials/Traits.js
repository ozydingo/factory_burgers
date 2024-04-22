import React from "react";

import { StyleSheet, css } from "aphrodite";
import PropTypes from "prop-types";

import Form from "react-bootstrap/Form";

import { traitsShape } from "lib/shapes";

function Traits(props) {
  const { traits } = props;

  return (
    <Form.Group controlId="factories.Traits">
      <Form.Label>How would you like that cooked?</Form.Label>
      <div className={css(styles.traits)}>
        {traits.map(trait => (
          <Form.Check
            key={trait.name}
            type="checkbox"
            disabled={props.disabled}
            id={trait.name}
            name={`traits[${trait.name}]`}
            label={trait.name}
          />
        ))}
      </div>
    </Form.Group>
  );
}

Traits.propTypes = {
  disabled: PropTypes.bool,
  traits: PropTypes.arrayOf(traitsShape).isRequired,
};

const styles = StyleSheet.create({
  traits: {
    display: "flex",
    flexDirection: "column",
    flexWrap: "wrap",
    maxHeight: "6em",
  },
});

export default Traits;
