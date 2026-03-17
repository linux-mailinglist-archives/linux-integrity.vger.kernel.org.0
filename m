Return-Path: <linux-integrity+bounces-9009-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKm9Cyd9uWmxHAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9009-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:19 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D42ADB04
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2033125EA8
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF52F39D7;
	Tue, 17 Mar 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l2/TzO5p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522062F691D;
	Tue, 17 Mar 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763619; cv=none; b=H3JuFDNp0Sk4UZ1GNWnGTmhgmpxI4nDk/qiPZXwQGhN5k/HgiRnTlFpET6EIhlpGWQPgmuMLS/r8bXhl8/U6yvDgUH9+7RsFpKLkq3bta89riE8hv+vrNthAo3fKrHo6jQ26iGJLTCt39/GC9WDgFtYtnJuWmGWqu1jhl4bIek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763619; c=relaxed/simple;
	bh=kMznvxDxNKPo1eYStvhpKWXxDrQacVSYIj3z3hD0Mm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3MYXf3yOwXFiZNINyFfRnJP8MqUMrLagb9wB1sib9dwzYpBqrIL39INKJOGo/tCpsUhkvCmDFA0eaPhtPFApml5pyoR+1++RK0KtPF9vIk0aSC+uubXDT/tIvxXDST+ULJUT7wsrSGPzVoNeFtcz/OwXxusJvY+MGMr2ztTvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l2/TzO5p; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HDe6dI032629;
	Tue, 17 Mar 2026 16:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6PrSG
	M2c8A4Swmft+dJ+URUdWPRK8pm9zwum/+Ioqq8=; b=l2/TzO5pd5y6fJS2qHif4
	zTqnjcl/dggjy1RpuTsXKJc0kAt44h3IVpQD/j61SGYM1ncDp9RqtNO0SyWfRW2P
	/jdVLAiz9qqHmAviJMPZQcjk2NQS6NqetEUOYq4djsumyCMVLUux2YrmGVcsZ3R7
	6vHHEBACK4SeYypQ7gvVEhyL+7xxW5Z7VSTL1JzgZFL6NENMfLfo85dFNrtdi1pF
	gPU1YcZSYGlA6AIdXJ2APrQS0E64/wfNWIGxcsKe4BKgHFrSZvdf+eDnXy7Y0VGm
	yN7woWDlTLrWUvmw1K1oxTkEBCqNglQDWMTIsneSRSVkyfXdjRqzuust7Y/0Ec5R
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x4fej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HFHp0f002741;
	Tue, 17 Mar 2026 16:06:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4mjp09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62HG2QOx028917;
	Tue, 17 Mar 2026 16:06:37 GMT
Received: from localhost (alecbro-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4mjnxk-1;
	Tue, 17 Mar 2026 16:06:36 +0000
From: Alec Brown <alec.r.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jarkko@kernel.org
Cc: peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
        ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, ardb@kernel.org,
        alec.r.brown@oracle.com
Subject: [PATCH 1/4] tpm: Initial step to reorganize TPM public headers
Date: Tue, 17 Mar 2026 16:03:32 +0000
Message-ID: <20260317160613.2899129-2-alec.r.brown@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317160613.2899129-1-alec.r.brown@oracle.com>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170142
X-Proofpoint-GUID: rmnTDjHoBOM9C3HhxkwT823argqApvCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MiBTYWx0ZWRfXwC7yj6QYmVvW
 ernUzoUDOPJvlhuiYZcreUn7slD+CYpHGm/o8OIIyKACCmaIQkFs4E7FSptm5MOZRH8Uv2PDwTd
 It2S5UXaBFIYF1ghnVStd3OHbKK2I1qDWhfr/DmSmHdzwEHoBmqEws/+4bZZsHJLz1EQRNQqwkG
 ZZrD1LHDJw18fRalWlrrmOl7PynUfEmy4gZCETUcSTws/1weRYNJrOvAagscY7uDoiFWL0Jz8pF
 UM08/SLsq7FVPRheJyZejmgAUefDthU2tU2uawESY0LERKDn2Nf2x6LxaSZHZ6dtOrmZ47flSVD
 V9ysz/LZCRIcbNlwjjOgq50Os6RoUqleNpHDC/lk6CnRNW0uPViy5kdtIIakpPUNhLi6wffOXnN
 ivmq6HVntmucsWRGHN2567gDKtUQb8dn4a3nUwNFbEEaucYyWlT6zzs1EeEtI+5+JFXkYkI79cy
 oAJG5/l9hLln2hyoVp0N0LwvwN6alninfPjPOoDY=
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b97c0f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=xt6ew7UTAAAA:8 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8
 a=aY4EUbk01JFM1SX_nzkA:9 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22
 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: rmnTDjHoBOM9C3HhxkwT823argqApvCn
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9009-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alec.r.brown@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A29D42ADB04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ross Philipson <ross.philipson@oracle.com>

From: Ross Philipson <ross.philipson@oracle.com>

Consolidate TPM1 constants in tpm_command.h and remove duplicate
constants from tpm1-cmd.c.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
---
 drivers/char/tpm/tpm-buf.c                |  1 -
 drivers/char/tpm/tpm1-cmd.c               | 14 +-------
 include/keys/trusted_tpm.h                |  1 -
 include/linux/tpm.h                       |  2 ++
 include/linux/tpm_command.h               | 43 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm1.c |  1 -
 security/keys/trusted-keys/trusted_tpm2.c |  1 -
 7 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dc882fc9fa9e..4c4f450630df 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -3,7 +3,6 @@
  * Handling of TPM command and other buffers.
  */
 
-#include <linux/tpm_command.h>
 #include <linux/module.h>
 #include <linux/tpm.h>
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index b49a790f1bd5..664ca1fff2e8 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -22,8 +22,6 @@
 
 #include "tpm.h"
 
-#define TPM_MAX_ORDINAL 243
-
 /*
  * Array with one entry per ordinal defining the maximum amount
  * of time the chip could take to return the result.  The ordinal
@@ -308,9 +306,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
-#define TPM_ORD_STARTUP 153
-#define TPM_ST_CLEAR 1
-
 /**
  * tpm1_startup() - turn on the TPM
  * @chip: TPM chip to use
@@ -459,7 +454,6 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	return 0;
 }
 
-#define TPM_ORD_PCR_EXTEND 20
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
@@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	return rc;
 }
 
-#define TPM_ORD_GET_CAP 101
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
@@ -511,7 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-#define TPM_ORD_GET_RANDOM 70
 struct tpm1_get_random_out {
 	__be32 rng_data_len;
 	u8 rng_data[TPM_MAX_RNG_DATA];
@@ -580,13 +572,12 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	return rc;
 }
 
-#define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
 	if (rc)
 		return rc;
 
@@ -609,7 +600,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	return rc;
 }
 
-#define TPM_ORD_CONTINUE_SELFTEST 83
 /**
  * tpm1_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
@@ -726,8 +716,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
-#define TPM_ORD_SAVESTATE 152
-
 /**
  * tpm1_pm_suspend() - pm suspend handler
  * @chip: TPM chip to use.
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 0fadc6a4f166..3a0fa3bc8454 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -3,7 +3,6 @@
 #define __TRUSTED_TPM_H
 
 #include <keys/trusted-type.h>
-#include <linux/tpm_command.h>
 
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 202da079d500..18dcf0ef46f6 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,6 +25,8 @@
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
+#include "tpm_command.h"
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
 #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index f5c03e9c3913..9a8991b8801d 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -2,28 +2,45 @@
 #ifndef __LINUX_TPM_COMMAND_H__
 #define __LINUX_TPM_COMMAND_H__
 
+/************************************************/
+/* TPM 1 Family Chips                           */
+/************************************************/
+
 /*
- * TPM Command constants from specifications at
- * http://www.trustedcomputinggroup.org
+ * TPM 1.2 Main Specification
+ * https://trustedcomputinggroup.org/resource/tpm-main-specification/
  */
 
+#define TPM_MAX_ORDINAL	243
+
 /* Command TAGS */
-#define TPM_TAG_RQU_COMMAND             193
-#define TPM_TAG_RQU_AUTH1_COMMAND       194
-#define TPM_TAG_RQU_AUTH2_COMMAND       195
-#define TPM_TAG_RSP_COMMAND             196
-#define TPM_TAG_RSP_AUTH1_COMMAND       197
-#define TPM_TAG_RSP_AUTH2_COMMAND       198
+enum tpm_command_tags {
+	TPM_TAG_RQU_COMMAND		= 193,
+	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
+	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
+	TPM_TAG_RSP_COMMAND		= 196,
+	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
+	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
+};
 
 /* Command Ordinals */
-#define TPM_ORD_GETRANDOM               70
-#define TPM_ORD_OSAP                    11
-#define TPM_ORD_OIAP                    10
-#define TPM_ORD_SEAL                    23
-#define TPM_ORD_UNSEAL                  24
+enum tpm_command_ordinals {
+	TPM_ORD_CONTINUE_SELFTEST	= 83,
+	TPM_ORD_GET_CAP			= 101,
+	TPM_ORD_GET_RANDOM		= 70,
+	TPM_ORD_PCR_EXTEND		= 20,
+	TPM_ORD_PCR_READ		= 21,
+	TPM_ORD_OSAP			= 11,
+	TPM_ORD_OIAP			= 10,
+	TPM_ORD_SAVESTATE		= 152,
+	TPM_ORD_SEAL			= 23,
+	TPM_ORD_STARTUP			= 153,
+	TPM_ORD_UNSEAL			= 24,
+};
 
 /* Other constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
+#define TPM_ST_CLEAR			1
 
 #endif
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 636acb66a4f6..10f79a8c2d35 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -17,7 +17,6 @@
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted_tpm.h>
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a7ea4a1c3bed..56eb8e20780a 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -9,7 +9,6 @@
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
-- 
2.47.3


