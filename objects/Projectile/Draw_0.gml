
depth = -9999;

image_blend = color;
image_xscale = scale;
image_yscale = scale;

sprite_index = sprite;

surface_set_target(SurfaceHandler.surface);
draw_self();
surface_reset_target();
