Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD82F94AE
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Jan 2021 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbhAQSgZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Jan 2021 13:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbhAQSgV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Jan 2021 13:36:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54DB5224DE;
        Sun, 17 Jan 2021 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610908539;
        bh=+UGV7w9HmISBjCC8ySk9WRypbNYyoiDbj/aNyoogVrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9/g7uczZh9DF/uyivW1GDIVRcl+oahil5b3GY80573LmnJAjhzmwgVgosvfuVPuc
         09O+OHIJ4q+V51oIqUIzYPsYDo/aROvQ+mgoiM7FVXg8P6SdKIsP2ChUgbY8QaTCtm
         w0qWYj1V7V4jSQTgDY9SQKr0D6JIbyKDKTub3oYGC02mM7/aQpxEmgQQZLtcHX5Mgl
         kGONZr7j5AsmMm5xzQ82fjKS11ol/O0KVgn4ZcQn020w7jlQXdnIJvWRficN4iWRmP
         xOQeSzA0F1Hvu/qorh28O19XeGSszZVzM201ofdXU/y3oFQ9aHTlgepwFHFsC/ZWGQ
         tjfGGkQtB8OOw==
Date:   Sun, 17 Jan 2021 20:35:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "florian.manoel@siemens.com" <florian.manoel@siemens.com>,
        joshz@google.com
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>
Subject: Re: TPM V2: kernel panic on linux reboot
Message-ID: <YASDd5pphvndrsm+@kernel.org>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 15, 2021 at 07:17:01AM +0000, florian.manoel@siemens.com wrote:
> 
> Hi,
> 
> this is my first post on this mailing list, so I briefly introduce myself. I am Florian Manoël, working at Siemens in Germany.
> I am currently on charge to implement a TPM V2 (Infineon slb9670, SPI connected) on our custom board, named 'LPE9403', equipped with a processor 64-bit ARM NXP LS1043a.
> I already made some adjustment (defconfig in U-Boot and Linux, device tree, init code in U-Boot).
> I have installed "tpm2-tools" using 'apt-get install'. I get to the point where the TPM is correctly detected and I can use some of the function like tpm2_getrandom().
> 
> However, when I execute the command 'reboot', it leads every time to a kernel panic. The logs seems to indicate that something went wrong with the shutdown of the TPM.
> In the first time, I wrote to the mailing list of 'tpm2-tools' and got redirected here.
> Can you provide me support to fix this issue ?
> My config :
> - Processor 64-bit ARM NXP LS1043a
> - TPM V2 Infineon slb9670
> - linux kernel version: 4.19.144
> 
> Below the logs of the Linux boot + kernel panic :
> "
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 4.19.144-audis-std (builder@isar) (gcc version 8.3.0 (Debian 8.3.0-2)) #1 SMP PREEMPT Wed Dec 2 12:18:57 UTC 2020
> [    0.000000] Machine model: Siemens LPE9403
> 
> /*
> Non relevant logs removed
> */
> 
> [    2.240475] fsl-dspi 2100000.spi: registered master spi3
> [    2.245980] spi spi3.3: setup mode 0, 8 bits/w, 18500000 Hz max --> 0
> [    2.258637] tpm_tis_spi spi3.3: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    2.264946] random: fast init done
> [    2.289984] fsl-dspi 2100000.spi: registered child spi3.3
> 
> /*
> Non relevant logs removed
> */
> 
> Debian GNU/Linux 10 lpe9403-VPM7001303 ttyS0
> 
> lpe9403-VPM7001303 login: admin
> Last login: Tue Nov 16 02:12:25 UTC 2021 on ttyS0
> Linux lpe9403-VPM7001303 4.19.144-audis-std #1 SMP PREEMPT Wed Dec 2 12:18:57 UTC 2020 aarch64
> 
> The programs included with the Debian GNU/Linux system are free software;
> the exact distribution terms for each program are described in the
> individual files in /usr/share/doc/*/copyright.
> 
> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> permitted by applicable law.
> 
> admin@lpe9403-VPM7001303:~$ sudo reboot
>          Stoppin[  OK  ] Stopped target Graphical Interface.
> [  OK  ] Stopped Daily Cleanup of Temporary Directories.
> [  OK  ] Stopped Syncronise system .ardware clock every 5 minutes.
>          Stopping watchdog daemon...
> [  OK  ] Stopped Serial Getty on ttyS0.
> [  OK  ] Stopped Wait for ntpd to synchronize system clock.
> [  OK  ] Stopped Session 1 of user admin.
>          Stopping User Manager for UID 1000...
> [  OK  ] Removed slice system-serial\x2dgetty.slice.
> [  OK  ] Stopped User Manager for UID 1000.
> [  OK  ] Stopped watchdog daemon.
> [  OK  ] Stopped target Multi-User System.
>          Stopping DCP daemon...
>          Stopping Login Service...
>          Stopping Event Manager service...
>          Stopping OpenBSD Secure Shell server...
>          Stopping SFP daemon...
>          Stopping Link Layer Discovery Protocol Agent Daemon....
>          Stopping Simple Network Ma.ent Protocol (SNMP) Daemon....
> [  OK  ] Stopped target Login Prompts.
>          Stopping Getty on tty1...
>          Stopping Temperature Monitor service...
>          Stopping Network Time Service...
>          Stopping Docker Application Container Engine...
>          Stopping Fail2Ban Service...
> [  OK  ] Stopped Firmware Update Confirmation.
>          Stopping User Runtime Directory /run/user/1000...
> [  OK  ] Unmounted /run/user/1000.
> [  OK  ] Stopped Login Service.
> [  OK  ] Stopped Temperature Monitor service.
> [  OK  ] Stopped SFP daemon.
> [  OK  ] Stopped Event Manager service.
> [  OK  ] Stopped DCP daemon.
> [  OK  ] Stopped Link Layer Discovery Protocol Agent Daemon..
> [  OK  ] Stopped Simple Network Man.ement Protocol (SNMP) Daemon..
> [  OK  ] Stopped Getty on tty1.
> [  OK  ] Stopped Network Time Service.
> [  OK  ] Stopped OpenBSD Secure Shell server.
> [  OK  ] Stopped Docker Application Container Engine.
> [  OK  ] Stopped User Runtime Directory /run/user/1000.
> [  OK  ] Removed slice User Slice of UID 1000.
>          Stopping containerd container runtime...
> [  OK  ] Stopped target Network is Online.
> [  OK  ] Stopped target Host and Network Name Lookups.
>          Stopping Permit User Sessions...
> [  OK  ] Removed slice system-getty.slice.
> [  OK  ] Stopped containerd container runtime.
> [  OK  ] Stopped Permit User Sessions.
> [  OK  ] Stopped Fail2Ban Service.
> [  OK  ] Stopped target Remote File Systems.
> [  OK  ] Stopped target Network.
>          Stopping Network Name Resolution...
> [  OK  ] Stopped Network Name Resolution.
>          Stopping Network Service...
> [  OK  ] Stopped Network Service.
> [  OK  ] Stopped target Network (Pre).
>          Stopping firewalld - dynamic firewall daemon...
> [  OK  ] Stopped firewalld - dynamic firewall daemon.
>          Stopping D-Bus System Message Bus...
>          Stopping Authorization Manager...
> [  OK  ] Stopped D-Bus System Message Bus.
> [  OK  ] Stopped Authorization Manager.
> [  OK  ] Stopped target Basic System.
> [  OK  ] Stopped target Slices.
> [  OK  ] Removed slice User and Session Slice.
> [  OK  ] Stopped target Sockets.
> [  OK  ] Closed lldpad.socket.
> [  OK  ] Closed Docker Socket for the API.
> [  OK  ] Closed sfw_manager socket listener.
> [  OK  ] Closed SWUpdate socket listener.
> [  OK  ] Stopped target Paths.
> [  OK  ] Closed D-Bus System Message Bus Socket.
> [  OK  ] Stopped target System Initialization.
> [  OK  ] Stopped target Swap.
>          Stopping Update UTMP about System Boot/Shutdown...
> [  OK  ] Stopped Apply Kernel Variables.
>          Stopping Load/Save Random Seed...
> [  OK  ] Stopped target Local Encrypted Volumes.
> [  OK  ] Stopped Dispatch Password .ts to Console Directory Watch.
> [  OK  ] Stopped Forward Password R.uests to Wall Directory Watch.
> [  OK  ] Stopped Load Kernel Modules.
> [  OK  ] Stopped Load/Save Random Seed.
> [  OK  ] Stopped Update UTMP about System Boot/Shutdown.
> [  OK  ] Stopped Create Volatile Files and Directories.
> [  OK  ] Stopped target Local File Systems.
>          Unmounting /etc...
>          Unmounting Home mount userdata...
>          Unmounting /var/log...
> [  OK  ] Unmounted /etc.
> [  OK  ] Unmounted Home mount userdata.
> [  OK  ] Unmounted /var/log.
>          Unmounting /userdata...
> [  OK  ] Unmounted /userdata.
> [  OK  ] Reached target Unmount All Filesystems.
> [  OK  ] Stopped target Local File Systems (Pre).
> [  OK  ] Stopped Create Static Device Nodes in /dev.
> [  OK  ] Stopped Create System Users.
> [  OK  ] Stopped Remount Root and Kernel File Systems.
> [  OK  ] Reached target Shutdown.
> [  OK  ] Reached target Final Step.
> [  OK  ] Started Reboot.
> [  OK  ] Reached target Reboot.
> [  675.609520] watchdog: watchdog0: watchdog did not stop!
> [  675.618665] systemd-shutdow: 24 output lines suppressed due to ratelimiting
> [  675.662848] systemd-shutdown[1]: Syncing filesystems and block devices.
> [  675.672034] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> [  675.686963] systemd-journald[233]: Received SIGTERM from PID 1 (systemd-shutdow).
> [  675.730174] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
> [  675.743123] systemd-shutdown[1]: Hardware watchdog 'GPIO Watchdog', version 0
> [  675.752565] systemd-shutdown[1]: Unmounting file systems.
> [  675.760922] [1021]: Remounting '/' read-only in with options '(null)'.
> [  675.782087] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
> [  675.795819] systemd-shutdown[1]: All filesystems unmounted.
> [  675.801420] systemd-shutdown[1]: Deactivating swaps.
> [  675.806725] systemd-shutdown[1]: All swaps deactivated.
> [  675.811975] systemd-shutdown[1]: Detaching loop devices.
> [  675.820775] systemd-shutdown[1]: All loop devices detached.
> [  675.895298] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
> [  675.904126] Mem abort info:
> [  675.906933]   ESR = 0x96000005
> [  675.909995]   Exception class = DABT (current EL), IL = 32 bits
> [  675.915924]   SET = 0, FnV = 0
> [  675.918989]   EA = 0, S1PTW = 0
> [  675.922138] Data abort info:
> [  675.925012]   ISV = 0, ISS = 0x00000005
> [  675.928856]   CM = 0, WnR = 0
> [  675.931830] user pgtable: 4k pages, 39-bit VAs, pgdp = 00000000bec7a5cc
> [  675.938447] [0000000000000058] pgd=0000000000000000, pud=0000000000000000
> [  675.945244] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  675.950807] Modules linked in: ipt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) br_netfilter(E) xt_tcpudp(E) ip6t_rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) nft_counter(E) nft_chain_nat_ipv6(E) nf_nat_ipv6(E) nft_chain_route_ipv6(E) nft_chain_nat_ipv4(E) nf_nat_ipv4(E) nf_nat(E) nft_chain_route_ipv4(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip6_tables(E) nft_compat(E) nf_tables(E) nfnetlink(E) audis_info(OE) ip_tables(E) x_tables(E)
> [  675.995303] Process systemd-shutdow (pid: 1, stack limit = 0x0000000010d499d8)
> [  676.002518] CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G           OE     4.19.144-audis-std #1
> [  676.011379] Hardware name: Siemens LPE9403 (DT)
> [  676.015902] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  676.020692] pc : tpm_transmit+0x148/0x678
> [  676.024692] lr : tpm_transmit+0x3b4/0x678
> [  676.028691] sp : ffffff800803b840
> [  676.031996] x29: ffffff800803b840 x28: 0000000000000000 
> [  676.037300] x27: 0000000000000000 x26: 000000000000000c 
> [  676.042604] x25: ffffff8008d1c508 x24: 0000000000000014 
> [  676.047908] x23: 0000000000001000 x22: ffffffc874d37000 
> [  676.053212] x21: 0000000000001000 x20: 0000000000000145 
> [  676.058516] x19: ffffffc87680c000 x18: 0000000000000000 
> [  676.063820] x17: 0000000000000000 x16: 0000000000000000 
> [  676.069123] x15: ffffffffffffffff x14: ffffff8008f09848 
> [  676.074427] x13: ffffffc873ae391c x12: ffffffc873ae31a9 
> [  676.079731] x11: 0101010101010101 x10: 0000000000000040 
> [  676.085036] x9 : ffffff8008f9c8f8 x8 : 0000000000004501 
> [  676.090339] x7 : ffffffc87680c000 x6 : ffffff800803b8fc 
> [  676.095643] x5 : 0000000000000000 x4 : 0000000000000000 
> [  676.100947] x3 : 0000000000004501 x2 : ffffffc83f794040 
> [  676.106250] x1 : 0000000000000000 x0 : 0000000000000000 
> [  676.111553] Call trace:
> [  676.113992]  tpm_transmit+0x148/0x678

Thanks for reporting this.

My first guess is that ->pre_shutdown() gets called before this.
It will nullify chip->ops, which will lead to null deref in
in tpm_del_char_device().

I'm just wondering why this has not shown up earlier..

I mean the callback has been there for a while (since v4.13):

commit d1bd4a792d3961a04e6154118816b00167aad91a
Author: Josh Zimmerman <joshz@google.com>
Date:   Sun Jun 25 14:53:24 2017 -0700

    tpm: Issue a TPM2_Shutdown for TPM2 devices.
    
    If a TPM2 loses power without a TPM2_Shutdown command being issued (a
    "disorderly reboot"), it may lose some state that has yet to be
    persisted to NVRam, and will increment the DA counter. After the DA
    counter gets sufficiently large, the TPM will lock the user out.
    
    NOTE: This only changes behavior on TPM2 devices. Since TPM1 uses sysfs,
    and sysfs relies on implicit locking on chip->ops, it is not safe to
    allow this code to run in TPM1, or to add sysfs support to TPM2, until
    that locking is made explicit.
    
    Signed-off-by: Josh Zimmerman <joshz@google.com>
    Cc: stable@vger.kernel.org
    Fixes: 74d6b3ceaa17 ("tpm: fix suspend/resume paths for TPM 2.0")
    Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: James Morris <james.l.morris@oracle.com>

> [  676.117646]  tpm_transmit_cmd+0x54/0xe8
> [  676.121475]  tpm2_shutdown+0x88/0xa8
> [  676.125041]  tpm_chip_unregister+0xc4/0xe0
> [  676.129130]  tpm_tis_spi_remove+0x24/0x40
> [  676.133133]  spi_drv_remove+0x34/0x58
> [  676.136788]  device_release_driver_internal+0x1a4/0x238
> [  676.142005]  device_release_driver+0x28/0x38
> [  676.146267]  bus_remove_device+0xd4/0x148
> [  676.150269]  device_del+0x158/0x388
> [  676.153749]  device_unregister+0x24/0x78
> [  676.157664]  spi_unregister_device+0x38/0x48
> [  676.161926]  __unregister+0x20/0x30
> [  676.165407]  device_for_each_child+0x58/0x88
> [  676.169669]  spi_unregister_controller+0x44/0x128
> [  676.174364]  dspi_remove+0x28/0x170
> [  676.177843]  dspi_shutdown+0x20/0x30
> [  676.181410]  platform_drv_shutdown+0x2c/0x38
> [  676.185671]  device_shutdown+0x114/0x1f0
> [  676.189588]  kernel_restart_prepare+0x44/0x50
> [  676.193936]  kernel_restart+0x20/0x68
> [  676.197590]  __se_sys_reboot+0x220/0x248
> [  676.201505]  __arm64_sys_reboot+0x24/0x30
> [  676.205507]  el0_svc_common+0xa4/0x198
> [  676.209248]  el0_svc_handler+0x38/0x78
> [  676.212988]  el0_svc+0x8/0xe8
> [  676.215949] Code: 72000400 b90073e0 54001360 f9435ec0 (f9402c02) 
> [  676.222039] ---[ end trace 8d405bebaa8bfb3f ]---
> [  676.226710] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [  676.226710] 
> [  676.235839] Kernel Offset: disabled
> [  676.239319] CPU features: 0x0,20002004
> [  676.243058] Memory Limit: none
> [  676.246108] Rebooting in 90 seconds..
> "
> 
> If needed, I can provide more information (u-boot logs and init code, device tree, u-boot and linux defconfig.) 
> Thanks for your support.
> 
> Mit freundlichen Grüßen
> Florian Manoël
> 
> Siemens AG
> Digital Industries
> Process Automation
> DI PA DCP R&D 2
> Östliche Rheinbrückenstr. 50
> 76187 Karlsruhe, Deutschland
> Tel.: +49 721 667-20051
> mailto:florian.manoel@siemens.com
> https://siemens.com
> 
> Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Snabe; Vorstand: Joe Kaeser, Vorsitzender; Roland Busch, Klaus Helmrich, Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berlin und München, Deutschland; Registergericht: Berlin-Charlottenburg, HRB 12300, München, HRB 6684; WEEE-Reg.-Nr. DE 23691322
> 

/Jarkko
