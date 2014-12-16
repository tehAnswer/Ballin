will_paginate @players
collection @players, :root => :players, :object_root => false
extends "api/players/player"

