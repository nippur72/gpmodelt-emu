# TODO

# varies

- emulazione floppy 1791 con CPM
- esaminare differenze boot loader
* listare le varie versioni di CCP
- esaminare le varie versioni di CCP
- capire perchè CCP BBB e EEE non bootano
- verificare perchè non carica testcas_macchina_reale.wav
- esaminare ROM_damiani.zip, ROM_enrico.zip
- minibasic capire se porta D8 anche su GP / fare versione fixata
- prevedere varie configurazioni possibili T5, T8, T10, T20, T30
- vedere lista software.xls (enrico)
- vedere situazione eprom.xls (enrico)
- vedere immagine hard disk sa1004_extracted.zip
- CPM 2.2 al boot scrive su porta 7ah, come mai?
- TODO perchè fa il READ ADDRESS
- emulazione seriale parallela in cpm LST: ecc
- implementare comandi 1791 mancanti (step out ecc)
- questione dei byte aggiuntivi in write track

# emulatore

- reset della memoria iniziale/random ecc

# porting su dischi 5.25

- bootsector cambiare 1Bh in 18+1 = 13h byte @ pos 31
- ccp/bios @ $bac2: 1a 00 03 07 00 f2 00 3f 00 c0 00 10 00 02

1a 00 03 07 00 f2 00 3f 00 c0 00 10 00 02
00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D

boot[31]  = 19;  // al posto di 27
table[0]  = 16;  // al posto di 26
table[5]  = 71;  // al posto di 242
table[13] = 4;   // al posto di 2

=======================
$00	SPT	"Sectors Per Track" Total number of 128 bytes sectors per track

$02	BSH Data allocation "Block Shift Factor" Number of 128 bytes sectors per
                "Allocation Block" ( determined by the data block allocation size. Stored as 2's-logarithm. See notes below ). {8}

$03	BLM "Data allocation Block Mask" To get the sector index of the Allocation Block
                the sector number is to combine logically by AND with this mask. (( 2^BSH)-1). See notes below.

$04	EXM	"Extent Mask" Number of extents per directory entry ( stored as 2's logarithm ). Determined by the data block allocation size and the number of disk blocks.

$05	DSM	Total storage capacity of the disk drive. Number of the last Allocation Block ( Number of entries per disk -1 )

$07	DRM	Number of the last directory entry ( Number of entries per disk -1 ). Total number of directory entries that can be stored on this drive. ( AL0, AL1 determine reserved directory blocks ).

$09	AL0	Starting value of the first two bytes of the allocation table. ( Determined by DRM; bit meaning see below )

$0A	AL1
$0B	CKS	"Check area Size"

Size of the directory check vector. Number of directory entries to check for disk change. Zero for a HDD.
$0D	OFF	Number of system reserved tracks at the beginning of the ( logical ) disk