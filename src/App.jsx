import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Home from './pages/Home';
import About from './pages/About';
import AddEvent from './components/AddEvent';
import EventList from './components/EventList';

function App() {
  return (
    <div>
      <h1>Event Management</h1>
      <AddEvent />
      <EventList />
    </div>
  );
}

export default App;
