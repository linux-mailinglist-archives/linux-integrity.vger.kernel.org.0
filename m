Return-Path: <linux-integrity+bounces-4573-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EADA12EC4
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1E33A78C6
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 22:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B61DB372;
	Wed, 15 Jan 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD4Igbc5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4971DA11B;
	Wed, 15 Jan 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981725; cv=none; b=g9fcRRWVdakVjNqz1QESkx3GQP7qqR2OyMplnkV5cFFvajdMRhFLFK8WNWW9bDlW93PLKhQA3l2XFJ6oZ+yUoBJvsvItezgtAFXMPZTCGdcshWUmA1VQVQoZXdWrkekRWR5ijkprKwCttZkm7iq47Knl9+W7QqJlnuvOTthEPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981725; c=relaxed/simple;
	bh=A9E1UIFSKc33JB9vhCT75gVdWuTZFCsp3gTv5ZbQRuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DI7hTLTsUhBz/ExJgbi3NZSLcm0TdFBsQpqt/p3tpkD+7nogwUMuQDJTgoGdd6YY/MX2cTIo4P2DB26RQTsmXZkvwpiG5y1TIo9VWteUGOkZGb8EJQNHDreRATfSRyA5C8L969vrVKYCjlBkRyhqI+3DNBKIH8gEdGHRrGQYR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD4Igbc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9522AC4CED1;
	Wed, 15 Jan 2025 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736981725;
	bh=A9E1UIFSKc33JB9vhCT75gVdWuTZFCsp3gTv5ZbQRuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bD4Igbc54x9juhEYmVIos2uTbaf+GnEP3kb+6uHWlPn93t5A/S0uQTuOeBSib4lvS
	 BY9BFZYJAKbZaK1LF9Hs0yU8rsq+vmwk/i5VSwvTza7BoP92X9bwNsvMUPCVmLhoa6
	 Qjzbp+rLDf+VR7Dr3vuqxAIHaInIsWvPvsFSX1rfjlb8yD2AMwsTVd8iMIVqkGLGGp
	 XxbG6EsGaD+igWl8QlyirbnLnDKOKmYGxzLQf/FJHuuZPeB1qeiZyiri9iauOE9t3W
	 WOhhxMDzu+JKVzCWM6HOEo7kudXQp+ZM0iNiSFYTpUwIF6kWuHrrwI9eEplTqnWLkh
	 AeS8XpbJ1UcGg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Stefan Berger <stefanb@us.ibm.com>,
	Reiner Sailer <sailer@us.ibm.com>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10] tpm: Map the ACPI provided event log
Date: Thu, 16 Jan 2025 00:42:56 +0200
Message-ID: <20250115224315.482487-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following failure was reported:

[   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
[   10.848132][    T1] ------------[ cut here ]------------
[   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
[   10.862827][    T1] Modules linked in:
[   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
[   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
[   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
[   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
[   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
[   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
[   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0

Above shows that ACPI pointed a 16 MiB buffer for the log events because
RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
bug with kvmalloc() and devm_add_action_or_reset().

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org # v2.6.16+
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v10:
* Had forgotten diff to staging (sorry).
v9:
* Call devm_add_action() as the last step and execute the plain action
  in the fallback path:
  https://lore.kernel.org/linux-integrity/87frlzzx14.wl-tiwai@suse.de/
v8:
* Reduced to only to this quick fix. Let HPE reserve 16 MiB if they want
  to. We have mapping approach backed up in lore.
v7:
* Use devm_add_action_or_reset().
* Fix tags.
v6:
* A new patch.
---
 drivers/char/tpm/eventlog/acpi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..50770cafa835 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
 	return n == 0;
 }
 
+static void tpm_bios_log_free(void *data)
+{
+	kvfree(data);
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -136,7 +141,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
@@ -161,10 +166,14 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		goto err;
 	}
 
+	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
+	if (ret)
+		goto err;
+
 	return format;
 
 err:
-	devm_kfree(&chip->dev, log->bios_event_log);
+	tpm_bios_log_free(log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
 }
-- 
2.48.0


