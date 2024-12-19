Return-Path: <linux-integrity+bounces-4428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF259F84DD
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 20:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6661893D71
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E01C232B;
	Thu, 19 Dec 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APts5EZ+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791991BCA0C;
	Thu, 19 Dec 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638129; cv=none; b=OgeRj+w6d54GXqorAqK+KHf2XFZAwJNgEvER22TJSJ+v128rCRcz0riYK2nRHarTOWHwNMtNMkCDqoOQ0dGn3pMa1L4V4JzLNsgCT27L5O0uwQEggVSlTmzOOKXiyoznSABQYGrbYdKP66GRjIwuTnECZImXpVdHa17rkyfkaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638129; c=relaxed/simple;
	bh=y1mem4ygG8U8ScHAePZn8EaCgmPalDuv4RXjb6Jdtzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UGwIUulR8C37Gn29L/d/++aNp1HvHmNmARZdj3C9BX+LQNBPVju0+ppZURYv+f8FIQq7GhSy+JE3Rrjpu99wKvOsfYLAIEpgQuCqB7xx7X+1kjLAG27/xcz+LqqLSPVpySD/yRimOBr/gB8QQizZtdLD0gN3t0GZsikwWi+nqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APts5EZ+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMhBi005248;
	Thu, 19 Dec 2024 19:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=PzOIvtEjH+UMr4iz
	9o9TPjgRakHjajDX9RqDPC1QurI=; b=APts5EZ+UthSFR6vKiCxveS/CWI5Sce5
	UmYh1VEcgc8ppgWau3BsLSEHnUNXv6c5cli8G7cpQ5cOjROLj5MgTZ+6z+RmJ2Mz
	Ji/v6wQBbQr55s/FM+6D46TYCeK08qHtAGs++PX0aoh+N+mTh8crogf05D9iC2Ms
	un415hfKDQaFLcHlWpkjCOEsrQwHPsmKDF5xcPXXAjSLEBtwvqr6OeSEiTa1WMUO
	78I46uXP9DOtfvF0DCFhYFZNLCP9JYjbDVc8iGGkT7+YaTxWU9v8Iha8qHHFAWwq
	Kqg4yqZzSiAZzb5YRnb1RsBDG9hTm77HOLEIVgjdnuAD5nLe+QYGCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2ksag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:53:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJJMMxh000719;
	Thu, 19 Dec 2024 19:53:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs27j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:53:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJrUpJ000673;
	Thu, 19 Dec 2024 19:53:30 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs1xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:53:29 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v12 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Thu, 19 Dec 2024 11:41:57 -0800
Message-Id: <20241219194216.152839-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190158
X-Proofpoint-ORIG-GUID: JhnV09FS1FVKN3eBHqC214O-Xz45W_d5
X-Proofpoint-GUID: JhnV09FS1FVKN3eBHqC214O-Xz45W_d5

The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

This patchset provides detailed documentation of DRTM, the approach used for
adding the capbility, and relevant API/ABI documentation. In addition to the
documentation the patch set introduces Intel TXT support as the first platform
for Linux Secure Launch.

A quick note on terminology. The larger open source project itself is called
TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
the use of Dynamic Launch technology is referred to as "Secure Launch" within
the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
in the code. The stub code discussed above is referred to as the SL stub.

The current status of the patch set submission is that it is waiting for
a review by the lib/crypto maintainers.

Links:

The TrenchBoot project including documentation:

https://trenchboot.org

The TrenchBoot project on Github:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

The TrenchBoot project provides a quick start guide to help get a system
up and running with Secure Launch for Linux:

https://github.com/TrenchBoot/documentation/blob/master/QUICKSTART.md

Patch set based on commit:

torvalds/master/f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e

Finally we would like to thank everyone for their input and assistance. It has
all been very helpful in improving the quality of our solution and in
reviewing/strengthening our security posture.

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

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Changes in v5:
 - Comprehensive documentation rewrite.
 - Use boot param loadflags to communicate Secure Launch status to
   kernel proper.
 - Fix incorrect check of X86_FEATURE_BIT_SMX bit.
 - Rename the alternate details and authorities PCR support.
 - Refactor the securityfs directory and file setup in slmodule.c.
 - Misc. cleanup from internal code reviews.
 - Use reverse fir tree format for variables.

Changes in v6:
 - Support for the new Secure Launch Resourse Table that standardizes
   the information passed and forms the ABI between the pre and post
   launch code.
 - Support for booting Linux through the EFI stub entry point and
   then being able to do a Secure Launch once EFI stub is done and EBS
   is called.
 - Updates to the documentation to reflect the previous two items listed.

Changes in v7:
 - Switch to using MONITOR/MWAIT instead of NMIs to park the APs for
   later bringup by the SMP code.
 - Use static inline dummy functions instead of macros when the Secure
   Launch feature is disabled.
 - Move early SHA1 code to lib/crypto and pull it in from there.
 - Numerous formatting fixes from comments on LKML.
 - Remove efi-stub/DL stub patch temporarily for redesign/rework.

Changes in v8:
 - Reintroduce efi-stub Linux kernel booting through the dynamic launch
   stub (DL stub).
 - Add new approach to setting localities > 0 through kernel and sysfs
   interfaces in the TPM mainline driver.
 - General code cleanup from v7 post comments.

Changes in v9:
 - Updated DL stub support for recent changes to EFI stub in the kernel.
 - Added patches to fix locality changing support in the TPM driver
   (these patches originally were posted as a separate set).
 - Enhanced Secure Launch TPM locality 2 setting in the TPM driver.
 - Added locality setting support through sysfs for user land to access.
 - Split up SHA1 and SHA256 changes into separate patches and updated
   the commit messages to be more clear (per request from upstream
   review).
 - Fix Clang compile issues detected by kernel test robot.
 - Modifications to the Secure Launch Resource Table ABI:
   . Use flex arrays in table structures.
   . Update and move fields in tables to make everything 8b aligned.
   . Add 2 new DLME fields and a txt_heap address field.
   . Remove platform specific tables that are not defined yet (AMD/ARM).
 - Update Kconfig dependencies for Secure Launch with SHA1/SHA256/TPM.
 - Remove push/pop of rsi since boot params is now stored in r15.
 - Update outdated kernel documentation.
 - Misc. comment fixes for type-os and mispellings.

Changes in v10:
 - Removed patch #1 from previous set that forced the kernel_info
   section at a fixed offset.
 - Add changes from Ard Biesheuvel to use the link step to generate the
   proper relative offsets for the MLE header in the kernel_info
   section.
 - Fix sizes and alignment slightly in the SLR table. Add comments to
   the SLR header to indicate it is defined by the TrenchBoot project.
 - Remove incorrect extra pop instruction noted in the head_64.S
   changes.
 - Use the prefix tpm/tpm2 to distinguish between TPM versions as is
   done in the rest of the TPM related code.
 - Rework the TPM locality setting/reporting changes to use "default"
   locality as opposed to "preferred". Remove uneeded extra locality
   function in the TPM interface (call the chip function directly).
 - Adopt comment/documentation changes to code and commit message per
   requests from the community.
 - Use u64 for the boot params physical address to avoid truncating
   pointers during casts.
 - Split adding of new MSR registers into its own patch.
 - Attempt to further address justification for using SHA-1 algorithm.
   Pick up some code suggestions for the SHA-1 patch.
 - Introduct slaunch_is_txt_launch() function per Jarkko Sakkinen's
   suggestion.
 - Implement minor changes to the EFI stub code per suggestions.

Changes in v11:
 - Add section to user documents about SHA-1 usage with Secure
   Launch as requested.
 - General cleanup and grammar fixes to the Linux user documentation.
 - Fix use of CONFIG_SECURE_LAUNCH in the EFI stub code to prevent
   32b build failures.
 - Cleanup of early event log handling code.

Changes in v12:
 - Modify the event processing and PCR extending code to cap all unknown
   algorithm bank PCRs and extend the cap digest into those banks/PCRs.
 - Fix documentation to have the correct NIST terminology and document
   links.
 - Switch custom SL vendor specific TPM event types used as markers
   back to type NO_ACTION to allow proper event log parsing.
 - Move boot_params_addr from the TXT heap into the SLRT Intel
   information table to make SLRT architecture specific table usage
   more consistent.
 - Change SL Kconfig dependencies from TCG_TPM to TCG_TIS && TCG_CRB
   to more accurately depend of the underlying TPM driver components.
 - Remove unwanted Unicode characters from documentation and comments
   plus minor documentation fix.

Daniel P. Smith (6):
  Documentation/x86: Secure Launch kernel documentation
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  tpm, tpm_tis: Close all localities
  tpm, tpm_tis: Address positive localities in
    tpm_tis_request_locality()
  x86: Secure Launch late initcall platform module

Ross Philipson (13):
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86/msr: Add variable MTRR base/mask and x2apic ID registers
  x86/boot: Place TXT MLE header in the kernel_info section
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  x86/reboot: Secure Launch SEXIT support on reboot paths
  tpm, tpm_tis: Allow locality to be set to a different value
  tpm, sysfs: Show locality used by kernel
  x86/efi: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 317 ++++++++
 .../secure_launch_details.rst                 | 587 ++++++++++++++
 .../secure_launch_overview.rst                | 252 ++++++
 arch/x86/Kconfig                              |  11 +
 arch/x86/boot/compressed/Makefile             |   3 +
 arch/x86/boot/compressed/head_64.S            |  29 +
 arch/x86/boot/compressed/kernel_info.S        |  50 +-
 arch/x86/boot/compressed/sha1.c               |   6 +
 arch/x86/boot/compressed/sha256.c             |   6 +
 arch/x86/boot/compressed/sl_main.c            | 597 ++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 726 ++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 596 ++++++++++++++
 arch/x86/kernel/slmodule.c                    | 508 ++++++++++++
 arch/x86/kernel/smpboot.c                     |  43 +-
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-chip.c                   |  33 +-
 drivers/char/tpm/tpm-sysfs.c                  |  10 +
 drivers/char/tpm/tpm_tis_core.c               |  18 +-
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |  94 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 547 +++++++++++++
 include/linux/slr_table.h                     | 277 +++++++
 include/linux/tpm.h                           |  10 +
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 40 files changed, 4931 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/sha1.c
 create mode 100644 arch/x86/boot/compressed/sha256.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h

Range-diff v11 -> v12:
-----------------------------------------------

 1:  6e41b99cee53 !  1:  c21b641482ba Documentation/x86: Secure Launch kernel documentation
    @@ Commit message
     
      ## Documentation/security/index.rst ##
     @@ Documentation/security/index.rst: Security Documentation
    -    digsig
         landlock
         secrets/index
    +    ipe
     +   launch-integrity/index
     
      ## Documentation/security/launch-integrity/index.rst (new) ##
    @@ Documentation/security/launch-integrity/index.rst (new)
      ## Documentation/security/launch-integrity/principles.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright © 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +=======================
     +System Launch Integrity
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +launch is, the integrity concern for system launch, and why using a Root of Trust
     +(RoT) from a Dynamic Launch may be desirable. Throughout this document,
     +terminology from the Trusted Computing Group (TCG) and National Institute for
    -+Science and Technology (NIST) is used to ensure that vendor natural language is
    ++Standards and Technology (NIST) is used to ensure that vendor natural language is
     +used to describe and reference security-related concepts.
     +
     +System Launch
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +   launch chain to the final Operating System.
     +
     +:Late Launch: The usage of a dynamic launch by an executing Operating System to
    -+   transition to a “known good” state to perform one or more operations, e.g. to
    ++   transition to a "known good" state to perform one or more operations, e.g. to
     +   launch into a new Operating System.
     +
     +System Integrity
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +    Guarding against improper information modification or destruction, and
     +    includes ensuring information non-repudiation and authenticity.
     +
    -+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
    ++    - NIST Glossary - https://csrc.nist.gov/glossary
     +
     +  mechanism
     +    A process or system that is used to produce a particular result.
     +
    -+    - NIST Special Publication 800-160 (VOLUME 1 ) - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf
    ++    - NIST Special Publication 800-160 (VOLUME 1 ) - https://doi.org/10.6028/NIST.SP.800-160v1r1
     +
     +  risk
     +    A measure of the extent to which an entity is threatened by a potential
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +    that would arise if the circumstance or event occurs; and (ii) the
     +    likelihood of occurrence.
     +
    -+    - NIST SP 800-30 Rev. 1 - https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-30r1.pdf
    ++    - NIST SP 800-30 Rev. 1 - https://doi.org/10.6028/NIST.SP.800-30r1
     +
     +  security mechanism
     +    A device or function designed to provide one or more security services
    @@ Documentation/security/launch-integrity/principles.rst (new)
     +  trust anchor
     +    An authoritative entity for which trust is assumed.
     +
    -+    - NIST SP 800-57 Part 1 Rev. 5 - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf
    ++    - NIST SP 800-57 Part 1 Rev. 5 - https://doi.org/10.6028/NIST.SP.800-57pt1r5
     +
     +  trusted
     +    An element that another element relies upon to fulfill critical
     +    requirements on its behalf.
     +
    -+    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
    ++    - NISTIR 8320A - https://doi.org/10.6028/NIST.IR.8320A
     +
     +  trusted computing base (TCB)
     +    Totality of protection mechanisms within a computer system, including
    @@ Documentation/security/launch-integrity/principles.rst (new)
      ## Documentation/security/launch-integrity/secure_launch_details.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright © 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +===================================
     +Secure Launch Config and Interfaces
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +        struct txt_os_mle_data {
     +                u32 version;
     +                u32 reserved;
    -+                u64 boot_params_addr;
     +                u64 slrt;
     +                u64 txt_info;
     +                u32 ap_wake_block;
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +Field                  Use
     +=====================  ========================================================================
     +version                Structure version, current value 1
    -+boot_params_addr       Physical base address of the Linux boot parameters
     +slrt                   Physical address of the Secure Launch Resource Table
     +txt_info               Pointer into the SLRT for easily locating TXT specific table
     +ap_wake_block          Physical address of the block of memory for parking APs after a launch
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
     +shortage.
     +
     +======  ========================
    -+Name:   SL_ERROR_TPM_NUMBER_ALGS
    ++Name:   SL_ERROR_TPM_INVALID_ALGS
     +Value:  0xc000801f
     +======  ========================
     +
     +Description:
     +
    -+The TPM 2.0 event log reports an unsupported number of hashing algorithms.
    -+Secure launch currently only supports a maximum of two: SHA1 and SHA256.
    ++The TPM 2.0 event log reports either no hashing algorithms, invalid algorithm ID
    ++or an algorithm size larger than the max size recognized by the TPM support code.
     +
     +======  ===========================
    -+Name:   SL_ERROR_TPM_UNKNOWN_DIGEST
    ++Name:   SL_ERROR_TPM_EVENT_COUNT
     +Value:  0xc0008020
     +======  ===========================
     +
     +Description:
     +
    -+The TPM 2.0 event log reports an unsupported hashing algorithm. Secure launch
    -+currently only supports two algorithms: SHA1 and SHA256.
    ++The TPM 2.0 event log contains an event with a digest count that is not equal
    ++to the algorithm count of the overall log. This is an invalid configuration
    ++that could indicate either a bug or a possible attack.
     +
     +======  ==========================
     +Name:   SL_ERROR_TPM_INVALID_EVENT
    @@ Documentation/security/launch-integrity/secure_launch_details.rst (new)
      ## Documentation/security/launch-integrity/secure_launch_overview.rst (new) ##
     @@
     +.. SPDX-License-Identifier: GPL-2.0
    -+.. Copyright © 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
    ++.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
     +
     +======================
     +Secure Launch Overview
 2:  356748240114 !  2:  d3fe72680064 x86: Secure Launch Kconfig
    @@ arch/x86/Kconfig: config EFI_RUNTIME_MAP
      
     +config SECURE_LAUNCH
     +	bool "Secure Launch support"
    -+	depends on X86_64 && X86_X2APIC && TCG_TPM && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
    ++	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
     +	help
     +	   The Secure Launch feature allows a kernel to be loaded
     +	   directly through an Intel TXT measured launch. Intel TXT
 3:  b5c3e85cf78e !  3:  c9f6c26d2b1e x86: Secure Launch Resource Table header file
    @@ include/linux/slr_table.h (new)
     + */
     +struct slr_entry_intel_info {
     +	struct slr_entry_hdr hdr;
    ++	u64 boot_params_addr;
     +	u64 txt_heap;
     +	u64 saved_misc_enable_msr;
     +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
 4:  f6b98edb08ac !  4:  7d8585845365 x86: Secure Launch main header file
    @@ include/linux/slaunch.h (new)
     + * Intel SMX provides a programming interface to establish a Measured Launched
     + * Environment (MLE). The measurement and protection mechanisms supported by the
     + * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
    -+ * the processor’s programming interface in an Intel TXT platform.
    ++ * the processor's programming interface in an Intel TXT platform.
     + *
     + * See:
     + *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
    -+ *   Intel Trusted Execution Technology - Measured Launch Environment Developer’s Guide
    ++ *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
     + */
     +
     +/*
    @@ include/linux/slaunch.h (new)
     +#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
     +#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
     +#define SL_ERROR_EVENTLOG_MAP		0xc000801e
    -+#define SL_ERROR_TPM_NUMBER_ALGS	0xc000801f
    -+#define SL_ERROR_TPM_UNKNOWN_DIGEST	0xc0008020
    ++#define SL_ERROR_TPM_INVALID_ALGS	0xc000801f
    ++#define SL_ERROR_TPM_EVENT_COUNT	0xc0008020
     +#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
     +#define SL_ERROR_INVALID_SLRT		0xc0008022
     +#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
    @@ include/linux/slaunch.h (new)
     +struct txt_os_mle_data {
     +	u32 version;
     +	u32 reserved;
    -+	u64 boot_params_addr;
     +	u64 slrt;
     +	u64 txt_info;
     +	u32 ap_wake_block;
 5:  51af0784cfb8 =  5:  1c3e03777864 x86: Add early SHA-1 support for Secure Launch early measurements
 6:  e17b74de81e7 =  6:  a0f34a29290d x86: Add early SHA-256 support for Secure Launch early measurements
 7:  cd1b2d720620 =  7:  b6d784c0d28b x86/msr: Add variable MTRR base/mask and x2apic ID registers
 8:  9f5903ad386a =  8:  bcad31b804ce x86/boot: Place TXT MLE header in the kernel_info section
 9:  0f1b8a570830 !  9:  506bb834e7bd x86: Secure Launch kernel early boot stub
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +#define SL_TPM_LOG		1
     +#define SL_TPM2_LOG		2
     +
    -+#define SL_TPM2_MAX_ALGS	2
    -+
    -+#define SL_MAX_EVENT_DATA	64
    -+#define SL_TPM_LOG_SIZE		(sizeof(struct tcg_pcr_event) + \
    -+				SL_MAX_EVENT_DATA)
    -+#define SL_TPM2_LOG_SIZE	(sizeof(struct tcg_pcr_event2_head) + \
    -+				SHA1_DIGEST_SIZE + SHA256_DIGEST_SIZE + \
    -+				sizeof(struct tcg_event_field) + \
    -+				SL_MAX_EVENT_DATA)
    -+
     +static void *evtlog_base;
     +static u32 evtlog_size;
     +static struct txt_heap_event_log_pointer2_1_element *log21_elem;
     +static u32 tpm_log_ver = SL_TPM_LOG;
    -+static struct tcg_efi_specid_event_algs tpm_algs[SL_TPM2_MAX_ALGS] = {0};
    ++static u32 tpm_num_algs;
    ++static struct tcg_efi_specid_event_algs *tpm_algs;
    ++static u8 event_buf[PAGE_SIZE];
     +
     +extern u32 sl_cpu_type;
     +extern u32 sl_mle_start;
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +static void sl_find_event_log_algorithms(void)
     +{
     +	struct tcg_efi_specid_event_head *efi_head =
    -+		(struct tcg_efi_specid_event_head *)(evtlog_base +
    -+					log21_elem->first_record_offset +
    -+					sizeof(struct tcg_pcr_event));
    ++		(struct tcg_efi_specid_event_head *)(evtlog_base + sizeof(struct tcg_pcr_event));
    ++	u32 i;
    ++
    ++	if (efi_head->num_algs == 0)
    ++		sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
     +
    -+	if (efi_head->num_algs == 0 || efi_head->num_algs > SL_TPM2_MAX_ALGS)
    -+		sl_txt_reset(SL_ERROR_TPM_NUMBER_ALGS);
    ++	tpm_algs = &efi_head->digest_sizes[0];
    ++	tpm_num_algs = efi_head->num_algs;
     +
    -+	memcpy(&tpm_algs[0], &efi_head->digest_sizes[0],
    -+	       sizeof(struct tcg_efi_specid_event_algs) * efi_head->num_algs);
    ++	for (i = 0; i < tpm_num_algs; i++) {
    ++		if (tpm_algs[i].digest_size > TPM_MAX_DIGEST_SIZE)
    ++			sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
    ++		/* Alg ID 0 is invalid and maps to TPM_ALG_ERROR */
    ++		if (tpm_algs[i].alg_id == TPM_ALG_ERROR)
    ++			sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
    ++	}
     +}
     +
     +static void sl_tpm_log_event(u32 pcr, u32 event_type,
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +			     const u8 *event_data, u32 event_size)
     +{
     +	u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
    -+	u8 log_buf[SL_TPM_LOG_SIZE] = {0};
     +	struct tcg_pcr_event *pcr_event;
     +	u32 total_size;
     +
    -+	pcr_event = (struct tcg_pcr_event *)log_buf;
    ++	/* Clear on each use */
    ++	memset(event_buf, 0, PAGE_SIZE);
    ++
    ++	pcr_event = (struct tcg_pcr_event *)event_buf;
     +	pcr_event->pcr_idx = pcr;
     +	pcr_event->event_type = event_type;
     +	if (length > 0) {
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +			      const u8 *data, u32 length,
     +			      const u8 *event_data, u32 event_size)
     +{
    -+	u8 sha256_hash[SHA256_DIGEST_SIZE] = {0};
    -+	u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
    -+	u8 log_buf[SL_TPM2_LOG_SIZE] = {0};
     +	struct sha256_state sctx256 = {0};
     +	struct tcg_pcr_event2_head *head;
     +	struct tcg_event_field *event;
    ++	u8 digest[TPM_MAX_DIGEST_SIZE];
     +	u32 total_size, alg_idx;
     +	u16 *alg_ptr;
     +	u8 *dgst_ptr;
     +
    -+	head = (struct tcg_pcr_event2_head *)log_buf;
    ++	/* Clear on each use */
    ++	memset(event_buf, 0, PAGE_SIZE);
    ++
    ++	head = (struct tcg_pcr_event2_head *)event_buf;
     +	head->pcr_idx = pcr;
     +	head->event_type = event_type;
     +	total_size = sizeof(*head);
    -+	alg_ptr = (u16 *)(log_buf + sizeof(*head));
    ++	alg_ptr = (u16 *)(event_buf + sizeof(*head));
     +
    -+	for (alg_idx = 0; alg_idx < SL_TPM2_MAX_ALGS; alg_idx++) {
    -+		if (!tpm_algs[alg_idx].alg_id)
    -+			break;
    ++	for (alg_idx = 0; alg_idx < tpm_num_algs; alg_idx++) {
    ++		memset(digest, 0, TPM_MAX_DIGEST_SIZE);
     +
     +		*alg_ptr = tpm_algs[alg_idx].alg_id;
     +		dgst_ptr = (u8 *)alg_ptr + sizeof(u16);
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +		if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA256) {
     +			sha256_init(&sctx256);
     +			sha256_update(&sctx256, data, length);
    -+			sha256_final(&sctx256, &sha256_hash[0]);
    -+			memcpy(dgst_ptr, &sha256_hash[0], SHA256_DIGEST_SIZE);
    -+			total_size += SHA256_DIGEST_SIZE + sizeof(u16);
    -+			alg_ptr = (u16 *)((u8 *)alg_ptr + SHA256_DIGEST_SIZE + sizeof(u16));
    ++			sha256_final(&sctx256, &digest[0]);
     +		} else if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA1) {
    -+			sha1(data, length, &sha1_hash[0]);
    -+			memcpy(dgst_ptr, &sha1_hash[0], SHA1_DIGEST_SIZE);
    -+			total_size += SHA1_DIGEST_SIZE + sizeof(u16);
    -+			alg_ptr = (u16 *)((u8 *)alg_ptr + SHA1_DIGEST_SIZE + sizeof(u16));
    ++			sha1(data, length, &digest[0]);
     +		} else {
    -+			sl_txt_reset(SL_ERROR_TPM_UNKNOWN_DIGEST);
    ++			/*
    ++			 * If there are TPM banks in use that are not supported
    ++			 * in software here, the PCR in that bank will be capped with
    ++			 * the well-known value 1 as the Intel ACM does.
    ++			 */
    ++			digest[0] = 0x01;
     +		}
     +
    ++		memcpy(dgst_ptr, &digest[0], tpm_algs[alg_idx].digest_size);
    ++		total_size += tpm_algs[alg_idx].digest_size + sizeof(u16);
    ++		alg_ptr = (u16 *)((u8 *)alg_ptr + tpm_algs[alg_idx].digest_size + sizeof(u16));
    ++
     +		head->count++;
     +	}
     +
    -+	event = (struct tcg_event_field *)(log_buf + total_size);
    ++	event = (struct tcg_event_field *)(event_buf + total_size);
     +	event->event_size = event_size;
     +	if (event_size > 0)
     +		memcpy((u8 *)event + sizeof(*event), event_data, event_size);
     +	total_size += sizeof(*event) + event_size;
     +
    -+	if (tpm2_log_event(log21_elem, evtlog_base, evtlog_size, total_size, &log_buf[0]))
    ++	if (tpm2_log_event(log21_elem, evtlog_base, evtlog_size, total_size, &event_buf[0]))
     +		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
     +}
     +
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +{
     +	struct slr_table *slrt = (struct slr_table *)entry->entity;
     +	struct slr_entry_intel_info *intel_info;
    ++	struct slr_entry_intel_info intel_tmp;
     +
     +	/*
     +	 * In revision one of the SLRT, the only table that needs to be
    @@ arch/x86/boot/compressed/sl_main.c (new)
     +		if (!intel_info)
     +			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
     +
    ++		/*
    ++		 * Make a temp copy and zero out address fields since they should
    ++		 * not be measured.
    ++		 */
    ++		intel_tmp = *intel_info;
    ++		intel_tmp.boot_params_addr = 0;
    ++		intel_tmp.txt_heap = 0;
    ++
     +		sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
    -+				     (void *)entry->entity, sizeof(*intel_info),
    ++				     (void *)&intel_tmp, sizeof(*intel_info),
     +				     entry->evt_info);
     +	}
     +}
    @@ arch/x86/boot/compressed/sl_stub.S (new)
     +	movl	$0, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
     +	movl	$0xffffffff, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ESTS)
     +
    -+	/* On Intel, the zero page address is passed in the TXT heap */
    -+	/* Read physical base of heap into EAX */
    ++	/* Read physical base of the TXT heap into %eax */
     +	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
     +	/* Read the size of the BIOS data into ECX (first 8 bytes) */
     +	movl	(%eax), %ecx
    @@ arch/x86/boot/compressed/sl_stub.S (new)
     +	call	sl_txt_verify_os_mle_struct
     +
     +	/*
    -+	 * Get the boot params address from the heap. Note %esi and %ebx MUST
    -+	 * be preserved across calls and operations.
    ++	 * Get the boot params address from the TXT info table in the SLRT.
    ++	 * Note %esi and %ebx MUST be preserved across calls and operations.
     +	 */
    -+	movl	SL_boot_params_addr(%eax), %esi
    ++	movl	SL_txt_info(%eax), %edi
    ++	movl	SL_boot_params_addr(%edi), %esi
     +
     +	/* Save %ebx so the APs can find their way home */
     +	movl	%ebx, (SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax)
    @@ arch/x86/kernel/asm-offsets.c: static void __used common(void)
     +	BLANK();
     +	OFFSET(SL_txt_info, txt_os_mle_data, txt_info);
     +	OFFSET(SL_mle_scratch, txt_os_mle_data, mle_scratch);
    -+	OFFSET(SL_boot_params_addr, txt_os_mle_data, boot_params_addr);
     +	OFFSET(SL_ap_wake_block, txt_os_mle_data, ap_wake_block);
     +	OFFSET(SL_ap_wake_block_size, txt_os_mle_data, ap_wake_block_size);
    ++	OFFSET(SL_boot_params_addr, slr_entry_intel_info, boot_params_addr);
     +	OFFSET(SL_saved_misc_enable_msr, slr_entry_intel_info, saved_misc_enable_msr);
     +	OFFSET(SL_saved_bsp_mtrrs, slr_entry_intel_info, saved_bsp_mtrrs);
     +	OFFSET(SL_num_logical_procs, txt_bios_data, num_logical_procs);
10:  a27c2e81b671 = 10:  adf97523eef7 x86: Secure Launch kernel late boot stub
11:  958ba468a362 ! 11:  00625a3db74f x86: Secure Launch SMP bringup support
    @@ arch/x86/include/asm/realmode.h: struct real_mode_header {
     
      ## arch/x86/kernel/smpboot.c ##
     @@
    - #include <linux/stackprotector.h>
      #include <linux/cpuhotplug.h>
      #include <linux/mc146818rtc.h>
    + #include <linux/acpi.h>
     +#include <linux/slaunch.h>
      
      #include <asm/acpi.h>
12:  2a041cad971f = 12:  f3b926ea6881 kexec: Secure Launch kexec SEXIT support
13:  9959392ce545 = 13:  309f73b37d82 x86/reboot: Secure Launch SEXIT support on reboot paths
14:  7630caf73735 <  -:  ------------ tpm: Protect against locality counter underflow
15:  70cffe579cf0 ! 14:  59dd2c48d085 tpm: Ensure tpm is in known state at startup
    @@ Metadata
     Author: Daniel P. Smith <dpsmith@apertussolutions.com>
     
      ## Commit message ##
    -    tpm: Ensure tpm is in known state at startup
    +    tpm, tpm_tis: Close all localities
     
    -    When tis_tis_core initializes, it assumes all localities are closed. There
    -    are cases when this may not be the case. This commit addresses this by
    -    ensuring all localities are closed before initializing begins.
    +    There are environments, for example, those that comply with the TCG D-RTM
    +    specification that requires the TPM to be left in locality 2. Prepare
    +    kernel for such environments by closing all the localities.
     
         Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
         Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
    +    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
     
      ## drivers/char/tpm/tpm_tis_core.c ##
     @@ drivers/char/tpm/tpm_tis_core.c: int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
16:  28557bbcc319 <  -:  ------------ tpm: Make locality requests return consistent values
17:  b45e3280d708 <  -:  ------------ tpm: Add ability to set the default locality the TPM chip uses
18:  8586e0e18743 <  -:  ------------ tpm: Add sysfs interface to allow setting and querying the default locality
 -:  ------------ > 15:  fd1eaa6970ce tpm, tpm_tis: Address positive localities in tpm_tis_request_locality()
 -:  ------------ > 16:  ed163188e807 tpm, tpm_tis: Allow locality to be set to a different value
 -:  ------------ > 17:  563c8f0ceac5 tpm, sysfs: Show locality used by kernel
19:  a74134ba0f24 ! 18:  341cb25e4cd0 x86: Secure Launch late initcall platform module
    @@ arch/x86/kernel/slmodule.c (new)
     +static void *txt_heap;
     +static struct txt_heap_event_log_pointer2_1_element *evtlog21;
     +static DEFINE_MUTEX(sl_evt_log_mutex);
    ++static struct tcg_efi_specid_event_head *efi_head;
     +
     +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
     +			      size_t count, loff_t *pos)
    @@ arch/x86/kernel/slmodule.c (new)
     +	if (!evtlog21)
     +		slaunch_txt_reset(txt, "Error failed to find TPM20 event log element\n",
     +				  SL_ERROR_TPM_INVALID_LOG20);
    ++
    ++	/* Save pointer to the EFI SpecID log header */
    ++	efi_head = (struct tcg_efi_specid_event_head *)(sl_evtlog.addr + sizeof(struct tcg_pcr_event));
     +}
     +
     +static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
    @@ arch/x86/kernel/slmodule.c (new)
     +	u16 *alg_id_field = (u16 *)((u8 *)event + sizeof(*event));
     +	struct tpm_digest *digests;
     +	u8 *dptr;
    -+	u32 i, j;
     +	int ret;
    ++	u32 i;
     +
    -+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
    -+			  GFP_KERNEL);
    ++	/*
    ++	 * Early SL code ensured the TPM algorithm information passed via
    ++	 * the log is valid. Small sanity check here.
    ++	 */
    ++	if (event->count != efi_head->num_algs)
    ++		slaunch_txt_reset(txt, "Event digest count mismatch with event log\n",
    ++				  SL_ERROR_TPM_EVENT_COUNT);
    ++
    ++	digests = kzalloc(efi_head->num_algs * sizeof(*digests), GFP_KERNEL);
     +	if (!digests)
     +		slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
     +				  SL_ERROR_GENERIC);
     +
    -+	for (i = 0; i < tpm->nr_allocated_banks; i++)
    -+		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
    -+
    -+	/* Early SL code ensured there was a max count of 2 digests */
     +	for (i = 0; i < event->count; i++) {
     +		dptr = (u8 *)alg_id_field + sizeof(u16);
     +
    -+		for (j = 0; j < tpm->nr_allocated_banks; j++) {
    -+			if (digests[j].alg_id != *alg_id_field)
    -+				continue;
    -+
    -+			switch (digests[j].alg_id) {
    -+			case TPM_ALG_SHA256:
    -+				memcpy(&digests[j].digest[0], dptr,
    -+				       SHA256_DIGEST_SIZE);
    -+				alg_id_field = (u16 *)((u8 *)alg_id_field +
    -+					SHA256_DIGEST_SIZE + sizeof(u16));
    -+				break;
    -+			case TPM_ALG_SHA1:
    -+				memcpy(&digests[j].digest[0], dptr,
    -+				       SHA1_DIGEST_SIZE);
    -+				alg_id_field = (u16 *)((u8 *)alg_id_field +
    -+					SHA1_DIGEST_SIZE + sizeof(u16));
    -+				break;
    -+			default:
    -+				break;
    -+			}
    -+		}
    ++		/* Setup each digest for the extend */
    ++		digests[i].alg_id = efi_head->digest_sizes[i].alg_id;
    ++		memcpy(&digests[i].digest[0], dptr,
    ++			efi_head->digest_sizes[i].digest_size);
    ++
    ++		alg_id_field = (u16 *)((u8 *)alg_id_field + sizeof(u16) +
    ++				efi_head->digest_sizes[i].digest_size);
     +	}
     +
     +	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
    @@ arch/x86/kernel/slmodule.c (new)
     +
     +		/*
     +		 * Marker events indicate where the Secure Launch early stub
    -+		 * started and ended adding post launch events.
    ++		 * started and ended adding post launch events. As they are
    ++		 * encountered, switch the event type to NO_ACTION so they
    ++		 * ignored in when the event log is processed since they are
    ++		 * not really measurements.
     +		 */
     +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
    ++			event->event_type = NO_ACTION;
     +			end = 1;
     +			break;
     +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
    ++			event->event_type = NO_ACTION;
     +			start = 1;
     +			goto next;
     +		}
    @@ arch/x86/kernel/slmodule.c (new)
     +		size = sizeof(*event) + event->event_size;
     +
     +		/*
    -+		 * Marker events indicate where the Secure Launch early stub
    -+		 * started and ended adding post launch events.
    ++		 * See comments in slaunch_tpm2_extend() concerning these special
    ++		 * event types.
     +		 */
     +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
    ++			event->event_type = NO_ACTION;
     +			end = 1;
     +			break;
     +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
    ++			event->event_type = NO_ACTION;
     +			start = 1;
     +			goto next;
     +		}
    @@ arch/x86/kernel/slmodule.c (new)
     +static void slaunch_pcr_extend(void __iomem *txt)
     +{
     +	struct tpm_chip *tpm;
    ++	int rc;
     +
     +	tpm = tpm_default_chip();
     +	if (!tpm)
     +		slaunch_txt_reset(txt, "Could not get default TPM chip\n",
     +				  SL_ERROR_TPM_INIT);
     +
    -+	if (!tpm_chip_set_default_locality(tpm, 2))
    ++	rc = tpm_chip_set_locality(tpm, 2);
    ++	if (rc)
     +		slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
     +				  SL_ERROR_TPM_INIT);
     +
    @@ arch/x86/kernel/slmodule.c (new)
     +		slaunch_tpm2_extend(tpm, txt);
     +	else
     +		slaunch_tpm_extend(tpm, txt);
    -+
    -+	tpm_chip_set_default_locality(tpm, 0);
     +}
     +
     +static int __init slaunch_module_init(void)
20:  55bf8030593b ! 19:  78ad72b83303 x86/efi: EFI stub DRTM launch support for Secure Launch
    @@ drivers/firmware/efi/libstub/x86-stub.c: static efi_status_t efi_decompress_kern
     +{
     +	struct slr_entry_intel_info *txt_info;
     +	struct slr_entry_policy *policy;
    -+	struct txt_os_mle_data *os_mle;
     +	bool updated = false;
     +	int i;
     +
    @@ drivers/firmware/efi/libstub/x86-stub.c: static efi_status_t efi_decompress_kern
     +	if (!txt_info)
     +		return false;
     +
    -+	os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
    -+	if (!os_mle)
    -+		return false;
    -+
    -+	os_mle->boot_params_addr = (u64)boot_params;
    ++	txt_info->boot_params_addr = (u64)boot_params;
     +
     +	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
     +	if (!policy)

-- 
2.39.3


