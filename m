Return-Path: <linux-integrity+bounces-6383-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C689BAD20B3
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 16:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C184169875
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862D7253933;
	Mon,  9 Jun 2025 14:16:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D6137C2A;
	Mon,  9 Jun 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478607; cv=none; b=Ba4ymhvAIHbSqRJc5ZcKVvx9Rxg7Q/TunFgFtdZFvljkHlgbPuzWwTBYU+bbj0aGoDIGcL4wLCqZADys72rVOwOO5RChm/XPMq7kZ7BF9xi5WuK93KloPPtMXwtrafotvrBSdG3HOrqtMJv6v9RxMOhwrxPj3H+edlNaWs6q+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478607; c=relaxed/simple;
	bh=KJtqNOaw0hT/sT9zpcXOR25EPvmlDm7S0LsXAzpPIz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhVjaEx6zyRfNbAMadOdzNSYh5zn3EN2Q1F0mrqdWG7VpbcphB4NLeRO2Sjkg2UNjwQfLHpz/oQhgbOHLW9ZYQw0wTUfwTlSjQ4B6m/ZA/o0s9kBqXbDa5wqhiQWyi/phq2H2X8JueB7Vyk3wdF6JXklhc72KA6tPQcq71wARUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0A8150C;
	Mon,  9 Jun 2025 07:16:26 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD6233F673;
	Mon,  9 Jun 2025 07:16:44 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v1 1/1] tpm_ffa_crb: handle tpm busy return code
Date: Mon,  9 Jun 2025 09:16:00 -0500
Message-ID: <20250609141600.3601340-2-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609141600.3601340-1-prachotan.bathi@arm.com>
References: <20250609141600.3601340-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 can
support SPs that support multiple services.
If the TPM service is sharing the SP with another service,
it could get an error code of BUSY if the other service is
in process.
This patch adds a parameterized variable (default 2000ms)
 that indicates the maximum time to keep retrying for.

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..e47e110bac9e 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -10,6 +10,8 @@
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
 #include <linux/arm_ffa.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include "tpm_crb_ffa.h"
 
 /* TPM service function status codes */
@@ -178,6 +180,17 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
+static unsigned int busy_timeout = 2000;
+/**
+ * busy_timeout - Maximum time to retry before giving up on busy
+ *
+ * This parameter defines the maximum time in milliseconds to retry
+ * sending a message to the TPM service before giving up.
+ */
+module_param(busy_timeout, uint, 0644);
+MODULE_PARM_DESC(busy_timeout,
+		 "Maximum time to retry before giving up on busy");
+
 static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
 				      unsigned long a0,
 				      unsigned long a1,
@@ -191,34 +204,47 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
 
 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
 
-	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
-		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
-		       sizeof(struct ffa_send_direct_data2));
+	ktime_t start;
+	ktime_t stop;
+
+	start = ktime_get();
+	stop = ktime_add(start, ms_to_ktime(busy_timeout));
+
+	do {
+		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
+			memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
+			       sizeof(struct ffa_send_direct_data2));
 
-		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
-		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
-		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
-		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
+			tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
+			tpm_crb_ffa->direct_msg_data2.data[1] = a0;
+			tpm_crb_ffa->direct_msg_data2.data[2] = a1;
+			tpm_crb_ffa->direct_msg_data2.data[3] = a2;
 
-		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
+			ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
 				&tpm_crb_ffa->direct_msg_data2);
-		if (!ret)
-			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
-	} else {
-		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
-		       sizeof(struct ffa_send_direct_data));
-
-		tpm_crb_ffa->direct_msg_data.data1 = func_id;
-		tpm_crb_ffa->direct_msg_data.data2 = a0;
-		tpm_crb_ffa->direct_msg_data.data3 = a1;
-		tpm_crb_ffa->direct_msg_data.data4 = a2;
-
-		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
-				&tpm_crb_ffa->direct_msg_data);
-		if (!ret)
-			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
-	}
+			if (!ret)
+				ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
+		} else {
+			memset(&tpm_crb_ffa->direct_msg_data, 0x00,
+			       sizeof(struct ffa_send_direct_data));
 
+			tpm_crb_ffa->direct_msg_data.data1 = func_id;
+			tpm_crb_ffa->direct_msg_data.data2 = a0;
+			tpm_crb_ffa->direct_msg_data.data3 = a1;
+			tpm_crb_ffa->direct_msg_data.data4 = a2;
+
+			ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
+				&tpm_crb_ffa->direct_msg_data);
+			if (!ret)
+				ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
+		}
+		if (ret == -EBUSY)
+			pr_err("TPM says busy, trying again, value, ret: %d\n",
+			       ret);
+		else
+			break;
+		usleep_range(50, 100);
+	} while (ktime_before(ktime_get(), stop));
 
 	return ret;
 }
-- 
2.43.0


