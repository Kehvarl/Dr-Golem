
require('app/classes/entity.rb')

def new_player
  return {x: 640, y: 480, w: 96, h: 96,
          anim_frames: [[0,6], [1,6], [2,6],
                        [3,6], [4,6], [5,6],
                        [6,4], [7,4], [8,4], [9,3]],
          frame_delay: 10, tile_x: 0, tile_y: 0,
          tile_w: 48, tile_h: 48,
          path: 'sprites/mwoods/characters/player.png'}
end

def new_slime
  return {x: [40, 80, 120, 240, 480, 920, 1040, 1120, 1160].sample(),
          y: [40, 80, 120, 240, 360, 600, 660].sample(),
          w: 64, h: 64,
          anim_frames: [[0,4], [0,4], [0,4],
                        [1,6], [1,6], [2,7],
                        [3,3], [3,3], [3,3], [4,5]],
          frame_delay: 10, tile_x: 0, tile_y: 0,
          tile_w: 32, tile_h: 32,
          path: 'sprites/mwoods/characters/slime.png'}
end

def tick args
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

  args.outputs.primitives << args.state.player
  args.outputs.primitives << args.state.enemies
end
