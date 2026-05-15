Return-Path: <linux-integrity+bounces-9572-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GVTJ+2PB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9572-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:28:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E49558171
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CA903075698
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD517405C35;
	Fri, 15 May 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0EnfCoh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A840C5DE
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879760; cv=none; b=Q71J2Z/UJfVSWRwzf+Cl/u6OZi0JZyZK5L15/ZJG2vJuKUqR6VhRwBaGHy85X4jNtoaX0l6nJoDLI5aG729rAbX7lAyuTuI8UOtjGMVz7elXrPmJz4wEYKHAQAP1UtCMp4CJSnYhCsy6x0Zb5EypNvPVtc7qfpBfMRkveNZ97HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879760; c=relaxed/simple;
	bh=UwbTsginbKatRYw5xm/hcVI6EpyOnfrhKVxHAkEoevA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKUYBCPT0/3/Wf1Ctg0Re7TWf7kOS02xr/T1LAx096H+OXcoN3S/O22C8DCe8aP8P5JdVVVO3qAh8l6f3ABasJdo93p3YYxVcMQWAJvS6KFtEqkzR0+001p3Cd14SZp36ckcRgONb8RFAVVdHNvFqIKWQjBr8c1Aif2dF3a9hxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0EnfCoh; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f30a4601bbso285830eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879758; x=1779484558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh0gWGTCHr3HLLSp6B0/bzede+AfJuos48AZ5KwqkJE=;
        b=H0EnfCohdl1bs0kKz2FPoOIqyc6u0VgIFzR65lCeNZEzgd9nrqvyx0/h9XI3mw+hkL
         vZONkm9lquaPNgG2TQBYIMvEgeq2rhteWq4YafnLi0uDtizXhJRxhEfookA9/krXWYsm
         b+1MHtLVhwaPpHW/oxj4hZgRd0Le+ENBrPh3yOrfTgJsWagEm4az4Hud+F3vwZYDpuZX
         zFqnc27fWBZEDYvfaKrWtgowbjYCsvpep5IvSW9JHZ9SRbsDihSuPutQWYUqnohMUfZV
         QRILxCI4J4vPXh4xNqy51RZPY5d0e6FLSXB0wABvNy7jK/pZAiQGXJq7VqFSpXtM9wBo
         1ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879758; x=1779484558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yh0gWGTCHr3HLLSp6B0/bzede+AfJuos48AZ5KwqkJE=;
        b=DiKCVM2OL4rxgCMGJvkE0wESu454LWu9VlnZoUJ+DX4IzF0+yNOWP3R753lj/ezxXI
         K2wQdUNsGxB5wuKLi92/+TSqPH9HzMeyBrUWQ/G8TWiZYsdaXBJlDQjDEZxyVORXmuKe
         WpoRlZxsPVeU5PPtHozuiZ1y3ghMsPdBW2P651IF2HvTwTg/61pcH1av4EXNrOppcHcI
         u/TEoyVaSdcj+WeuQRFBOS405Bd/azm017krAypn8YrLelQTxZm/PZBhcbeWrBuZbEyH
         kyNoyPwjjgz3QPo9wUMKanD85mcOL3EcWjMH37SE+zALDXJUaolyNzGdn6ONTewoT4yt
         Ncfg==
X-Forwarded-Encrypted: i=1; AFNElJ8L6p0rAjKYEhaxd4eTn/jr7hplSB+tNeLkwNB3pZh8ZbRfpP+Ac5D7+VYY+EvHaU3yq4cYcMAFiMO3SW5Ye5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagDuLad/pkYVcMjowX04CKDmr/g9arU7IXgBp8MKisFm3YH+/
	k1dFYHiP31bFkhgmyzjF2eX5ypZiqdkpfZy9XcNw7M7QCNrarTkUmoo4
X-Gm-Gg: Acq92OEZmwzffOesl36igXWk9oBaLtQlNdQEtd+iixHdhJgMrbXvMc4aJL1l/wiPzkx
	66r63Ml6lBBQmgHrb3JP6mnSfnj7Bll9QGwvqXGbtk4y4kEa4a73ZH09gerZ1CJnAL4prL8v8Bw
	lJBNoq5pNbgIGRWchJVAfnx4N7ugROeSpEwYgAtPPlekq6hI8cQeiRd+WySAWxjHVRXSP3+IfZC
	m+8uUdniDGXrlYQTZeiAnrf4sidb/C7kZTvpwdpWNFJSI3yM/MMJkw38WNzFHjtI9F7OMSTUjGO
	I5DheI0flLj9L/z8vKOifG6qdyfcd8AKsdsDsPUBMU3loJNbuDr1qlSf+MFGh1Grmr/QpGJ35Cs
	gokF8x+EYL96m0qbDuQJbL8HCwYRfNTjkz3ijoRbCGjMmePSbaD2jqgV4AC/B7FSolFMAXAfqKm
	ceYe027AiZRENkTOoQjZEn9AYwZGbruq3kTV62MCpAwA==
X-Received: by 2002:a05:7301:7c12:b0:2ed:e14:7f57 with SMTP id 5a478bee46e88-303986c651cmr3242643eec.33.1778879758108;
        Fri, 15 May 2026 14:15:58 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8006639eec.12.2026.05.15.14.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:57 -0700 (PDT)
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
Subject: [PATCH v16 37/38] x86/efistub: EFI stub DRTM support for Secure Launch
Date: Fri, 15 May 2026 14:14:09 -0700
Message-ID: <20260515211410.31440-38-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40E49558171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9572-lists,linux-integrity=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Invoke the Secure Launch protocol exposed by the boot loader at the
appropriate time to perform a measured launch of the decompressed
kernel after ExitBootServices().

Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/firmware/efi/libstub/Makefile      |  1 +
 drivers/firmware/efi/libstub/efistub.h     | 24 ++++++++++++++
 drivers/firmware/efi/libstub/x86-slaunch.c | 38 ++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c    | 27 ++++++++++++---
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-slaunch.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e386ffd009b7..fd5eaf3142b2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,6 +86,7 @@ lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
+lib-$(CONFIG_SECURE_LAUNCH)	+= x86-slaunch.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 979a21818cc1..18301ba3ae0f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1267,4 +1267,28 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
 efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
 
+#ifdef CONFIG_SECURE_LAUNCH
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle);
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base);
+void efi_secure_launch(void);
+#else
+static inline
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static inline
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base)
+{
+	return EFI_SUCCESS;
+}
+
+static inline void efi_secure_launch(void)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-slaunch.c b/drivers/firmware/efi/libstub/x86-slaunch.c
new file mode 100644
index 000000000000..98ff15f94996
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-slaunch.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+#include <linux/stddef.h>
+#include <linux/slr_efi.h>
+#include <linux/slaunch.h>
+
+#include <asm/boot.h>
+#include <asm/bootparam.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+static struct efi_slaunch_protocol *slaunch;
+
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle)
+{
+	return efi_bs_call(handle_protocol, image_handle,
+			   &EFI_SLAUNCH_PROTOCOL_GUID, (void **)&slaunch);
+}
+
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base)
+{
+	if (!slaunch)
+		return EFI_SUCCESS;
+
+	return slaunch->setup_dlme(slaunch, base, mle_header_offset, (u64)boot_params);
+}
+
+void efi_secure_launch(void)
+{
+	if (!slaunch)
+		return;
+
+	slaunch->launch(slaunch);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..339e63ae84ef 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -833,7 +833,8 @@ static efi_status_t parse_options(const char *cmdline)
 }
 
 static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
-					  struct boot_params *boot_params)
+					  struct boot_params *boot_params,
+					  unsigned long alloc_limit)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long addr, alloc_size, entry;
@@ -877,8 +878,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
-				  LOAD_PHYSICAL_ADDR,
-				  EFI_X86_KERNEL_ALLOC_LIMIT);
+				  LOAD_PHYSICAL_ADDR, alloc_limit);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -890,6 +890,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	*kernel_entry = addr + entry;
 
+	status = efi_secure_launch_prepare(boot_params, addr);
+	if (status != EFI_SUCCESS)
+		return status;
+
 	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
 	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
 						  kernel_inittext_size);
@@ -914,6 +918,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       struct boot_params *boot_params)
 
 {
+	unsigned long alloc_limit = EFI_X86_KERNEL_ALLOC_LIMIT;
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	const struct linux_efi_initrd *initrd = NULL;
 	unsigned long kernel_entry;
@@ -925,6 +930,17 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	status = efi_secure_launch_init(handle);
+	switch (status) {
+	case EFI_SUCCESS:
+		alloc_limit = U32_MAX;
+		break;
+	case EFI_UNSUPPORTED:
+		break;
+	default:
+		efi_exit(handle, status);
+	}
+
 	if (!IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL) || !boot_params) {
 		status = efi_allocate_bootparams(handle, &boot_params);
 		if (status != EFI_SUCCESS)
@@ -974,7 +990,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_mem_encrypt > 0)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 
-	status = efi_decompress_kernel(&kernel_entry, boot_params);
+	status = efi_decompress_kernel(&kernel_entry, boot_params, alloc_limit);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
 		goto fail;
@@ -1029,6 +1045,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch();
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.47.3


