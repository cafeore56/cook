extends Control
# Interstitial広告

var _interstitial_ad : InterstitialAd
var _interstitial_ad_load_callback := InterstitialAdLoadCallback.new()
var _full_screen_content_callback := FullScreenContentCallback.new()


func _ready():
	MobileAds.initialize()	# Google Mobile Ads SDK を初期化
	_interstitial_ad_load_callback.on_ad_failed_to_load = _on_interstitial_ad_failed_to_load
	_interstitial_ad_load_callback.on_ad_loaded = _on_interstitial_ad_loaded
	_full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		if _interstitial_ad:
			_interstitial_ad.destroy()
			_interstitial_ad = null
		load_ad()
	load_ad()


# 広告を読み込む
func load_ad() -> void:
	var unit_id : String
	if OS.get_name() == "Android":
		unit_id = DataBase.AdMob["Interstitial"].Android
	elif OS.get_name() == "iOS":
		unit_id = DataBase.AdMob["Interstitial"].IOS
	
	InterstitialAdLoader.new().load(unit_id, AdRequest.new(), _interstitial_ad_load_callback)


# 広告の読み込み失敗
func _on_interstitial_ad_failed_to_load(adError : LoadAdError) -> void:
	print("広告の読み込みに失敗しましたよー%" % adError)


# 広告の読み込みが完了しました。
func _on_interstitial_ad_loaded(interstitial_ad : InterstitialAd) -> void:
	print("interstitial ad loaded" + str(interstitial_ad._uid))
	self._interstitial_ad = interstitial_ad
	self._interstitial_ad.full_screen_content_callback = _full_screen_content_callback




# 広告を表示する --この関数にボタンを紐づけるのが一番重要
func show_interstitial():
	if _interstitial_ad:
		_interstitial_ad.show()
	print("うわーお")
	await get_tree().create_timer(0.1).timeout
	#TransitionScreen.change_scene("res://scene/main.tscn")
