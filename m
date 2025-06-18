Return-Path: <linux-integrity+bounces-6471-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7BADE8F8
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jun 2025 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61AB3B393E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jun 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBE2DE21A;
	Wed, 18 Jun 2025 10:23:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFB2DE1E2;
	Wed, 18 Jun 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242191; cv=none; b=dICquCAR06qiU3T5DxjCa6Fqe1g2TnCsZlcFhFvJjL+CEeNFcSt0l038aT189ml4lAMAh8CTEsqo01MgHClWFbb8d7L1DUPWNK5FJVFmE4UldPomlk7KGRPXQbm3Mojacs81TsnWHvKDld7T7UULHbAKXb9ETKUUcmaKxCvy9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242191; c=relaxed/simple;
	bh=MTXa6A8nQtm2Tlld5BzWdCXG3mqQlWzGBq3MLCLaa50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPsW/oAZEmkTfavMFoYXDJTLSpYAf+wpUEiSQSer0nNYkF1mxmL4jghNsz68/kdGkx/pn7f6M6D1MZ45k6Cm7Zw7ZhIeFf7l5g/QMqxzwNu41oky6qC/InEhETKYIgzt15H6hkn/YNjnCE0hlllqMN31yMzmjN5jN2652PX+IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E16731D13;
	Wed, 18 Jun 2025 03:22:48 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24DD93F66E;
	Wed, 18 Jun 2025 03:23:08 -0700 (PDT)
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
Subject: [PATCH v4 2/2] tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in
Date: Wed, 18 Jun 2025 11:23:02 +0100
Message-Id: <20250618102302.2379029-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618102302.2379029-1-yeoreum.yun@arm.com>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
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
probe the tpm_crb_ffa by register tpm_crb_ffa driver so that
when tpm_crb_ffa device is created before tpm_crb_ffa_init(),
probe the tpm_crb_ffa device in tpm_crb_ffa_init() to finish probe the
TPM device completely.

This ensures that the TPM device using CRB over FF-A
can be successfully probed, even if crb_acpi_driver_init() is called first.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..462fcf610020 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -115,6 +115,7 @@ struct tpm_crb_ffa {
 };
 
 static struct tpm_crb_ffa *tpm_crb_ffa;
+static struct ffa_driver tpm_crb_ffa_driver;
 
 static int tpm_crb_ffa_to_linux_errno(int errno)
 {
@@ -168,13 +169,23 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
  */
 int tpm_crb_ffa_init(void)
 {
+	int ret = 0;
+
+	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
+		ret = ffa_register(&tpm_crb_ffa_driver);
+		if (ret) {
+			tpm_crb_ffa = ERR_PTR(-ENODEV);
+			return ret;
+		}
+	}
+
 	if (!tpm_crb_ffa)
-		return -ENOENT;
+		ret = -ENOENT;
 
 	if (IS_ERR_VALUE(tpm_crb_ffa))
-		return -ENODEV;
+		ret = -ENODEV;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
@@ -369,7 +380,9 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };
 
+#ifdef MODULE
 module_ffa_driver(tpm_crb_ffa_driver);
+#endif
 
 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


