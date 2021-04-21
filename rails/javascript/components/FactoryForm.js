import React, { useEffect, useMemo, useState, useRef } from 'react';

import { css, StyleSheet } from 'aphrodite';
import PropTypes from 'prop-types';

import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";

import Attributes from "./partials/Attributes";
import FactorySelection from "./partials/FactorySelection";
import FormFieldsForOwner from "./partials/FormFieldsForOwner";
import Traits from "./partials/Traits";

import { factoryShape } from "data/testing/shapes";
import { indexBy, usePrevious } from "./framework";

function FactoryForm(props) {
  const blueprints = props.blueprints || [];
  const owner = props.owner;
  const inquiry = props.inquiry || "What'll it be?";

  const [factoryInput, setFactoryInput] = useState("");

  function handleFactory(event) {
    const value = event.target.value;
    setFactoryInput(value);
  }

  const indexedBluePrints = useMemo(() => indexBy(blueprints, blueprint => blueprint.factory.name), [blueprints]);
  const selectedBlueprint = useMemo(() => indexedBluePrints[factoryInput], [factoryInput]);
  const attributes = useMemo(() => selectedBlueprint && selectedBlueprint.factory.attributes || [], [selectedBlueprint]);
  const traits = useMemo(() => selectedBlueprint && selectedBlueprint.factory.traits || [], [selectedBlueprint]);
  const validSelection = !!selectedBlueprint;

  const prevOwner = usePrevious(props.owner);

  function sameOwner(owner, other) {
    const ownerType = owner && owner.type;
    const ownerId = owner && owner.id;
    const otherOwnerType = other && other.type;
    const otherOwnerId = other && other.id;
    return ownerType === otherOwnerType && ownerId == otherOwnerId;
  }

  useEffect(() => {
    if (!sameOwner(props.owner, prevOwner)) { setFactoryInput(""); }
  }, [props.owner]);

  const form = useRef(null);

  function startOver() {
    form.current && form.current.reset();
    setFactoryInput("");
    props.startOver();
  }

  return (
    <Form ref={form} onSubmit={props.handleSubmit}>

      <FactorySelection
        options={blueprints}
        label={inquiry}
        value={factoryInput}
        onChange={handleFactory}
        owner={owner}
      />

      <FormFieldsForOwner owner={owner} association={selectedBlueprint && selectedBlueprint.association} />

      {traits.length > 0 && (
        <Traits disabled={props.disabled} traits={traits} />
      )}

      {attributes.length > 0 && (
        <Attributes disabled={props.disabled} attributes={attributes} />
      )}

      <div className={css(styles.buttons)}>
        <Button variant="outline-dark" className="btn-primary" disabled={props.disabled || !validSelection} type="submit">
          Gimme!
        </Button>
        <Button variant="outline-dark" className="btn-danger" disabled={props.disabled} onClick={startOver} type="button">
          Start Over
        </Button>{' '}
      </div>
    </Form>
  );
}

FactoryForm.propTypes = {
  blueprints: PropTypes.arrayOf(
    PropTypes.shape({
      factory: factoryShape.isRequired,
      association: PropTypes.string,
    })
  ).isRequired,
  disabled: PropTypes.bool,
  handleSubmit: PropTypes.func,
  inquiry: PropTypes.string,
  owner: PropTypes.shape({
    type: PropTypes.string,
    id: PropTypes.any,
  }),
  startOver: PropTypes.func,
};

const styles = StyleSheet.create({
  buttons: {
    display: "flex",
    justifyContent: "space-between",
  },
});

export default FactoryForm;
