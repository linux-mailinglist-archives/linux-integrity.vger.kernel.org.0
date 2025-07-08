Return-Path: <linux-integrity+bounces-6644-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60FAFDB68
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jul 2025 00:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DC4585041
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2822A7E6;
	Tue,  8 Jul 2025 22:52:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592702367BF;
	Tue,  8 Jul 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015150; cv=none; b=l7NH3e0TFlS5ZNuFEVzz5HeMaqXOV9PeGSLN9/IJSEarHu95Ls2tifx02q//hDM1Pr2+M82tmiu0n4vO1GJLZWtmNqWLys7/2UMHYnbKlclo72RpmcGRIm8myc814L7Lol1FX7zLX2YtZikH9W63nWIOkJskKlqqd2D/VT5S8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015150; c=relaxed/simple;
	bh=yfifoK1lCQIBGtO4PIoaGuKMpw1ve2V3EflpM9EmCY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX9LRQvZMrdOcmzAn7eAwFePxK2djuvs2W+k0O39P/kljOhsUwF9S7DjW6oUMugqayVZkH8gCNelzb+NbuzJCWBTO8lzsFQatm/vY/ZO3kwHJJ5CvtJ2CM2tW3N1+ucy/KAGzkTNdwyBZD8uuj8wpn4pIPo1cvjIIOaOx1iJq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FA41764;
	Tue,  8 Jul 2025 15:52:15 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9EE3F66E;
	Tue,  8 Jul 2025 15:52:27 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v9 3/3] tpm_crb_ffa: handle tpm busy return code
Date: Tue,  8 Jul 2025 17:51:51 -0500
Message-ID: <20250708225151.2473657-4-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708225151.2473657-1-prachotan.bathi@arm.com>
References: <20250708225151.2473657-1-prachotan.bathi@arm.com>
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
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 drivers/char/tpm/tpm_crb_ffa.c                | 45 ++++++++++++++++---
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..343377538fe9 100644
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
index 7faed6f3bf66..06599c07b746 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -10,8 +10,16 @@
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
 #include <linux/arm_ffa.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include "tpm_crb_ffa.h"
 
+static unsigned int busy_timeout_ms = 2000;
+
+module_param(busy_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(busy_timeout_ms,
+		 "Maximum time in ms to retry before giving up on busy");
+
 /* TPM service function status codes */
 #define CRB_FFA_OK			0x05000001
 #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
@@ -178,17 +186,13 @@ int tpm_crb_ffa_init(void)
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
@@ -214,6 +218,33 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
 	}
 
+	return ret;
+}
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


