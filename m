Return-Path: <linux-integrity+bounces-4489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAA79FD5A1
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586163A1239
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65F1F7089;
	Fri, 27 Dec 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvS+Lu51"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63B320B;
	Fri, 27 Dec 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735313959; cv=none; b=RGRVfP5Js9hj8aN59hlvhfJBR4MzXWrV9DuZAoe38vuzkCm5YWqwk84JjAJWF7vUSMYG7MDzw0LNl3t3xhjvEr8e1qjrQyjWqY5JE5dOZRw+B4v+d/aSaiQ6ALhiLEQZsmom4Gh8XrYRGbmAdMbOMy16AGyGlVr6MWpTo/TcvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735313959; c=relaxed/simple;
	bh=7mzQY7/7p8tFlllO115gV5ll9BUzuzVq7bkL40Yq9nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqKyrGMsgOfctMowzEnJ6D1BFZWuXSPvNLlkX57Om4dxDWW1zore1YyoOewYzYItUH8P9GMj1HbC90npmhFwXRbY1IPhqjaFJrd6EvQDsHZqqYWIWvvs/nFYKYPFBwZD+f3jnKoTaWFAAu19SA0v3xX7NUs9/4vWzoVOzAGk7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvS+Lu51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FD9C4CED0;
	Fri, 27 Dec 2024 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735313957;
	bh=7mzQY7/7p8tFlllO115gV5ll9BUzuzVq7bkL40Yq9nA=;
	h=From:To:Cc:Subject:Date:From;
	b=lvS+Lu51+qHR29oFWarwrXqW3Zvq2gaHNcgjMXmwoffTt8my6Sk/dc1zCZrS/QsSY
	 yeYfFQ4ewY5/RXzfz7D+9mcD8RVOQCs/agCDY2sIysb8jrEcegTHZkAz3xrcTV54wu
	 5hS25Hu0oq8/hgMFNmBlSz0CcqnnT04VyY5aexcCkw9gkpYUkODZc2Jyws62NDfeDW
	 yPOapP3UFJ+VXlJsT5H7ArFb4foQP3CGV3hWdvYt/+ilQzjzmCGHbUuMLp374GWpuL
	 RmqkZyogJEn5rDKgmuM2WWfx2hfO2Za/Cq33/VwU0FctWxA9FbvMow8cdb7tAZWZhJ
	 8w3cE6+40oIWQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Stefan Berger <stefanb@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Reiner Sailer <sailer@us.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8] tpm: Map the ACPI provided event log
Date: Fri, 27 Dec 2024 17:39:09 +0200
Message-ID: <20241227153911.28128-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.1
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
v8:
* Reduced to only to this quick fix. Let HPE reserve 16 MiB if they want
  to. We have mapping approach backed up in lore.
v7:
* Use devm_add_action_or_reset().
* Fix tags.
v6:
* A new patch.
---
 drivers/char/tpm/eventlog/acpi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..394c8302cefd 100644
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
@@ -136,10 +141,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(&chip->dev, tpm_bios_log_free, log->bios_event_log);
+	if (ret) {
+		log->bios_event_log = NULL;
+		return ret;
+	}
+
 	log->bios_event_log_end = log->bios_event_log + len;
 
 	virt = acpi_os_map_iomem(start, len);
-- 
2.47.1


