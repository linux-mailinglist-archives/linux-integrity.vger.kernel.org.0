Return-Path: <linux-integrity+bounces-5762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03AA84174
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 13:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6BC4C3A6C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEA21B9C7;
	Thu, 10 Apr 2025 11:07:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F71DF991;
	Thu, 10 Apr 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283227; cv=none; b=cF2b56UlpNURpkny8yEVaAnlq34cLP/3YlWXxNtPh+avgBTMmfw0Cosll/nhOpOss9drUTVlY8pqME2qblki+7ZjcerwxBhSQFfgQ8MOWzP/raC338OnK9tooZZv2hBgj3+AOoXKTWUeLxt/YcORFS7VKIBLrkouLFKa6ALH7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283227; c=relaxed/simple;
	bh=o2o+6a4xQL07Dgpaqul/mMfczU2V+raqlFx4x3NQwp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tIHWcYsoHfLWBrUGpTAjLJx+7t/7EvV1sVQ/23LoV4kbn1aix4KtG2Z3Xg751yKT/SKisyoKm4P9HTUZN+2xG3osagIesOWjqxHufnWX/LZag1wXGH+Zg4bC/SiveBvPJ8XtWzJ4jJdVd4JxRWx2wGZuP22jcsBfBVlY/YV0r4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC60106F;
	Thu, 10 Apr 2025 04:07:04 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB0023F6A8;
	Thu, 10 Apr 2025 04:07:02 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] tpm_ffa_crb: access tpm service over FF-A direct message request v2
Date: Thu, 10 Apr 2025 12:07:01 +0100
Message-Id: <20250410110701.1244965-1-yeoreum.yun@arm.com>
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
 drivers/char/tpm/tpm_crb_ffa.c | 55 ++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 3169a87a56b6..0716c88e0281 100644
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
+			!ffa_partition_supports_direct_req2_recv(ffa_dev)) {
 		pr_err("TPM partition doesn't support direct message receive.\n");
 		return -EINVAL;
 	}
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


