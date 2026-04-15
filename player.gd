extends CharacterBody2D

const kecepatan = 100
var arah = "diam"
var sedang_serang = false

func _physics_process(delta):
	gerak_player(delta)

func gerak_player(delta):
	if Input.is_action_just_pressed("klik_kiri") and not sedang_serang:
		serang()
		return

	if sedang_serang:
		velocity.x = 0
		velocity.y = 0
		move_and_slide()
		return

	if Input.is_action_pressed("ui_right"):
		arah = "kanan"
		arah_player(true)
		velocity.x = kecepatan
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		arah = "kiri"
		arah_player(true)
		velocity.x = -kecepatan
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		arah = "atas"
		arah_player(true)
		velocity.x = 0
		velocity.y = -kecepatan
	elif Input.is_action_pressed("ui_down"):
		arah = "bawah"
		arah_player(true)
		velocity.x = 0
		velocity.y = kecepatan
	else:
		arah_player(false)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func serang():
	sedang_serang = true
	velocity.x = 0
	velocity.y = 0

	var animasi = $AnimatedSprite2D

	# Tentukan animasi serang sesuai arah
	if arah == "kanan":
		animasi.flip_h = false
		animasi.play("serang")
	elif arah == "kiri":
		animasi.flip_h = true
		animasi.play("serang")
	elif arah == "atas":
		animasi.flip_h = false
		animasi.play("serang_atas")
	elif arah == "bawah":
		animasi.flip_h = false
		animasi.play("serang_bawah")
	else:
		animasi.flip_h = false
		animasi.play("serang")

	# Tunggu animasi selesai baru lanjut
	await animasi.animation_finished

	sedang_serang = false
	animasi.play("diam")

func arah_player(gerak):
	var animasi = $AnimatedSprite2D

	if arah == "kanan":
		animasi.flip_h = false
		if gerak:
			animasi.play("jalan_kanan")
		else:
			animasi.play("diam")
	elif arah == "kiri":
		animasi.flip_h = true
		if gerak:
			animasi.play("jalan_kiri")
		else:
			animasi.play("diam")
	elif arah == "atas":
		animasi.flip_h = false
		if gerak:
			animasi.play("jalan_atas")
		else:
			animasi.play("diam")
	elif arah == "bawah":
		animasi.flip_h = false
		if gerak:
			animasi.play("jalan_bawah")
		else:
			animasi.play("diam")
