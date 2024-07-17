#!/bin/bash

sed -i 's_<dd> Erik Schultes, .* FAIR Implementation Profile (FIP) Ontology.</dd>_<dd>Barbara Magagna, Erik Schultes, and Tobias Kuhn. FAIR Implementation Profile (FIP) Ontology.</dd>_' doc/fip/index-en.html

sed -i 's_{"@type":"Person","name":"https://orcid.org/0000-0001-8888-635X","url":"https://orcid.org/0000-0001-8888-635X"},{"@type":"Person","name":"https://orcid.org/0000-0002-1267-0234","url":"https://orcid.org/0000-0002-1267-0234"},{"@type":"Person","name":"https://orcid.org/0000-0003-2195-3997","url":"https://orcid.org/0000-0003-2195-3997"}_{"@type":"Person","name":"https://orcid.org/0000-0003-2195-3997","url":"https://orcid.org/0000-0003-2195-3997"},{"@type":"Person","name":"https://orcid.org/0000-0002-1267-0234","url":"https://orcid.org/0000-0002-1267-0234"},{"@type":"Person","name":"https://orcid.org/0000-0001-8888-635X","url":"https://orcid.org/0000-0001-8888-635X"}_' doc/fip/index-en.html

sed -i 's_<dd><a href="https://orcid.org/0000-0001-8888-635X"> Erik Schultes</a></dd><dd><a href="https://orcid.org/0000-0002-1267-0234"> Tobias Kuhn</a></dd><dd><a href="https://orcid.org/0000-0003-2195-3997"> Barbara Magagna</a></dd>_<dd><a href="https://orcid.org/0000-0003-2195-3997">Barbara Magagna</a></dd><dd><a href="https://orcid.org/0000-0001-8888-635X">Erik Schultes</a></dd><dd><a href="https://orcid.org/0000-0002-1267-0234">Tobias Kuhn</a></dd>_' doc/fip/index-en.html

