Return-Path: <linux-integrity+bounces-4571-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D9A12DA0
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654723A41BF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451601DA112;
	Wed, 15 Jan 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nezd8nX8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC94D599;
	Wed, 15 Jan 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976169; cv=none; b=VUaRf6bn4XDCmByieIlmSXMLB0/mMSwSMj2ezLLXeyv0t8Qr3iAb/ghqgOUU+lFZ1eWn/ZG58IvXmuWM0DVm4C08wDTEALjN3LE56wuGqvMwO2ru4VFkL8+97+Rlxp5kb1r/XzF1rQaOb3ke3Gv+Tl/+eVmDXQxslZRCK2kNa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976169; c=relaxed/simple;
	bh=4zT/Agcn8gYciKlkGmDRXwSQHgpkRsd47yw2ZWOY50g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvCLyPSS9FXt77pmiehkEnUYpX5vmtQSzv4aS0JaclFAmZNGwI6A0GB053kUGPczkNE2z6DQA3c92+8n7xRHKPgt+x2suC0GAWhofzyzcGQVLB77foej6RWAUFHHJY/9m9Zm3MKX3xRjD/b+QwheH0V8e3LHZMGANqGpwgpc2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nezd8nX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D02C4CED1;
	Wed, 15 Jan 2025 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976168;
	bh=4zT/Agcn8gYciKlkGmDRXwSQHgpkRsd47yw2ZWOY50g=;
	h=From:To:Cc:Subject:Date:From;
	b=Nezd8nX84KxusPZoVCt8MwHROtfv8l5OcuD6tgriacyOAASePCeuPM7xAPqUkzO0Z
	 PweF67ZgDYKGjRc3KUyinLIDPygHaFcn1mrTjKylqp6u7tzlRYenww7iApe6NXTcBK
	 0qlmTcIhJK0LUH0/w7nFUmNEcF9lJvUSXm3OwgkWMwBtV/xzgVZdXEzaJ4Yz+YrvCg
	 AZG3TG57AcXt3nreJfIE1Et/OOsDNN91IyyGEk76Im4EsCazFs1TxvuRw1VGXowIg6
	 B0dRUfi0E4swnU0rajBSH1hMdix+FTOsAXahbNsOFX/CPXXm70qHMdpa/e2R5IOLTF
	 tsQDC+zTe/UHQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Reiner Sailer <sailer@us.ibm.com>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Stefan Berger <stefanb@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9] tpm: Map the ACPI provided event log
Date: Wed, 15 Jan 2025 23:22:35 +0200
Message-ID: <20250115212237.57436-1-jarkko@kernel.org>
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
 drivers/char/tpm/eventlog/acpi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..cf02ec646f46 100644
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
 
@@ -161,10 +166,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		goto err;
 	}
 
+	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
+	if (ret) {
+		log->bios_event_log = NULL;
+		goto err;
+	}
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


