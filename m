Return-Path: <linux-integrity+bounces-6377-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE1AD00E1
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AB37A256E
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6482882C8;
	Fri,  6 Jun 2025 10:58:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15762882A2;
	Fri,  6 Jun 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207483; cv=none; b=aMO6JFfdu2s1fFpA7Z2t2d2gnH/ZIAQQ+S2HNQ3ciUS5CwPbT2NkP36GGnwQ5mnVKFzfQzctEH+fcb0wyMsUklSFe2KyHI6OHOvtz4DMJrG8+COBcu/WniLYw0lK73A/WDAccxbyUHa/asUWNH3oxLbYAAf0cG5lHDL3EkWZ4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207483; c=relaxed/simple;
	bh=LdC86cJWlp6U1sDvJ8jk50YwXi2SHmaCJx6IuM9Udl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFJV0O024QEK2IY82PCMg4gXpWMNQp/uvncAMiB1UVEbRsL2/cmD2pQSgjGL/MwcTQbkStZgDrro2LiCf0ZVQblb0mOT++4n/gY0TqaqkUrirveJonkErVP9pI7oscz8/trlnvqp4x1TYzLXvG03esrX31aQ1PQj+8jCTL5KLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E4A1BD0;
	Fri,  6 Jun 2025 03:57:43 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA4313F59E;
	Fri,  6 Jun 2025 03:57:59 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa driver when it's built-in
Date: Fri,  6 Jun 2025 11:57:54 +0100
Message-Id: <20250606105754.1202649-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606105754.1202649-1-yeoreum.yun@arm.com>
References: <20250606105754.1202649-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To integrate tpm_event_log with IMA subsystem,
tpm_crb and tpm_crb_ffa driver should be built as built-in
(CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y).

However, this could make failure for ima_init() gets tpm chip when
each initcall function deployed like:

0000000000000888 l       .initcall6.init	0000000000000000 crb_acpi_driver_init
000000000000088c l       .initcall6.init	0000000000000000 tpm_crb_ffa_driver_init

If crb_api_driver_init() is called first, probing tpm device using CRB over
FFA method is deferred since tpm_crb_ffa_driver_init() isn't called yet.

Deferred probe of the tpm device will be probed by system workqueue
in proper time after deferred_probe_initcall() registers the work.
However, ima_init() could be called first if they're deployed like:

000000000000012c l       .initcall7.init	0000000000000000 init_ima
000000000000016c l       .initcall7.init	0000000000000000 deferred_probe_initcall7

In this situation, ima_init() failed to find tpm device and it failed to
generate boot_aggregate with PCR values.

That's why kernel prints log this situation though tpm device exists:
   [    3.080786] ima: No TPM chip found, activating TPM-bypass!

To resolve this, call ffa_register() in tpm_crb_ffa_init() when it was
built with built-in so that ima can generate boot_aggregate log with
PCR values properly.

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


