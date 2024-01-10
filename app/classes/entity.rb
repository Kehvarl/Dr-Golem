class Entity
  attr_accessor :x, :y, :w, :h, :path, :angle, :a, :r, :g, :b, :tile_x,
                :tile_y, :tile_w, :tile_h, :flip_horizontally,
                :flip_vertically, :angle_anchor_x, :angle_anchor_y, :id,
                :angle_x, :angle_y, :z,
                :source_x, :source_y, :source_w, :source_h, :blendmode_enum,
                :source_x2, :source_y2, :source_x3, :source_y3, :x2, :y2, :x3, :y3,
                :anchor_x, :anchor_y
  
  def initialize args
    @x = args.x || 640
    @y = args.y || 480
    @w = args.w || 96
    @h = args.h || 96
    @vx = 0
    @vy = 0
    @target_x = @x
    @target_y = @y
    @dx = 0
    @dy = 0
    @cooldown = 0
    # Idle Down, Right, Up
    # Walk D, R, U
    # Attack D, R, U
    # Die
    @anim_frames = args.anim_frames || [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @anim_state = args.anim_state || 0
    @frame = args.frame || 0
    @frame_delay = args.frame_delay || 10
    @frame_counter = @frame_delay
    @sprite_w = args.tile_w || 80
    @sprite_h = args.tile_h || 80
    @padding_x = args.padding_x || 0
    @padding_y = args.padding_y || 0
    @tile_x = @tile_base_x = args.tile_x || 0
    @tile_y = @tile_base_y = args.tile_y || 0
    @tile_w = args.tile_w || 80
    @tile_h = args.tile_h || 80
    @flip_horizontally = false
    @anchor_x = 0.0
    @anchor_y = 0.0
    @path = args.path || 'sprites/circle/blue.png'
  end

  def tick args
    if moving
      move_towards_target args
    end
    
    if @dx != 0
      @x += @dx
      @dx = 0
    elsif @dy != 0
      @y += @dy
      @dy = 0
    elsif @cooldown >= 0
      @cooldown -= 1
    end

    animate
  end

  def animate
    # If was moving and stopped
    if @cooldown <= 0 and @anim_state >= 3
      @cooldown = 0
      @anim_state -= 3
    end

    
    # Next frame of animation
    @frame_counter -= 1
    if @frame_counter <= 0
      @frame_counter = @frame_delay
      @frame = (@frame + 1) % @anim_frames[@anim_state][1]
      @tile_y = @tile_base_y + (@anim_frames[@anim_state][0]* @sprite_h) + @padding_y
      @tile_x = @tile_base_x + (@frame * @sprite_w) + @padding_x
      @tile_h = @sprite_h - (2 * @padding_y)
      @tile_w = @sprite_w - (2 * @padding_x)
    end
  end

  def moving
    return (@x != @target_x or @y != @target_y)
  end

  def move_towards_target args
    dx = 0
    dy = 0
    if @x < @target_x
      dx = 1
    elsif @x > @target_x
      dx = -1
    end
    if @y < @target_y
      dy = 1
    elsif @y > @target_y
      dy = -1
    end
    move(args, dx, dy)
    cooldown = 1
  end

  def move(args, dx=0, dy=0)	  
    if dx < 0
      @anim_state = 4
      @flip_horizontally = true
    elsif dx > 0
      @anim_state = 4
      @flip_horizontally = false
    elsif dy < 0
      @anim_state = 3
      @flip_horizontally = false
    elsif dy > 0
      @anim_state = 5
      @flip_horizontally = false
    end

    check_collisions args, dx, dy
  end

  def check_collisions args, dx, dy
    temp = {x: @x + dx, y: @y + dy, w: @w, h: @h}
    collisions = args.state.game_map.collisions(args, temp)
    if collisions.length == 0
      @dx = dx
      @dy = dy
      @cooldown = 1
    else
      @target_x = @x - dx
      @target_y = @y - dy
      @cooldown = 0
      @dx = 0
      @dy = 0
    end   
  end

  def move_by(dx, dy)
    @target_x = @x +  dx
    @target_y = @y + dy
  end

  def move_to(tx, ty)
    @target_x = tx
    @target_y = ty
  end

  def center_x
    (@x + @w.div(2))
  end

  def center_y
    (@y + @h.div(2))
  end

  def serialize
    { x: @x, y: @y, w: @w, h: @h,
      vx: @vx, vy: @vy,
      target_x: @target_x, target_y: @target_y,
      dx: @dx, dy: @dy,
      anim_frames: @anim_frames, anim_state: @anim_state,
      frame: @frame
    }
  end

  def inspect
    "#{serialize}"
  end

  def to_s
    "#{serialize}"
  end  

  def primitive_marker
    :sprite
  end
end
