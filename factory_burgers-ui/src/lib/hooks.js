// useRemoteData -- fetch remote data with standardized fetching and error states
//
// USAGE
//
// function fetchMyData() {
//  // ... return your data or a promise for your data ...
// }
//
// const data = useRemoteData(fetchMyData);
//   // -- OR --
// const data = useRemoteData(fetchMyData, dependencies);
//
// Similar to `useEffect`, `dependencies` will trigger the fetch to occur again.
// `dependencies` defaults to [], meaning the fetch will happen only once.


import { useEffect, useMemo, useState } from "react";
export function useRemoteData(loadFn, dependencies = []) {
  const [error, setError] = useState(null);
  const [fetching, setFetching] = useState(dependencies.length === 0);
  const [response, setResponse] = useState(null);

  useEffect(() => {
    setFetching(true);
    asyncFetch().then(setResponse).catch(setError).then(done);
  }, dependencies); // eslint-disable-line react-hooks/exhaustive-deps

  async function asyncFetch() {
    return loadFn();
  }

  function done() {
    setFetching(false);
  }

  const value = useMemo(() => {
    return {error, fetching, response};
  }, [error, fetching, response]);

  return value;
}
