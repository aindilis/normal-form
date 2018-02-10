"Normal Form" by "Andrew Dougherty"

Include Real Date and Time by Ron Newcomb.

Include Hal 9000 by Andrew Dougherty.


[FIXME: Write unit tests]


Volume 1 - Normal Form

[**************************************************************]

Book 1 - Hal

Chapter 1 - Definiens

[Add a help system here]

Section 1 - Configuration

A clock is a kind of device. A clock has a time called the current
time. A clock can be analog or digital. The current time of a clock is
usually 9:01 AM. The description of a clock is "It shows the time to
be [if analog]about [the current time to the nearest five minutes in
words][otherwise][the current time][end if]."

Understand "set [clock] to [time]" as setting it by time. Setting it
by time is an action applying to one thing and one time.

Instead of setting a clock to something:
  say "[The noun] can be set only to a time of day, such as 8:00 AM, or midnight." 

Carry out setting a clock by time:
  now the current time of the noun is the time understood. 

Report setting a clock by time:
  say "You set [the noun] to [time understood]."

Setting a clock by time is acting fast.

The take automatic actions out of world rule is listed before the
every turn stage rule in the turn sequence rules.

This is the take automatic actions out of world rule: if acting fast,
rule succeeds.

Checking the time is an action applying to one thing.  Understand
"check [something]" as checking the time.

Before checking the time:
  say "[the current time of the noun]."

Understand "go to sleep" as sleeping.


Section 2 - Domain (HAL)

A geographical location is a kind of object.  A geographical
location has a number called the latitude.  The latitude of a
geographical location is usually 333.  A geographical location has
a number called the longitude.  The longitude of a geographical
location is usually 333.  A geographical location has
a number called the altitude.  The altitude of a geographical
location is usually -333.

The unknown geographical location is a geographical location.  A room
has a geographical location called the center of the room.  The center
of the room is usually the unknown geographical location.  A region
has a geographical location called the center of the region.  The
center of the region is usually the unknown geographical location.

A computer, a computer peripheral, a monitor and a KVM are kinds of
devices.  A computer is usually switched on.  A monitor is a kind of
computer peripheral.  A computer has some text called the fully
qualified hostname.  [Understand "FQDN" as the fully qualified
hostname.]

A security camera is a kind of device.

A backup hard drive is a kind of computer peripheral.

A cell phone is a kind of device.

An artificial intelligence is a kind of person.  

A headset is a kind of device.

Fill level is a kind of value.  The fill levels are completely full,
almost full, half full, almost empty and completely empty.

A 5 gallon water bottle is a kind of container.  A water bottle has a
fill level called the bottle's fill level.

A 5 gallon water dispenser is a kind of device.  A bottle compartment
is a container.  A bottle compartment is part of a water dispenser.  A
5 gallon water dispenser can be top loading or bottom loading.

[create an action for filling a glass of water using the water
dispenser, and have it model it getting lower on water.]


Section 3 - Init (HAL)

Andrew's SVRE's HAL 9000 is an artificial intelligence.

[add something about HAL 9000 being called Hal.]

The game clock is a clock.  The game clock is part of Hal.

Instead of asking Hal about "actions": try asking Hal about "the
possible actions".  Instead of asking Hal about "the actions": try
asking Hal about "the possible actions".  Instead of asking Hal about
"possible actions": try asking Hal about "the possible actions".
Instead of asking Hal about "the possible actions": say "The possible
actions are:[paragraph break][the list of verbs].".  Instead of asking
Hal about "recommended actions": try asking Hal about "the recommended
actions".  Instead of asking Hal about "the recommended actions": say
"The recommended actions are:[paragraph break][the list of verbs].".

Instead of asking Hal about "the list of objects": say "The objects
are:[paragraph break][the list of objects].".


Section 4 - Misc

Definition: a direction (called thataway) is viable if the room
thataway from the location is a room.

Instead of going nowhere: 
  let count of exits be the number of viable directions; 
  if the count of exits is 0, say "You appear to be trapped in here." instead; 
  if the count of exits is 1, say "From here, the only way out is [list of viable directions]."; 
  otherwise say "From here, the viable exits are [list of viable directions]."

Understand "flip [something switched off]" as switching on. Understand
"flip [something switched on]" as switching off. Understand "flip
[something]" as switching on.

Test lighting with "turn off light / look / flip light switch".


[**************************************************************]

[<REDACTED>]
