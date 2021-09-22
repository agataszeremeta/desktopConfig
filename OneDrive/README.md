# OneDrive Setup on Desktop

Guide for installing and configuring OneDrive on Ubuntu to synchronize between computers. Note there is no official Microsoft OneDrive client. Instead, a free maintained fork [OneDrive Client for Linux](https://github.com/abraunegg/onedrive) is used. 

Guide adapts on steps provided by Logix's tutorial [How To Keep OneDrive In Sync With A Folder On Linux Using OneDrive Free Client Fork](https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html).

## Installation
1. Install OneDrive by running:

```sudo apt install onedrive```

2. Authorize the OneDrive Free Client (fork) for Linux with your Microsoft OneDrive account through the terminal by running:

```onedrive```

- The terminal will show a message about authorizing this app by visiting a link. Open the link in a web browser and log in to your Microsoft account. 
- Click yes on the page asking if you want to let this application access your information. This will direct to a blank page (this is okay and expected). 
- Copy that blank page's URL and paste it into the terminal where you're authorizing the onedrive tool. A message in the terminal will appear saying that No OneDrive sync will be performed without either of these two arguments being present. Ignore this. It is because we didn't try to sync any files, we just authorized the onedrive application with your OneDrive account.

3. Test the installation through a dry-run (train-sync). 

```onedrive --synchronize --verbose --dry-run```
 
## Usage

Either all folders or selected folders can be synchronized using the OneDrive client.

### Synchronize All Folders

To synchronize all folders, simply run:

```onedrive --synchronize```

### Synchronize Select Folders/Files

To synchronize select folders, you can either create a *sync_list* file in *~/.config/onedrive*, adding the relative paths to the directories/files to sync or by explicitly specifying them when running the synchronize command.

Note that OneDrive Free Client for Linux doesn't remove any already synchronized directories or files from your disk in case you exclude them later via selective sync. It only exclude them from future synchronizations.

1. _Sync_List_ File Method
  - Create a *sync_list* file in *~/.config/onedrive*
  - Add relative paths to the directories/files of interest

Example: You only want to synchronize 1 directory, called Photos, and 2 files called file1.odt, file2.odt, both of which are in the Documents folder in your OneDrive account. In that case the ~/.config/onedrive/sync_list file would include:

```
Backup
Photos
Documents/file1.odt
Documents/file2.odt
```

The first time you use selective sync, and every time after making any changes to the *~/.config/onedrive/sync_list* file, you must perform a full re-synchronization using --resync:

```onedrive --synchronize --resync ```

2. Explicit Stating Method

```onedrive --synchronize --'RelativeDirectory' ```


