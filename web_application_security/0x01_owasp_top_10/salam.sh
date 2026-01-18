import requests

# Konfiqurasiya
base_url = "http://web0x01.hbtn/a3/xss_stored"
# Sənin brauzerdəki sessiya cookielərini bura yazmalısan (əgər login olmusansa)
# Və ya sadəcə requests.Session() istifadə edib skript daxilində login ola bilərik, 
# amma bu tapşırıqda sessiya adətən IP əsaslı və ya sadə cookie ilə işləyir.
# Əgər cookie lazımdırsa, F12 -> Application -> Cookies bölməsindən götürüb bura əlavə et.
cookies = {
    # "session_id": "sənin_cookie_dəyərin" # Əgər tələb olunursa
}

# Hədəf ID-lər (Adətən bu tapşırıqda 11, 12, 13 olur)
targets = [11, 12, 13]

print("--- Əməliyyat Başladı ---")

for user_id in targets:
    # İzləmə (Follow) sorğusu
    # Qeyd: Real URL strukturunu yoxlamaq lazımdır, adətən POST və ya GET olur.
    # Bu laboratoriyada adətən profilə girib "Follow" düyməsi bir API çağırır.
    # Biz birbaşa həmin endpointi çağırmağa cəhd edirik.
    
    print(f"[*] İstifadəçi {user_id} izlənilir...")
    
    # 1. Profil səhifəsinə get (bəzən bu kifayətdir ki, 'visited' sayılsın)
    url_profile = f"{base_url}/profile/{user_id}"
    requests.get(url_profile, cookies=cookies)
    
    # 2. 'Follow' əməliyyatı (Endpoint təxmini: /api/follow və ya profile səhifəsindəki form)
    # Çox vaxt bu tapşırıqda sadəcə profil səhifəsindəki 'Follow' linkinə GET sorğusu kifayətdir.
    # Struktur belə ola bilər: /a3/xss_stored/profile/{id}/follow
    url_follow = f"{base_url}/profile/{user_id}/follow"
    r = requests.post(url_follow, cookies=cookies) # Bəzən GET, bəzən POST
    if r.status_code == 405: # Əgər POST işləməsə, GET yoxlayırıq
        requests.get(url_follow, cookies=cookies)

print("[+] İzləmə tamamlandı.")

# Bayrağı yoxlayaq (Öz profilimizdə)
print("[*] Bayraq yoxlanılır...")
me_url = f"{base_url}/profile/me" # Və ya sənin öz ID-n
r = requests.get(me_url, cookies=cookies)

if "Flag" in r.text or "flag" in r.text:
    print("\n[!!!] BAYRAQ TAPILDI [!!!]")
    for line in r.text.split("\n"):
        if "Flag" in line or "flag" in line:
            print(">> " + line.strip())
            # Fayla yazaq
            with open("3-flag.txt", "w") as f:
                f.write(line.strip())
else:
    print("[-] Bayraq hələ görünmür. Brauzerdə profilinə girib əl ilə yoxla.")
