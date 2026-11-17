# FDTOOL V2 — Service Procedure Catalog

## Objetivo

Crear un catálogo versionado de procedimientos por fabricante, modelo, variante regional, operador, chipset y versión de Android. La arquitectura se inspira en la organización de suites profesionales de servicio técnico, pero FDTOOL mantiene sus propios procedimientos y no presupone que un método de otra herramienta sea reproducible.

## Arquitectura propuesta

1. **Device Identification**: recopila fabricante, marca, modelo, codename, Android, build fingerprint y, cuando esté disponible de forma legítima, chipset/variante. Los identificadores sensibles se enmascaran en informes.
2. **Capability Detection**: determina qué interfaces están disponibles (ADB autorizado, Fastboot, diagnóstico manual). La detección no ejecuta cambios.
3. **Catalog Client**: descarga un catálogo JSON versionado por HTTPS desde un endpoint configurable. Conserva una copia local con fecha de expiración y muestra cuándo está desconectado.
4. **Compatibility Matcher**: compara fabricante/modelo/código regional/operador/Android. Si no hay coincidencia exacta, presenta el procedimiento como no verificado; nunca extrapola compatibilidad.
5. **Procedure Runner**: inicialmente muestra pasos y enlaces oficiales. Cada operación futura debe declarar permisos, requisitos, riesgos, compatibilidad y confirmación explícita.
6. **Audit Log**: registra fecha, versión del catálogo, dispositivo identificado de forma minimizada, procedimiento consultado y resultado declarado por el técnico.

## Esquema de cada procedimiento

El contrato está en `../Data/service-procedures.schema.json`. El catálogo inicial está en `../Data/service-procedures.json`.

Campos principales:
- `id`, `title`, `category`, `status`: identidad y nivel de verificación.
- `match`: fabricantes, modelos, códigos de modelo, chipset, operadores, regiones y Android.
- `connection`: `none`, `adb-read-only`, `fastboot-read-only`, `manufacturer-portal` o `manual`.
- `requirements`, `steps`, `limitations`: requisitos, instrucciones y límites.
- `source`, `checkedAt`, `reviewedAt`: trazabilidad y vigencia.

## Seguridad y límites de SIM Unlock

- El diagnóstico puede identificar indicios de SIM Lock, pero ADB/Fastboot no ofrecen un comando universal de desbloqueo de red.
- Los procedimientos de desbloqueo se basarán en códigos NCK cuando el fabricante/operador los proporcione, portales oficiales o interfaces de servicio documentadas y autorizadas.
- No se incluirán métodos para alterar IMEI, clonar identidades, extraer credenciales/tokens, modificar NV/EFS para eludir bloqueos, evadir controles antirrobo/FRP ni explotar vulnerabilidades.
- No se afirmará que un teléfono está desbloqueado hasta comprobarlo con una SIM de otro operador y documentar el resultado.
- El catálogo no debe contener contraseñas, claves privadas ni credenciales de servidor.

## Actualización del catálogo

El servidor debe publicar un JSON validado contra el esquema. Para producción:
- HTTPS obligatorio.
- Firma digital del manifiesto/catálogo y verificación en el cliente antes de importar.
- Versiones monotónicas, fecha de expiración y rollback controlado.
- Historial de cambios y revisión humana antes de marcar un procedimiento como `verified`.
- No ejecutar código descargado desde el catálogo. El catálogo contiene datos e instrucciones; el motor local implementa las operaciones permitidas.

## Estado actual

Esta entrega define el contrato de datos y un flujo inicial de diagnóstico manual. **No hay todavía servidor desplegado ni desbloqueo SIM automático**. La integración cliente/servidor y la verificación criptográfica quedan para la siguiente fase.
