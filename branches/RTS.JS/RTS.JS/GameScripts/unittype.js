function UnitType(speed, direction, health, damage, range, cost, team, behaviorFunc, behaviors) {
    this.speed = speed;
    this.direction = direction;
    this.health = health;
    this.damage = damage;
    this.range = range;
    this.cost = cost;
    this.team = team;
    this.getBehavior = behaviorFunc;
    this.behaviors = behaviors;
}
   
