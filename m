Return-Path: <linux-integrity+bounces-6412-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DEAD53D5
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC4F189EB4C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE68425BEEF;
	Wed, 11 Jun 2025 11:24:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4A26157E;
	Wed, 11 Jun 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641097; cv=none; b=lR0zOge1y1n1sTlcHJgWJnPtroC+env6YGUVjoz1QwbqkzP6EM64CqnIR3GOtPMK8GGLzcJIGJyo6Rv1UEyWDiXMPKjK3WL0G4P1WVwLyOQ+RbHGF0e2LikunPEl8IYozI7ivyLUdrMc514svUHt5+90rs151XLMpMYKO0lMORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641097; c=relaxed/simple;
	bh=CF/MUxGhw96kEox5MVRZY8BzNOEV4A+mER0fmPLfrhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA2mHAK5xM1wwyY14puMlerAWkO+tKjT3KDfc3rAwJkhq+l5wMPpdlTb6Hzmiv+hXwswCDsJRP0YC2vL+iWNo10OTdCLLYb2x9F/JMCimyJ/1ywIkMryJIe6tqWEl1LciKyfrOSq8CCB/AbJqYgWrw1CB1qaIWAY4ETaEIVB8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFAF82BCD;
	Wed, 11 Jun 2025 04:24:35 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 030553F59E;
	Wed, 11 Jun 2025 04:24:53 -0700 (PDT)
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
Subject: [PATCH v3 2/2] tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in
Date: Wed, 11 Jun 2025 12:24:48 +0100
Message-Id: <20250611112448.17751-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611112448.17751-1-yeoreum.yun@arm.com>
References: <20250611112448.17751-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To generate the boot_aggregate log in the IMA subsystem using TPM PCR values,
the TPM driver must be built as built-in and must be probed before
the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using the CRB interface,
probing fails and returns -EPROBE_DEFER
if the tpm_crb_ffa device — an FF-A device that provides
the communication interface to the tpm_crb driver — has not yet been probed.

This issue occurs because both crb_acpi_driver_init() and
tpm_crb_ffa_driver_init() are registered with device_initcall.
As a result, crb_acpi_driver_init() may be invoked before
tpm_crb_ffa_driver_init(), which is responsible for probing the tpm_crb_ffa device.

When this happens, IMA fails to detect the TPM device and
logs the following message:

  | ima: No TPM chip found, activating TPM-bypass!

Consequently, it cannot generate the boot_aggregate log with
the PCR values provided by the TPM.

To resolve this issue, the tpm_crb_ffa_init() function explicitly attempts to
probe the tpm_crb_ffa. This ensures that the TPM device using CRB over FF-A
can be successfully probed, even if crb_acpi_driver_init() is called first.

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


