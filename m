Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82C127ADD2
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI1Mbn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 08:31:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgI1Mbg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 08:31:36 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kMsJF-0008AR-3e
        for linux-integrity@vger.kernel.org; Mon, 28 Sep 2020 12:31:13 +0000
Received: by mail-pj1-f69.google.com with SMTP id q95so869407pja.0
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 05:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=rZw2nCdHrYRZQbKeMnwC3YDrwN7/pNVg34BcBouI6LM=;
        b=Fbd8Zh/mFbqcFSGYLO+JHhHX1YF2xYEoM5oJkVYGEr3U0q8asdqz99XyHPgPiLdePC
         nIyx1z5/PmKyrdulA2QYLIjhuAO8Uwht1/WbKzM5VN8PsAvLi+X0DVjnjrkgHsK9Mb4f
         06yhNsYoBLZ3qqG/o8AaMs/15J2fL1k/v9JKwXOdSXKp3qBQuGr4Vd5BPWmxe7nXGPS2
         5LIFDTJDhgvZ11uX3usxJxTXoAKS1oXRG+EJbxAjOQuUuEZeegw8NfAU95iz0iYlhzsO
         KLmr3Sb4GcFWZXiy1RUlmNeFr1Zkfgl7HddrnzGQlt9vslIUN54gF/jXKgrDMDSxdJhb
         YzFA==
X-Gm-Message-State: AOAM532Nb61bDKS/EcBpOQUKA7b9soXkipRwCyRl1UqhtbSClXQSrK3s
        30xIXYMHXh1+Y2gIXkANruc3PBDjLw7GXWAEGE9xGQrJPzqEJ58V4lgXQFE662/YiDUFINXfdBC
        JCNY+V76WxV1W7FCRpbQxn6l9oTa8E7Pos+2ngaJNcZ5HDQ==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr1171760pjt.68.1601296269229;
        Mon, 28 Sep 2020 05:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL9Q48dK0Q/Kg/bJOJLfxrS84XpZjB85CTQVcPhMqZy8ftqPiETciMmeNUwEXG2CsblIvCCQ==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr1171665pjt.68.1601296267722;
        Mon, 28 Sep 2020 05:31:07 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id t9sm1188178pgp.90.2020.09.28.05.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 05:31:06 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-Id: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
Date:   Mon, 28 Sep 2020 20:31:04 +0800
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
To:     tyhicks@linux.microsoft.com
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 7f3d176f5f7e "tpm: Require that all digests are present in TCG_PCR_EVENT2 structures" causes a null pointer dereference on all laptops I have:

[    0.000000] microcode: microcode updated early to revision 0xd6, date = 2020-04-27
[    0.000000] Linux version 5.8.0-rc6+ (gcc (Ubuntu 10.2.0-6ubuntu1) 10.2.0, GNU ld (GNU Binutils for Ubuntu) 2.35) #25 SMP Mon Sep 28 20:16:01 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/@/boot/vmlinuz-5.8.0-rc6+ root=UUID=523fd023-8a9d-45cc-90fc-7823d5a8636f ro rootflags=subvol=@ quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000403fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040400000-0x000000004f248fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004f249000-0x000000004f24afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004f24b000-0x000000004fee4fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004fee5000-0x000000004fee5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004fee6000-0x000000005eaabfff] usable
[    0.000000] BIOS-e820: [mem 0x000000005eaac000-0x000000005eaacfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005eaad000-0x000000005eaadfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005eaae000-0x0000000068419fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006841a000-0x00000000694f4fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000694f5000-0x0000000069599fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006959a000-0x00000000695fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000695ff000-0x00000000695fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000069600000-0x000000006f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000028f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=0x69592000 SMBIOS=0x686a5000 SMBIOS 3.0=0x686a2000 ACPI=0x695fe000 ACPI 2.0=0x695fe014 ESRT=0x6852f000 MEMATTR=0x62e3b018 RNG=0x686a6198 TPMEventLog=0x5ec19d18 
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N27ET38W (1.24 ) 11/28/2019
[    0.000000] tsc: Detected 1800.000 MHz processor
[    0.000956] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000959] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000973] last_pfn = 0x28f800 max_arch_pfn = 0x400000000
[    0.000980] MTRR default type: write-back
[    0.000982] MTRR fixed ranges enabled:
[    0.000984]   00000-9FFFF write-back
[    0.000986]   A0000-BFFFF uncachable
[    0.000987]   C0000-FFFFF write-protect
[    0.000989] MTRR variable ranges enabled:
[    0.000991]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000993]   1 base 0070000000 mask 7FF0000000 uncachable
[    0.000995]   2 base 006C000000 mask 7FFC000000 uncachable
[    0.000996]   3 base 006B000000 mask 7FFF000000 uncachable
[    0.000997]   4 disabled
[    0.000998]   5 disabled
[    0.000999]   6 disabled
[    0.001000]   7 disabled
[    0.001001]   8 disabled
[    0.001001]   9 disabled
[    0.001927] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002290] last_pfn = 0x69600 max_arch_pfn = 0x400000000
[    0.023351] esrt: Reserving ESRT space from 0x000000006852f000 to 0x000000006852f0b0.
[    0.023366] check: Scanning 1 areas for low memory corruption
[    0.023375] Using GB pages for direct mapping
[    0.024218] Secure boot disabled
[    0.024220] RAMDISK: [mem 0x268a9000-0x275b0fff]
[    0.024234] ACPI: Early table checksum verification disabled
[    0.024239] ACPI: RSDP 0x00000000695FE014 000024 (v02 LENOVO)
[    0.024245] ACPI: XSDT 0x00000000695B3188 00012C (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024254] ACPI: FACP 0x00000000695EC000 0000F4 (v05 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024263] ACPI: DSDT 0x00000000695C1000 026B21 (v02 LENOVO SKL      00000000 INTL 20160527)
[    0.024268] ACPI: FACS 0x000000006953E000 000040
[    0.024272] ACPI: SSDT 0x00000000695F4000 008063 (v02 LENOVO DptfTabl 00001000 INTL 20160527)
[    0.024277] ACPI: SSDT 0x00000000695F3000 0003DB (v02 LENOVO Tpm2Tabl 00001000 INTL 20160527)
[    0.024282] ACPI: TPM2 0x00000000695F2000 000034 (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024286] ACPI: UEFI 0x0000000069553000 000042 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024291] ACPI: SSDT 0x00000000695EE000 0030DA (v02 LENOVO SaSsdt   00003000 INTL 20160527)
[    0.024296] ACPI: SSDT 0x00000000695ED000 0005C6 (v02 LENOVO PerfTune 00001000 INTL 20160527)
[    0.024300] ACPI: HPET 0x00000000695EB000 000038 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024305] ACPI: APIC 0x00000000695EA000 00012C (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024309] ACPI: MCFG 0x00000000695E9000 00003C (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024314] ACPI: ECDT 0x00000000695E8000 000053 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024318] ACPI: SSDT 0x00000000695BF000 001C12 (v02 LENOVO RVP7Rtd3 00001000 INTL 20160527)
[    0.024323] ACPI: SSDT 0x00000000695BD000 00163C (v02 LENOVO ProjSsdt 00000010 INTL 20160527)
[    0.024327] ACPI: BOOT 0x00000000695BC000 000028 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024332] ACPI: BATB 0x00000000695BB000 00004A (v02 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024336] ACPI: SSDT 0x00000000695B9000 0017AE (v02 LENOVO CpuSsdt  00003000 INTL 20160527)
[    0.024341] ACPI: SSDT 0x00000000695B8000 00056D (v02 LENOVO CtdpB    00001000 INTL 20160527)
[    0.024346] ACPI: SSDT 0x00000000695B7000 000678 (v02 LENOVO UsbCTabl 00001000 INTL 20160527)
[    0.024350] ACPI: LPIT 0x00000000695B6000 000094 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024355] ACPI: WSMT 0x00000000695B5000 000028 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024359] ACPI: SSDT 0x00000000695B4000 000141 (v02 LENOVO HdaDsp   00000000 INTL 20160527)
[    0.024364] ACPI: SSDT 0x00000000695FD000 0004D5 (v02 LENOVO TbtTypeC 00000000 INTL 20160527)
[    0.024368] ACPI: SSDT 0x00000000695B2000 0002D1 (v02 LENOVO Wwan     00000001 INTL 20160527)
[    0.024373] ACPI: DBGP 0x00000000695B1000 000034 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024378] ACPI: DBG2 0x00000000695B0000 000054 (v00 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024382] ACPI: POAT 0x00000000695AF000 000055 (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024386] ACPI: SSDT 0x00000000695AE000 00006C (v01 LENOVO NvOptTbl 00001000 INTL 20160527)
[    0.024391] ACPI: SSDT 0x00000000695AC000 00147E (v02 LENOVO SgPch    00001000 INTL 20160527)
[    0.024396] ACPI: DMAR 0x00000000695AB000 0000A8 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024400] ACPI: ASF! 0x00000000695AA000 0000A0 (v32 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024405] ACPI: FPDT 0x00000000695A9000 000044 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024409] ACPI: BGRT 0x00000000695A8000 000038 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024414] ACPI: UEFI 0x000000006950A000 00013E (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024427] ACPI: Local APIC address 0xfee00000
[    0.024549] No NUMA configuration found
[    0.024550] Faking a node at [mem 0x0000000000000000-0x000000028f7fffff]
[    0.024568] NODE_DATA(0) allocated [mem 0x28f7d5000-0x28f7fffff]
[    0.025152] Zone ranges:
[    0.025153]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.025155]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.025156]   Normal   [mem 0x0000000100000000-0x000000028f7fffff]
[    0.025158]   Device   empty
[    0.025159] Movable zone start for each node
[    0.025165] Early memory node ranges
[    0.025166]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.025168]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.025169]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.025170]   node   0: [mem 0x0000000040400000-0x000000004f248fff]
[    0.025171]   node   0: [mem 0x000000004f24b000-0x000000004fee4fff]
[    0.025172]   node   0: [mem 0x000000004fee6000-0x000000005eaabfff]
[    0.025173]   node   0: [mem 0x000000005eaae000-0x0000000068419fff]
[    0.025174]   node   0: [mem 0x00000000695ff000-0x00000000695fffff]
[    0.025175]   node   0: [mem 0x0000000100000000-0x000000028f7fffff]
[    0.025646] Zeroed struct page in unavailable ranges: 34895 pages
[    0.025648] Initmem setup node 0 [mem 0x0000000000001000-0x000000028f7fffff]
[    0.025651] On node 0 totalpages: 2062257
[    0.025652]   DMA zone: 64 pages used for memmap
[    0.025653]   DMA zone: 21 pages reserved
[    0.025655]   DMA zone: 3995 pages, LIFO batch:0
[    0.025695]   DMA32 zone: 6593 pages used for memmap
[    0.025696]   DMA32 zone: 421910 pages, LIFO batch:63
[    0.031851]   Normal zone: 25568 pages used for memmap
[    0.031852]   Normal zone: 1636352 pages, LIFO batch:63
[    0.056609] Reserving Intel graphics memory at [mem 0x6b800000-0x6f7fffff]
[    0.057005] ACPI: PM-Timer IO Port: 0x1808
[    0.057007] ACPI: Local APIC address 0xfee00000
[    0.057018] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.057019] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.057020] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.057020] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.057021] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.057022] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.057023] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.057024] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.057025] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.057026] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.057026] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.057027] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.057028] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.057029] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.057030] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.057031] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.057060] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.057063] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.057065] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.057067] ACPI: IRQ0 used by override.
[    0.057068] ACPI: IRQ9 used by override.
[    0.057071] Using ACPI (MADT) for SMP configuration information
[    0.057073] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.057083] e820: update [mem 0x62211000-0x622a1fff] usable ==> reserved
[    0.057095] TSC deadline timer available
[    0.057097] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.057129] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.057132] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.057134] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x000fffff]
[    0.057137] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x403fffff]
[    0.057139] PM: hibernation: Registered nosave memory: [mem 0x4f249000-0x4f24afff]
[    0.057142] PM: hibernation: Registered nosave memory: [mem 0x4fee5000-0x4fee5fff]
[    0.057144] PM: hibernation: Registered nosave memory: [mem 0x5eaac000-0x5eaacfff]
[    0.057145] PM: hibernation: Registered nosave memory: [mem 0x5eaad000-0x5eaadfff]
[    0.057148] PM: hibernation: Registered nosave memory: [mem 0x62211000-0x622a1fff]
[    0.057150] PM: hibernation: Registered nosave memory: [mem 0x6841a000-0x694f4fff]
[    0.057151] PM: hibernation: Registered nosave memory: [mem 0x694f5000-0x69599fff]
[    0.057152] PM: hibernation: Registered nosave memory: [mem 0x6959a000-0x695fefff]
[    0.057154] PM: hibernation: Registered nosave memory: [mem 0x69600000-0x6f7fffff]
[    0.057155] PM: hibernation: Registered nosave memory: [mem 0x6f800000-0xefffffff]
[    0.057156] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.057157] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfe00ffff]
[    0.057158] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
[    0.057158] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.057161] [mem 0x6f800000-0xefffffff] available for PCI devices
[    0.057162] Booting paravirtualized kernel on bare hardware
[    0.057166] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.057174] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.057553] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.057565] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
[    0.057566] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.057611] Built 1 zonelists, mobility grouping on.  Total pages: 2030011
[    0.057612] Policy zone: Normal
[    0.057614] Kernel command line: BOOT_IMAGE=/@/boot/vmlinuz-5.8.0-rc6+ root=UUID=523fd023-8a9d-45cc-90fc-7823d5a8636f ro rootflags=subvol=@ quiet splash vt.handoff=7
[    0.058570] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.059012] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.059133] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.107023] Memory: 7938644K/8249028K available (14339K kernel code, 2398K rwdata, 4888K rodata, 2552K init, 5148K bss, 310384K reserved, 0K cma-reserved)
[    0.107051] random: get_random_u64 called from __kmem_cache_create+0x42/0x610 with crng_init=1
[    0.107349] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.107380] Kernel/User page tables isolation: enabled
[    0.107416] ftrace: allocating 42945 entries in 168 pages
[    0.139454] ftrace: allocated 168 pages with 3 groups
[    0.139643] rcu: Hierarchical RCU implementation.
[    0.139645] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.139646] 	Rude variant of Tasks RCU enabled.
[    0.139647] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.139649] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.145731] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.146515] random: crng done (trusting CPU's manufacturer)
[    0.146561] Console: colour dummy device 80x25
[    0.146568] printk: console [tty0] enabled
[    0.146604] ACPI: Core revision 20200528
[    0.147235] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.147327] APIC: Switch to symmetric I/O mode setup
[    0.147331] DMAR: Host address width 39
[    0.147333] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.147342] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.147344] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.147350] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.147352] DMAR: RMRR base: 0x00000068a3f000 end: 0x00000068a5efff
[    0.147353] DMAR: RMRR base: 0x0000006b000000 end: 0x0000006f7fffff
[    0.147356] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.147358] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.147359] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.149342] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.149344] x2apic enabled
[    0.149359] Switched APIC routing to cluster x2apic.
[    0.153521] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.171278] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x19f2297dd97, max_idle_ns: 440795236593 ns
[    0.171284] Calibrating delay loop (skipped), value calculated using timer frequency.. 3600.00 BogoMIPS (lpj=7200000)
[    0.171288] pid_max: default: 32768 minimum: 301
[    0.175327] LSM: Security Framework initializing
[    0.175345] Yama: becoming mindful.
[    0.175384] AppArmor: AppArmor initialized
[    0.175462] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.175488] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.175997] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.176039] process: using mwait in idle threads
[    0.176042] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.176044] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.176048] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.176050] Spectre V2 : Mitigation: Full generic retpoline
[    0.176052] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.176053] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.176058] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.176059] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.176062] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.176081] SRBDS: Mitigation: Microcode
[    0.176081] MDS: Mitigation: Clear CPU buffers
[    0.176405] Freeing SMP alternatives memory: 40K
[    0.181834] smpboot: CPU0: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (family: 0x6, model: 0x8e, stepping: 0xa)
[    0.182119] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.182130] ... version:                4
[    0.182131] ... bit width:              48
[    0.182131] ... generic registers:      4
[    0.182133] ... value mask:             0000ffffffffffff
[    0.182133] ... max period:             00007fffffffffff
[    0.182134] ... fixed-purpose events:   3
[    0.182135] ... event mask:             000000070000000f
[    0.182207] rcu: Hierarchical SRCU implementation.
[    0.183280] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.183280] smp: Bringing up secondary CPUs ...
[    0.183280] x86: Booting SMP configuration:
[    0.183280] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.196411] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.196411]  #5 #6 #7
[    0.200044] smp: Brought up 1 node, 8 CPUs
[    0.200044] smpboot: Max logical packages: 1
[    0.200044] smpboot: Total of 8 processors activated (28800.00 BogoMIPS)
[    0.203794] devtmpfs: initialized
[    0.203794] x86/mm: Memory block size: 128MB
[    0.204714] PM: Registering ACPI NVS region [mem 0x5eaac000-0x5eaacfff] (4096 bytes)
[    0.204714] PM: Registering ACPI NVS region [mem 0x694f5000-0x69599fff] (675840 bytes)
[    0.204714] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.204714] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.204714] pinctrl core: initialized pinctrl subsystem
[    0.204714] PM: RTC time: 12:25:35, date: 2020-09-28
[    0.204714] thermal_sys: Registered thermal governor 'fair_share'
[    0.204714] thermal_sys: Registered thermal governor 'bang_bang'
[    0.204714] thermal_sys: Registered thermal governor 'step_wise'
[    0.204714] thermal_sys: Registered thermal governor 'user_space'
[    0.204714] NET: Registered protocol family 16
[    0.204714] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.204714] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.204714] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.204714] audit: initializing netlink subsys (disabled)
[    0.204719] audit: type=2000 audit(1601295935.056:1): state=initialized audit_enabled=0 res=1
[    0.207379] EISA bus registered
[    0.207395] cpuidle: using governor ladder
[    0.207395] cpuidle: using governor menu
[    0.207395] Simple Boot Flag at 0x47 set to 0x1
[    0.207395] ACPI: bus type PCI registered
[    0.207395] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.207823] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.207848] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.207865] PCI: Using configuration type 1 for base access
[    0.208464] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.211358] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.211358] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.211433] ACPI: Added _OSI(Module Device)
[    0.211435] ACPI: Added _OSI(Processor Device)
[    0.211436] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.211438] ACPI: Added _OSI(Processor Aggregator Device)
[    0.211440] ACPI: Added _OSI(Linux-Dell-Video)
[    0.211441] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.211443] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.323550] ACPI: 15 ACPI AML tables successfully acquired and loaded
[    0.326638] ACPI: EC: EC started
[    0.326639] ACPI: EC: interrupt blocked
[    0.330789] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.330790] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.333947] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.408030] ACPI: Dynamic OEM Table Load:
[    0.408065] ACPI: SSDT 0xFFFF917D05F8C800 00058B (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
[    0.411495] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.413948] ACPI: Dynamic OEM Table Load:
[    0.413963] ACPI: SSDT 0xFFFF917D05AE1800 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
[    0.417292] ACPI: Dynamic OEM Table Load:
[    0.417305] ACPI: SSDT 0xFFFF917D056CA240 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
[    0.420446] ACPI: Dynamic OEM Table Load:
[    0.420459] ACPI: SSDT 0xFFFF917D05F88800 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
[    0.424487] ACPI: Dynamic OEM Table Load:
[    0.424505] ACPI: SSDT 0xFFFF917D05FF5000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
[    0.429483] ACPI: Dynamic OEM Table Load:
[    0.429496] ACPI: SSDT 0xFFFF917D05AE5800 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
[    0.432744] ACPI: Dynamic OEM Table Load:
[    0.432755] ACPI: SSDT 0xFFFF917D05AE6400 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
[    0.441362] ACPI: Interpreter enabled
[    0.441450] ACPI: (supports S0 S3 S4 S5)
[    0.441452] ACPI: Using IOAPIC for interrupt routing
[    0.441529] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.442895] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.450005] ACPI: Power Resource [PUBS] (on)
[    0.450438] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
[    0.474970] ACPI: Power Resource [PC01] (on)
[    0.501222] ACPI: Power Resource [WRST] (on)
[    0.502693] ACPI: Power Resource [PXP] (on)
[    0.534688] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.534698] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.538817] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.541136] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    0.545149] PCI host bridge to bus 0000:00
[    0.545153] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.545155] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.545157] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.545158] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.545160] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.545161] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.545163] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.545164] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.545166] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.545167] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.545168] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.545170] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.545171] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.545173] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.545174] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.545175] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    0.545177] pci_bus 0000:00: root bus resource [mem 0x6f800000-0xefffffff window]
[    0.545179] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.545180] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.545197] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.546796] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.546816] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.546825] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.546832] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.546859] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.548500] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.548520] pci 0000:00:04.0: reg 0x10: [mem 0xe9240000-0xe9247fff 64bit]
[    0.550278] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.550298] pci 0000:00:08.0: reg 0x10: [mem 0xe9250000-0xe9250fff 64bit]
[    0.551939] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.551966] pci 0000:00:14.0: reg 0x10: [mem 0xe9220000-0xe922ffff 64bit]
[    0.552049] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.553845] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.553873] pci 0000:00:14.2: reg 0x10: [mem 0xe9251000-0xe9251fff 64bit]
[    0.555608] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.555872] pci 0000:00:15.0: reg 0x10: [mem 0xe9252000-0xe9252fff 64bit]
[    0.558419] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.558447] pci 0000:00:16.0: reg 0x10: [mem 0xe9253000-0xe9253fff 64bit]
[    0.558527] pci 0000:00:16.0: PME# supported from D3hot
[    0.560277] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.560387] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.562154] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.562274] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.564036] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.565627] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.567367] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
[    0.567474] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.569249] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.571067] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.571086] pci 0000:00:1f.2: reg 0x10: [mem 0xe924c000-0xe924ffff]
[    0.572837] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.572872] pci 0000:00:1f.3: reg 0x10: [mem 0xe9248000-0xe924bfff 64bit]
[    0.572912] pci 0000:00:1f.3: reg 0x20: [mem 0xe9230000-0xe923ffff 64bit]
[    0.572976] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.574710] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.574766] pci 0000:00:1f.4: reg 0x10: [mem 0xe9254000-0xe92540ff 64bit]
[    0.574817] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.576585] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.576616] pci 0000:00:1f.6: reg 0x10: [mem 0xe9200000-0xe921ffff]
[    0.576737] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.578516] pci 0000:02:00.0: [10de:1d10] type 00 class 0x030200
[    0.578546] pci 0000:02:00.0: reg 0x10: [mem 0xe8000000-0xe8ffffff]
[    0.578561] pci 0000:02:00.0: reg 0x14: [mem 0x70000000-0x7fffffff 64bit pref]
[    0.578576] pci 0000:02:00.0: reg 0x1c: [mem 0x80000000-0x81ffffff 64bit pref]
[    0.578586] pci 0000:02:00.0: reg 0x24: [io  0xd000-0xd07f]
[    0.578597] pci 0000:02:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.578623] pci 0000:02:00.0: Enabling HDA controller
[    0.579008] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.579012] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.579016] pci 0000:00:1c.0:   bridge window [mem 0xe8000000-0xe8ffffff]
[    0.579022] pci 0000:00:1c.0:   bridge window [mem 0x70000000-0x81ffffff 64bit pref]
[    0.579623] pci 0000:04:00.0: [8086:24fd] type 00 class 0x028000
[    0.579778] pci 0000:04:00.0: reg 0x10: [mem 0xe9100000-0xe9101fff 64bit]
[    0.580406] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.581375] pci 0000:00:1c.6: PCI bridge to [bus 04]
[    0.581381] pci 0000:00:1c.6:   bridge window [mem 0xe9100000-0xe91fffff]
[    0.581464] pci 0000:07:00.0: [8086:15c0] type 01 class 0x060400
[    0.581538] pci 0000:07:00.0: enabling Extended Tags
[    0.581640] pci 0000:07:00.0: supports D1 D2
[    0.581641] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.581823] pci 0000:00:1d.0: PCI bridge to [bus 07-3f]
[    0.581828] pci 0000:00:1d.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.581834] pci 0000:00:1d.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.581919] pci 0000:08:00.0: [8086:15c0] type 01 class 0x060400
[    0.581997] pci 0000:08:00.0: enabling Extended Tags
[    0.582100] pci 0000:08:00.0: supports D1 D2
[    0.582102] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.582235] pci 0000:08:01.0: [8086:15c0] type 01 class 0x060400
[    0.582313] pci 0000:08:01.0: enabling Extended Tags
[    0.582420] pci 0000:08:01.0: supports D1 D2
[    0.582422] pci 0000:08:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.582551] pci 0000:08:02.0: [8086:15c0] type 01 class 0x060400
[    0.582629] pci 0000:08:02.0: enabling Extended Tags
[    0.582731] pci 0000:08:02.0: supports D1 D2
[    0.582732] pci 0000:08:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.582911] pci 0000:07:00.0: PCI bridge to [bus 08-3f]
[    0.582921] pci 0000:07:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.582929] pci 0000:07:00.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.583004] pci 0000:09:00.0: [8086:15bf] type 00 class 0x088000
[    0.583042] pci 0000:09:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.583056] pci 0000:09:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.583127] pci 0000:09:00.0: enabling Extended Tags
[    0.583248] pci 0000:09:00.0: supports D1 D2
[    0.583250] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.583440] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.583451] pci 0000:08:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.583510] pci 0000:08:01.0: PCI bridge to [bus 0a-3e]
[    0.583521] pci 0000:08:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.583528] pci 0000:08:01.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.583619] pci 0000:3f:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.583659] pci 0000:3f:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.583749] pci 0000:3f:00.0: enabling Extended Tags
[    0.583873] pci 0000:3f:00.0: supports D1 D2
[    0.583875] pci 0000:3f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.583962] pci 0000:3f:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:08:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.584100] pci 0000:08:02.0: PCI bridge to [bus 3f]
[    0.584110] pci 0000:08:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.584417] pci 0000:40:00.0: [17aa:0003] type 00 class 0x010802
[    0.584452] pci 0000:40:00.0: reg 0x10: [mem 0xe9000000-0xe9003fff 64bit]
[    0.584642] pci 0000:40:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1d.2 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.584869] pci 0000:00:1d.2: PCI bridge to [bus 40]
[    0.584874] pci 0000:00:1d.2:   bridge window [mem 0xe9000000-0xe90fffff]
[    0.590857] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.590970] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.591078] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.591186] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.591298] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.591410] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.591521] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.591628] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.592874] ACPI: EC: interrupt unblocked
[    0.592875] ACPI: EC: event unblocked
[    0.592889] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.592890] ACPI: EC: GPE=0x16
[    0.592892] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.592894] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.593043] iommu: Default domain type: Translated 
[    0.593043] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    0.593043] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.593043] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.593043] vgaarb: loaded
[    0.593043] SCSI subsystem initialized
[    0.593043] libata version 3.00 loaded.
[    0.593043] ACPI: bus type USB registered
[    0.593043] usbcore: registered new interface driver usbfs
[    0.593043] usbcore: registered new interface driver hub
[    0.593043] usbcore: registered new device driver usb
[    0.593043] pps_core: LinuxPPS API ver. 1 registered
[    0.593043] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.593043] PTP clock support registered
[    0.593043] EDAC MC: Ver: 3.0.0
[    0.593043] Registered efivars operations
[    0.593043] NetLabel: Initializing
[    0.593043] NetLabel:  domain hash size = 128
[    0.593043] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.593043] NetLabel:  unlabeled traffic allowed by default
[    0.593043] PCI: Using ACPI for IRQ routing
[    0.604603] PCI: pci_cache_line_size set to 64 bytes
[    0.605649] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.605651] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.605652] e820: reserve RAM buffer [mem 0x4f249000-0x4fffffff]
[    0.605654] e820: reserve RAM buffer [mem 0x4fee5000-0x4fffffff]
[    0.605655] e820: reserve RAM buffer [mem 0x5eaac000-0x5fffffff]
[    0.605656] e820: reserve RAM buffer [mem 0x62211000-0x63ffffff]
[    0.605657] e820: reserve RAM buffer [mem 0x6841a000-0x6bffffff]
[    0.605659] e820: reserve RAM buffer [mem 0x69600000-0x6bffffff]
[    0.605660] e820: reserve RAM buffer [mem 0x28f800000-0x28fffffff]
[    0.605665] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.605665] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.608346] clocksource: Switched to clocksource tsc-early
[    0.627497] VFS: Disk quotas dquot_6.6.0
[    0.627520] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.627693] AppArmor: AppArmor Filesystem Enabled
[    0.627737] pnp: PnP ACPI init
[    0.627936] system 00:00: [mem 0x40000000-0x403fffff] has been reserved
[    0.627944] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.628251] system 00:01: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.628253] system 00:01: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.628255] system 00:01: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.628257] system 00:01: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.628259] system 00:01: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.628261] system 00:01: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.628263] system 00:01: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.628269] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.628919] system 00:02: [io  0xff00-0xfffe] has been reserved
[    0.628925] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630010] system 00:03: [io  0x0680-0x069f] has been reserved
[    0.630013] system 00:03: [io  0xffff] has been reserved
[    0.630015] system 00:03: [io  0xffff] has been reserved
[    0.630016] system 00:03: [io  0xffff] has been reserved
[    0.630018] system 00:03: [io  0x1800-0x18fe] has been reserved
[    0.630020] system 00:03: [io  0x164e-0x164f] has been reserved
[    0.630025] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630233] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.630312] system 00:05: [io  0x1854-0x1857] has been reserved
[    0.630317] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.630350] pnp 00:06: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.630377] pnp 00:07: Plug and Play ACPI device, IDs LEN009b PNP0f13 (active)
[    0.630601] system 00:08: [io  0x1800-0x189f] could not be reserved
[    0.630604] system 00:08: [io  0x0800-0x087f] has been reserved
[    0.630606] system 00:08: [io  0x0880-0x08ff] has been reserved
[    0.630608] system 00:08: [io  0x0900-0x097f] has been reserved
[    0.630610] system 00:08: [io  0x0980-0x09ff] has been reserved
[    0.630612] system 00:08: [io  0x0a00-0x0a7f] has been reserved
[    0.630613] system 00:08: [io  0x0a80-0x0aff] has been reserved
[    0.630615] system 00:08: [io  0x0b00-0x0b7f] has been reserved
[    0.630617] system 00:08: [io  0x0b80-0x0bff] has been reserved
[    0.630619] system 00:08: [io  0x15e0-0x15ef] has been reserved
[    0.630621] system 00:08: [io  0x1600-0x167f] could not be reserved
[    0.630623] system 00:08: [io  0x1640-0x165f] could not be reserved
[    0.630626] system 00:08: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.630628] system 00:08: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.630630] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.630632] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.630634] system 00:08: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.630636] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.630638] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.630640] system 00:08: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.630646] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.633302] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.635254] system 00:0a: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.635256] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.635258] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.635260] system 00:0a: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.635262] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.635264] system 00:0a: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.635266] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.635268] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    0.635270] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.635273] system 00:0a: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.635278] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.635944] system 00:0b: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.635946] system 00:0b: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.635948] system 00:0b: [mem 0x00100000-0x6f7fffff] could not be reserved
[    0.635950] system 00:0b: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.635952] system 00:0b: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.635957] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.636231] pnp: PnP ACPI: found 12 devices
[    0.642598] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.642691] NET: Registered protocol family 2
[    0.642841] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.642930] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.643126] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.643262] TCP: Hash tables configured (established 65536 bind 65536)
[    0.643328] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.643381] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.643461] NET: Registered protocol family 1
[    0.643467] NET: Registered protocol family 44
[    0.643474] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    0.643485] pci 0000:08:01.0: bridge window [io  0x1000-0x0fff] to [bus 0a-3e] add_size 1000
[    0.643490] pci 0000:07:00.0: bridge window [io  0x1000-0x0fff] to [bus 08-3f] add_size 1000
[    0.643493] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 07-3f] add_size 2000
[    0.643502] pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x3fff]
[    0.643508] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00080000 pref]
[    0.643510] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
[    0.643512] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.643515] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.643520] pci 0000:00:1c.0:   bridge window [mem 0xe8000000-0xe8ffffff]
[    0.643523] pci 0000:00:1c.0:   bridge window [mem 0x70000000-0x81ffffff 64bit pref]
[    0.643529] pci 0000:00:1c.6: PCI bridge to [bus 04]
[    0.643535] pci 0000:00:1c.6:   bridge window [mem 0xe9100000-0xe91fffff]
[    0.643544] pci 0000:07:00.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.643547] pci 0000:08:01.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.643549] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.643555] pci 0000:08:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.643566] pci 0000:08:01.0: PCI bridge to [bus 0a-3e]
[    0.643569] pci 0000:08:01.0:   bridge window [io  0x2000-0x2fff]
[    0.643575] pci 0000:08:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.643580] pci 0000:08:01.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643587] pci 0000:08:02.0: PCI bridge to [bus 3f]
[    0.643593] pci 0000:08:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.643603] pci 0000:07:00.0: PCI bridge to [bus 08-3f]
[    0.643606] pci 0000:07:00.0:   bridge window [io  0x2000-0x2fff]
[    0.643612] pci 0000:07:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.643616] pci 0000:07:00.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643623] pci 0000:00:1d.0: PCI bridge to [bus 07-3f]
[    0.643625] pci 0000:00:1d.0:   bridge window [io  0x2000-0x3fff]
[    0.643630] pci 0000:00:1d.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.643633] pci 0000:00:1d.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643638] pci 0000:00:1d.2: PCI bridge to [bus 40]
[    0.643643] pci 0000:00:1d.2:   bridge window [mem 0xe9000000-0xe90fffff]
[    0.643652] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.643653] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.643655] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.643656] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.643658] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.643659] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.643661] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.643663] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.643664] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.643666] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.643667] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.643668] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.643670] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.643671] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.643673] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.643674] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    0.643676] pci_bus 0000:00: resource 20 [mem 0x6f800000-0xefffffff window]
[    0.643678] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
[    0.643679] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.643681] pci_bus 0000:02: resource 1 [mem 0xe8000000-0xe8ffffff]
[    0.643682] pci_bus 0000:02: resource 2 [mem 0x70000000-0x81ffffff 64bit pref]
[    0.643684] pci_bus 0000:04: resource 1 [mem 0xe9100000-0xe91fffff]
[    0.643686] pci_bus 0000:07: resource 0 [io  0x2000-0x3fff]
[    0.643687] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.643689] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643690] pci_bus 0000:08: resource 0 [io  0x2000-0x2fff]
[    0.643692] pci_bus 0000:08: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.643693] pci_bus 0000:08: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643695] pci_bus 0000:09: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.643696] pci_bus 0000:0a: resource 0 [io  0x2000-0x2fff]
[    0.643697] pci_bus 0000:0a: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.643699] pci_bus 0000:0a: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.643700] pci_bus 0000:3f: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.643702] pci_bus 0000:40: resource 1 [mem 0xe9000000-0xe90fffff]
[    0.643998] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.645514] PCI: CLS 128 bytes, default 64
[    0.645566] Unpacking initramfs...
[    0.687158] Freeing initrd memory: 13344K
[    0.703360] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.703362] software IO TLB: mapped [mem 0x63ac5000-0x67ac5000] (64MB)
[    0.703565] resource sanity check: requesting [mem 0xfed10000-0xfed15fff], which spans more than pnp 00:08 [mem 0xfed10000-0xfed13fff]
[    0.703573] caller snb_uncore_imc_init_box+0x6c/0xb0 mapping multiple BARs
[    0.704008] check: Scanning for low memory corruption every 60 seconds
[    0.704854] Initialise system trusted keyrings
[    0.704874] Key type blacklist registered
[    0.704937] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.707221] zbud: loaded
[    0.707755] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.708012] fuse: init (API version 7.31)
[    0.708268] integrity: Platform Keyring initialized
[    0.726635] Key type asymmetric registered
[    0.726637] Asymmetric key parser 'x509' registered
[    0.726647] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.726738] io scheduler mq-deadline registered
[    0.727400] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.727784] pcieport 0000:00:1c.6: PME: Signaling with IRQ 123
[    0.727946] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.727978] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.728387] pcieport 0000:00:1d.2: PME: Signaling with IRQ 125
[    0.729034] pcieport 0000:08:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.729443] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.729542] efifb: probing for efifb
[    0.729589] efifb: showing boot graphics
[    0.731411] efifb: framebuffer at 0xc0000000, using 8100k, total 8100k
[    0.731413] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.731414] efifb: scrolling: redraw
[    0.731416] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.731479] fbcon: Deferring console take-over
[    0.731480] fb0: EFI VGA frame buffer device
[    0.731501] intel_idle: MWAIT substates: 0x11142120
[    0.731502] intel_idle: v0.5.1 model 0x8E
[    0.732272] intel_idle: Local APIC timer is reliable in all C-states
[    0.732928] ACPI: AC Adapter [AC] (off-line)
[    0.733104] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.733159] ACPI: Sleep Button [SLPB]
[    0.733226] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.733265] ACPI: Lid Switch [LID]
[    0.733318] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.733355] ACPI: Power Button [PWRF]
[    0.741598] thermal LNXTHERM:00: registered as thermal_zone0
[    0.741600] ACPI: Thermal Zone [THM0] (41 C)
[    0.742001] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.746305] Linux agpgart interface v0.103
[    0.751509] tpm_tis STM7304:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.773103] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.781565] loop: module loaded
[    0.782072] libphy: Fixed MDIO Bus: probed
[    0.782074] tun: Universal TUN/TAP device driver, 1.6
[    0.782173] PPP generic driver version 2.4.2
[    0.782360] VFIO - User Level meta-driver version: 0.3
[    0.782836] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.782843] ehci-pci: EHCI PCI platform driver
[    0.782865] ehci-platform: EHCI generic platform driver
[    0.782887] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.782891] ohci-pci: OHCI PCI platform driver
[    0.782906] ohci-platform: OHCI generic platform driver
[    0.782921] uhci_hcd: USB Universal Host Controller Interface driver
[    0.783314] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.783324] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.784465] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    0.784900] xhci_hcd 0000:00:14.0: cache line size of 128 is not supported
[    0.785268] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
[    0.785270] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.785272] usb usb1: Product: xHCI Host Controller
[    0.785274] usb usb1: Manufacturer: Linux 5.8.0-rc6+ xhci-hcd
[    0.785276] usb usb1: SerialNumber: 0000:00:14.0
[    0.785510] hub 1-0:1.0: USB hub found
[    0.785538] hub 1-0:1.0: 12 ports detected
[    0.788245] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.788250] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.788254] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.788315] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.08
[    0.788317] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.788319] usb usb2: Product: xHCI Host Controller
[    0.788321] usb usb2: Manufacturer: Linux 5.8.0-rc6+ xhci-hcd
[    0.788322] usb usb2: SerialNumber: 0000:00:14.0
[    0.788537] hub 2-0:1.0: USB hub found
[    0.788556] hub 2-0:1.0: 6 ports detected
[    0.789716] usb: port power management may be unreliable
[    0.790313] xhci_hcd 0000:3f:00.0: xHCI Host Controller
[    0.790320] xhci_hcd 0000:3f:00.0: new USB bus registered, assigned bus number 3
[    0.791567] xhci_hcd 0000:3f:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
[    0.791996] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
[    0.791998] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.792000] usb usb3: Product: xHCI Host Controller
[    0.792002] usb usb3: Manufacturer: Linux 5.8.0-rc6+ xhci-hcd
[    0.792004] usb usb3: SerialNumber: 0000:3f:00.0
[    0.792226] hub 3-0:1.0: USB hub found
[    0.792241] hub 3-0:1.0: 2 ports detected
[    0.793620] xhci_hcd 0000:3f:00.0: xHCI Host Controller
[    0.793625] xhci_hcd 0000:3f:00.0: new USB bus registered, assigned bus number 4
[    0.793630] xhci_hcd 0000:3f:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.793696] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.08
[    0.793699] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.793701] usb usb4: Product: xHCI Host Controller
[    0.793703] usb usb4: Manufacturer: Linux 5.8.0-rc6+ xhci-hcd
[    0.793704] usb usb4: SerialNumber: 0000:3f:00.0
[    0.793915] hub 4-0:1.0: USB hub found
[    0.793931] hub 4-0:1.0: 2 ports detected
[    0.795098] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.797908] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.797916] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.798220] mousedev: PS/2 mouse device common for all mice
[    0.798825] rtc_cmos 00:04: RTC can wake from S4
[    0.799691] rtc_cmos 00:04: registered as rtc0
[    0.799922] rtc_cmos 00:04: setting system clock to 2020-09-28T12:25:36 UTC (1601295936)
[    0.799981] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.799997] i2c /dev entries driver
[    0.800078] device-mapper: uevent: version 1.0.3
[    0.800265] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    0.800325] platform eisa.0: Probing EISA bus 0
[    0.800328] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.800331] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.800333] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.800334] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.800336] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.800338] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.800340] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.800342] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.800343] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.800345] platform eisa.0: EISA: Detected 0 cards
[    0.800351] intel_pstate: Intel P-state driver initializing
[    0.800493] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.802103] battery: ACPI: Battery Slot [BAT1] (battery present)
[    0.802261] intel_pstate: HWP enabled
[    0.802406] ledtrig-cpu: registered to indicate activity on CPUs
[    0.802409] EFI Variables Facility v0.08 2004-May-17
[    0.849653] intel_pmc_core INT33A1:00:  initialized
[    0.849727] drop_monitor: Initializing network drop monitor service
[    0.849852] NET: Registered protocol family 10
[    0.858785] Segment Routing with IPv6
[    0.858801] NET: Registered protocol family 17
[    0.858875] Key type dns_resolver registered
[    0.859256] microcode: sig=0x806ea, pf=0x80, revision=0xd6
[    0.859304] microcode: Microcode Update Driver: v2.2.
[    0.859307] IPI shorthand broadcast: enabled
[    0.859314] sched_clock: Marking stable (858141484, 1159856)->(867095256, -7793916)
[    0.859520] registered taskstats version 1
[    0.859552] Loading compiled-in X.509 certificates
[    0.860163] Loaded X.509 cert 'Build time autogenerated kernel key: 54aec3f9a7a83dc4da728839484e01ad5628cca8'
[    0.860190] zswap: loaded using pool lzo/zbud
[    0.860254] Key type ._fscrypt registered
[    0.860254] Key type .fscrypt registered
[    0.860255] Key type fscrypt-provisioning registered
[    0.860295] Key type trusted registered
[    0.863972] Key type encrypted registered
[    0.863974] AppArmor: AppArmor sha1 policy hashing enabled
[    0.865532] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.865557] integrity: Loaded X.509 cert 'SomeOrg: shim: a01ee84e9b37ace407961cc468c5909447878469'
[    0.865557] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.866059] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.866438] ima: Allocated hash algorithm: sha1
[    0.899840] ima: No architecture policies found
[    0.899853] evm: Initialising EVM extended attributes:
[    0.899853] evm: security.selinux
[    0.899854] evm: security.SMACK64
[    0.899854] evm: security.SMACK64EXEC
[    0.899854] evm: security.SMACK64TRANSMUTE
[    0.899855] evm: security.SMACK64MMAP
[    0.899855] evm: security.apparmor
[    0.899855] evm: security.ima
[    0.899856] evm: security.capability
[    0.899856] evm: HMAC attrs: 0x1
[    0.901084] PM:   Magic number: 4:769:431
[    0.901324] RAS: Correctable Errors collector initialized.
[    0.902249] Freeing unused decrypted memory: 2040K
[    0.902629] Freeing unused kernel image (initmem) memory: 2552K
[    0.955788] Write protecting the kernel read-only data: 22528k
[    0.956376] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    0.956751] Freeing unused kernel image (rodata/data gap) memory: 1256K
[    1.001456] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.001457] x86/mm: Checking user space page tables
[    1.045679] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.045683] Run /init as init process
[    1.045684]   with arguments:
[    1.045684]     /init
[    1.045685]     splash
[    1.045685]   with environment:
[    1.045686]     HOME=/
[    1.045686]     TERM=linux
[    1.045686]     BOOT_IMAGE=/@/boot/vmlinuz-5.8.0-rc6+
[    1.123304] usb 1-7: new full-speed USB device number 2 using xhci_hcd
[    1.131591] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    1.131893] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.134210] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.134777] nvme nvme0: pci function 0000:40:00.0
[    1.135465] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.135499] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.136470] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.136471] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.136682] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.146535] i2c i2c-0: 1/2 memory slots populated (from DMI)
[    1.146904] i2c i2c-0: Successfully instantiated SPD at 0x50
[    1.149467] nvme nvme0: 8/0/0 default/read/poll queues
[    1.151634]  nvme0n1: p1 p2
[    1.273246] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.10
[    1.273247] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.354739] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    1.403779] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.422318] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 54:ee:75:e8:57:0d
[    1.422319] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.422398] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0FF
[    1.423365] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    1.440172] usb 2-3: New USB device found, idVendor=0bda, idProduct=0316, bcdDevice= 2.04
[    1.440173] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.440174] usb 2-3: Product: USB3.0-CRW
[    1.440175] usb 2-3: Manufacturer: Generic
[    1.440175] usb 2-3: SerialNumber: 20120501030900000
[    1.450702] usb-storage 2-3:1.0: USB Mass Storage device detected
[    1.450853] scsi host0: usb-storage 2-3:1.0
[    1.450941] usbcore: registered new interface driver usb-storage
[    1.451973] usbcore: registered new interface driver uas
[    1.563603] usb 1-8: new high-speed USB device number 3 using xhci_hcd
[    1.719368] tsc: Refined TSC clocksource calibration: 1800.006 MHz
[    1.719374] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x19f22f68897, max_idle_ns: 440795282550 ns
[    1.719441] clocksource: Switched to clocksource tsc
[    1.749565] usb 1-8: New USB device found, idVendor=13d3, idProduct=56a6, bcdDevice=17.11
[    1.749566] usb 1-8: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.749567] usb 1-8: Product: Integrated Camera
[    1.749568] usb 1-8: Manufacturer: Azurewave
[    1.749569] usb 1-8: SerialNumber: 0001
[    1.879612] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    1.961525] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4690]
[    1.995613] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[    1.995617] psmouse serio1: synaptics: Trying to set up SMBus access
[    2.029848] usb 1-9: New USB device found, idVendor=06cb, idProduct=009a, bcdDevice= 1.64
[    2.029850] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    2.029851] usb 1-9: SerialNumber: 8d97a807073f
[    2.123284] raid6: avx2x4   gen() 33662 MB/s
[    2.191283] raid6: avx2x4   xor()  7823 MB/s
[    2.259290] raid6: avx2x2   gen() 34710 MB/s
[    2.327283] raid6: avx2x2   xor() 21996 MB/s
[    2.395283] raid6: avx2x1   gen() 29843 MB/s
[    2.453415] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
[    2.453630] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.463284] raid6: avx2x1   xor() 17251 MB/s
[    2.531283] raid6: sse2x4   gen() 14572 MB/s
[    2.599284] raid6: sse2x4   xor()  7714 MB/s
[    2.667284] raid6: sse2x2   gen() 14801 MB/s
[    2.735284] raid6: sse2x2   xor()  9395 MB/s
[    2.803283] raid6: sse2x1   gen() 12606 MB/s
[    2.871283] raid6: sse2x1   xor()  6407 MB/s
[    2.871283] raid6: using algorithm avx2x2 gen() 34710 MB/s
[    2.871284] raid6: .... xor() 21996 MB/s, rmw enabled
[    2.871285] raid6: using avx2x2 recovery algorithm
[    2.873488] xor: automatically using best checksumming function   avx       
[    2.888674] Btrfs loaded, crc32c=crc32c-intel
[    2.900071] BTRFS: device fsid 523fd023-8a9d-45cc-90fc-7823d5a8636f devid 1 transid 25614 /dev/nvme0n1p2 scanned by btrfs (226)
[    2.909027] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.914425] BTRFS info (device nvme0n1p2): disk space caching is enabled
[    2.914425] BTRFS info (device nvme0n1p2): has skinny extents
[    2.927688] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    3.028091] systemd[1]: Inserted module 'autofs4'
[    3.131106] systemd[1]: systemd 246.4-1ubuntu1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.147832] systemd[1]: Detected architecture x86-64.
[    3.250968] systemd[1]: /lib/systemd/system/dbus.service:12: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    3.266746] systemd[1]: /lib/systemd/system/plymouth-start.service:17: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    3.280929] systemd[1]: Queued start job for default target Graphical Interface.
[    3.281905] systemd[1]: Created slice system-modprobe.slice.
[    3.282085] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.282235] systemd[1]: Created slice User and Session Slice.
[    3.282288] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.282323] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    3.282371] systemd[1]: Reached target Remote File Systems.
[    3.282382] systemd[1]: Reached target Slices.
[    3.282942] systemd[1]: Listening on Syslog Socket.
[    3.283022] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.283063] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    3.283205] systemd[1]: Listening on Journal Audit Socket.
[    3.283269] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.283351] systemd[1]: Listening on Journal Socket.
[    3.283482] systemd[1]: Listening on udev Control Socket.
[    3.283554] systemd[1]: Listening on udev Kernel Socket.
[    3.284232] systemd[1]: Mounting Huge Pages File System...
[    3.284871] systemd[1]: Mounting POSIX Message Queue File System...
[    3.285633] systemd[1]: Mounting Kernel Debug File System...
[    3.286494] systemd[1]: Mounting Kernel Trace File System...
[    3.288497] systemd[1]: Starting Journal Service...
[    3.289509] systemd[1]: Starting Set the console keyboard layout...
[    3.290404] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.291223] systemd[1]: Starting Load Kernel Module drm...
[    3.291809] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    3.291848] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    3.293362] systemd[1]: Starting Load Kernel Modules...
[    3.294353] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.295537] systemd[1]: Starting Coldplug All udev Devices...
[    3.297017] systemd[1]: Starting Uncomplicated firewall...
[    3.299325] systemd[1]: Mounted Huge Pages File System.
[    3.299456] systemd[1]: Mounted POSIX Message Queue File System.
[    3.299549] systemd[1]: Mounted Kernel Debug File System.
[    3.299628] systemd[1]: Mounted Kernel Trace File System.
[    3.300072] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.300712] systemd[1]: Finished Uncomplicated firewall.
[    3.302706] BTRFS info (device nvme0n1p2): disk space caching is enabled
[    3.303906] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.304690] systemd[1]: Activating swap /swapfile...
[    3.305256] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    3.305331] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    3.306243] systemd[1]: Starting Load/Save Random Seed...
[    3.307494] systemd[1]: Starting Create System Users...
[    3.307921] systemd[1]: modprobe@drm.service: Succeeded.
[    3.308405] systemd[1]: Finished Load Kernel Module drm.
[    3.309284] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    3.310152] systemd[1]: swapfile.swap: Swap process exited, code=exited, status=255/EXCEPTION
[    3.310156] systemd[1]: swapfile.swap: Failed with result 'exit-code'.
[    3.310620] systemd[1]: Failed to activate swap /swapfile.
[    3.310633] fbcon: Taking over console
[    3.310707] Console: switching to colour frame buffer device 240x67
[    3.316335] systemd[1]: Dependency failed for Swap.
[    3.316426] systemd[1]: swap.target: Job swap.target/start failed with result 'dependency'.
[    3.317653] systemd[1]: Finished Load/Save Random Seed.
[    3.318713] lp: driver loaded but no devices found
[    3.320614] systemd[1]: Finished Create System Users.
[    3.321729] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.323635] ppdev: user-space parallel port driver
[    3.328151] systemd[1]: Finished Load Kernel Modules.
[    3.329113] systemd[1]: Mounting FUSE Control File System...
[    3.330341] systemd[1]: Mounting Kernel Configuration File System...
[    3.331713] systemd[1]: Starting Apply Kernel Variables...
[    3.333368] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.334171] systemd[1]: Mounted FUSE Control File System.
[    3.334300] systemd[1]: Mounted Kernel Configuration File System.
[    3.336311] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    3.345662] systemd[1]: Finished Apply Kernel Variables.
[    3.369868] systemd[1]: Finished Set the console keyboard layout.
[    3.370002] systemd[1]: Reached target Local File Systems (Pre).
[    3.371032] systemd[1]: Mounting Mount unit for core, revision 9804...
[    3.371834] systemd[1]: Mounting Mount unit for core, revision 9993...
[    3.374338] systemd[1]: Mounting Mount unit for core18, revision 1754...
[    3.375210] systemd[1]: Mounting Mount unit for core18, revision 1885...
[    3.397071] systemd[1]: Finished Coldplug All udev Devices.
[    3.403051] systemd[1]: Started Journal Service.
[    3.591546] nfc: nfc_init: NFC Core ver 0.1
[    3.591566] NET: Registered protocol family 39
[    3.601382] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    3.601518] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    3.632755] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    3.642398] mc: Linux media interface: v0.10
[    3.654347] Non-volatile memory driver v1.3
[    3.659733] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.659735] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.659735] thinkpad_acpi: ThinkPad BIOS N27ET38W (1.24 ), EC N27HT16W
[    3.659736] thinkpad_acpi: Lenovo ThinkPad T580, model 20LAZ3TXCN
[    3.660613] intel_rapl_common: Found RAPL domain package
[    3.660614] intel_rapl_common: Found RAPL domain dram
[    3.663671] thinkpad_acpi: radio switch found; radios are enabled
[    3.664089] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    3.664090] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    3.665758] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
[    3.668932] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.669188] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.669391] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    3.672466] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[    3.672553] Bluetooth: Core ver 2.22
[    3.672568] NET: Registered protocol family 31
[    3.672568] Bluetooth: HCI device and connection manager initialized
[    3.672571] Bluetooth: HCI socket layer initialized
[    3.672573] Bluetooth: L2CAP socket layer initialized
[    3.672576] Bluetooth: SCO socket layer initialized
[    3.676803] videodev: Linux video capture interface: v2.00
[    3.686197] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    3.686830] checking generic (c0000000 7e9000) vs hw (e7000000 1000000)
[    3.686832] checking generic (c0000000 7e9000) vs hw (c0000000 10000000)
[    3.686833] fb0: switching to inteldrmfb from EFI VGA
[    3.687141] Console: switching to colour dummy device 80x25
[    3.687198] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.689326] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.689475] Intel(R) Wireless WiFi driver for Linux
[    3.690054] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=mem
[    3.690201] usbcore: registered new interface driver btusb
[    3.696498] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 2015
[    3.697209] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    3.697527] Bluetooth: hci0: Device revision is 16
[    3.697528] Bluetooth: hci0: Secure boot is enabled
[    3.697529] Bluetooth: hci0: OTP lock is enabled
[    3.697529] Bluetooth: hci0: API lock is enabled
[    3.697530] Bluetooth: hci0: Debug lock is disabled
[    3.697530] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    3.703237] iwlwifi 0000:04:00.0: Found debug destination: EXTERNAL_DRAM
[    3.703247] iwlwifi 0000:04:00.0: Found debug configuration: 0
[    3.704958] iwlwifi 0000:04:00.0: loaded firmware version 36.79ff3ccf.0 8265-36.ucode op_mode iwlmvm
[    3.705011] iwlwifi 0000:04:00.0: Direct firmware load for iwl-debug-yoyo.bin failed with error -2
[    3.707431] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[    3.716430] uvcvideo: Found UVC 1.00 device Integrated Camera (13d3:56a6)
[    3.720105] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[    3.728323] thinkpad_acpi: battery 2 registered (start 0, stop 100)
[    3.731821] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[    3.731829] battery: new extension: ThinkPad Battery Extension
[    3.731887] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input6
[    3.736923] uvcvideo 1-8:1.0: Entity type for entity Realtek Extended Controls Unit was not initialized!
[    3.736925] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not initialized!
[    3.736927] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was not initialized!
[    3.736928] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not initialized!
[    3.737859] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input7
[    3.746187] usbcore: registered new interface driver uvcvideo
[    3.746189] USB Video Class driver (1.1.1)
[    3.769580] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
[    3.771599] rmi4_smbus 0-002c: registering SMbus-connected sensor
[    3.778248] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
[    3.779020] iwlwifi 0000:04:00.0: Allocated 0x00400000 bytes for firmware monitor.
[    3.784538] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    3.784539] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.784540] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.784540] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.784541] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.784541] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    3.790698] cryptd: max_cpu_qlen set to 1000
[    3.809401] AVX2 version of gcm_enc/dec engaged.
[    3.809403] AES CTR mode by8 optimization enabled
[    3.834103] iwlwifi 0000:04:00.0: base HW address: e4:70:b8:68:56:9b
[    3.911612] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    3.912038] thermal thermal_zone11: failed to read out thermal zone (-61)
[    3.928242] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3276-030, fw id: 2620110
[    3.978254] audit: type=1400 audit(1601295939.671:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=543 comm="apparmor_parser"
[    3.982082] audit: type=1400 audit(1601295939.675:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=544 comm="apparmor_parser"
[    3.982085] audit: type=1400 audit(1601295939.675:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=544 comm="apparmor_parser"
[    3.984909] audit: type=1400 audit(1601295939.683:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=546 comm="apparmor_parser"
[    3.995346] audit: type=1400 audit(1601295939.691:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=549 comm="apparmor_parser"
[    3.996509] audit: type=1400 audit(1601295939.691:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=554 comm="apparmor_parser"
[    3.996512] audit: type=1400 audit(1601295939.691:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=554 comm="apparmor_parser"
[    3.996513] audit: type=1400 audit(1601295939.691:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=554 comm="apparmor_parser"
[    4.002226] audit: type=1400 audit(1601295939.695:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=558 comm="apparmor_parser"
[    4.008619] intel_rapl_common: Found RAPL domain package
[    4.008620] intel_rapl_common: Found RAPL domain core
[    4.008622] intel_rapl_common: Found RAPL domain uncore
[    4.008623] intel_rapl_common: Found RAPL domain dram
[    4.040382] input: Synaptics TM3276-030 as /devices/rmi4-00/input/input8
[    4.052654] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
[    4.077049] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    4.087826] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    4.108894] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    4.128782] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    4.137821] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    4.390823] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.390824] Bluetooth: BNEP filters: protocol multicast
[    4.390827] Bluetooth: BNEP socket layer initialized
[    4.474010] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    4.510729] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio2/input/input9
[    4.772633] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
[    4.909659] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DRAM
[    4.977022] iwlwifi 0000:04:00.0: FW already configured (0) - re-configuring
[    5.034383] [drm] Initialized i915 1.6.0 20200515 for 0000:00:02.0 on minor 0
[    5.052312] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.052488] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input10
[    5.052730] ACPI: Video Device [PXSX] (multi-head: no  rom: yes  post: no)
[    5.052757] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:35/LNXVIDEO:01/input/input11
[    5.052929] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    5.170946] fbcon: i915drmfb (fb0) is primary device
[    5.173408] Console: switching to colour frame buffer device 240x67
[    5.199030] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    5.243362] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC257: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.243363] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.243364] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    5.243365] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    5.243365] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.243366] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
[    5.243367] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    5.295906] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    5.295959] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    5.296006] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    5.296077] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    5.296177] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    5.296273] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    5.296354] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    5.507637] kauditd_printk_skb: 27 callbacks suppressed
[    5.507638] audit: type=1400 audit(1601295941.203:38): apparmor="ALLOWED" operation="open" profile="/usr/sbin/sssd" name="/etc/sssd/conf.d/" pid=782 comm="sssd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.507666] audit: type=1400 audit(1601295941.203:39): apparmor="ALLOWED" operation="open" profile="/usr/sbin/sssd" name="/usr/share/sssd/cfg_rules.ini" pid=782 comm="sssd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.577216] Bluetooth: hci0: Waiting for firmware download to complete
[    5.577642] Bluetooth: hci0: Firmware loaded in 1838183 usecs
[    5.577744] Bluetooth: hci0: Waiting for device to boot
[    5.589798] Bluetooth: hci0: Device booted in 11850 usecs
[    5.589861] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16.ddc
[    5.592854] Bluetooth: hci0: Applying Intel DDC parameters completed
[    5.593814] Bluetooth: hci0: Firmware revision 0.1 build 50 week 12 2019
[    5.649709] NET: Registered protocol family 38
[    5.899193] audit: type=1400 audit(1601295941.591:40): apparmor="DENIED" operation="capable" profile="/usr/sbin/cups-browsed" pid=809 comm="cups-browsed" capability=23  capname="sys_nice"
[    8.177552] rfkill: input handler disabled
[    9.255669] wlp4s0: authenticate with d8:8f:76:7c:52:a9
[    9.269395] wlp4s0: send auth to d8:8f:76:7c:52:a9 (try 1/3)
[    9.276566] wlp4s0: authenticated
[    9.279342] wlp4s0: associate with d8:8f:76:7c:52:a9 (try 1/3)
[    9.281538] wlp4s0: RX AssocResp from d8:8f:76:7c:52:a9 (capab=0x1011 status=0 aid=4)
[    9.286457] wlp4s0: associated
[    9.335279] IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
[    9.344907] wlp4s0: Limiting TX power to 27 (27 - 0) dBm as advertised by d8:8f:76:7c:52:a9
[   15.119747] Bluetooth: RFCOMM TTY layer initialized
[   15.119753] Bluetooth: RFCOMM socket layer initialized
[   15.119756] Bluetooth: RFCOMM ver 1.11
[   15.300074] rfkill: input handler enabled
[   16.772821] rfkill: input handler disabled
[   17.868849] BUG: kernel NULL pointer dereference, address: 000000000000002c
[   17.868852] #PF: supervisor read access in kernel mode
[   17.868854] #PF: error_code(0x0000) - not-present page
[   17.868855] PGD 0 P4D 0 
[   17.868858] Oops: 0000 [#1] SMP PTI
[   17.868860] CPU: 0 PID: 1873 Comm: fwupd Not tainted 5.8.0-rc6+ #25
[   17.868861] Hardware name: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N27ET38W (1.24 ) 11/28/2019
[   17.868866] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
[   17.868868] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
[   17.868869] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
[   17.868871] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000000000000010
[   17.868872] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff917c99b19438
[   17.868873] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff917cbfeae4c0
[   17.868874] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000010
[   17.868875] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff917c99b19470
[   17.868876] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000) knlGS:0000000000000000
[   17.868877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.868878] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00000000003606f0
[   17.868879] Call Trace:
[   17.868884]  seq_read+0x95/0x470
[   17.868887]  ? security_file_permission+0x150/0x160
[   17.868889]  vfs_read+0xaa/0x190
[   17.868891]  ksys_read+0x67/0xe0
[   17.868893]  __x64_sys_read+0x1a/0x20
[   17.868896]  do_syscall_64+0x52/0xc0
[   17.868898]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   17.868900] RIP: 0033:0x7f9d83be91dc
[   17.868901] Code: Bad RIP value.
[   17.868902] RSP: 002b:00007fff7f5e0250 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   17.868903] RAX: ffffffffffffffda RBX: 00005651d262f420 RCX: 00007f9d83be91dc
[   17.868904] RDX: 0000000000001000 RSI: 00007fff7f5e0350 RDI: 0000000000000010
[   17.868905] RBP: 00007f9d83cc54a0 R08: 0000000000000000 R09: 00005651d26c1830
[   17.868906] R10: 00005651d2582010 R11: 0000000000000246 R12: 0000000000001000
[   17.868907] R13: 00007fff7f5e0350 R14: 0000000000000d68 R15: 00007f9d83cc48a0
[   17.868909] Modules linked in: rfcomm ccm cmac algif_hash algif_skcipher af_alg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic bnep joydev mei_hdcp wmi_bmof intel_rapl_msr intel_wmi_thunderbolt x86_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper crypto_simd cryptd rapl input_leds intel_cstate snd_hda_intel snd_intel_dspcfg rmi_smbus iwlmvm snd_hda_codec serio_raw snd_hwdep mac80211 rmi_core snd_hda_core libarc4 uvcvideo snd_pcm videobuf2_vmalloc btusb videobuf2_memops iwlwifi videobuf2_v4l2 btrtl btbcm videobuf2_common btintel thunderbolt i915 bluetooth mei_me videodev thinkpad_acpi nvram cfg80211 ledtrig_audio mei mc ecdh_generic ecc i2c_algo_bit processor_thermal_device snd_seq_midi drm_kms_helper snd_seq_midi_event intel_soc_dts_iosf syscopyarea sysfillrect snd_rawmidi intel_pch_thermal sysimgblt intel_rapl_common intel_xhci_usb_role_switch fb_sys_fops ucsi_acpi roles cec
[   17.868935]  typec_ucsi typec nxp_nci_i2c snd_seq nxp_nci wmi nci nfc snd_timer snd_seq_device snd int3403_thermal soundcore int340x_thermal_zone video mac_hid int3400_thermal acpi_pad acpi_thermal_rel sch_fq_codel parport_pc ppdev lp parport drm ip_tables x_tables autofs4 btrfs blake2b_generic libcrc32c xor zstd_compress raid6_pq uas usb_storage psmouse e1000e nvme i2c_i801 i2c_smbus nvme_core intel_lpss_pci intel_lpss idma64 virt_dma pinctrl_sunrisepoint pinctrl_intel
[   17.868951] CR2: 000000000000002c
[   17.868953] ---[ end trace ee7716fff5dec2fb ]---
[   17.868955] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
[   17.868957] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
[   17.868958] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
[   17.868959] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000000000000010
[   17.868960] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff917c99b19438
[   17.868961] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff917cbfeae4c0
[   17.868962] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000010
[   17.868963] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff917c99b19470
[   17.868964] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000) knlGS:0000000000000000
[   17.868965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.868966] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00000000003606f0

