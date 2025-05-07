@tool extends EditorScript
## ProjectSettings


func _run() -> void:
	# 画面サイズ
	ProjectSettings.set("display/window/size/viewport_width",512)
	ProjectSettings.set("display/window/size/viewport_height",1024)
	#ProjectSettings.set("display/window/size/window_width_override",512)
	#ProjectSettings.set("display/window/size/window_height_override",1024)
	ProjectSettings.set("display/window/size/window_width_override",256)
	ProjectSettings.set("display/window/size/window_height_override",512)
	# 画面ストレッチタイプ
	ProjectSettings.set("display/window/stretch/mode", "canvas_items")
	# 画面（縦横設定）(縦向きセンサー対応のはず）
	ProjectSettings.set("display/window/handheld/orientation", DisplayServer.SCREEN_SENSOR_PORTRAIT)
	# 画像（近くでクッキリ）
	ProjectSettings.set("rendering/textures/canvas_textures/default_texture_filter", "Nearest")
	# Androidエクスポート用設定
	ProjectSettings.set("rendering/textures/vram_compression/import_etc2_astc", true)
	# 最大FPS（60）
	ProjectSettings.set("application/run/max_fps", 60)
	# デバッグ警告文無効化
	ProjectSettings.set("debug/gdscript/warnings/unused_signal", "Ignore")
	ProjectSettings.set("debug/gdscript/warnings/integer_division", "Ignore")
	# マウスでクリック可設定
	ProjectSettings.set("input_devices/pointing/emulate_touch_from_mouse", true)
	# Blender無効
	ProjectSettings.set("filesystem/import/blender/enabled", false)
	# 2D物理LayerName設定
	ProjectSettings.set("layer_names/2d_physics/layer_1", "player")
	ProjectSettings.set("layer_names/2d_physics/layer_2", "enemy")
	ProjectSettings.set("layer_names/2d_physics/layer_3", "npc")
	ProjectSettings.set("layer_names/2d_physics/layer_4", "wall")
	ProjectSettings.set("layer_names/2d_physics/layer_5", "obj")
	ProjectSettings.set("layer_names/2d_physics/layer_6", "item")
	ProjectSettings.set("layer_names/2d_physics/layer_7", "nana")
	# 設定をセーブ
	ProjectSettings.save()
