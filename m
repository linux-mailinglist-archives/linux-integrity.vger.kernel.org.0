Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEE3ACFFC
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhFRQKM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:10:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21648 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhFRQJw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG0sSL005128;
        Fri, 18 Jun 2021 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=cZtN+8nwtoxzhypWMGF1iqcvE3f3HnWCGtPwWI8XDW4=;
 b=x1D8TcHCTJNefN2K5hbMyHjXlF1f+b65shWXgPtY260zKpZHmZ5PiSEx/J4sg6n/W2J/
 ynDNa6bn1hPMnOavDvBVgox82u3/nzM5mS6Oo6WbBQ5WAxW3vm/6sfJCgXsaKOwucI3o
 SQw9zyLrTP/lq7Vjyq4h0hsgT9w9H4U7TcI2lWwGzUxdaMeQHMmjnu/ci4/t/iRwpecG
 jiYKo3l4NbfArpFW9rbIgLU6fY43fWgdNkgqsTGkqQ7t1ZzBR5aXdt/OAyObDGF4xT4r
 M1yBMPPyq1c4H2lWEPeX/ek0Qu6EXUA43hb1MpTRGcqcQaJO24TWiZONQK7aenn3yEEU cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptmbhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1Hbf173276;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 396way763w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG6s8f014307;
        Fri, 18 Jun 2021 16:06:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 396way7622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15IG6iP0011853;
        Fri, 18 Jun 2021 16:06:44 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:44 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 00/12] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Fri, 18 Jun 2021 12:12:45 -0400
Message-Id: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: kfnuDuVbn0NqkP9qJ6fRNWohmbPfUOk1
X-Proofpoint-ORIG-GUID: kfnuDuVbn0NqkP9qJ6fRNWohmbPfUOk1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The focus of Trechboot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity. This requires the linux kernel
to be directly invoked by x86 Dynamic launch measurements to establish
Dynamic Root of Trust for Measurement (DRTM). The dynamic launch will
be initiated by a boot loader with associated support added to it, for
example the first targeted boot loader will be GRUB2. An integral part of
establishing the DRTM involves measuring everything that is intended to
be run (kernel image, initrd, etc) and everything that will configure
that kernel to run (command line, boot params, etc) into specific PCRs,
the DRTM PCRs (17-22), in the TPM. Another key aspect is the dynamic
launch is rooted in hardware, that is to say the hardware (CPU) is what
takes the first measurement for the chain of integrity measurements. On
Intel this is done using the GETSEC instruction provided by Intel's TXT
and the SKINIT instruction provided by AMD's AMD-V. Information on these
technologies can be readily found online. This patchset introduces Intel
TXT support.

To enable the kernel to be launched by GETSEC, a stub must be built
into the setup section of the compressed kernel to handle the specific
state that the dynamic launch process leaves the BSP in. Also this stub
must measure everything that is going to be used as early as possible.
This stub code and subsequent code must also deal with the specific
state that the dynamic launch leaves the APs in.

A quick note on terminology. The larger open source project itself is
called Trenchboot, which is hosted on Github (links below). The kernel
feature enabling the use of the x86 technology is referred to as "Secure
Launch" within the kernel code. As such the prefixes sl_/SL_ or
slaunch/SLAUNCH will be seen in the code. The stub code discussed above
is referred to as the SL stub.

Note that patch 1 was authored by Arvind Sankar. We were not able to get
a status on this patch but Secure Launch depends on it so it is included
with the set.

The basic flow is:

 - Entry from the dynamic launch jumps to the SL stub
 - SL stub fixes up the world on the BSP
 - For TXT, SL stub wakes the APs, fixes up their worlds
 - For TXT, APs are left halted waiting for an NMI to wake them
 - SL stub jumps to startup_32
 - SL main locates the TPM event log and writes the measurements of
   configuration and module information into it.
 - Kernel boot proceeds normally from this point.
 - During early setup, slaunch_setup() runs to finish some validation
   and setup tasks.
 - The SMP bringup code is modified to wake the waiting APs. APs vector
   to rmpiggy and start up normally from that point.
 - SL platform module is registered as a late initcall module. It reads
   the TPM event log and extends the measurements taken into the TPM PCRs.
 - SL platform module initializes the securityfs interface to allow
   asccess to the TPM event log and TXT public registers.
 - Kernel boot finishes booting normally
 - SEXIT support to leave SMX mode is present on the kexec path and
   the various reboot paths (poweroff, reset, halt).

Links:

The Trenchboot project including documentation:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

GRUB2 pre-launch support patchset (WIP):

https://lists.gnu.org/archive/html/grub-devel/2020-05/msg00011.html

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (9):
  x86: Secure Launch Kconfig
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch
  iommu: Do not allow IOMMU passthrough with Secure Launch

 Documentation/x86/boot.rst              |  13 +
 arch/x86/Kconfig                        |  32 ++
 arch/x86/boot/compressed/Makefile       |   3 +
 arch/x86/boot/compressed/early_sha1.c   | 103 +++++
 arch/x86/boot/compressed/early_sha1.h   |  17 +
 arch/x86/boot/compressed/early_sha256.c |   7 +
 arch/x86/boot/compressed/head_64.S      |  37 ++
 arch/x86/boot/compressed/kaslr.c        |  11 +
 arch/x86/boot/compressed/kernel_info.S  |  52 ++-
 arch/x86/boot/compressed/kernel_info.h  |  12 +
 arch/x86/boot/compressed/sl_main.c      | 523 +++++++++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S      | 667 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +
 arch/x86/include/asm/realmode.h         |   3 +
 arch/x86/kernel/Makefile                |   2 +
 arch/x86/kernel/asm-offsets.c           |  19 +
 arch/x86/kernel/reboot.c                |  10 +
 arch/x86/kernel/setup.c                 |   3 +
 arch/x86/kernel/slaunch.c               | 543 ++++++++++++++++++++++++++
 arch/x86/kernel/slmodule.c              | 495 ++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c               |  86 ++++
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/trampoline_64.S    |  37 ++
 drivers/char/tpm/tpm-chip.c             |  13 +-
 drivers/iommu/intel/dmar.c              |   4 +
 drivers/iommu/intel/iommu.c             |   5 +
 drivers/iommu/iommu.c                   |   6 +-
 include/linux/slaunch.h                 | 540 ++++++++++++++++++++++++++
 kernel/kexec_core.c                     |   4 +
 lib/crypto/sha256.c                     |   8 +
 lib/sha1.c                              |   4 +
 31 files changed, 3261 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/kernel_info.h
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h

-- 
1.8.3.1

