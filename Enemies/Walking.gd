extends KinematicBody2D


var moveSpeed = -100;
var velocity = Vector2();
var collisionSpeed = 0;


func _process(delta):
	velocity.x = moveSpeed;
	if (collisionSpeed > 0):
		collisionSpeed -= 1
	var collision = move_and_collide(velocity * delta)
	if collision && collisionSpeed <= 0:
		moveSpeed *= -2;
		collisionSpeed += 100;
		get_node("AnimatedSprite").flip_h = !get_node("AnimatedSprite").flip_h
