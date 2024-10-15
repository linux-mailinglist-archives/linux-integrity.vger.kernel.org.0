Return-Path: <linux-integrity+bounces-3814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B899F762
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 21:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2161E284564
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF71B6CF6;
	Tue, 15 Oct 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DAjuobc9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2831F80C3;
	Tue, 15 Oct 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021188; cv=none; b=Pt3cPzk4x++7HCl3eZqWEpiLQFutp6f0wlI+R/DKzz620wKGFVmynrppEW9vn1iikIHnzAeku0c06MFQogLeb3k6mmKhnutp4TCuXJB/1U8xejtfTTtYYJg8gpIS8duRU6OBq7zsyVwSYW/c1KxvdnI/6ecXhfNXM84FADAHNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021188; c=relaxed/simple;
	bh=SaC2xpsyVmEewrREwaV1t3ezVOEBlC3wRbOP+ZWT4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMZhWeM91S4BPCCWLt5yvPk3gaLAJjd3pCr69bRt74V2K6Omh/vbADuYDbdIqfDodmzSSOCPpL7VhQKS94k4prnRm3GGUd3DF7GSH7PWIlM8kdVA+nhi0dMiYEZE0x3H4r/aYEPk5l+nU80vTXoeDe7Poukg6zpJcFsbX89nFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DAjuobc9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJY3k3029851;
	Tue, 15 Oct 2024 19:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Nalg9xPyFkMtebeWQh8ejquc7+ahdb3+mMo3lfKkG
	Kw=; b=DAjuobc9QCfYmwAmho0aHFIjpEqtv4HL+zr9ELczoPqgQGFbsQ7VBMrnb
	u3RdhFATjGd0zrCrnpXDRU4pffxZLwDdTMyMCH1t7ukvRTHXzcBnJO5korkUwLkw
	BHS6cj4aOS94op2vIorg8b/YM+wpIOD2gLBxhTpAA9uM+gm/NwbA0nw2ndlUry1X
	l7flc19VSMqSEpkiBbM08dp3+N9wkvXD2LCRNnb84AHhbiPcPHN0eo1TQmqHNY0j
	/St+IamtD72KxOCE+fNAG3kGg10PhpHq1/ZUxyzVq0SP5K1MZM+8wXxeYg+PS3LC
	qXAG5H6Ag+URWCaxRe/gtLZokTQtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17g67w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:39:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FJdPSn009465;
	Tue, 15 Oct 2024 19:39:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17g67u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:39:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHmpsI027499;
	Tue, 15 Oct 2024 19:39:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txnpyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:39:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FJdMAe32834292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:39:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C55E520043;
	Tue, 15 Oct 2024 19:39:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FF720040;
	Tue, 15 Oct 2024 19:39:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.187.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 19:39:20 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, James.Bottomley@HansenPartnership.com,
        roberto.sassu@huawei.com, mapengyu@gmail.com,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to be disabled on boot
Date: Tue, 15 Oct 2024 15:39:16 -0400
Message-ID: <20241015193916.59964-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Si7hbLg7yXxAS_aAV5YjnZuOD0OiD09b
X-Proofpoint-GUID: sI-PfRBgqaUlq4s9QaqjBN_9lm-_k7WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=784 phishscore=0 clxscore=1011
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150131

The initial TPM2 HMAC session capability added HMAC authentication to
each and every TPM communication making the pcr_extend performance
abysmal for HW TPMs. Further, the new CONFIG_TCG_TPM2_HMAC option was
configured by default on x86_64.

The decision to use the TPM2 HMAC session capability feature doesn't
differentiate between the critical encrypted and the non-encrypted
communication, but when configured is required for all TPM communication.

In addition, the reason to HMAC the tpm2_pcr_extend() as provided in commit
6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()") was to protect
tpm2_pcr_extend() when used by "trusted keys" to lock the PCR.  However,
locking the PCR is currently limited to TPM 1.2.

We can revert the commit which adds the HMAC sessions for
tpm2_pcr_extend, allow just the TPM2 pcr_extend HMAC capability to be
disabled on boot for better IMA performance, or define a generic boot
command line option to disable HMAC in general.  This patch allows
disabling the HMAC for just the TPM2_pcr_extend.

Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Comment: applied and tested with/without patches in Jarkko's hmac-v5 branch -
commit 92999f9cd11f ("tpm: flush the auth session only when /dev/tpm0 is open")

 .../admin-guide/kernel-parameters.txt         |  5 ++
 drivers/char/tpm/tpm2-cmd.c                   | 41 ++++++++++---
 drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
 include/linux/tpm.h                           |  4 ++
 4 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..c7811f32ba28 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6727,6 +6727,11 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
+	tpm_pcr_extend_hmac_disable [HW,TPM]
+			Disable TPM2 pcr_extend HMAC for better IMA
+			performance. By default is set to true (1).
+			Mainly needed when using a HW TPM2.
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index aba024cbe7c5..bac409520a72 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -14,6 +14,14 @@
 #include "tpm.h"
 #include <crypto/hash_info.h>
 
+static int __ro_after_init tpm2_pcr_extend_hmac = 1;
+static int __init tpm2_pcr_extend_hmac_setup(char *str)
+{
+	tpm2_pcr_extend_hmac = 0;
+	return 0;
+}
+__setup("tpm2_pcr_extend_hmac_disable", tpm2_pcr_extend_hmac_setup);
+
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -232,18 +240,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	rc = tpm2_start_auth_session(chip);
-	if (rc)
-		return rc;
+	if (tpm2_pcr_extend_hmac) {
+		rc = tpm2_start_auth_session(chip);
+		if (rc)
+			return rc;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc) {
-		tpm2_end_auth_session(chip);
+		if (tpm2_pcr_extend_hmac)
+			tpm2_end_auth_session(chip);
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
-	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	if (tpm2_pcr_extend_hmac) {
+		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	} else {
+		tpm_buf_append_handle(chip, &buf, pcr_idx, NULL);
+		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
@@ -253,9 +269,16 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	if (tpm2_pcr_extend_hmac) {
+		tpm_buf_fill_hmac_session(chip, &buf);
+		rc = tpm_transmit_cmd(chip, &buf, 0,
+				      "attempting extend a PCR value");
+		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	} else {
+		rc = tpm_transmit_cmd(chip, &buf, 0,
+				      "attempting extend a PCR value");
+	}
+
 
 	tpm_buf_destroy(&buf);
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index de860773eead..fae56dfe0d92 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -205,6 +205,14 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
+			   u32 handle, u8 *name)
+{
+	tpm_buf_append_u32(buf, handle);
+	/* count the number of handles in the upper bits of flags */
+	buf->handles++;
+}
+
 /**
  * tpm_buf_append_name() - add a handle area to the buffer
  * @chip: the TPM chip structure
@@ -237,9 +245,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_u32(buf, handle);
-		/* count the number of handles in the upper bits of flags */
-		buf->handles++;
+		tpm_buf_append_handle(chip, buf, handle, name);
 		return;
 	}
 
@@ -272,6 +278,31 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphrase_len)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphrase_len;
+
+	if (tpm_buf_length(buf) != offset) {
+		/* not the first session so update the existing length */
+		len += get_unaligned_be32(&buf->data[offset]);
+		put_unaligned_be32(len, &buf->data[offset]);
+	} else {
+		tpm_buf_append_u32(buf, len);
+	}
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, passphrase_len);
+	tpm_buf_append(buf, passphrase, passphrase_len);
+}
+
 /**
  * tpm_buf_append_hmac_session() - Append a TPM session element
  * @chip: the TPM chip structure
@@ -309,26 +340,8 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		/* offset tells us where the sessions area begins */
-		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-		u32 len = 9 + passphrase_len;
-
-		if (tpm_buf_length(buf) != offset) {
-			/* not the first session so update the existing length */
-			len += get_unaligned_be32(&buf->data[offset]);
-			put_unaligned_be32(len, &buf->data[offset]);
-		} else {
-			tpm_buf_append_u32(buf, len);
-		}
-		/* auth handle */
-		tpm_buf_append_u32(buf, TPM2_RS_PW);
-		/* nonce */
-		tpm_buf_append_u16(buf, 0);
-		/* attributes */
-		tpm_buf_append_u8(buf, 0);
-		/* passphrase */
-		tpm_buf_append_u16(buf, passphrase_len);
-		tpm_buf_append(buf, passphrase, passphrase_len);
+		tpm_buf_append_auth(chip, buf, attributes, passphrase,
+				    passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 28a932aa0416..d30bb1c114f1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -504,9 +504,13 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
+			   u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.47.0


