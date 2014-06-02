kitchen-Raspberry_PI
====================
## chefを実行する前にやること
### 固定IP
/etc/network/interfacesを変更する．  

    # iface eth0 inet dhcp 
    iface eth0 inet static
    
    address 192.168.1.100
    netmask # ここはそれぞれの環境に合わせて
    gateway # ここも

### chef用ユーザ作成
chefはパスワードなしで`sudo`が実行できるユーザが必要．  
chefユーザを作成してsudoresファイルを追加．  

    $ adduser chef
    $ echo 'chef ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/chef

### 公開鍵認証
/etc/ssh/sshd_config の最後に追加．  

    PubkeyAuthentication no
    AuthorizedKeysFile      %h/.ssh/authorized_keys

sshdを`reload`  

    $ service sshd reload

## ホスト側の準備
公開鍵秘密鍵ペアを作成する．

    $ ssh key-gen

~/.ssh/configにRaspberry PIの設定を追加．

    Host Raspberrypi
        HostName 192.168.1.100
        User chef
        IdentityFile ~/.ssh/id_rsa
     
  
公開鍵をRaspberry PIにコピーする．

    $ scp ~/.ssh/id_rsa chef@192.168.1.100:/home/chef/.ssh/authorized_keys

## chef実行

    $ knife solo cook Raspberrypi
