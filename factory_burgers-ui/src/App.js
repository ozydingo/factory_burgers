import './App.css';
import './layout.css';

import * as api from "./api";

function App() {
  return (
    <div className="App">
      <header>
        <div class="header-text">testing</div>
      </header>
      <main>
        <p>Hello, world.</p>
        <button class="btn btn-primary" onClick={api.index}>Get Factories</button>
      </main>
    </div>
  );
}

export default App;
