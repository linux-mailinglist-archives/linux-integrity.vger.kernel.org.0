Return-Path: <linux-integrity+bounces-9536-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEbDOgGNB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9536-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE6D557BB3
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96FA3032835
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101F3EBF3A;
	Fri, 15 May 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtfgL7d7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED73ED109
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879659; cv=none; b=e4y2MkzRha2HA5DL9bfuHukktR/gBgaomUkXeBbadsTqBPoUScXtcopf+kGcb0qDZ3s8hoIOivmwm4nmltW+OGQ0HMV6EbyRY3QXCEErdGcgyeEvxyoRw6RxGRUxGbqgCbMEL5UFNEIyVazrgmc8WKqXZu/V8lX3MgmhFXb2YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879659; c=relaxed/simple;
	bh=JgJyVLfDqMQljVqRU1MTHdSlUCVaSc0hfEkcczuhqcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGJgWyJc4kPtKYyjmWcU0ciq8DOB7vLKwXWTfmYWZN6LNoLOEEHNCUGMI8sWoiDyhH9j8JC/WQcQDyJL5zy5UtGwcLLvXpjQUMOwdINE80A2ujFhom6vN2JuOLd54JbZO/t7kPLVMsm4CvMFN32OIWi8WQlRMxHgNJ/tunehHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtfgL7d7; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso373779eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879655; x=1779484455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg1O72SYx+Mww3ZjC2LhL3IwBU8aOcEM6iuwyJssfKc=;
        b=VtfgL7d7KSiuzNG5iroeCd6PGRFsxK0zNEtY8VbbevY++FbZegbne6D+xeV/Yg8VPu
         0YkrmF92wtCJFFViCyPILayp3jMOl2/0IB8Qmo5NRMZKIWOw+5qQa5+J3TKDpHh24F+N
         +BmMea9opbRfHaopvH/yYiOnULGA1qpdso2BgEhyZ5tngPmmQL7NuKuBp7U+FrAb4UCZ
         UV2p3OqvzcW/dtwIgEWg2mnMizv71blKbRo8N2n/w+VkhNLiyxGDLZyMes3DnIZskMXK
         5uFoPzGhxR9XjbFxeImU3YCkrV8DkV/9OqBXQhSEkAydAnCDQA6vBEanT1VLiENLB1AR
         GkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879655; x=1779484455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rg1O72SYx+Mww3ZjC2LhL3IwBU8aOcEM6iuwyJssfKc=;
        b=FZfiZmksSqIlIU06osRqGyicZKE32DQgl7DfWkTBwSNojLw+brdos8pTfeXthVN1Jr
         gK4C63uAJl7Y+uRxsCcsbYAERj4ISkAO8MYtK6akkVQH+CXR+sDDIgVk3IWCjm0z+ny/
         mjyFLGJ8yXRbd9FpVMVW/IoNLNJkEl2psWRE1si6n8nwsiMW1QupLZuVkjfsHB87hh4r
         OoPp4EOtALlMINRRHxYhq0A8MV4E93hwzESUyWVukKCnmHlKMrYXx81dn7nyRd23ulbm
         u3i/wY/gU/YoWuh0bt3EazBvyh7h/8K8/amr2dCtRvAJSK8HWxUD31gJBWVz1doOklFi
         CW5w==
X-Forwarded-Encrypted: i=1; AFNElJ8d2m5jPf6n5Crvn50ZIm/9Gup8gfl5zq5wkOPYhV5msiaGaue9+nCjZ+63eMy655meLLUkG8XPC2tteJCbmTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6z3np0lsilE5oACHgAPlMQBcS0W4633L9dSGDo/jm91edYDqj
	DOL7s3v8mIcKdkHNRPGaXT9wjWgEOf5EA3IqdAqE2EXviKWMlERVs4Pe
X-Gm-Gg: Acq92OFiHR5ban9Hw7UQXvqMxQ5E2CsVRFhAFtovI8WmbOPKOHvycfgiKk9R5vKUgOT
	Dejx8xsQIF3MT8OUJo43yg+VRygUK1lXYB80yJC1q2vYlke7jJqkHOmzQmRzy7dxlB+SlG7sXUU
	gQ8kWc17PmE8Idp4gT1xmmEx26th+RL5wyZzLjn2hYEcCqDZ7qoOqjfyQnxGRtGtIP47y86hn2l
	ERUVmbsO0dxcZOj0eor2fF3C+oBC4xxSUgIF+yE9kxlJDfyU4xbOaJu/NA5HyeFLN7vnHUjiQ54
	XMaO6190H7YGIsLT3IIz6/3AuoyJShByAKTEc7elLhnt0xrdPXvvKqJlGWdvFvtZzlIQG7ZPpTW
	hznDbc2JfqUfE9ZD7nBUCkeLzxmh2h5WB31BlmFjh4UMYnMjhAUDRCy6HUzpixuMuwGzZcLB5Y4
	mVjmTkczNKiopTug1vn/l6WlgaPoa60wQ=
X-Received: by 2002:a05:7300:6c05:b0:2d8:df01:d9f6 with SMTP id 5a478bee46e88-3039864d5c1mr2737865eec.23.1778879655311;
        Fri, 15 May 2026 14:14:15 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8003313eec.12.2026.05.15.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:14 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public headers
Date: Fri, 15 May 2026 14:13:33 -0700
Message-ID: <20260515211410.31440-2-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DE6D557BB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9536-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url,oracle.com:email,apertussolutions.com:email]
X-Rspamd-Action: no action

Consolidate TPM1 constants in tpm_command.h and remove duplicate
constants from tpm1-cmd.c.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c                |  1 -
 drivers/char/tpm/tpm1-cmd.c               | 14 +-------
 include/keys/trusted_tpm.h                |  1 -
 include/linux/tpm.h                       |  2 ++
 include/linux/tpm_command.h               | 41 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm1.c |  1 -
 security/keys/trusted-keys/trusted_tpm2.c |  1 -
 7 files changed, 31 insertions(+), 30 deletions(-)

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
index 202da079d500..1846d5485a2c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,6 +25,8 @@
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
+#include <linux/tpm_command.h>
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
 #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index f5c03e9c3913..174b043d8bbc 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -3,27 +3,42 @@
 #define __LINUX_TPM_COMMAND_H__
 
 /*
- * TPM Command constants from specifications at
- * http://www.trustedcomputinggroup.org
+ * == TPM 1 Family Chips ==
+ *
+ * TPM 1.2 Main Specification:
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
index 6ea728f1eae6..0d3244af8de3 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -18,7 +18,6 @@
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted_tpm.h>
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53..29d79c05ed6b 100644
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


