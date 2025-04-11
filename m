Return-Path: <linux-integrity+bounces-5832-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D1A8578A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33259A667A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A81C5F09;
	Fri, 11 Apr 2025 09:09:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776E1EFFB0;
	Fri, 11 Apr 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362542; cv=none; b=WDNcX5dfVxPNw8hkWXJXG8rC+5U07yeiMVSorNkZK1+7xb78mQbZwR8JtTcDC9ads8gtWwfL4zj8Td/foEylilumuiflVy796aNuqirKzftvAuJITY18Ja7KEOJjKuCeY4lD9PT5obpU4hifl9WPDZq2jyFe/1OBopMS57uIu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362542; c=relaxed/simple;
	bh=VYdZKuADpSZfKN7QRE8E6no6p8GxaxTH4ayPTxzMQh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t94Uu4M9+8sABWZQBSEbhE7KKVAiYqHcj36hTTiI/otMvVPZy/US7PESvO2WZNk9pwqzj8pqZR4wmoqaU0fqsHRjSeUklnpuKiw9ENlTf1/dzZx0g+hLr7msiliu027UUcAOSHOfPsXGDgC4qRvzxbYal0i8GkH8E38LnEQzXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3C0106F;
	Fri, 11 Apr 2025 02:08:59 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 993FC3F6A8;
	Fri, 11 Apr 2025 02:08:58 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct message request v2
Date: Fri, 11 Apr 2025 10:08:56 +0100
Message-Id: <20250411090856.1417021-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For secure partition with multi service, tpm_ffa_crb can access tpm
service with direct message request v2 interface according to chapter 3.3,
TPM Service Command Response Buffer Interface Over FF-A specification [0].

This patch reflects this spec to access tpm service over
FF-A direct message request v2 ABI.

Link: https://developer.arm.com/documentation/den0138/latest/ [0]
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
Since v1:
    - Fix indentation.
    - https://lore.kernel.org/all/20250410110701.1244965-1-yeoreum.yun@arm.com/
---
 drivers/char/tpm/tpm_crb_ffa.c | 55 ++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 3169a87a56b6..fed775cf53ab 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -105,7 +105,10 @@ struct tpm_crb_ffa {
 	u16 minor_version;
 	/* lock to protect sending of FF-A messages: */
 	struct mutex msg_data_lock;
-	struct ffa_send_direct_data direct_msg_data;
+	union {
+		struct ffa_send_direct_data direct_msg_data;
+		struct ffa_send_direct_data2 direct_msg_data2;
+	};
 };

 static struct tpm_crb_ffa *tpm_crb_ffa;
@@ -185,18 +188,34 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,

 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;

-	memset(&tpm_crb_ffa->direct_msg_data, 0x00,
-	       sizeof(struct ffa_send_direct_data));
-
-	tpm_crb_ffa->direct_msg_data.data1 = func_id;
-	tpm_crb_ffa->direct_msg_data.data2 = a0;
-	tpm_crb_ffa->direct_msg_data.data3 = a1;
-	tpm_crb_ffa->direct_msg_data.data4 = a2;
+	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
+		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
+		       sizeof(struct ffa_send_direct_data2));
+
+		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
+		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
+		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
+		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
+
+		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
+				&tpm_crb_ffa->direct_msg_data2);
+		if (!ret)
+			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
+	} else {
+		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
+		       sizeof(struct ffa_send_direct_data));
+
+		tpm_crb_ffa->direct_msg_data.data1 = func_id;
+		tpm_crb_ffa->direct_msg_data.data2 = a0;
+		tpm_crb_ffa->direct_msg_data.data3 = a1;
+		tpm_crb_ffa->direct_msg_data.data4 = a2;
+
+		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
+				&tpm_crb_ffa->direct_msg_data);
+		if (!ret)
+			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
+	}

-	ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
-			&tpm_crb_ffa->direct_msg_data);
-	if (!ret)
-		ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);

 	return ret;
 }
@@ -231,8 +250,13 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)

 	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
 	if (!rc) {
-		*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
-		*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
+		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
+			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
+			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
+		} else {
+			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
+			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
+		}
 	}

 	return rc;
@@ -277,7 +301,8 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)

 	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure

-	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
+	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
+	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
 		pr_err("TPM partition doesn't support direct message receive.\n");
 		return -EINVAL;
 	}
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


