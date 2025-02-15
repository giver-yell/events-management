import { useState } from 'react';
import { supabase } from '../supabaseClient';

function AddEvent() {
  const [name, setName] = useState('');
  const [contents, setContents] = useState('');
  const [cost, setCost] = useState(0);
  const [startAt, setStartAt] = useState('');
  const [endAt, setEndAt] = useState('');
  const [ownerId, setOwnerId] = useState(1); // 仮の値
  const [paymentTimingId, setPaymentTimingId] = useState(1); // 仮の値
  const [shopId, setShopId] = useState(1); // 仮の値

  const addEvent = async () => {
    const { data, error } = await supabase.from('events').insert([
      {
        name,
        contents,
        cost,
        start_at: startAt,
        end_at: endAt,
        owner_id: ownerId,
        payment_timing_id: paymentTimingId,
        shop_id: shopId,
      },
    ]);
    if (error) {
      console.error('Error adding event:', error);
    } else {
      console.log('Event added:', data);
    }
  };

  return (
    <div>
      <h2>Add Event</h2>
      <form
        onSubmit={(e) => {
          e.preventDefault();
          addEvent();
        }}
      >
        <input
          type="text"
          placeholder="Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <textarea
          placeholder="Contents"
          value={contents}
          onChange={(e) => setContents(e.target.value)}
          required
        />
        <input
          type="number"
          placeholder="Cost"
          value={cost}
          onChange={(e) => setCost(parseInt(e.target.value))}
          required
        />
        <input
          type="datetime-local"
          placeholder="Start At"
          value={startAt}
          onChange={(e) => setStartAt(e.target.value)}
          required
        />
        <input
          type="datetime-local"
          placeholder="End At"
          value={endAt}
          onChange={(e) => setEndAt(e.target.value)}
          required
        />
        <button type="submit">Add Event</button>
      </form>
    </div>
  );
}

export default AddEvent;
