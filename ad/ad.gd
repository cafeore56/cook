extends Node

# Banner広告
var _ad_view: AdView
var _adPosition := AdPosition.Values.BOTTOM
#var ad_size := AdSize.new(200, 200)

func _ready():
	_on_load_banner_pressed()	# 広告
	
# ■ AdMob -----------------------------------------
# 広告を作成（読み込み）
func _create_ad_view() -> void:
	if _ad_view:
		_ad_view.destroy()
	
	var unit_id : String
	if OS.get_name() == "Android":
		unit_id = DataBase.AdMob.Banner["Android"]
	elif OS.get_name() == "iOS":
		unit_id = DataBase.AdMob.Banner["IOS"]
	_ad_view = AdView.new(unit_id, AdSize.BANNER, _adPosition)
	#_ad_view = AdView.new(unit_id, ad_size, AdPosition.Values.BOTTOM)
	
# 広告を表示する
func _on_load_banner_pressed():
	if _ad_view == null:
		_create_ad_view()
	var ad_request := AdRequest.new()
	_ad_view.load_ad(ad_request)
	
	
