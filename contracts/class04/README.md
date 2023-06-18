# BLOCKCHAIN BITES - ETHEREUM LIMA - UNI

WORKSHOP DE PROGRAMACIÓN BLOCKCHAIN

## Ponente

Lee Marreros - [Linkedin](https://www.linkedin.com/in/lee-marreros/) - [Twitter](https://twitter.com/LeeMarreros)

## ¡Síguenos! No te pierdas nigún evento

[Discord](https://discord.gg/7hJBfgfpvs)

[LinkedIn](https://www.linkedin.com/company/blockchain-bites-es/)

[MeetUp](https://www.meetup.com/blockchain-bites)

[Twitter](https://twitter.com/bbitesschool)

## Ejercicio Semana 4

### Objetivo: Vamos a crear un contrato que se comporte como un cajero automático o ATM.

Mediente este contrato, el usuario puede depositar y retirar fondos.
Así también el usuario puede transferir fondos a otro usuario.
Tendrá las siguientes características:

- Permite depositar fondos en el contrato mediante el método 'depositar'.
- Permite retirar fondos del contrato mediante el método 'retirar'.
- Permite transferir fondos a otro usuario mediante el método 'transferir'.
- Permite consultar el saldo del usuario. Hacer la estructura de datos 'public'
- Permite consultar el saldo del ATM. Hacer la variable 'public'
- modifier de pausa: verifica si el boolean 'pausado' es true o false
- modifier de admin: verifica que el msg.sender sea el admin
- Permite cambiar el boolean 'pausado' mediante el método 'cambiarPausado' y verifica que solo es llamado por el admin
  Notas:
- para guardar y actualizar los balances de un usuario, se utilizará un diccionario
- el modifier protector usa un booleano para saber si está activo o no
- este booleano solo puede ser modificado por una cuenta admin definida previamente

### Testing

Ejecutar el siguiente comando. Deberían pasar todos los tests

`$ npx hardhat test test/EjercicioSemana4.js`
