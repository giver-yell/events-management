import { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';

function EventList() {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      const { data, error } = await supabase.from('events').select('*');
      if (error) {
        console.error('Error fetching events:', error);
      } else {
        console.log('Fetched events:', data);
        setEvents(data);
      }
    };
  
    fetchEvents();
  }, []);

  return (
    <div>
      <h1>Event List</h1>
      <ul>
        {events.map((event) => (
          <li key={event.id}>
            <strong>{event.name}</strong> - {event.contents} <br />
            Cost: {event.cost} yen | Start: {new Date(event.start_at).toLocaleString()} | End: {new Date(event.end_at).toLocaleString()}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default EventList;
