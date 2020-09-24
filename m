Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532AD2774BA
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgIXPCJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 11:02:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60638 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPCI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 11:02:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OF062S123345;
        Thu, 24 Sep 2020 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=cELzVuMzCPT3axjaAeiEoxE5gCcx4JGS/89qgFwwGjc=;
 b=dJZAnOWHg7MuyRDw+xyXx9dYFAt67GAK28MGWTMHNeQaJuAAhC4nRWLIVbDvexjWcwga
 kFyFy4k4gQBiv+DVLi+56UBgJtbn/H2TVUXcHkA0I17daxAXRcTjwkgQLCXhU+Dc3qxp
 MQILaP4wqnAtRewoOW5OO5V2mZE0fX0FzNmmc5jTJ/LpElcZPCzlJY3pRLTVhVDTPxBB
 tJeCzMJ1basCoNJHFwY8KQ+1ZGpfwIzsBQZf5l0PzS8ZEtUk8zC+FcvA3YMOw3agzOyI
 BKtyddq9PRnrSTeLYDmAc4RxhlMuH2krmAcnjixiVhZejRV43sn5vs80uHNMdGXddzvg rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33qcpu5qqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 15:00:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEu93S177146;
        Thu, 24 Sep 2020 14:58:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33r28x3vg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OEw7CH022535;
        Thu, 24 Sep 2020 14:58:07 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:07 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 00/13] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Thu, 24 Sep 2020 10:58:28 -0400
Message-Id: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Trenchboot project focus on boot security has led to the enabling of
the Linux kernel to be directly invocable by the x86 Dynamic Launch
instruction(s) for establishing a Dynamic Root of Trust for Measurement
(DRTM). The dynamic launch will be initiated by a boot loader with
associated support added to it, for example the first targeted boot
loader will be GRUB2. An integral part of establishing the DRTM involves
measuring everything that is intended to be run (kernel image, initrd,
etc) and everything that will configure that kernel to run (command
line, boot params, etc) into specific PCRs, the DRTM PCRs (17-22), in
the TPM. Another key aspect is the dynamic launch is rooted in hardware,
that is to say the hardware (CPU) is what takes the first measurement
for the chain of integrity measurements. On Intel this is done using
the GETSEC instruction provided by Intel's TXT and the SKINIT
instruction provided by AMD's AMD-V. Information on these technologies
can be readily found online. This patchset introduces Intel TXT support.

To enable the kernel to be launched by GETSEC, a stub must be built
into the setup section of the compressed kernel to handle the specific
state that the dynamic launch process leaves the BSP in. This is
analogous to the EFI stub that is found in the same area. Also this stub
must measure everything that is going to be used as early as possible.
This stub code and subsequent code must also deal with the specific
state that the dynamic launch leaves the APs in.

A quick note on terminology. The larger open source project itself is
called Trenchboot, which is hosted on Github (links below). The kernel
feature enabling the use of the x86 technology is referred to as "Secure
Launch" within the kernel code. As such the prefixes sl_/SL_ or
slaunch/SLAUNCH will be seen in the code. The stub code discussed above
is referred to as the SL stub.

The basic flow is:

 - Entry from the dynamic launch jumps to the SL stub
 - SL stub fixes up the world on the BSP
 - For TXT, SL stub wakes the APs, fixes up their worlds
 - For TXT, APs are left halted waiting for an NMI to wake them
 - SL stub jumps to startup_32
 - SL main runs to measure configuration and module information into the
   DRTM PCRs. It also locates the TPM event log.
 - Kernel boot proceeds normally from this point.
 - During early setup, slaunch_setup() runs to finish some validation
   and setup tasks.
 - The SMP bringup code is modified to wake the waiting APs. APs vector
   to rmpiggy and start up normally from that point.
 - Kernel boot finishes booting normally
 - SL securityfs module is present to allow reading and writing of the
   TPM event log.
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

Daniel P. Smith (4):
  x86: Add early TPM TIS/CRB interface support for Secure Launch
  x86: Add early TPM1.2/TPM2.0 interface support for Secure Launch
  x86: Add early general TPM interface support for Secure Launch
  x86: Secure Launch adding event log securityfs

Ross Philipson (9):
  x86: Secure Launch Kconfig
  x86: Secure Launch main header file
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch

 Documentation/x86/boot.rst                    |   9 +
 arch/x86/Kconfig                              |  36 ++
 arch/x86/boot/compressed/Makefile             |   8 +
 arch/x86/boot/compressed/early_sha1.c         | 104 ++++
 arch/x86/boot/compressed/early_sha1.h         |  17 +
 arch/x86/boot/compressed/early_sha256.c       |   6 +
 arch/x86/boot/compressed/early_sha512.c       |   6 +
 arch/x86/boot/compressed/head_64.S            |  34 +
 arch/x86/boot/compressed/kernel_info.S        |   7 +
 arch/x86/boot/compressed/sl_main.c            | 390 ++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 606 ++++++++++++++++++
 arch/x86/boot/compressed/tpm/crb.c            | 304 +++++++++
 arch/x86/boot/compressed/tpm/crb.h            |  20 +
 arch/x86/boot/compressed/tpm/tis.c            | 215 +++++++
 arch/x86/boot/compressed/tpm/tis.h            |  46 ++
 arch/x86/boot/compressed/tpm/tpm.c            | 145 +++++
 arch/x86/boot/compressed/tpm/tpm.h            |  48 ++
 arch/x86/boot/compressed/tpm/tpm1.h           | 112 ++++
 arch/x86/boot/compressed/tpm/tpm1_cmds.c      |  99 +++
 arch/x86/boot/compressed/tpm/tpm2.h           |  89 +++
 arch/x86/boot/compressed/tpm/tpm2_auth.c      |  44 ++
 arch/x86/boot/compressed/tpm/tpm2_auth.h      |  21 +
 arch/x86/boot/compressed/tpm/tpm2_cmds.c      | 145 +++++
 arch/x86/boot/compressed/tpm/tpm2_constants.h |  66 ++
 arch/x86/boot/compressed/tpm/tpm_buff.c       | 121 ++++
 arch/x86/boot/compressed/tpm/tpm_common.h     | 127 ++++
 arch/x86/boot/compressed/tpm/tpmbuff.h        |  34 +
 arch/x86/boot/compressed/tpm/tpmio.c          |  51 ++
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/asm-offsets.c                 |  16 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 856 ++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c                     |  86 +++
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  37 ++
 drivers/char/tpm/tpm-chip.c                   |  13 +-
 drivers/iommu/intel/dmar.c                    |   4 +
 include/linux/sha512.h                        |  21 +
 include/linux/slaunch.h                       | 544 ++++++++++++++++
 kernel/kexec_core.c                           |   4 +
 lib/sha1.c                                    |   4 +
 lib/sha512.c                                  | 209 +++++++
 44 files changed, 4722 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/early_sha512.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/boot/compressed/tpm/crb.c
 create mode 100644 arch/x86/boot/compressed/tpm/crb.h
 create mode 100644 arch/x86/boot/compressed/tpm/tis.c
 create mode 100644 arch/x86/boot/compressed/tpm/tis.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_constants.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_buff.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_common.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmbuff.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmio.c
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 include/linux/sha512.h
 create mode 100644 include/linux/slaunch.h
 create mode 100644 lib/sha512.c

-- 
1.8.3.1

