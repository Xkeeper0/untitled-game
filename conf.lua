function love.conf(t)
	t.identity              = "untitled-game"
	t.version               = "0.10.1"
	t.console               = true

	t.window.title          = "Ludum Dare 36"
	t.window.icon           = nil
	t.window.width          = 960
	t.window.height         = 672
	t.window.borderless     = false
	t.window.resizable      = false
	t.window.minwidth       = 1
	t.window.minheight      = 1
	t.window.fullscreen     = false
	t.window.fullscreentype = "desktop"
	t.window.vsync          = true
	t.window.msaa           = 0
	t.window.display        = 1
	t.window.highdpi        = false
	t.window.x              = nil
	t.window.y              = nil
end
