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
    @face = args.face || 0
    @path = args.path || 'sprites/circle/blue.png'
  end

  def move(dx=0, dy=0)
    @x += dx
    @y += dy
    
  end

  def center_x
    (self.x + self.w.div(2))
  end

  def center_y
    (self.y + self.h.div(2))
  end

  def render
    return {x: self.x, y: self.y, w: self.w, h: self.h, path: self.path}.sprite!
    
  end
end
