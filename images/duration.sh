cat <<'EOF'
 ______   _______                _                                               _   _       _   _                          _       _ 
|  ____| |__   __|     /\       | |                                             (_) | |     (_) (_)                        | |     (_)
| |__       | |       /  \      | |__     __ _   _ __    __   __   __ _   _ __   _  | |_      ___    _ __    _ __     ___  | |_     _ 
|  __|      | |      / /\ \     | '_ \   / _` | | '__|   \ \ / /  / _` | | '__| | | | __|    / _ \  | '_ \  | '_ \   / _ \ | __|   | |
| |____     | |     / ____ \    | | | | | (_| | | |       \ V /  | (_| | | |    | | | |_    | (_) | | |_) | | |_) | |  __/ | |_    | |
|______|    |_|    /_/    \_\   |_| |_|  \__,_| |_|        \_/    \__,_| |_|    |_|  \__|    \___/  | .__/  | .__/   \___|  \__|   |_|
                                                                                                    | |     | |                       
                                                                                                    |_|     |_|                       
                                                                                                                                      
EOF

curl -s https://eta.mateuszdrwal.com/api/status | jq -r '.duration' | figlet -w 230


cat <<'EOF'




  _____                                                           _                _                        ______   _______                                       _   _       _   _                          _   
 |  __ \                                                         | |              | |                      |  ____| |__   __|     /\                              (_) | |     (_) (_)                        | |  
 | |  | |   ___   _ __    _ __     __ _    __   __   ___    ___  | | __   __ _    | |__     __ _   _ __    | |__       | |       /  \      __   __   __ _   _ __   _  | |_      ___    _ __    _ __     ___  | |_ 
 | |  | |  / _ \ | '_ \  | '_ \   / _` |   \ \ / /  / _ \  / __| | |/ /  / _` |   | '_ \   / _` | | '__|   |  __|      | |      / /\ \     \ \ / /  / _` | | '__| | | | __|    / _ \  | '_ \  | '_ \   / _ \ | __|
 | |__| | |  __/ | | | | | | | | | (_| |    \ V /  |  __/ | (__  |   <  | (_| |   | | | | | (_| | | |      | |____     | |     / ____ \     \ V /  | (_| | | |    | | | |_    | (_) | | |_) | | |_) | |  __/ | |_ 
 |_____/   \___| |_| |_| |_| |_|  \__,_|     \_/    \___|  \___| |_|\_\  \__,_|   |_| |_|  \__,_| |_|      |______|    |_|    /_/    \_\     \_/    \__,_| |_|    |_|  \__|    \___/  | .__/  | .__/   \___|  \__|
                                                                                                                                                                                      | |     | |                 
                                                                                                                                                                                      |_|     |_|                 
EOF

( curl -s https://eta.mateuszdrwal.com/api/status | jq -jr '.total_open_prec' ; printf '%% av tiden' ) | figlet -w 230

sleep 0.5

cat <<'EOF'




     __      __  _   _   _         _                            _                                         _          _        
     \ \    / / (_) | | | |       | |                          | |                                       | |        | |       
      \ \  / /   _  | | | |     __| |  _   _    __   __   ___  | |_    __ _      ___    _ __ ___       __| |   ___  | |_      
       \ \/ /   | | | | | |    / _` | | | | |   \ \ / /  / _ \ | __|  / _` |    / _ \  | '_ ` _ \     / _` |  / _ \ | __|     
        \  /    | | | | | |   | (_| | | |_| |    \ V /  |  __/ | |_  | (_| |   | (_) | | | | | | |   | (_| | |  __/ | |_      
         \/     |_| |_| |_|    \__,_|  \__,_|     \_/    \___|  \__|  \__,_|    \___/  |_| |_| |_|    \__,_|  \___|  \__|     
                                                                                                                              
                                                                                                                              
      _   _                      __                                        __      ______   _______              ___          
     (_) (_)                    (())                                      (())    |  ____| |__   __|     /\     |__ \         
       __ _   _ __     _ __     __ _    __ _    ___    _ __      _ __     __ _    | |__       | |       /  \       ) |        
      / _` | | '__|   | '_ \   / _` |  / _` |  / _ \  | '_ \    | '_ \   / _` |   |  __|      | |      / /\ \     / /         
     | (_| | | |      | | | | | (_| | | (_| | | (_) | | | | |   | |_) | | (_| |   | |____     | |     / ____ \   |_|          
      \__,_| |_|      |_| |_|  \__,_|  \__, |  \___/  |_| |_|   | .__/   \__,_|   |______|    |_|    /_/    \_\  (_)          
                                        __/ |                   | |                                                           
                                       |___/                    |_|                                                           
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                        _        __            _                                              
                                                       | |      / /           | |                                             
      _ __     __ _   _ __    _ __     __ _       ___  | | __  / /_     __ _  | |__        ___    ___                         
     | '_ \   / _` | | '_ \  | '_ \   / _` |     / __| | |/ / | '_ \   / _` | | '_ \      / __|  / _ \                        
     | | | | | (_| | | | | | | |_) | | (_| |  _  \__ \ |   <  | (_) | | (_| | | |_) |  _  \__ \ |  __/                        
     |_| |_|  \__,_| |_| |_| | .__/   \__,_| (_) |___/ |_|\_\  \___/   \__,_| |_.__/  (_) |___/  \___|                        
                             | |                                                                                              
                             |_|
EOF
