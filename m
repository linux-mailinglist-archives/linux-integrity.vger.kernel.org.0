Return-Path: <linux-integrity+bounces-9573-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHfdLq2PB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9573-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:27:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E0558125
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CCA30F0563
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B663F6C52;
	Fri, 15 May 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF56TtPm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D8405C41
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879764; cv=none; b=AEu8kvOEa3J3Ra/3sf4kQ0+lH9/M/HWyytr2ZiHSFBRYxkz2FUfojZOW+st2Z3x0AvIFWupCicnC/silvnKpVbTn3jSllVkZ3cpIcPB7SHlsljrB3xyliheoei9Sqpx+ejekLZJVmfaIH9Acub7ZVAkQS+pJuy31fB8ANbAz9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879764; c=relaxed/simple;
	bh=Yb8MnWED6Q7bAT/hqKNGG8lkKmGIJFI2VweKIbS2p4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6xBnOeuoBbzX5TXGo69P9IoSLviLponpVPLZOmjw4jP+gC6KI5QYeVqqz4DL2XwuJTYAImaBu9wL3boTrBrz1SN445UoPWEzGkDxreTTm7PRcyAmesJGqg19Q+/ypgbV7dudY06jIzLSQe+0LYHWjCcfSBSYtCd12uikw+rqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF56TtPm; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-132830d8281so952079c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879761; x=1779484561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCBpSoWd+DzhR5w/L2qTUePdSLNQuDLLzBvZ0vft3Fw=;
        b=BF56TtPmbTq/ykC8PdHqLL2T52MU6o1OuGFsPhF6ynYNpWVBeiSvCagbcZxtobjddA
         xexaxNpjpT7SjCuVkLzRxN1AiPOoYkIe3NCnWxNp8aEWbCIaIjx9ozVYBYKc69mHI3t1
         cmhkh4WEmi7Ax0rxbTg9QkQpikFSs1q0NqeF3bEFDZn03MJX7OsocK3Sr/O8UlpX/P4Y
         IcczdzzNyATeOkj00G7LTkEmkHAk7flzvVbai4qA4ibYRHCbnjVIwocwTADiEtvJTKI1
         JWoSdHMS7BnisdwKjfCIzp8ncdxHCX1VIPaHE7wrI6lrms4o/Dp1o7D3YCFluVOHP+v3
         lukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879761; x=1779484561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCBpSoWd+DzhR5w/L2qTUePdSLNQuDLLzBvZ0vft3Fw=;
        b=NnrdbvZUxXpbheB7wwveRa7RrmusAkQQqFYgE5582QgOhZSyd888ibAxGw26y1r0oB
         zlpVrespm3gcK1jwoIjqwLoeZdBgKRjJHbXDyq5fKYutDW4BURTZD5kZaFzG5M1cAynC
         B2xuU+C3NNyWUYP6H2rD8QYvKpaKdnMu3kZ6mvbDbggl+QieN+iZL4osIOQBv24Egv7Y
         zn/Z70klykXIFE8MtAnh4je4DBnEw7mkmdYkkywY+OZctHchsa+dSc8ZdNpxfiEiOwHS
         1LA/HIbUTDkKygOccOIf72tZl5aIjNT2IeCVnJImK/cV3VdXOkxzrRI7ftbfn2BPMLiy
         28AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rxIRRmI+/jhE8+FI+HjqJEl4BZCBQNXnTLMRalPQ2DBXLkWxVER+a2msiX2dffbRYyfiFH1Ooy+5G50nvjBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuUgGWvCJipFbNyS9SlhfF3A0BK7I/wL/brSHBtk9CyuoXypN
	UGaUr2/yEXiAq5uCv/qsXoYnLewPeLKB1bW/EyhlVyfZoAMmyWQimHeR
X-Gm-Gg: Acq92OEJN7lvL+5SNOg2aPjaeVdbZEfptxFFKDhkZRhh3CjT8lHpWcQrfTtmRzip6jX
	YX+fHZbcr61Cr/sguRHjHuK2v+fWwMlpD6+A1LBeM5cuxAiju7L92FSo2av1KLsEswLwICovJB0
	pAAR3MekguKsOzqRMntUSj8SALPdnjsEi0C7tk9hdtyBHDbrvuJqJidPqnDgk+CcCjrmxXcHHFQ
	HJxWxVrfvVyqUUyKy+BA9TgMh1P5C5PbqyUHjVP4AWbJ1C3eCCCyUpYuLmX+ieUPipWZj7a/Udv
	ZtJIsDjgh2rePb5N/aLZ6qOby+UpVYjp4D8r7hi6qFwRfVn0yuKhwyRIODwHcH2XqV3TMbPwqkb
	5/NOxwvUyJRp/twLNV79D+QqkNMRcxVj1CUT0MkdCuYNm1YkMCo9Ao/f2MGbBB17RHR9wLhgW8q
	i5CijpObqCCXuMCkA/SSOx7Fos4E6YKJI=
X-Received: by 2002:a05:7022:1a85:b0:12d:d972:b96e with SMTP id a92af1059eb24-1350542e8e5mr2758254c88.20.1778879760953;
        Fri, 15 May 2026 14:16:00 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm11529163c88.0.2026.05.15.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:16:00 -0700 (PDT)
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
Subject: [PATCH v16 38/38] x86/boot: Legacy boot DRTM support for Secure Launch
Date: Fri, 15 May 2026 14:14:10 -0700
Message-ID: <20260515211410.31440-39-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 3B5E0558125
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
	TAGGED_FROM(0.00)[bounces-9573-lists,linux-integrity=lfdr.de];
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

From: Ard Biesheuvel <ardb@kernel.org>

Implement Secure Launch D-RTM of the decompressed kernel via a
callback interface exposed by the Secure Launch Resource Table (SLRT), a
reference to which is added to struct boot_params.

This permits a boot loader to set up the Secure Launch, allow the
decompressor to execute up to the point where it would otherwise boot the
core kernel, and at that point, perform the Dynamic Launch Event in a
architecture/vendor specific manner. This is similar to how EFI boot
achieves this, using a EFI protocol exposed by the boot loader.

This requires that the decompressor unpacks the kernel into the buffer that
it was started from itself, and so physical KASLR needs to be omitted
(although the boot loader is free to place the decompressor at any
suitably aligned locations in system memory, and so it can perform the
physical randomization itself).

It also relies on the demand paging logic in the decompressor, to ensure
that the SLRT and the entry point it describes are callable, at least to
the extent that allows the callback code to re-establish its own
execution environment.

Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 Documentation/arch/x86/zero-page.rst  |  1 +
 arch/x86/boot/compressed/misc.c       | 51 ++++++++++++++++++++++++---
 arch/x86/boot/compressed/pgtable_64.c |  7 ++++
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
index 45aa9cceb4f1..dd98b467929c 100644
--- a/Documentation/arch/x86/zero-page.rst
+++ b/Documentation/arch/x86/zero-page.rst
@@ -20,6 +20,7 @@ Offset/Size	Proto	Name			Meaning
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
 070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
+078/008		ALL	slr_table_addr		Physical address of Secure Launch Resource Table
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e3b5177bfa6f..eaaface4cd7d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -17,6 +17,7 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <linux/slr_table.h>
 
 /*
  * WARNING!!
@@ -391,6 +392,36 @@ static void early_sev_detect(void)
 		lines = cols = 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+static void sl_initiate_launch(unsigned long table, unsigned long base)
+{
+	struct slr_table *slrt = (void *)table;
+	struct slr_entry_dl_info *dl_info;
+	struct slr_setup_dlme dlme;
+	dl_launch_func launch_fn;
+
+	dlme.dlme_base = base;
+	dlme.dlme_header_offset = mle_header_offset;
+	dlme.dlme_table = 0;
+
+	if (!slrt)
+		return;
+
+	dl_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+	if (!dl_info)
+		return;
+
+	launch_fn = (void *)dl_info->dl_launch;
+
+	/* Do the Dynamic Launch Event */
+	launch_fn(&dl_info->bl_context, &dlme);
+}
+#else
+static inline void sl_initiate_launch(unsigned long table, unsigned long base)
+{
+}
+#endif
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -491,10 +522,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	debug_putaddr(trampoline_32bit);
 #endif
 
-	choose_random_location((unsigned long)input_data, input_len,
-				(unsigned long *)&output,
-				needed_size,
-				&virt_addr);
+	/*
+	 * When doing a secure launch, the actual launch will be initiated by
+	 * jumping back to the bootloader. Omit physical KASLR in that case, to
+	 * avoid trampling on its code or data inadvertently.
+	 */
+	if (!boot_params_ptr->slr_table_addr)
+		choose_random_location((unsigned long)input_data, input_len,
+				       (unsigned long *)&output,
+				       needed_size, &virt_addr);
 
 	/* Validate memory location choices. */
 	if ((unsigned long)output & (MIN_KERNEL_ALIGN - 1))
@@ -528,6 +564,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	debug_puthex(entry_offset);
 	debug_putstr(").\n");
 
+	/*
+	 * Secure Launch involves calling back into the bootloader, so this
+	 * needs to happen before disabling exception handling, to ensure that
+	 * the entry point will be mapped on demand if needed.
+	 */
+	sl_initiate_launch(boot_params_ptr->slr_table_addr, (unsigned long)output);
+
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 3e9d651da73e..f82094669ac0 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -124,6 +124,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 
 	l5_required = !cmdline_find_option_bool("no5lvl");
 
+	/*
+	 * Don't change the number of levels when doing a Secure Launch. The
+	 * Secure Launch stub will take care of that if needed.
+	 */
+	if (bp->slr_table_addr)
+		l5_required = l5_enabled;
+
 	if (l5_required) {
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 8155fa899f50..bc2ef37096af 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -121,7 +121,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 slr_table_addr;				/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
-- 
2.47.3


