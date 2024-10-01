### Lokacija `.env` fajla:
- `.env` fajl treba biti smješten u root direktorijumu projekta.

# Kredencijali za prijavu:

## DESKTOP: 
- **Username**: admin
- **Password**: admin

## MOBILE:
1. **Username**: kemal  
   **Password**: student

2. **Username**: lejla  
   **Password**: student

## ONLINE PLAĆANJE:

- **Broj kartice**: 4242 4242 4242 4242
- **Datum**: 12/34

### RabbitMQ implementacija:
   
Na desktop aplikaciji kod rezervacija, prijava na prakse i stipendije klikom na akciju tj. ikonicu za uređivanje i promjenom statusa prijave ili rezervacije šalje se mail korisniku kao obavijest da li je prijava otkazana ili odobrena
- Publisher: MailService (pozvan unutar poslovne logike u StateMachines dijelu projekta, u funkcijama za odobravanje i otkazivanje prijava/rezervacija) šalje poruku RabbitMQ-u.
- Subscriber: Konzolni projekt koji sluša poruke i obrađuje ih.

