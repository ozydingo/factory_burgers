import { useEffect } from "react";

import './App.css';
import './layout.css';

import Error from "components/Error";
import Fetching from "components/Fetching";

import * as api from "lib/api";
import { useRemoteData } from "lib/hooks";

function App() {
  const factories = useRemoteData(api.index);

  useEffect(() => { console.log(factories) }, [factories]);

  return (
    <div className="App">
      <header>
        <div class="header-text">testing</div>
      </header>
      <main>
        {factories.fetching && <Fetching />}
        {factories.error && <Error />}
        {factories.response && (
          <p>Hello, world.</p>
        )}
      </main>
    </div>
  );
}

export default App;
