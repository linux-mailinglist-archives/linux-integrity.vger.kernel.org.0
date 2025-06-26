Return-Path: <linux-integrity+bounces-6558-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063EAEA5AA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD53D568007
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB02EF9AE;
	Thu, 26 Jun 2025 18:45:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7F2EF2A6;
	Thu, 26 Jun 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963539; cv=none; b=IXPIsuCZDeq6VimRvD5IUw9VRNoSQmd/iSF2j2eXrinjrkto+y54iXVIBFZFCjvAXIBXT990YAXbE02aF9aSyxyv124IC/GQISDgMDV2z/TgZ6h6ffdCJeC5APvvApQTOazNwCHhzj2fcCNesiFgvskfaCcj1DTyEarBWyECDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963539; c=relaxed/simple;
	bh=LZaIsLivWrm8jAuNh46A+s8OExisEIxeFrTonwFIkBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVxEujur/iDDjt8kJK6hn9Hv/JecDwPcaygwr32s/sn12YK9CMkHAubLrNa2ELgj6Nvqr7TZC6pmiHXt5ure6bKczIkPhUdJoEfomHgMr/j5KHvrHz4LsdXmhaeaXQ8xXDWQM+CfGrjPhG6PoINrrLNz7ZqnlEG5GA7JgPOTbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2093271B;
	Thu, 26 Jun 2025 11:45:19 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2686A3F66E;
	Thu, 26 Jun 2025 11:45:37 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v8 3/3] tpm_crb_ffa: handle tpm busy return code
Date: Thu, 26 Jun 2025 13:45:21 -0500
Message-ID: <20250626184521.1079507-4-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626184521.1079507-1-prachotan.bathi@arm.com>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 [1] can support secure
partitions that support multiple services. For CRB over FF-A interface,
if the firmware TPM or TPM service [1] shares its Secure Partition (SP)
with another service, message requests may fail with a -EBUSY error.

To handle this, replace the single check and call with a retry loop
that attempts the TPM message send operation until it succeeds or a
configurable timeout is reached. Implement a _try_send_receive function
to do a single send/receive and modify the existing send_receive to
add this retry loop.
The retry mechanism introduces a module parameter (`busy_timeout_ms`,
default: 2000ms) to control how long to keep retrying on -EBUSY
responses. Between retries, the code waits briefly (50-100 microseconds)
to avoid busy-waiting and handling TPM BUSY conditions more gracefully.

The parameter can be modified at run-time as such:
echo 3000 | tee /sys/module/tpm_crb_ffa/parameters/busy_timeout_ms
This changes the timeout from the default 2000ms to 3000ms.

[1] TPM Service Command Response Buffer Interface Over FF-A
https://developer.arm.com/documentation/den0138/latest/

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 drivers/char/tpm/tpm_crb_ffa.c                | 49 ++++++++++++++++---
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..eb1ebbc328ab 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7214,6 +7214,14 @@
 			causing a major performance hit, and the space where
 			machines are deployed is by other means guarded.
 
+	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
+			Maximum time in milliseconds to retry sending a message
+			to the TPM service before giving up. This parameter controls
+			how long the system will continue retrying when the TPM
+			service is busy.
+			Format: <unsigned int>
+			Default: 2000 (2 seconds)
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 397cc3b0a478..a6c9e9c2c344 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -10,6 +10,8 @@
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
 #include <linux/arm_ffa.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include "tpm_crb_ffa.h"
 
 #define memzero(s, n) memset((s), 0, (n))
@@ -180,17 +182,13 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
-static int __tpm_crb_ffa_send_receive(unsigned long func_id,
-				      unsigned long a0,
-				      unsigned long a1,
-				      unsigned long a2)
+static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
+					  unsigned long a0, unsigned long a1,
+					  unsigned long a2)
 {
 	const struct ffa_msg_ops *msg_ops;
 	int ret;
 
-	if (!tpm_crb_ffa)
-		return -ENOENT;
-
 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
 
 	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
@@ -221,6 +219,43 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
 	}
 
+	return ret;
+}
+
+static unsigned int busy_timeout_ms = 2000;
+/**
+ * This parameter defines the maximum time in milliseconds to retry
+ * sending a message to the TPM service before giving up.
+ */
+module_param(busy_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(busy_timeout_ms,
+		 "Maximum time in ms to retry before giving up on busy");
+
+static int __tpm_crb_ffa_send_receive(unsigned long func_id, unsigned long a0,
+				      unsigned long a1, unsigned long a2)
+{
+	ktime_t start, stop;
+	int ret;
+
+	if (!tpm_crb_ffa)
+		return -ENOENT;
+
+	start = ktime_get();
+	stop = ktime_add(start, ms_to_ktime(busy_timeout_ms));
+
+	for (;;) {
+		ret = __tpm_crb_ffa_try_send_receive(func_id, a0, a1, a2);
+
+		if (ret != -EBUSY)
+			break;
+
+		usleep_range(50, 100);
+		if (ktime_after(ktime_get(), stop)) {
+			dev_warn(&tpm_crb_ffa->ffa_dev->dev,
+				 "Busy retry timed out\n");
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.43.0


