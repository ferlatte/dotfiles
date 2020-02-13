# How to use a YubiKey

Installed GPGSuite instead of from brew, and installed the YubiKey tools:

    brew cask install gpg-suite
    brew install ykman ykpers

Did no shell configuration at all.

`gpg —card-edit` popped up a nice UI window for pin entries.

If you want to use the Yubikey for ssh keys, you need to use the GPGSuite `gpg-agent` instead of `ssh-agent`; edit `~/.ssh/config` and make sure IdentityAgent looks like this:

     IdentityAgent ~/.gnupg/S.gpg-agent.ssh

Followed Eric's doc for everything else around generating the actual keys, included below.

## Setting the Yubikey User and Admin PIN codes

The YubiKey ships with a default User PIN of 123456 and a default Admin PIN of 12345678. These PIN codes should be changed before use.

The User PIN is the PIN that will be used on a daily basis when signing commits or authenticating. The Admin PIN is used to make changes to the YubiKey itself, such as when enabling or disabling touch-mode. 

1. Insert your YubiKey into the USB port.
1. Enter the command: gpg --card-edit
1. Enter the command: admin
1. Enter the command: passwd
1. To change the Admin PIN enter: 3
1. Enter the default PIN of 12345678
1. Enter your new 8 digit Admin PIN, add it to 1Password, and confirm it. 
1. To change the User PIN enter: 1
1. Enter the default PIN of 123456
1. Enter your new 6 digit User PIN, add it to 1Password, and confirm it. 
1. Enter the command: q
1. Enter the command: name 
1. Enter your surname and given name (these should match the name provided when you generate your certificate) 
1. Enter the command q to exit the admin menu

If you make a mistake and need to reset your YubiKey PINs, you can do so with the command: ykman openpgp reset

Key Generation
Generating a GPG Private Key
This will generate the secret key.

Enter the GPG command: gpg --expert --full-gen-key
When prompted to specify the key type, enter 1 (for "RSA and RSA (Default)") and press Enter
Specify the size of key you want to generate. This key size will also apply to subkey size. Do one of the following:
For a YubiKey 4 series, enter 2048 and press Enter
For a YubiKey 5 series, enter 4096 and press Enter
Specify an indefinite expiration date of the key by pressing press Enter. Verify the expiration date when prompted
Now you will enter your user information. Enter your Real Name and press Enter. Be sure to enter both your first and last name
Enter your @truss.works Email Address and press Enter. If you do not perform commits with your @truss.works email address, we’ll add your GitHub email address to the key in a later step. 
If desired, enter a Comment about this key (e.g., “work”), and press Enter. (To leave the comment blank, just press Enter)
Review the information you entered, make any changes if necessary. If all information is correct, enter O (for Okay) and press Enter
A dialog box is displayed so you can enter the passphrase for your key. While the key is being generated, move your mouse around or type on the keyboard to gain enough entropy. When the key has been generated, you will see several messages displayed. Make a note of the key ID, that is displayed in the message such as "gpg: key 1234ABC marked as ultimately trusted". The key ID in this case is 1234ABC and you will need this key ID to perform other operations.
If at any point you forget the key ID, enter gpg --list-signatures to display it. 
It’s time to add the subkeys. Some of these may already be created. You can check what’s been created by checking your keys. 
Add a (S) signing subkey
This will be used for git commit and tag signing.

Enter the GPG command: gpg --expert --edit-key 1234ABC (where 1234ABC is the key ID of your key)
Enter the command: addkey
You are prompted to specify the type of key. Enter 4 for RSA (sign only)
Specify the size of the key that you want to generate. Do one of the following:
For a YubiKey 4 series, enter 2048 and press Enter
For a YubiKey 5 series, enter 4096 and press Enter
Specify the expiration of the authentication key (this should be the same expiration as the key). Unless you have a specific need, this should be set to indefinite
When prompted to save your changes, enter y (yes)  
If prompted to replace the existing key, select no. 
Enter the passphrase for the key. Note that this is the passphrase, and not the User PIN or Admin PIN
Add an (A) authentication subkey
This subkey will be used to pull private git repos and may be used to authenticate to any SSH host. 
Enter the GPG command: gpg --expert --edit-key 1234ABC (where 1234ABC is the key ID of your key)
Enter the command: addkey
You are prompted to specify the type of key. Enter 8 for RSA
To add an authentication key, toggle all options until Authenticate is the only selection, and then Q if you are finished. 
This is interface has a unique design where you need to toggle things on and off to get the desired result. 
The default state shows Sign Encrypt active. 


Enter A to enable Authenticate. Enter E then S (separately) to disable Sign and Encrypt. 

Hit Q to finish.	
Specify the size of the key that you want to generate. Do one of the following:
For a YubiKey 4 series, enter 2048 and press Enter
For a YubiKey 5 series, enter 4096 and press Enter
Specify the expiration of the authentication key (this should be the same expiration as the key). Unless you have a specific need, this should be set to indefinite
When prompted to save your changes, enter y (yes)
If prompted to replace the existing key, select no. 
Enter the passphrase for the key. Note that this is the passphrase, and not the User PIN or Admin PIN

Check your keys
After adding the subkeys, enter the GPG command: gpg --expert --edit-key 1234ABC (where 1234ABC is the key ID of your key)
The optimal output should look similar to this, showing an individual subkey for E (Encrypt), A (Authenticate), and S (Sign) in our YubiKey keychain. 



Note that if you haven’t imported the keys to your Yubikey yet then your output will not include those card-no details.
Creating Backups
These steps are not required, but will help configure a new YubiKey should yours become lost or damaged. While you could start from scratch (and should in some cases), this will provide the quickest path to recovery. 
Create a backup of your key (optional)
This will create a backup of the secret key and subkeys.  

Insert the YubiKey into the USB port
Enter the GPG command: gpg --export-secret-key --armor 1234ABC >> /path/to/secret.key (where 1234ABC is the key ID of your key)
Enter the GPG command: gpg --export-secret-subkeys >> /path/to/secret.sub.key --armor 1234ABC (where 1234ABC is the key ID of your key)
Store these files in 1Password and delete them from your system. 
Create a revocation certificate (optional)
This will allow you to revoke the key should your secret key becomes lost or compromised. This step is not required in our current use case because we’re not uploading our certificates to a public keyserver. This may be required for future use at some point, so we’ll leave this in place for the time being. 

Enter the command: gpg --gen-revoke 1234ABC > 1234ABC-revoke-cert.asc (where 1234ABC is the key ID of your key)
Enter the command: Y
Select a reason for revocation. The reason really doesn’t matter for our use case. I usually select 3 = Key is no longer used
Enter an optional description, or hit enter to continue. This field is not important. 
Enter the command: Y
Store the output from this in a safe place 
Configuring the YubiKey
Importing the keys to your Yubikey
This will destructively move the secret key as well as the three subkeys to the YubiKey from the local keystore, via the keytocard command.

Insert the YubiKey into the USB port
Enter the GPG command: gpg --edit-key 1234ABC (where 1234ABC is the key ID of your key)
Enter the command: toggle to switch to the public key listing (there will be no visible output)
Enter the command: key 1 (to select subkey 1)
The interface is not intuitive here. Typing key 1 will select the first subkey (ssb). An * next to the key will indicate that it has been selected: 

Enter the command: keytocard
When prompted where to store the key, select 2. This will move the encryption subkey to the YubiKey
Enter the command: key 1 (to deselect subkey 1)
Enter the command: key 2 (to select subkey 2)
Enter the command: keytocard
When prompted where to store the key, select 1. This will move the signing subkey to the YubiKey
Enter the command: key 2 (to deselect subkey 2)
Enter the command: key 3 (to select subkey 3)
Enter the command: keytocard
When prompted where to store the key, select 3. This will move the authentication subkey to the YubiKey
Enter the command: save to save the configuration and exit to the CLI. 
Adding Additional Email Addresses
Enter the GPG command: gpg --expert --edit-key 1234ABC (where 1234ABC is the key ID of your key)
Enter the command: adduid
Enter your Name
Enter the Additional Email Address
Enter a comment if desired
Enter (O)kay
Enter your PIN if prompted
Enter the command: quit
When prompted to save your changes, enter y (yes). You have now saved the additional email address to your YubiKey


Configuring git signing
Insert the YubiKey into the USB port
Enter the GPG command: gpg --export --armor 1234ABC (where 1234ABC is the key ID of your secret key)
This will export your public key, which is derived from the secret key. Copy this entire key including the lines: 

Add this key into GitHub
Add the key into your git config with the following command: git config --global user.signingkey 1234ABC (where 1234ABC is the key ID of your key)
Add your name to your git config with the following command: git config --global user.name “your name” (this should match the name provided when you generate your certificate) 
Add your email to your git config with the following command: git config --global user.email email@truss.works (this should match the email that you push commits with)
Configuring Github
This step is not sequential and is linked in previous steps. If you’ve reached this point in the document, you should have already completed this. 

Sign into the GitHub web interface
Click on the user icon in the upper right hand corner and select settings
Select SSH and PGP Keys 
Add an SSH Key and enter the value generated in Configuring SSH
Add a new GPG Key and enter the value generated in Configuring git signing
Using Github Desktop
Configure Git client to always sign commits: git config --global commit.gpgsign true
echo no-tty >> ~/.gnupg/gpg.conf
Specify GPG path for clients: git config --global gpg.program /usr/local/bin/gpg
Using the YubiKey
Signing git commits

Insert the YubiKey into the USB port
To sign a git commit: 

To sign a git tag: 

When signing, you should be prompted to enter your YubiKey User PIN
If you’ve enabled touch mode, touch the YubiKey
Enabling touch-only mode (optional)
It is possible that your YubiKey could be activated by malware on your machine, which could conceivably use a keylogger to capture your PIN and use that information to automatically sign commits and tags when you're not aware.

If enabling touch-only mode, it is recommended to perform this step after you’ve confirmed that everything else is working. 

Enter the command: ykman openpgp set-touch aut on
Enter: yes
Enter the 8 digit Admin PIN to confirm the setting change

NOTE: When touch mode is enabled, the operation will appear to stall. This is the only prompt that you will receive to touch your YubiKey. Failure to touch the YubiKey for authentication will result in failure of the operation. You can also disable touch-only mode with the following command: ykman openpgp set-touch aut off
Disabling OTP (One Time Password)
Disabling the OTP is possible using the Yubikey Manager, and does not affect any other functionality of the Yubikey.

A side effect of the YubiKey is the Yubisneeze. The YubiKey will generate and paste a password to your screen nearly every time that you touch it. 

Insert the YubiKey into the USB port
Enter the command: ykman config usb --disable otp
Enter Y to confirm

To re-enable otp, use the command: ykman config usb --enable otp


## References
https://www.guyrutenberg.com/2019/06/04/disable-yubikeys-otp/
https://support.yubico.com/support/solutions/articles/15000006420-using-your-yubikey-with-openpgp
https://developers.yubico.com/PGP/Git_signing.html
https://malcolmsparks.com/posts/yubikey-gpg.html
https://mikebeach.org/2017/09/07/yubikey-gpg-key-for-ssh-authentication/
https://ocramius.github.io/blog/yubikey-for-ssh-gpg-git-and-local-login/
https://www.prado.lt/yubikey-ssh-authentication
