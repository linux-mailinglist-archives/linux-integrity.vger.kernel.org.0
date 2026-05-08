Return-Path: <linux-integrity+bounces-9489-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DggBoYj/mmunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9489-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B64FA43E
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90EFC300ACB2
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED96421F1F;
	Fri,  8 May 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3dTWKD2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AC421F1A;
	Fri,  8 May 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262892; cv=none; b=lQvwAhxeU+Tsqg2e+I4U1FFOuuEVk3neyazk3UQ1DprpieiZM3sX6qPdi+uvtTWmze9w3wQuVQx7XuRhzXSuQ0aPO9l25xeeNcNshvvlr9ea74bAI8gOD4DmPVYZlayo/ekhtNJ6lzkE29rcHRzHsa3vsftQRc4otCZhJ+/18qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262892; c=relaxed/simple;
	bh=TBNCVdCAkWh6fuk6mWj5LJxZtMNMIwaTT5dZw7QeK68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jX9hUXAJSZEZzL06aLrScbvcfTmYkgIZjoazErpKS1tMfv4fqXKZ2688AHofAgrol0hmmRIHcxPoAxzLshdEiT9NgNk57r/MSzHHD8mQJmNnFSy3HV5eyzAq8mDTd9x+gE15fM6fqjKJaIg8tn+xGQM6mJ9F2Jyod2FQT4G1zD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3dTWKD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8101C2BCC9;
	Fri,  8 May 2026 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262892;
	bh=TBNCVdCAkWh6fuk6mWj5LJxZtMNMIwaTT5dZw7QeK68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l3dTWKD2wfcguZP+/OHzH19sdBUsw/L7rr18YgiFZbK5cQGE6IdVuFa5WgTLNOCtM
	 gEPNfUnj2IumN7lbKpEABu/LhnxZ43r6Xm2Icl4Nn8Hu5i+Ub9DLXx4/6LYLDMYo/H
	 +pixvF6Mj1ADqRKvzNAQ4ft614vTenUFfOIo7xAqnNp9lhXSQBMwaMRlH47CRzpq4N
	 1ev3iagxEV1pvrA3RtFmYh9h/AuuzU8DjofVDwcww7ZiYH8L7+8rLOwo56NmoCqBhq
	 qcdXpH8kt6JxQwtzRBCKNvUBD8mLF08A6CqUIQPw+1tyulyxbRzgFQw9a6fqaRA0U5
	 Uuio0xPf010mw==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Fri, 08 May 2026 18:54:16 +0100
Subject: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: A09B64FA43E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9489-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Move the FF-A core bring-up and teardown paths into platform driver
probe and remove callbacks, and register a synthetic arm-ffa platform
device to bind the driver.

This makes the FF-A core lifetime follow the driver model while keeping
the device creation internal to the FF-A core. Use normal platform driver
registration so the probe path has standard driver-core semantics.

The synthetic platform device is a temporary bridge until ACPI and
devicetree describe the FF-A core device or object. Once those firmware
description paths are defined, the internal platform device creation can
be dropped and the driver can bind to the firmware-described device
directly.

Since the transport selection now happens from the platform probe path,
drop the __init annotation from ffa_transport_init().

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/common.h |  4 +--
 drivers/firmware/arm_ffa/driver.c | 53 ++++++++++++++++++++++++++++++++++-----
 drivers/firmware/arm_ffa/smccc.c  |  2 +-
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_ffa/common.h b/drivers/firmware/arm_ffa/common.h
index 9c6425a81d0d..5cdf4bd222c6 100644
--- a/drivers/firmware/arm_ffa/common.h
+++ b/drivers/firmware/arm_ffa/common.h
@@ -18,9 +18,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid);
 
 #ifdef CONFIG_ARM_FFA_SMCCC
-int __init ffa_transport_init(ffa_fn **invoke_ffa_fn);
+int ffa_transport_init(ffa_fn **invoke_ffa_fn);
 #else
-static inline int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
+static inline int ffa_transport_init(ffa_fn **invoke_ffa_fn)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6efb85787e6e..97ecdb5dac09 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -36,6 +36,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -46,6 +47,7 @@
 
 #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
+#define FFA_PLATFORM_NAME	"arm-ffa"
 
 #define SENDER_ID_MASK		GENMASK(31, 16)
 #define RECEIVER_ID_MASK	GENMASK(15, 0)
@@ -114,6 +116,7 @@ struct ffa_drv_info {
 };
 
 static struct ffa_drv_info *drv_info;
+static struct platform_device *ffa_pdev;
 
 /*
  * The driver must be able to support all the versions from the earliest
@@ -2029,7 +2032,7 @@ static void ffa_notifications_setup(void)
 	ffa_notifications_cleanup();
 }
 
-static int __init ffa_init(void)
+static int ffa_probe(struct platform_device *pdev)
 {
 	int ret;
 	u32 buf_sz;
@@ -2042,6 +2045,7 @@ static int __init ffa_init(void)
 	drv_info = kzalloc_obj(*drv_info);
 	if (!drv_info)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, drv_info);
 
 	ret = ffa_version_check(&drv_info->version);
 	if (ret)
@@ -2103,19 +2107,56 @@ static int __init ffa_init(void)
 		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
 	free_pages_exact(drv_info->rx_buffer, rxtx_bufsz);
 free_drv_info:
+	platform_set_drvdata(pdev, NULL);
 	kfree(drv_info);
+	drv_info = NULL;
 	return ret;
 }
-module_init(ffa_init);
 
-static void __exit ffa_exit(void)
+static void ffa_remove(struct platform_device *pdev)
 {
+	struct ffa_drv_info *info = platform_get_drvdata(pdev);
+
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap();
-	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
-	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
-	kfree(drv_info);
+	free_pages_exact(info->tx_buffer, info->rxtx_bufsz);
+	free_pages_exact(info->rx_buffer, info->rxtx_bufsz);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	drv_info = NULL;
+}
+
+static struct platform_driver ffa_driver = {
+	.probe = ffa_probe,
+	.remove = ffa_remove,
+	.driver = {
+		.name = FFA_PLATFORM_NAME,
+	},
+};
+
+static int __init ffa_init(void)
+{
+	int ret;
+
+	ffa_pdev = platform_device_register_simple(FFA_PLATFORM_NAME,
+						   PLATFORM_DEVID_NONE,
+						   NULL, 0);
+	if (IS_ERR(ffa_pdev))
+		return PTR_ERR(ffa_pdev);
+
+	ret = platform_driver_register(&ffa_driver);
+	if (ret)
+		platform_device_unregister(ffa_pdev);
+
+	return ret;
+}
+module_init(ffa_init);
+
+static void __exit ffa_exit(void)
+{
+	platform_device_unregister(ffa_pdev);
+	platform_driver_unregister(&ffa_driver);
 }
 module_exit(ffa_exit);
 
diff --git a/drivers/firmware/arm_ffa/smccc.c b/drivers/firmware/arm_ffa/smccc.c
index 4d85bfff0a4e..e6125dd9f58f 100644
--- a/drivers/firmware/arm_ffa/smccc.c
+++ b/drivers/firmware/arm_ffa/smccc.c
@@ -17,7 +17,7 @@ static void __arm_ffa_fn_hvc(ffa_value_t args, ffa_value_t *res)
 	arm_smccc_1_2_hvc(&args, res);
 }
 
-int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
+int ffa_transport_init(ffa_fn **invoke_ffa_fn)
 {
 	enum arm_smccc_conduit conduit;
 

-- 
2.43.0


