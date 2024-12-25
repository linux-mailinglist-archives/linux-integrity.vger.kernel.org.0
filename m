Return-Path: <linux-integrity+bounces-4474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD29FC667
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2024 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8056118829A8
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BB17B50F;
	Wed, 25 Dec 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J36oY5vX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DA8BFF;
	Wed, 25 Dec 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735155173; cv=none; b=Le+EHlL/iov0MX2W/ezqJJrhZs9uO+CuixMQkHjeZJQ9ouOapfVLTQMOzdcTqzzsEVrMQw/kEfO6mJPUzhQ5EKyLBJJoNKUK5ay0kg/v510RxdvR5U9fz73QOwy+/bqSS8zX9/GMHcBQsVBBH6MbdXQ2JA6DpBFIGYxDmx0kNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735155173; c=relaxed/simple;
	bh=fexw1rkWlywczYizQsE+6s+iL+8XEekLQ+cDsQHvbgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4fAycS2Cvvx17anQEP65G9xWpg2kycQYKTYBsc7Z9Q1AKLWjBBpvpxWa9DUSFSLPIta6y5tQRuRW1F77hUkLb2HARDAyw9vavDYebhuKiL2rWTSW5DKKZwQQljoPJ1TyrrRVcisyoUsZxazdVEUxbMeSIdDC2sc7Rkdgrqds3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J36oY5vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F103C4CECD;
	Wed, 25 Dec 2024 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735155172;
	bh=fexw1rkWlywczYizQsE+6s+iL+8XEekLQ+cDsQHvbgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=J36oY5vXcJ9l8koSz81h/RmWWJkn/6U8Lk5c6fCWhS6nrODuC+P3OZL+N8cK1bU9W
	 anA8YvQ0FZkKDTYYzb33uwT3FBQtL6+jmb3J33JLHdtRPJOZBrZqXaQ3NRf2+OAxcL
	 3mjQmhLDEQ/UpOoFTnT1SnSKx3nA705gPNKfkgJj4L7Kq8AkC1VRoSUaC82ZMHGJv6
	 G2IPGh8TEOziEqLC9l+TXX3YMXg83J4/7969kLNGbAbl8pLOFg5jsMiTddmp7O9QDl
	 Tiu+Ugnu4KoHvV1bvzVkDftVxCgBmVtp5Tj6i3yUSVkXxeEdizgi28rE7ou55Nv9Sa
	 OGlm5dw04ePcQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Reiner Sailer <sailer@us.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Stefan Berger <stefanb@us.ibm.com>
Cc: stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] tpm: Map the ACPI provided event log
Date: Wed, 25 Dec 2024 21:32:31 +0200
Message-ID: <20241225193242.40066-1-jarkko@kernel.org>
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
bug with kvmalloc() and devres_add().

Cc: stable@vger.kernel.org # v2.6.16+
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
* A new patch.
---
 drivers/char/tpm/eventlog/acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..7cd44a46a0d7 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -136,10 +136,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
+	devres_add(&chip->dev, log->bios_event_log);
+
 	log->bios_event_log_end = log->bios_event_log + len;
 
 	virt = acpi_os_map_iomem(start, len);
-- 
2.47.1


