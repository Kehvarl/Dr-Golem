class GameMap
  attr_accessor :obstacles, :collisions
  def initialize args
    @w = args.w || 1280
    @h = args.h || 720
    @obstacles = []
  end

  def add_obstacle x, y, w, h, r=128, g=128, b=128
    @obstacles << {x: x, y: y, w: w, h: h, r: r, g: g, b: b}.solid!
  end

  def collisions args, entity
    return args.geometry.find_all_intersect_rect(entity,
                                                 @obstacles)
  end
end
