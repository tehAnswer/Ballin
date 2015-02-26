import Ember from 'ember';


var center =  {
  positionsCanPlay : function () {
    return ["C"];
  },
  namePosition: function() {
    return "Center";
  }
}

var powerForward = {
  positionsCanPlay : function () {
    return ["PF"];
  },
  namePosition: function() {
    return "Power Forward";
  }
}

var forward = {
  positionsCanPlay: function () {
    return ["PF", "SF"];
  },
  namePosition: function() {
    return "Forward";
  }
}

var smallForward = {
  positionsCanPlay: function () {
    return ["SF"];
  },
  namePosition: function() {
    return "Small Forward";
  }
}

var shootingGuard = {
  positionsCanPlay: function () {
    return ["SG"];
  },
  namePosition: function() {
    return "Shooting Guard";
  }
}

var pointGuard = {
  positionsCanPlay: function () {
    return ["PG"];
  },
  namePosition: function() {
    return "Point Guard";
  }  
}

var guard = {
  positionsCanPlay: function () {
    return ["PG", "SG"];
  },
  namePosition: function() {
    return "Guard";
  }  
}

var defaultStrategy = {
  positionsCanPlay: function () {
    return [];
  },
  namePosition: function() {
    return "";
  }  
}


var Position = function () {
  this.abbreviation = "";
}

Position.prototype = {
  getStrategy: function(position) {
    if (position === 'PG') {
      return pointGuard;
    } else if (position === 'SG') {
      return shootingGuard;
    } else if (position === 'SF') {
      return  smallForward;
    } else if (position === 'PF') {
      return powerForward;
    } else if (position ==='C') {
      return center;
    } else if (position === 'G') {
      return guard;
    } else if (position === 'F') {
      return forward;
    } else {
      return defaultStrategy;
    }
  },

  setStrategy: function (strategy) {
    this.strategy = strategy;
  },

  positionsCanPlay: function(abbreviation) {
    this.setStrategy(this.getStrategy(abbreviation));
    return this.strategy.positionsCanPlay();
  },

  namePosition: function(abbreviation) {
    this.setStrategy(this.getStrategy(abbreviation));
    return this.strategy.namePosition(abbreviation);
  }
}



export default Ember.Mixin.create({
  positionToWord: function (position) {
    var strat = new Position();
    return strat.namePosition(position);
  },
  positionsCanPlay: function(position) {
    var strat = new Position();
    return strat.positionsCanPlay(position);
  }
});