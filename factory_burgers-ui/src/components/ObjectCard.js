import React from "react";
import PropTypes from "prop-types";

import { StyleSheet, css } from "aphrodite";

import ExternalLinkIcon from "./icons/ExternalLinkIcon";

import { classes } from "./framework";

function animationClass({ isNew, isActive }) {
  if (isNew) {
    return "created";
  } else if (isActive) {
    return "selected";
  } else {
    return null;
  }
}

function ObjectCard(props) {
  const { object = {} } = props;
  const attributes = object.attributes || {};
  const className = animationClass({isNew: props.new, isActive: props.active});
  return (
    <div className={classes(css(styles.object, props.active && styles.active), className, "background-mayo hoverable")} onClick={props.activate}>
      <div className={css(styles.objectTitle)}>
        {object.type}
        {object.link && (
          <a href={object.link} target="_blank" rel="noopener noreferrer" className="ml-1">
            <ExternalLinkIcon />
          </a>
        )}
      </div>
      <div className={css(styles.objectDetails)}>
        {Object.entries(attributes).map(([name, value]) => (
          <div key={name}>
            {`${name}: ${value}`}
          </div>
        ))}
      </div>
    </div>
  );
}

ObjectCard.propTypes = {
  activate: PropTypes.func.isRequired,
  active: PropTypes.bool,
  new: PropTypes.bool,
  object: PropTypes.shape({
    attributes: PropTypes.object.isRequired,
    type: PropTypes.string.isRequired,
    link: PropTypes.string,
  }).isRequired,
};

const styles = StyleSheet.create({
  active: {
    boxShadow: "5px 5px 0px #333",
  },
  object: {
    border: "2px solid #222",
    borderRadius: "1em",
    display: "flex",
    flexDirection: "column",
    padding: "0.5em",
    marginRight: "0.5em",
    position: "relative",
    cursor: "pointer",
    transition: "background-color 0.2s",
  },
  objectDetails: {
    flex: 1,
    width: "100%",
  },
  objectTitle: {
    flex: 0,
    width: "100%",
    borderBottom: "2px solid #222",
    marginBottom: "3px",
  },
});

export default ObjectCard;
