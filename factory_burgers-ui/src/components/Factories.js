import React, { useMemo, useState } from 'react';
import PropTypes from 'prop-types';

import { StyleSheet, css } from "aphrodite";

import { factoryShape } from "lib/shapes";

import FactoryForm from "./FactoryForm";
import FactoryMalfunction from "./FactoryMalfunction";
import ObjectCard from "./ObjectCard";
import ObjectUnderConstruction from "./ObjectUnderConstruction.js";

function findAssociationFactory(factories, association) {
  return {
    factory: factories.find(f => f.name === association.factory_name),
    association: association.association_name,
  };
}

function objectId(object) {
  return {
    type: object.type,
    id: object.attributes.id,
  };
}

function Factories(props) {
  const { factories } = props;

  // Just use this for testing objects without having to create them
  // const staticObject = [{type: "test", attributes: {id: 1, name: "first"}}, {type: "test", attributes: {id: 1, name: "second"}}];
  const staticObject = [];

  const [constructing, setConstructing] = useState(false);
  const [error, setError] = useState(null);
  const [fetching, setFetching] = useState(false);
  const [newObjectIndex, setNewObjectIndex] = useState(null);
  const [objects, setObjects] = useState([...staticObject]);
  const [selectedObjectIndex, setSelectedObjectIndex] = useState(null);

  const factoryList = factories.map(factory => ({factory}));
  const selectedObject = selectedObjectIndex !== null && objects.length > 0 && objects[selectedObjectIndex];

  const associationFactories = useMemo(() => {
    if (!selectedObject || !selectedObject.association_factories) { return []; }
    const matchingFactories = selectedObject.association_factories.map(
      item => findAssociationFactory(factories, item)
    );
    return matchingFactories;
  }, [factories, selectedObject]);

  const blueprints = selectedObject ? associationFactories : factoryList;
  const inquiry = selectedObject ? `Would you like fries with that ${selectedObject.type}?` : null;

  function startOver() {
    setNewObjectIndex(null);
    setNewObjectIndex(null);
    setObjects([]);
    setSelectedObjectIndex(null);
  }

  function selectObject(ii) {
    setNewObjectIndex(null);
    setSelectedObjectIndex(ii);
  }

  function handleSubmit(event) {
    event.preventDefault();
    setConstructing(true);
    setError(null);
    setFetching(true);
    const data = formData(event.target);
    submit(data);
  }

  async function submit(data) {
    const url = props.submitPath;

    const response = await fetch(url, {
      method: "POST",
      body: data,
    });

    const responseData = await response.json();

    if (!response.ok) {
      // eslint-disable-next-line no-console
      console.error(JSON.stringify(responseData));
      handleSubmitError(responseData.error || "Uh oh, something broke.");
    } else {
      handleResponseData(responseData);
    }
  }

  function handleResponseData(responseData) {
    if (responseData.ok) {
      // eslint-disable-next-line no-console
      console.log(JSON.stringify(responseData));
      handleObject(responseData.data);
    } else {
      // eslint-disable-next-line no-console
      console.error(responseData.error);
      handleSubmitError(responseData.error || "Uh oh, something went wrong.");
    }
  }

  function handleSubmitError(message) {
    setConstructing(false);
    setError(message);
    setFetching(false);
  }

  function handleObject(object) {
    setConstructing(false);
    setError(null);
    setFetching(false);
    setObjects(objects.slice().concat([object]));
    if (objects.length === 0) {
      setSelectedObjectIndex(0);
    }
    setNewObjectIndex(objects.length);
  }

  function formData(form) {
    return new FormData(form);
  }

  return (
    <div className="container">
      <h2>Order Up!</h2>

      {(constructing || (objects.length > 0)) && (
        <>
          {constructing ? "Comin' right up!" : "Here you go!"}
          {objects.length > 1 && (
            <span>{" "}P.S. -- select any object to build out its dependencies.</span>
          )}
          <div className={css(styles.objectList)}>
            {objects.map((object, ii) => (
              <ObjectCard
                key={ii}
                object={object}
                active={selectedObjectIndex === ii}
                activate={() => selectObject(ii)}
                new={newObjectIndex === ii}
              />
            ))}
            {constructing && <ObjectUnderConstruction />}
          </div>
        </>
      )}

      {error && <FactoryMalfunction message={error} />}

      <div className={css(styles.form)}>
        <FactoryForm
          owner={selectedObject ? objectId(selectedObject) : null}
          blueprints={blueprints}
          disabled={fetching}
          handleSubmit={handleSubmit}
          startOver={startOver}
          inquiry={inquiry}
        />
      </div>
    </div>
  );
}

Factories.propTypes = {
  factories: PropTypes.arrayOf(factoryShape),
  submitPath: PropTypes.string,
};

const styles = StyleSheet.create({
  form: {
    marginBottom: "2em",
    transition: "opacity 0.5s ease-out",
    overflow: "hidden",
  },
  objectList: {
    display: "flex",
    margin: "0.5em 0 1em",
  },
});

export default Factories;
