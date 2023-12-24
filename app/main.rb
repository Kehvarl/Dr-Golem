def tick args
  args.state.player.x ||=640
  args.state.player.y ||=480
  args.state.player.d ||=0

  if args.inputs.keyboard.down
    args.state.player.y -= 1
    args.state.player.d = 270
  elsif args.inputs.keyboard.up
    args.state.player.y += 1
    args.state.player.d = 90
  elsif args.inputs.keyboard.left
    args.state.player.x -= 1
    args.state.player.d = 180
  elsif args.inputs.keyboard.right
    args.state.player.x += 1
    args.state.player.d = 0
  end

  args.outputs.primitives << {x: args.state.player.x,
                              y: args.state.player.y,
                              w: 32,
                              h: 32,
                              angle: args.state.player.d,
                              path: "sprites/circle/blue.png"}.sprite!

end
