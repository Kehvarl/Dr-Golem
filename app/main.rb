
require('app/classes/entity.rb')

def tick args
  args.state.player ||= Entity.new({})

  if args.inputs.keyboard.down
    args.state.player.move(0,-1)
  elsif args.inputs.keyboard.up
    args.state.player.move(0,1)
  elsif args.inputs.keyboard.left
    args.state.player.move(-1, 0)
  elsif args.inputs.keyboard.right
    args.state.player.move(1,0)
  end

  if args.inputs.mouse.button_left
    args.state.player.move_to(args.inputs.mouse.x, args.inputs.mouse.y)
  end

  args.state.player.tick args

  args.outputs.primitives << args.state.player
end
