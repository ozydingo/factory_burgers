import React from "react";

import ObjectCard from "./ObjectCard";

function ObjectUnderConstruction() {
  return (
    <div className="under-construction">
      <ObjectCard
        object={{type: "building..."}}
      />
    </div>
  );
}

export default ObjectUnderConstruction;
