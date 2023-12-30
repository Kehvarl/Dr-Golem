class GameMap
  def initialize args
    @w = args.w || 1280
    @h = args.h || 720
    @tiles = load_map(args)
  end

  def load_map args
    out = {}
    (0..args.h).each |y| do
      (0..args.w).each |x| do
        out[(x,y)] = '.'
      end
    end
      
    end
  end
end
