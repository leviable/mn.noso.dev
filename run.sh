
#!/bin/bash

Xvfb :99 -screen 0 640x480x8 -nolisten tcp &

chmod +x /app/Noso

/app/Noso
