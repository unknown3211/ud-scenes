import React, { useState } from "react";
import "./App.css";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const App: React.FC = () => {
  const [text, setText] = useState<string>("");
  const [distancenumber, setDistanceNumber] = useState<number | "">("");

  useNuiEvent("setVisible", (data: any) => {
  });

  const PlaceSceneEvent = (event: any) => {
    fetchNui<any>('placescene', {
      text: text,
      distancenumber: distancenumber,
    });
    ResetUI();
  };

  const ResetUI = () => {
    setText("");
    setDistanceNumber("");
  }

  const CloseEvent = () => {
    fetchNui('hideFrame', {});
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Place Scene</h1>
        <p>Highlight text for formatting</p>
        <div className="text-box">
          <textarea className="text-area" value={text} onChange={e => setText(e.target.value)} />
        </div>
        <div className="distance-text">
          <textarea className="distance-area" placeholder="Render Distance (Min 3, Max 10)" value={distancenumber} onChange={e => setDistanceNumber(Number(e.target.value))} />
        </div>
        <div className="divider-centered"></div>
        <div className="buttons-container">
          <button className="App-button" onClick={CloseEvent}>Cancel</button>
          <button className="App-button" onClick={PlaceSceneEvent}>Submit</button>
        </div>
      </header>
    </div>
  );
};

export default App;