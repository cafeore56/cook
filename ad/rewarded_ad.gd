extends Button
## Rewarded広告

var _rewarded_ad : RewardedAd
var _rewarded_ad_load_callback := RewardedAdLoadCallback.new()
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
var _full_screen_content_callback := FullScreenContentCallback.new()

@onready var ad_button = $"."


func _ready():
	MobileAds.initialize()	# Google Mobile Ads SDK を初期化
	_rewarded_ad_load_callback.on_ad_failed_to_load = _on_rewarded_ad_failed_to_load
	_rewarded_ad_load_callback.on_ad_loaded = _on_rewarded_ad_loaded
	on_user_earned_reward_listener.on_user_earned_reward = _on_user_earned_reward
	_full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		ad_button.disabled = true
		if _rewarded_ad:
			_rewarded_ad.destroy()
			_rewarded_ad = null
		load_ad()
	ad_button.disabled = true
	load_ad()
	self.pressed.connect(_on_pressed)
	EventBus.rewarded_display_shot.connect(_on_pressed)


# 広告を読み込む
func load_ad() -> void:
	var unit_id : String
	if OS.get_name() == "Android":
		unit_id = DataBase.AdMob["Rewarded"].Android
	elif OS.get_name() == "iOS":
		unit_id = DataBase.AdMob["Rewarded"].IOS
 
	RewardedAdLoader.new().load(unit_id, AdRequest.new(), _rewarded_ad_load_callback)


# 広告の読み込み失敗
func _on_rewarded_ad_failed_to_load(adError : LoadAdError) -> void:
	print("広告の読み込みに失敗しましたよー%" % adError)
	EventBus.rewarded_not_set.emit()


# 広告の読み込みが完了しました。
func _on_rewarded_ad_loaded(rewarded_ad : RewardedAd) -> void:
	self._rewarded_ad = rewarded_ad
	self._rewarded_ad.full_screen_content_callback = _full_screen_content_callback
	ad_button.disabled = false
	
	# 広告セット完了
	EventBus.rewarded_set_ok.emit()

# 広告を見終わった後の処理
func _on_user_earned_reward(rewarded_item : RewardedItem): # not using rewarded_item
	print("on_user_earned_reward, rewarded_item: rewarded", rewarded_item.amount, rewarded_item.type)
	# 広告を見たという事
	EventBus.rewarded_shot.emit()

# 広告を表示する --この関数にボタンを紐づけるのが一番重要
func _on_pressed():
	if _rewarded_ad:
		_rewarded_ad.show(on_user_earned_reward_listener)
		print("PC確認用（広告再生中）")
