Return-Path: <linux-integrity+bounces-6390-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C925FAD2DAE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4E170512
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C726B97E;
	Tue, 10 Jun 2025 06:03:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CA2620E5;
	Tue, 10 Jun 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535427; cv=none; b=ICIxLQVph4KqvJEYafCWbg5/c80+eOTwN3AMmdQxCSlobGE5di4LwfvcqJOQz3m1u6T8emVN468aJxd3Tvz1lJpkVcMO2hKedPyBWfeLqJHZu09QP+e0pdx1pAlYMj4UF0Jkrmy8co03me0Yq0LPimppW50QtppGK26OypJpDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535427; c=relaxed/simple;
	bh=Wk4ic3cKCwA/CUwVZNrW0uVYklt7Lox9BLDg1LmmMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9iZhCdwQMYfu0z+MrU51Igu+OnFKMhpZhnv6LRxlmgPFtSUjcezq96RJy2uzh+IY6fCZ9/ANppB02nd3h1u9nBrxYVGCE+a/AHUhKG4ooIAoEGRL+Rxk+i6PRgR7vwbKRXVhx0dJ6BWKQiwMnuh7ZS2K3hRMFxwJ2wJkL27Y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9008B16A3;
	Mon,  9 Jun 2025 23:03:24 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 416103F673;
	Mon,  9 Jun 2025 23:03:42 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: jarkko@kernel.org,
	sudeep.holla@arm.com,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 2/2] tpm: tpm_crb_ffa: manually register tpm_crb_ffa driver when it's built-in
Date: Tue, 10 Jun 2025 07:03:34 +0100
Message-Id: <20250610060334.2149041-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610060334.2149041-1-yeoreum.yun@arm.com>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To integrate tpm_event_log with IMA subsystem,
tpm_crb and tpm_crb_ffa driver should be built as built-in
(CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y) and
TPM device using CRB over FF-A should be probed
before ima_init() which is called as late_initcall.

However, we couldn't control the probing order between
crb_acpi_driver_init() and tpm_crb_ffa_driver_init() that's why
crb_acpi_driver_init() could be called before
tpm_crb_ffa_driver_init() when they're deployed like:

0000000000000888 l       .initcall6.init>-0000000000000000 crb_acpi_driver_init
000000000000088c l       .initcall6.init>-0000000000000000 tpm_crb_ffa_driver_init

In this situation, the TPM device is queued deferred probing
and it can be handled later ima_init() caled in init_ima().

000000000000012c l       .initcall7.init>-0000000000000000 init_ima
000000000000016c l       .initcall7.init>-0000000000000000 deferred_probe_initcall7

When this happen, IMA fails to generate boot_aggregate with
TPM's PCR values so it prints below message:

   | ima: No TPM chip found, activating TPM-bypass!

To resolve this issue, the tpm_crb_ffa_init() function
attempts to probe the tpm_crb_ffa device.
This ensures that the TPM device using CRB over FF-A can be
successfully probed even if crb_acpi_driver_init() is called first.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..2ef29b66fa5d 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -115,6 +115,7 @@ struct tpm_crb_ffa {
 };

 static struct tpm_crb_ffa *tpm_crb_ffa;
+static struct ffa_driver tpm_crb_ffa_driver;

 static int tpm_crb_ffa_to_linux_errno(int errno)
 {
@@ -168,13 +169,22 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
  */
 int tpm_crb_ffa_init(void)
 {
-	if (!tpm_crb_ffa)
-		return -ENOENT;
+	int ret = 0;

-	if (IS_ERR_VALUE(tpm_crb_ffa))
-		return -ENODEV;
+	if (IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
+		if (!tpm_crb_ffa)
+			ret = -ENOENT;

-	return 0;
+		if (IS_ERR_VALUE(tpm_crb_ffa))
+			ret = -ENODEV;
+
+		return ret;
+	}
+
+	ret = ffa_register(&tpm_crb_ffa_driver);
+	BUG_ON(!ret && !tpm_crb_ffa);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);

@@ -369,7 +379,9 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };

+#ifdef MODULE
 module_ffa_driver(tpm_crb_ffa_driver);
+#endif

 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


