Return-Path: <linux-integrity+bounces-6463-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B316BADD521
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE42C1AF3
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6282EE5E5;
	Tue, 17 Jun 2025 16:06:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2A2ED15A;
	Tue, 17 Jun 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176365; cv=none; b=FYTSuhwP32wFo3CkAT6l2N7J6/89n2t4nY6deX3L5y0OxENuvWcbV3iYGHsbJgZ9n8l0OCSfs6qXCs5J4nz7tTv6ybDtBJIAIR4j4LsOkpthxOK5Wf+Is+931R+jdNSE3T9YnE1QZ57FgUICj1MP4ETH/cYwD0F4i2VQqMhYRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176365; c=relaxed/simple;
	bh=tqn64CpxIoVLfBgWh0yazhjmJJ5Nq3lx93cjqaKoLPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH6hSRWAFQOpg5vGPpsxU/Qn9lT9Cg/Xml1uZFb3WOhrW57sdnX4uDdKy/IHqCinG6C7YohoFwn4c0NwBIbUDdgpW0Y879vKlehb8SRGk+sXTeLLOH4TIjD8r+LK9uZtse7MFypvDODktROjsr2V9tZxMZapxHUbhDBiMRKKr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94277150C;
	Tue, 17 Jun 2025 09:05:41 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568B93F58B;
	Tue, 17 Jun 2025 09:06:02 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v6 2/2] tpm_crb_ffa: handle tpm busy return code
Date: Tue, 17 Jun 2025 11:05:44 -0500
Message-ID: <20250617160544.444321-3-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617160544.444321-1-prachotan.bathi@arm.com>
References: <20250617160544.444321-1-prachotan.bathi@arm.com>
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
 drivers/char/tpm/tpm_crb_ffa.c | 66 +++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 089d1e54bb46..4615347795fa 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -10,8 +10,12 @@
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
 #include <linux/arm_ffa.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include "tpm_crb_ffa.h"
 
+#define memzero(s, n) memset((s), 0, (n))
+
 /* TPM service function status codes */
 #define CRB_FFA_OK			0x05000001
 #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
@@ -178,22 +182,18 @@ int tpm_crb_ffa_init(void)
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
-		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
-		       sizeof(struct ffa_send_direct_data2));
+		memzero(&tpm_crb_ffa->direct_msg_data2,
+			sizeof(struct ffa_send_direct_data2));
 
 		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
 		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
@@ -201,12 +201,12 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
 
 		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
-				&tpm_crb_ffa->direct_msg_data2);
+						&tpm_crb_ffa->direct_msg_data2);
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
 	} else {
-		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
-		       sizeof(struct ffa_send_direct_data));
+		memzero(&tpm_crb_ffa->direct_msg_data,
+			sizeof(struct ffa_send_direct_data));
 
 		tpm_crb_ffa->direct_msg_data.data1 = func_id;
 		tpm_crb_ffa->direct_msg_data.data2 = a0;
@@ -214,11 +214,51 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 		tpm_crb_ffa->direct_msg_data.data4 = a2;
 
 		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
-				&tpm_crb_ffa->direct_msg_data);
+						 &tpm_crb_ffa->direct_msg_data);
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
 	}
 
+	return ret;
+}
+
+static unsigned int busy_timeout_ms = 2000;
+/**
+ * busy_timeout_ms - Maximum time to retry before giving up on busy
+ *
+ * This parameter defines the maximum time in milliseconds to retry
+ * sending a message to the TPM service before giving up.
+ */
+module_param(busy_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(busy_timeout_ms,
+		 "Maximum time(in ms) to retry before giving up on busy");
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
+		if (ret == -EBUSY) {
+			usleep_range(50, 100);
+			if (ktime_after(ktime_get(), stop)) {
+				dev_warn(&tpm_crb_ffa->ffa_dev->dev,
+					 "Busy retry timed out\n");
+				break;
+			}
+		} else {
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.43.0


