import React from "react";

import { useState, Component } from "react";

import { PrimaryButton, DefaultButton, Dropdown, IDropdownOption, Pivot, PivotItem, Label, Stack, IStackTokens } from '@fluentui/react';
import { Modal } from "@fluentui/react";
import { ChoiceGroup, IChoiceGroupOption } from "@fluentui/react";
import { Checkbox } from "@fluentui/react";

import { GPEmulator } from "./emulator";

// import { Uploader } from "./UploadButton";

import { machineTypes } from "./emulator";

let machineOptions: IDropdownOption<{machineTypes: string}>[] = [
   { key: "T05" , text: "Model T/05 (64x16, cassette)"  },
   { key: "T08" , text: 'Model T/08 (64x16, two 5"1/4 floppy disks)'  },
   { key: "T10" , text: 'Model T/10 (64x16, two 8" floppy disks)' },
   { key: "T20" , text: 'Model T/20 (80x24, 5MB hard disk SASI, four 8" floppy disks)' }
];

interface IState {
   showPreferences: boolean;
   machine: machineTypes;
}

export class Gui extends Component<IState> {

   state = {
      showPreferences: false,
      machine: getEmulator().ROM_CONFIG
   };

   componentDidMount() {
      document.addEventListener('keydown', this.handleKeyDown);
   }

   componentWillUnmount() {
      document.removeEventListener('keydown', this.handleKeyDown);
   }

   handleKeyDown = (e: any) => {
      if(e.code == "F10") {
         // F10 toggle preferences window
         this.setState({ showPreferences: !this.state.showPreferences });
      }
      else if(e.code == "Escape") {
         // close preferences window if open
         if(this.state.showPreferences) close();
      }
      else {
         // console.log(e.code);
      }
   }

   close = () => {
      this.setState({ showPreferences: false });
   }

   buttonPowerOnOffClick = () => {
      getEmulator().power();
      this.close();
   }

   buttonCloseClick = () => {
      this.close();
   }

   /*
   function handleUploadVZ(files: FileList) {
      emulator.droppedFiles(files);
      close();
   }

   function handleChangeMemory(event: React.FormEvent<HTMLDivElement>, item: IDropdownOption|undefined) {
      if(item===undefined) return;
      let memory = String(item.key);
      setMemory(memory);
      emulator.setMemory(memory);
   }

   function handleChangeJoystickConnected(ev?: React.FormEvent<HTMLElement | HTMLInputElement> | undefined, isChecked?: boolean) {
      let joyconn = isChecked==true;
      setJoystick_connected(joyconn);
      emulator.connectJoystick(joyconn);
   }
   */

   handleChangeMachine = (event: React.FormEvent<HTMLDivElement>, item: IDropdownOption|undefined) => {
      if(item===undefined) return;
      let machine = String(item.key) as machineTypes;
      this.setState({ machine });
      getEmulator().configure(machine);
   }

   render() {
      let { showPreferences, machine } = this.state;
      let {
         handleKeyDown,
         handleChangeMachine,
         buttonCloseClick,
         buttonPowerOnOffClick,
      } = this;

      return (
         <Modal isOpen={showPreferences}>
            <div onKeyDown={handleKeyDown} style={{padding: '2em'}}>
               <Pivot style={{height: '500px'}}>

                  <PivotItem headerText="Configuration" headerButtonProps={{'data-order': 2}}>
                        <Dropdown label="Machine" options={machineOptions} selectedKey={machine} onChange={handleChangeMachine} />
                  </PivotItem>

                  <PivotItem headerText="About" headerButtonProps={{'data-order': 8}}>
                     <Label>General Processor Model T/08/10/20 emulator</Label>
                     <p>Written by Antonino Porcino</p>
                  </PivotItem>

               </Pivot>

               <Stack horizontal horizontalAlign="space-between">
                  <DefaultButton onClick={buttonPowerOnOffClick}>Power OFF/ON</DefaultButton>
                  <PrimaryButton onClick={buttonCloseClick}>Close</PrimaryButton>
               </Stack>

            </div>
         </Modal>
      );
   }
}

function getEmulator(): GPEmulator {
   const instance = (window as any).gp as GPEmulator;
   return instance;
}

/*
                  <PivotItem headerText="Files" headerButtonProps={{'data-order': 1}}>
                     <Label>Programs</Label>
                     {/*
                     <Stack horizontal horizontalAlign="start" tokens={numericalSpacingStackTokens}>
                        {<Uploader value="Load VZ" onUpload={handleUploadVZ} accept=".vz" />}
                        {<DefaultButton onClick={()=>{}} disabled={true}>Save VZ</DefaultButton>}
                     </Stack>
                     * /}
                     {/*
                     <DefaultButton onClick={()=>{}} disabled={true}>Download BINARY memory area</DefaultButton>
                     <UploadButton value="Load cart" onUpload={this.handleUpload} accept=".bin" />
                     <div>Remove cart</div>
                     <div>Load ROM</div>
                     * /}
                     </PivotItem>

                     <PivotItem headerText="CPU" headerButtonProps={{'data-order': 2}}>
                        {/*
                        <Dropdown label="CPU" options={machineOptions} selectedKey={machine} onChange={handleChangeMachine} />
                        <Dropdown label="Memory" options={memoryOptions} selectedKey={memory} onChange={handleChangeMemory} />
                        <div>MC6847 snow: on/off</div>
                     * /}
                     </PivotItem>

                     <PivotItem headerText="Joysticks" headerButtonProps={{'data-order': 2}}>
                        {/*}
                        <Checkbox label="Joystick interface connected" checked={joystick_connected} onChange={handleChangeJoystickConnected} />
                        <ChoiceGroup defaultSelectedKey="B" options={joystickOptions} onChange={_onChange} label="Pick one" required={true} />;
                     * /}
                     </PivotItem>

                     <PivotItem headerText="Tape" headerButtonProps={{'data-order': 3}}>
                        {/*
                        <Uploader value="Load .WAV" onUpload={handleUploadVZ} accept=".wav" />
                        * /}
                        <div>Record file WAV</div>
                        <div>Stop tape</div>
                        <div>cassette audio: on/off</div>

                     </PivotItem>

                     <PivotItem headerText="Disk" headerButtonProps={{'data-order': 4}}>
                        <div>Disk drive interface on/off</div>
                        <div>Load disk in drive 1</div>
                        <div>Load disk in drive 2</div>
                        <div>Download disk in drive 1</div>
                        <div>Download disk in drive 2</div>
                        <div>Unmount disk in drive 1</div>
                        <div>Unmount disk in drive 2</div>
                     </PivotItem>

                     <PivotItem headerText="Printer" headerButtonProps={{'data-order': 5}}>
                        <div>Save printer output</div>
                     </PivotItem>

                     <PivotItem headerText="Video" headerButtonProps={{'data-order': 6}}>
                        <div>Brighness contrast saturation</div>
                        <div>Monochrome output</div>
                        <div>Take snapshot</div>
                     </PivotItem>

                     <PivotItem headerText="Text files" headerButtonProps={{'data-order': 7}}>
                        <div>Load text file</div>
                        <div>Paste clipboard text</div>
                     </PivotItem>
   */