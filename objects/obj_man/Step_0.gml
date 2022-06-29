keyUp = keyboard_check(vk_up);
keyLeft = keyboard_check(vk_left);
keyDown = keyboard_check(vk_down);
keyRight = keyboard_check(vk_right);
keyInteract = keyboard_check_pressed(ord("Z"));

if ridingZamboni {
	movementSpeed = 3 
	if hspd > 0 image_xscale = -1 else image_xscale = 1;
	if frameCount % 5 == 0 instance_create_layer(x + irandom_range(-3, 3), y + irandom_range(-3, 3), "Instances", obj_cloud);
}
else {
	movementSpeed = 1;
	if hspd > 0 image_xscale = 1 else image_xscale = -1;
	walkAnimSpeed = hspd;
	if walkAnimSpeed < 0 walkAnimSpeed *= -1;
	image_speed = walkAnimSpeed;
}

if place_meeting(x, y, obj_ice){
	vspd = lerp(vspd, (keyDown - keyUp) * movementSpeed, iceSlideRate);
	hspd = lerp(hspd, (keyRight - keyLeft) * movementSpeed, iceSlideRate);
}
else {
	vspd = (keyDown - keyUp) * movementSpeed;
	hspd = (keyRight - keyLeft) * movementSpeed;
}

if !instance_place(x + hspd, y, obj_wall) {
	x += hspd;
}

if !instance_place(x, y + vspd, obj_wall) {
	y += vspd;	
}



if keyInteract {
	if ridingZamboni {
		sprite_index = spr_man;
		instance_create_layer(x, y, "Instances", obj_zam);
		ridingZamboni = false;
	}
	else {
		if distance_to_object(obj_zam) < 50 {
			sprite_index = spr_manzam;
			instance_destroy(obj_zam);
			ridingZamboni = true;
		}
	}
}

frameCount++;