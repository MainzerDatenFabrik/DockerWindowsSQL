# docker_why_investigator_db


## Informationen

- **Container: synchronizer**
  - port: 2020  
  - db:   AdventureWorks2014
  
- **Container: why_investigator**
  - port: 2019  
  - db:   why_investigator_stage

## Benutzung:

> Bevor die docker-compose.yml benutzt werden kann, müssen "Anpassungen" gemacht werden. Siehe [Anpassungen](#anpassungen) für weitere Informationen.

Den **Terminal/CMD/PowerShell** öffnen, in das Verzeichnis wo sich die **docker-compose.yml** Datei befindet wechseln (`cd /home/my/path/to/directory/containing/docker/compose/file`) und mit dem Befehl `docker-compose up` die beiden Container erzeugen und initialisieren (dies kann einige Minuten dauern).

Alternativ: Mit dem Befehl `docker-compose up -d` den Prozess vom Terminal/CMD/PowerShell detachen, damit das Eingabefenster nicht blockiert. Anschließend kann über den Terminal/CMD/PowerShell mit dem Befehl `docker-compose down` die Container gestoppt werden.

Nachdem die Container erstellt wurden, können die Container nach beispielsweise einem Neustart des Systems mit dem Befehl `docker start CONTAINER_NAME` gestartet werden, wobei **CONTAINER_NAME** durch den Namen des Containers ersetzt werden muss, der gestartet werden soll.
> `docker start synchronizer`  
> `docker start why_investigator`

Auf ähnliche Weise können die Container gestoppt werden: `docker stop CONTAINER_NAME`.
> `docker stop synchronizer`  
> `docker stop why_investigator`

## Anpassungen:

Die Datei **docker-compose.yml** ist der Blueprint für docker config files. Folgende Anpassungen müssen von jedem Benutzer gemacht werden:

### Zeile 11: (Synchronizer)
Die Zeile `attach_dbs=[{'dbName':'AdventureWorks2014', 'dbFiles':['C:\\Users\\aaron\\SCH Dropbox\\datenbanken\\data_logs\\AdventureWorks2014_Data.mdf', 'C:\\Users\\aaron\\SCH Dropbox\\datenbanken\\data_logs\\AdventureWorks2014_Log.ldf']}]` muss so angepasst werden, dass die angegebenen Pfade für **dbFiles** zu den jeweiligen .mdf und .ldf files zeigen (e.g., C:\\benedikt\\... oder C:\\simon\\...). ACHTUNG: Doppelte Backslashes zum trennen von directory names verwenden.

> Vermutlich sollte alles gleich sein und ihr müsst nur "aaron" im Pfad mit eurem Windows Benutzernamen austauschen.

### Zeile 13: (Synchronizer)
Die Zeile `c:/Users/aaron/SCH Dropbox/datenbanken/data_logs:c:/Users/aaron/SCH Dropbox/datenbanken/data_logs` muss so angepasst werden, dass der Pfad auf den Ordner zeigt, in dem sich die .mdf und .ldf Datein befinden die in Zeile 11 eingebunden werden sollen.
Achtung: Das format ist dabei `c:/PATH/TO/FILE:c:/PATH/TO/FILE`. 
Achtung: Das Laufwerk mit einem kleinen Buchstaben bezeichnen: c:/, d:/, etc.
Achtung: Einfache Forewardslashes zum trennen von directory names verwenden.

> Vermutlich sollte alles gleich sein und ihr müsst nur "aaron" im Pfad mit eurem Windows Benutzernamen austauschen.

### Zeile 23: (Why_investigator)
Wie Zeile 11 nur dieses mal mit Angaben bezüglich Why_investigator, nicht Synchronizer.

### Zeile 25: (Why_investigator)
Wie Zeile 13, nur dieses mal mit Angaben bezüglich Why_investigator, nicht Synchronizer.
"# DockerWindowsSQL" 
