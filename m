Return-Path: <linux-integrity+bounces-9535-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHqCDrGMB2rC8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9535-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:14:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DC557B0E
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F4D300D44F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B33ECBE8;
	Fri, 15 May 2026 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh7qIjCV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579903EC2D1
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879655; cv=none; b=GMV9olSzF5Mn1X+onvJDvD0O2YQCmcSGjL9nnfXhi8+t4KZ3HNVeBrRLczXgvi8nGRfB3lJGkS7KaQ2vHyiHhzWSHQoDQk/DsFrfEcl3BXU9Q/BuJ7N336MQAy/vkhB+HAVCHXKAtS6L9u/b4BgvBERsvfra7toUOPqzSyhVPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879655; c=relaxed/simple;
	bh=rFYaUaAT16Cmq71pIwaII1M5sgICxN3WJjU+oZD6zvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8DbAmKXiTQDPSkzI1Q9UCOW6lt32KvLPpi9LJYwx+H5H9fN4hOlNQxW090DQ/RIhSWAQKMez54K1lC05HAFSpE2wkaBQTu/+uZsh6MbOHhZ7Q1y8Okc/bqXsaAjR7GNfVzHiYvebYUQ6aw4Zss6zzN4b9gyRiIizcxP1iNvrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh7qIjCV; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1332772f6b3so283165c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879652; x=1779484452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZWDYSQL0KY9ESsVCDJnFdENr1SKqKscOsf4LFzsjVs=;
        b=Eh7qIjCVEsaKhcH/uTf8ZTh1yNmAdX4amJcXFgk5WpPvfyincAYECewqjQHDXk47Yj
         DtMzo7AP3wKhjTRcQ62aSFvaRoBNJKlfQV21wO6lNJQ0/5sU9M4DpaSC5grOo7TEHxQ6
         fEMLYX+Ea6Juv+TO7vzSTW95oTuDmFumWkqjH8QyISYaJTz5mOwRDh3xx6SwVQEh0suH
         fvdHqrNnkYdfs3Y9YTOtrTj6U+FO+rudKMghwdwhmznPK3MFQvVRSMMSzYO/SNkIpqCL
         0iiPnMIqxLQaDUpm7g8X8gd3uZCEzF4xSHzOZjVsQSFPE1s8pr6Df5Gs5ntr9ytUbCqq
         XGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879652; x=1779484452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZWDYSQL0KY9ESsVCDJnFdENr1SKqKscOsf4LFzsjVs=;
        b=CLQBIAIe9fg6FZvICkHge0x3wqdCB/akDDdV2wZqDa1KsSTbekjuHilnoe8seEDvpw
         1uVi5wqWWkWNY/iT+AVunEP/x/mP7BrDnrg8egb46wXVWXasVLogzTaNjqafiTA7bfqz
         +5Ch9jHLAd5Vl/XVV/W//1TolPDYa48Fjf5+11rJdqzLPEU3SbW3RDSdUNcJxEfVHtXF
         +0rvsPdmSffwwGvnDXlf8SOE5hhOi8gzbfpFVYFAnxXnuTCBHLSPdEjF/6yulmYz90+B
         usE7hs40lBHJutStpbq2c2+oK0dIV812ynb8zCtRmKyJz/8LkIZAlhjzCvIazFJrELWN
         fHAg==
X-Forwarded-Encrypted: i=1; AFNElJ/wvqkkGFKzzs9n3XGrp8O5lBEOtvugzmNcdbLRMdNwTYPh2nfBMPDst8ZNo/YSW/IaEyFDOMOcewLUQNMBdHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyaWC4Aw5tYGHJ1LLWpbM4T5g3wdMTCt4Bzsex0fjrWukM60H
	CdnWnfthACl0HFxnfyub6Ptv+SIt78byPomVirqNx2NKlrJMhDF6hseO
X-Gm-Gg: Acq92OGtnEXQf5f2EG1sSjIDUfvvkTAt5A06BR5ess4/uwkukSqa99czEN34AxqdrJ3
	zeAAYiSvyP6sKXpcEDXIgSEBthXCaFSgT9kxtFhpgc3V9EsjCMm5CX8gsP0F+VnofG3bVJFrjBK
	8wq1XdYfVevcwvJf6v6AyH+atOkBkoCno2zobvjV+lnxZNMULELlowsJB5UoOPkr3fzSot4IQbA
	XhJI5HSTO0KcEzuURWB857jsx2EJCTVHiI9UBSMe2BvToAo3YBLM7RgybuPUp9QRzDrETBX8G8A
	jNjMadZ2I1/udIBKMQUI3nKVfd8y3LbLaxmORING75eRAGucCg2fvnieqlqTkLsd7TIByvTDnu1
	mhRbO93UWlNniOTsy2NGYAV554DZBppfPLr/bo8CsfbksaMm+5cpjr9UGo6bKZSBlQciug2Jshp
	PwypS3+V1U5Ii6tRgwPphALgnYohEXcLw=
X-Received: by 2002:a05:7022:b8f:b0:130:6978:c96 with SMTP id a92af1059eb24-13504738d6cmr2812237c88.19.1778879652253;
        Fri, 15 May 2026 14:14:12 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm11362043c88.5.2026.05.15.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:11 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 00/38] x86: Secure Launch support for Intel TXT
Date: Fri, 15 May 2026 14:13:32 -0700
Message-ID: <20260515211410.31440-1-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C8DC557B0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9535-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
Root of Trust (DRTM) support in the kernel. This is complementary to
better known Static Root of Trust (SRTM) schemes such as UEFI
SecureBoot.

This series provides the common infrastructure along with Intel TXT
support, without needing the tboot exokernel. Support for AMD SKINIT is
pending the common infrastructure getting nailed down, and ARM are
looking to build on it too.

Originally, tboot were approached to see if they'd take support for
other vendors, but they elected not to. Hence this approach instead.

Work is being coordinated by the Trenchboot project,
https://trenchboot.org/, organising Secure Launch support for upstream
open source projects including Grub, iPXE and Xen. The goal of the
Trenchboot project is to make DTRM easy to use, e.g. GRUB adds "slaunch"
as a command in the boot stanza. See
https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide for
more details

Patch set based on commit:
torvalds/master/028ef9c96e96197026887c0f092424679298aae8
(tag: v7.0) Linux 7.0

Finally we would like to thank everyone for their input and
assistance. It has all been very helpful in improving the quality of
our solution and in reviewing/strengthening our security posture.

Thanks
Ross Philipson and Daniel P. Smith

Changes in v16:

 - Moved Secure Launch entry point out of the x86 setup kernel into the
   mainline kernel.
 - Add EFI protocol support for DL stub callback.
 - Add SHA 384/512 PCR extend support.
 - Rewrote Secure Launch kernel documentation.
 - Updated the reorganization of TPM header and buffer related files.
 - TXT early heap parsing support.
 - Corrected commit messages and tag lists per review feedback.
 - Fix code formatting and typos.

Changes in v15:

 - Rewriting and reformatting of the cover letter, commit message and
   code comments per requests from maintainers.
 - Introduction of a early TPM driver in the x86 setup kernel to allow
   TPM extend command very early in the boot.
 - Remove previous TPM extending architecture that attempted to update
   the TPM PCRs later in the boot process.
 - Include set of split up TPM header files to allow TPM driver reuse
   in other environments (e.g. early kernel, x86).
 - Split slaunch.h into 2 files, with a new txt.h. The former contains
   platform agnostic definitions for the SL feature. The new txt.h file
   contains Intel TXT definitions from the public specs.
 - Split TPM headers up following the specifications where the
   technologies are defined.
 - Fix code formatting and typos.

Alec Brown (1):
  tpm: Remove main TPM header from TPM event log header

Ard Biesheuvel (3):
  x86/boot: Slight refactor of the 5 level paging logic
  x86/efistub: EFI stub DRTM support for Secure Launch
  x86/boot: Legacy boot DRTM support for Secure Launch

Daniel P. Smith (9):
  tpm/tpm_tis: Close all localities
  tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
  tpm/tpm_tis: Allow locality to be set to a different value
  tpm/sysfs: Show locality used by kernel
  Documentation/security: Secure Launch kernel documentation
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  x86: Add early SHA-384/512 support for Secure Launch early
    measurements
  x86/slaunch: Secure Launch late initcall platform module

Jarkko Sakkinen (3):
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle()
  tpm-buf: Implement managed allocations

Ross Philipson (22):
  tpm: Initial step to reorganize TPM public headers
  tpm: Move TPM1 specific definitions to the command header
  tpm: Move TPM2 specific definitions to the command header
  tpm: Move TPM common base definitions to the command header
  tpm: Move platform specific definitions to the new PTP header
  tpm-buf: Add TPM buffer support header for standalone reuse
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86/efi: Secure Launch Resource Table EFI definitions header file
  x86: Secure Launch main header file
  x86/txt: Intel Trusted eXecution Technology (TXT) definitions
  lib/crypto: Add SHA1 support for pre-boot environments
  lib/crypto: Add SHA512 support for pre-boot environments
  x86: Allow WARN_trap() macro to be included in pre-boot environments
  x86/msr: Add variable MTRR base/mask and x2apic ID registers
  x86/tpm: Early startup TPM PCR extending driver
  x86/slaunch: Add MLE header and Secure Launch entrypoint to the core
    kernel
  x86/slaunch: Secure Launch kernel early boot initialization
  x86/slaunch: Secure Launch kernel late boot initialization
  x86/slaunch: Secure Launch SMP bringup support
  kexec/slaunch: Secure Launch kexec SEXIT support
  reboot/slaunch: Secure Launch SEXIT support on reboot paths

 Documentation/arch/x86/boot.rst               |   8 +
 Documentation/arch/x86/zero-page.rst          |   1 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |   9 +
 .../launch-integrity/secure_launch.rst        | 681 ++++++++++++++
 arch/x86/Kconfig                              |  15 +
 arch/x86/boot/compressed/Makefile             |   2 +-
 arch/x86/boot/compressed/misc.c               |  55 +-
 arch/x86/boot/compressed/pgtable_64.c         |  18 +-
 arch/x86/boot/startup/Makefile                |   8 +
 arch/x86/boot/startup/exports.h               |   7 +
 arch/x86/boot/startup/lib-sha1.c              |   6 +
 arch/x86/boot/startup/lib-sha256.c            |   6 +
 arch/x86/boot/startup/lib-sha512.c            |   6 +
 arch/x86/boot/startup/sl_main.c               | 638 +++++++++++++
 arch/x86/boot/startup/tpm.h                   |  47 +
 arch/x86/boot/startup/tpm_drv.c               | 567 ++++++++++++
 arch/x86/include/asm/boot.h                   |   4 +
 arch/x86/include/asm/bug.h                    |   8 +-
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/asm/txt.h                    | 281 ++++++
 arch/x86/include/uapi/asm/bootparam.h         |   3 +-
 arch/x86/kernel/Makefile                      |   3 +
 arch/x86/kernel/asm-offsets.c                 |  22 +
 arch/x86/kernel/reboot.c                      |  14 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/sl_stub.S                     | 847 ++++++++++++++++++
 arch/x86/kernel/slaunch.c                     | 619 +++++++++++++
 arch/x86/kernel/slmodule.c                    | 353 ++++++++
 arch/x86/kernel/smpboot.c                     |  47 +-
 arch/x86/kernel/vmlinux.lds.S                 |   5 +
 arch/x86/realmode/init.c                      |   8 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 arch/x86/tools/relocs.c                       |   1 +
 drivers/char/tpm/tpm-buf.c                    | 148 +--
 drivers/char/tpm/tpm-chip.c                   |  35 +-
 drivers/char/tpm/tpm-sysfs.c                  |  31 +-
 drivers/char/tpm/tpm.h                        | 180 ----
 drivers/char/tpm/tpm1-cmd.c                   | 193 ++--
 drivers/char/tpm/tpm2-cmd.c                   | 338 +++----
 drivers/char/tpm/tpm2-sessions.c              | 144 ++-
 drivers/char/tpm/tpm2-space.c                 |  57 +-
 drivers/char/tpm/tpm_tis_core.c               |  24 +-
 drivers/char/tpm/tpm_tis_core.h               |  64 +-
 drivers/char/tpm/tpm_vtpm_proxy.c             |  30 +-
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/efistub.h        |  24 +
 drivers/firmware/efi/libstub/x86-slaunch.c    |  38 +
 drivers/firmware/efi/libstub/x86-stub.c       |  27 +-
 drivers/iommu/intel/dmar.c                    |   4 +
 include/keys/trusted_tpm.h                    |   1 -
 include/linux/slaunch.h                       | 262 ++++++
 include/linux/slr_efi.h                       |  40 +
 include/linux/slr_table.h                     | 339 +++++++
 include/linux/tpm.h                           | 234 +----
 include/linux/tpm_buf.h                       |  57 ++
 include/linux/tpm_command.h                   | 516 ++++++++++-
 include/linux/tpm_eventlog.h                  |   4 +-
 include/linux/tpm_ptp.h                       | 151 ++++
 kernel/kexec_core.c                           |   8 +
 lib/crypto/sha1.c                             |  10 +-
 lib/crypto/sha512.c                           |  10 +-
 security/keys/trusted-keys/trusted_tpm1.c     |  37 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 171 ++--
 66 files changed, 6385 insertions(+), 1129 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch.rst
 create mode 100644 arch/x86/boot/startup/lib-sha1.c
 create mode 100644 arch/x86/boot/startup/lib-sha256.c
 create mode 100644 arch/x86/boot/startup/lib-sha512.c
 create mode 100644 arch/x86/boot/startup/sl_main.c
 create mode 100644 arch/x86/boot/startup/tpm.h
 create mode 100644 arch/x86/boot/startup/tpm_drv.c
 create mode 100644 arch/x86/include/asm/txt.h
 create mode 100644 arch/x86/kernel/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 drivers/firmware/efi/libstub/x86-slaunch.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_efi.h
 create mode 100644 include/linux/slr_table.h
 create mode 100644 include/linux/tpm_buf.h
 create mode 100644 include/linux/tpm_ptp.h

-- 
2.47.3


