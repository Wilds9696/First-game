extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
@onready var hitbox := $Hitbox # Pastikan nama nodenya "Hitbox" (Area2D)

var sudah_mati = false

func _ready():
	sprite.play("idle")
	# Menghubungkan signal secara otomatis lewat kode
	if not hitbox.area_entered.is_connected(kena_serang):
		hitbox.area_entered.connect(kena_serang)

func kena_serang(area: Area2D):
	if sudah_mati:
		return

	# DEBUG: Baris ini akan muncul di Output setiap kali ada benda menyentuh musuh
	print("Sesuatu menabrak musuh: ", area.name)

	# Menggunakan Group jauh lebih aman daripada nama Node
	if area.is_in_group("senjata"):
		print("Kena senjata! Musuh mati.")
		musuh_mati()

func musuh_mati():
	sudah_mati = true
	
	# Matikan deteksi tabrakan agar tidak kena pukul lagi saat sudah mati
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	# Matikan pergerakan
	set_physics_process(false)
	
	# Mainkan animasi mati
	sprite.play("mati")
	
	# Tunggu animasi selesai (0.4 detik) sebelum menghapus musuh
	await get_tree().create_timer(0.4).timeout
	queue_free()
