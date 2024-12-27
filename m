Return-Path: <linux-integrity+bounces-4482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CE9FD082
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 07:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F683A056D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016357C93;
	Fri, 27 Dec 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E66TjOEO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70CC8DF;
	Fri, 27 Dec 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735279262; cv=none; b=ssUYP3RPtzBskW9d2DCHZtmhnH9JpI85ecqfggiATO8xrwogJ0YtHT7iyP8f6nHTArv/X+CIPenmaeEXWZ0YV+KM0jKeC64fMYTlK0cSLelYrQpxCyn1JpOlE9BmvOMV0N0l/Ar/FukcKqvHlNDMMW/1WCU9y9zU1jkZsyz2SNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735279262; c=relaxed/simple;
	bh=KO2bZJCIAJh1reSAw90Loi+oYozwK2mdvvbQdrwdRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZK2+qd6hYlOhn5avKnNFn34dF7Z1VeekQgfjkgARrRkX70YBwl/Q5+B5Gsh+aZhH/R3mNFkFaGmi1f8fXZGVuWok7Kx4zYyMB1wFkjZSmRd8E/jBsuw4SKq0wMUCcodfESI4rPER5kwNoXwW4CorMcCW9vTv4Bef8HvEsmG+cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E66TjOEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C2C4CED0;
	Fri, 27 Dec 2024 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735279261;
	bh=KO2bZJCIAJh1reSAw90Loi+oYozwK2mdvvbQdrwdRN0=;
	h=From:To:Cc:Subject:Date:From;
	b=E66TjOEO9JfQj8by8KWBaSjQuXESu+43hT545B8ICEXVUqX6oVu71RqGCKLelW2MH
	 8SfFY3/pSpk+izZp5JFKtZKOANyahnMaIOOCXaiQX2BegHw2OA3KKgf8f8YP47qx3L
	 exKRYlw8a2quXGCgHx9Lu+Wvs3OoSo9IomR+OSAUOsC6DIQAPLLK1URLO+oU+LqOfX
	 RSSlVaBvQvXsL2gA8T9Ysyb42Px98YtYEg5XUo3nFVuOnTgG8ydgQhxfPoqh0jdVgl
	 YOWTkJcImR65ZS31WtpclfKDO/RzcOYPm4T2sFIpg8agSFxQvFhZfFp5O6nQyszhwL
	 ee7/PryVJQslg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Reiner Sailer <sailer@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Stefan Berger <stefanb@us.ibm.com>
Cc: stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] tpm: Map the ACPI provided event log
Date: Fri, 27 Dec 2024 08:00:44 +0200
Message-ID: <20241227060053.174314-1-jarkko@kernel.org>
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

Cc: stable@vger.kernel.org # v2.6.16+
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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


