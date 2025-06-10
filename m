Return-Path: <linux-integrity+bounces-6405-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC55AD44DD
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E098A3A439D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B5284B25;
	Tue, 10 Jun 2025 21:35:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5823958C;
	Tue, 10 Jun 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591331; cv=none; b=C1C857LN7WDAcTfseqqBoIX90t2WxjcKofvEL+CjHQfi2cbhj+6fS5yjQug+kQgRqWDeDlS6+xvAiJ+3aelPdfifK55MpMkt2ybvAJY78O1Iqr4ZcGkOx3J7Y5jndYHDafJGqcqKxSrzvBiBILNHZWp81bw5rciZrRULs/6B3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591331; c=relaxed/simple;
	bh=pCV5e9SgIfZkWF2C5ae5BFXAb7IvQC6jCuCk0AWF18M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5L3mNvwib5Y2VA+Y6OoXnG6Qq+02qc8UqtgkR6eLvlcwwq9m90X8fZuhoxEIjEHkx/ha1j9ijHN5IyOlpGJqLU/cLzec0T7g0cUohDvEHzzdwj/a89akblsMYu8gowAkDU1vLCGMrfOKs7bpIT6D6HPr76FALWzVyytQfLw52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A79B168F;
	Tue, 10 Jun 2025 14:35:09 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9432D3F66E;
	Tue, 10 Jun 2025 14:35:28 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v2 1/1] tpm_crb_ffa: handle tpm busy return code
Date: Tue, 10 Jun 2025 16:35:05 -0500
Message-ID: <20250610213505.3881352-2-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610213505.3881352-1-prachotan.bathi@arm.com>
References: <20250610213505.3881352-1-prachotan.bathi@arm.com>
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
This adds a parameterized variable (default 2000ms)
 that indicates the maximum time to keep retrying for.
When the TPM service returns a BUSY error code, we sleep
 50-100us before retrying again, until we are over the
busy timeout.

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 78 +++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..122984e15971 100644
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
@@ -191,34 +204,51 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
 
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
+		// Check if the TPM service returned busy
+		if (ret == -EBUSY)
+			pr_err("TPM says busy, trying again, value, ret: %d\n",
+			       ret);
+		else
+			// If TPM did not return busy, we are done, exit the loop
+			break;
+		// Sleep for a short time before retrying to avoid busy looping
+		usleep_range(50, 100);
+	} while (ktime_before(ktime_get(), stop));
+	// If we are here, we either got a valid response or we are over the busy timeout
 
 	return ret;
 }
-- 
2.43.0


