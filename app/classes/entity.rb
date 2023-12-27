class Entity
  attr_accessor :x, :y, :w, :h, :path, :angle, :a, :r, :g, :b, :tile_x,
                :tile_y, :tile_w, :tile_h, :flip_horizontally,
                :flip_vertically, :angle_anchor_x, :angle_anchor_y, :id,
                :angle_x, :angle_y, :z,
                :source_x, :source_y, :source_w, :source_h, :blendmode_enum,
                :source_x2, :source_y2, :source_x3, :source_y3, :x2, :y2, :x3, :y3,
                :anchor_x, :anchor_y
  
  def initialize args
    @x = args.x || 0
    @y = args.y || 0
    @w = args.w || 32
    @h = args.h || 32
    @dx = 0
    @dy = 0
    @anim_frames = args.walk_anim || [[0], [0], [0], [0], [0]] # Idle, R, L, U, D
    @anim_state = args.anim_state || 0
    @frame = args.frame || 0
    @frame_delay = args.frame_delay || 10
    @frame_counter = @frame_delay
    @tile_x = @tile_base_x = args.tile_x || 0
    @tile_y = @tile_base_y = args.tile_y || 0
    @tile_w = args.tile_w || 80
    @tile_h = args.tile_h || 80
    @path = args.path || 'sprites/circle/blue.png'
  end

  def tick args
    @frame_counter -= 1
    if @frame_counter <= 0
      @frame_counter = @frame_delay
      @frame = (@frame + 1) % @anim_frames[@anim_state].length

      @tile_x = @tile_base_x + @anim_frames[@anim_state][@frame]
    end
    
    if @dx != 0
      @x += @dx
      @dx = 0
    elsif @dy != 0
      @y += @dy
      @dy = 0
    end
  end

  def move(dx=0, dy=0)
    @dx += dx
    @dy += dy
  end

  def center_x
    (self.x + self.w.div(2))
  end

  def center_y
    (self.y + self.h.div(2))
  end

  def primitive_marker
    :sprite
  end
end
