Return-Path: <linux-integrity+bounces-5879-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93935A895C6
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0701715FE
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 07:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E427A934;
	Tue, 15 Apr 2025 07:57:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B61274670;
	Tue, 15 Apr 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703841; cv=none; b=b3PokfgV+WkiNvyXyEq63x1/S0gHVBvAeTl3+2MiG9Y4Mhzq7ojK/JH8dAVJmfvfy7C1m7s8gcAr8LeYPRGd6hYKhOwSdcvWXOOWIn1UUl9v2IZdcNS49v34s9wiVUoK5kRWJE9YAq04Dy2ugGTHMuBqfBpaxjfMXPM129kt1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703841; c=relaxed/simple;
	bh=1vq/iYdbkX8WMkFqiHBNY/g7/r4iMpTcSkW0w4OHcaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqmvkBn6RfBcEIhOYxdLNGK/nT9dAarFkVLia5aM1cZqsFuK3nYwPFoJ46CrdhTS/AqLNiMVqio0lbBHQ/WmTtq837GxOOMQTSRNYn0zU/QK6zLXLHWFc1xqPeKw93r7CLfIebhZCvhhcedIPvIxmBA2ga/9suNXHIedDpmQwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D18339;
	Tue, 15 Apr 2025 00:57:17 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89AFE3F694;
	Tue, 15 Apr 2025 00:57:17 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com,
	sgarzare@redhat.com
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 1/2] tpm_ffa_crb: access tpm service over FF-A direct message request v2
Date: Tue, 15 Apr 2025 08:57:11 +0100
Message-Id: <20250415075712.2157073-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415075712.2157073-1-yeoreum.yun@arm.com>
References: <20250415075712.2157073-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For secure partition with multi service, tpm_ffa_crb can access tpm
service with direct message request v2 interface according to chapter 3.3,
TPM Service Command Response Buffer Interface Over FF-A specificationi v1.0 BET.

This patch reflects this spec to access tpm service over
FF-A direct message request v2 ABI.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
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


