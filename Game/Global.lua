return {
  DEBUG_MODE = true,
  STATIC_OBJECT_ID = 0,
  BLOCK_SIZE = 32,
  BLOCK_LINE_COLOR = {255,255,255,80},
  COLLIDER_PADDING = 2,
  BACKGROUD_COLOR = {149, 165, 166},
  DISABLED_COLOR  = {255,255,255,127},
  -- Controlles
  CAMERA_ZOOM_FACTOR = 1.5,
  CONTROLS = {
    new_block               = {'sc:n'},
    end_game                = {'sc:escape'},
    zoom_in                 = {'sc:2'},
    zoom_out                = {'sc:1'},
    zoom_reset              = {'sc:0'},
    camera_drag             = {'mouse:2'},
    blockGroup_drag         = {'mouse:1'},
    blockGroup_rotate_left  = {'sc:q'},
    blockGroup_rotate_right = {'sc:e'},
    debug_toggle            = {'sc:d'},
    debug_activation_key    = {'sc:space'},
  },
  BLOCKTYPE_CONTROLBLOCK_FORCE = 2000,
  BLOCKTYPE_PROPULSIONBLOCK_FORCE = 2000,
  BLOCK_LINEARDAMPING = 2.5,

  -- COLLISION CLASSES
  COLLISION_CLASS_BLOCK = "BLOCK"
}
