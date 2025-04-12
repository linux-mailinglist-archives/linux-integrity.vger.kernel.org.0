Return-Path: <linux-integrity+bounces-5857-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A821EA86B1D
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 07:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC68C0C9F
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 05:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8817B502;
	Sat, 12 Apr 2025 05:47:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1114A62A;
	Sat, 12 Apr 2025 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436847; cv=none; b=m7C9xUeJM6qiv3pvv7hLd/T68Uy/Fi5eA04rrwrgAPwAPnvoyl4zX9oDx6r99zx9r7FRGJTG4xGb5hj53kNcwf9j/rq/vsObGAsdysJaNJIWEzd2wOjGmBPveDW/FnYmT49Qe1FGQkEP5zfnnrAiE93ASt3//pZsSXIAPU5qYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436847; c=relaxed/simple;
	bh=HAgXGPwsFZUAPUtRHWbBey2pt1vWdGgEcfyzccBe4ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gSBwWVsr9zmfxydf5TZIjK+q2A4rXrZkZSuML8UFoIFb3RLfq/ydIzaQcDmPwDId4z0v0zD4iEE1rB6h41fIhKkJfvEQfLAJWJhHov8TVd/ORT4PrMMj1Mb3Syx8+6jD67jmsSKEaLIOydSwdcTKAuH0ohai6G8wRB3XNo5rNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF10106F;
	Fri, 11 Apr 2025 22:47:23 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B61CF3F694;
	Fri, 11 Apr 2025 22:47:22 -0700 (PDT)
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
Subject: [PATCH v3] tpm_ffa_crb: access tpm service over FF-A direct message request v2
Date: Sat, 12 Apr 2025 06:47:21 +0100
Message-Id: <20250412054721.1647439-1-yeoreum.yun@arm.com>
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
TPM Service Command Response Buffer Interface Over FF-A specification, v1.0 BET.

This patch reflects this spec to access tpm service over
FF-A direct message request v2 ABI.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
Since v2:
    - rewokring commit message
    - https://lore.kernel.org/all/20250411090856.1417021-1-yeoreum.yun@arm.com/

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


