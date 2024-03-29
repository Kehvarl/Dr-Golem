
require('app/classes/entity.rb')
require('app/classes/game_map.rb')

def new_player
  return {x: 640, y: 480, w: 36, h: 44,
          anim_frames: [[0,6], [1,6], [2,6],
                        [3,6], [4,6], [5,6],
                        [6,4], [7,4], [8,4], [9,3]],
          frame_delay: 10, tile_x: 0, tile_y: 0,
          tile_w: 18, tile_h: 22,
          sprite_w: 48, sprite_h: 48,
          padding_x: 13, padding_y: 21,
          path: 'sprites/mwoods/characters/player.png'}
end

def new_slime
  return {x: [40, 80, 120, 240, 480, 920, 1040, 1120, 1160].sample(),
          y: [40, 80, 120, 240, 360, 600, 660].sample(),
          w: 32, h: 32,
          anim_frames: [[0,4], [0,4], [0,4],
                        [1,6], [1,6], [2,7],
                        [3,3], [3,3], [3,3], [4,5]],
          frame_delay: 10, tile_x: 0, tile_y: 0,
          tile_w: 16, tile_h: 24,
          sprite_w: 32, sprite_h: 32,
          padding_x: 8, padding_y: 4,
          path: 'sprites/mwoods/characters/slime.png'}
end

def new_game_map
  m = GameMap.new({})
  m.add_obstacle(480, 240, 240, 60, 128, 128, 128)
  return m
end

def tick args
  args.state.game_map ||= new_game_map
  args.state.player ||= Entity.new(new_player)
  args.state.enemies ||= [Entity.new(new_slime), Entity.new(new_slime),
                          Entity.new(new_slime)]

  if args.inputs.keyboard.down
    args.state.player.move_by(0,-1)
  elsif args.inputs.keyboard.up
    args.state.player.move_by(0,1)
  elsif args.inputs.keyboard.left
    args.state.player.move_by(-1, 0)
  elsif args.inputs.keyboard.right
    args.state.player.move_by(1,0)
  end

  if args.inputs.mouse.button_left
    args.state.player.move_to(args.inputs.mouse.x, args.inputs.mouse.y)
  end

  args.state.player.tick args
  args.state.enemies.each do |e|
    if not e.moving
      e.move_to([args.state.player.x, 48, 60, 1140].sample,
                [args.state.player.y, 48, 120, 650].sample)
    end
    e.tick args
  end

  args.outputs.primitives << args.state.game_map.obstacles
  args.outputs.primitives << args.state.player
  args.outputs.primitives << args.state.enemies
end
