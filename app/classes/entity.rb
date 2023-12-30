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
    @dx = 0
    @dy = 0
    @cooldown = 0
    # Idle Down
    # Idle Right
    # Idle Up
    # Walk Down
    # Walk Right
    # Walk Up
    # Attack Down
    # Attack Right
    # Attack Up
    # Die
    @anim_frames = args.walk_anim || [6, 6, 6, 6, 6, 6, 4, 4, 4, 3]
    @anim_state = args.anim_state || 0
    @frame = args.frame || 0
    @frame_delay = args.frame_delay || 10
    @frame_counter = @frame_delay
    @tile_x = @tile_base_x = args.tile_x || 0
    @tile_y = @tile_base_y = args.tile_y || 0
    @tile_w = args.tile_w || 48
    @tile_h = args.tile_h || 48
    @flip_horizontally = false
    @path = args.path || 'sprites/mwoods/characters/player.png'
  end

  def tick args
    @frame_counter -= 1
    if @frame_counter <= 0
      @frame_counter = @frame_delay
      @frame = (@frame + 1) % @anim_frames[@anim_state]
      @tile_y = @tile_base_y + (@anim_state * @tile_h)
      @tile_x = @tile_base_x + (@frame * @tile_w)
    end
    
    if @dx != 0
      @x += @dx
      @dx = 0
    elsif @dy != 0
      @y += @dy
      @dy = 0
    elsif @cooldown > 0
      @cooldown -= 1
      if @cooldown <= 0
        @cooldown = 0
        @anim_state -= 3
      end
    end
  end

  def move(dx=0, dy=0)	  
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
    @dx += dx
    @dy += dy
    @cooldown = 1
  end

  def center_x
    (@x + @w.div(2))
  end

  def center_y
    (@.y + @h.div(2))
  end

  def primitive_marker
    :sprite
  end
end
