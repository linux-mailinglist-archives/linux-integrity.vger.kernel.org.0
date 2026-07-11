Return-Path: <linux-integrity+bounces-9910-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eu0mH+JoUmrOPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9910-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:01:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A1742129
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:01:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E3I3cJgm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9910-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9910-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA7A13024A27
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944AF3C988D;
	Sat, 11 Jul 2026 16:01:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13283C7E13
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785678; cv=none; b=mDlxtenwdBFfmm09prT24GPpiXp5N5FQDSjJLiLzBaLWvqBkndZSkCwSiBME/d7DDaeyo0aKcFeDqqLlXP/5x2IgL8HlUXZXUXsZ7X13yWDLWNS3tGHiJ2AyBDm/iedAewj8xvDPmuQSy+XjdbeiERVBqr6sFHqwvDwkXu5jbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785678; c=relaxed/simple;
	bh=EoUUqjZYbOtXIHZLtFz07ku884IQ3g6CHyUbrcA60Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYrDGhi07oKUtTwHN7dwnJggS7C2h91opEEU+EYf5QI0w2O6FVWCw4P2RrgN/F8bJthz43Cooa8XRhFvsMOZto+j592IjzhzpFJUicuH9+JNYPPMYElp4AGZRsWy9XCh+VVRsGrvTHhM9KlPHTdhNIUE/YaTwLwBnopiAs9Ma7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3I3cJgm; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381216921aaso2100855a91.1
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785676; x=1784390476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjmfOUOJML2D2cy2d1JFAGzOl9Dis6s/LeoJt74YybY=;
        b=E3I3cJgmGCJCvODzN0XZFToodG6Pea2HPYmVs/QzXdjYZDCll/9BGXUzhXSm7bTHu1
         yAnXn5gsVybI+1DerBypM6FSlrkSBlxhrfPu4Thp2LqGR97qlJvr5cKbJHfMDGJ0V5RY
         Kw6n2wF7N1xc6m0DR+IBiU0ReVKl94t1mt+j5UAfmsRfoHURWNOiV6nUkdk5CD7K2cz8
         KPodvg+gSKiQanMaUlpR6IV0KZr9jh5B5RQzVRtYXj3bBBQ99dE2QG2mTs6w11KCRRf2
         IT6/mA+psoI+4OuAsDsB3x9Gny/3047Hg1OjI2WdnS8Gn7620G4bntNd1lPxcx8Hq53I
         TToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785676; x=1784390476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZjmfOUOJML2D2cy2d1JFAGzOl9Dis6s/LeoJt74YybY=;
        b=Xtur7RQgUTtxBFtjP3g57xl/6l7IWeLDqcY1yDjXo+RrBEYWrZvbDkdmKnoSa4Wlss
         gVr7iS1vOO37P1MifyOyepnI22uB3+oh5HEvVlZEeHdw9Lm6qpyoXvM5b81ZTOALduMX
         qQSPS0khJ4yEDFEm7wcidBGZfL1vHXXxp8ZpU4eLjHUQb0hUFvsiOb9QAbY5P0UgYx6K
         IxejlkamHYohG7jf+QSYEV4n/N7lHFhHMLaEdaM5sBvgKavS3cftv15HLrz0zgI3UwY5
         b8sJc5YPcBFmRIhQoFO4Qtt0KwhMEAKV7VGHTkepZfmJY2P95W9heYIPX1FxPuPkuWIV
         204A==
X-Forwarded-Encrypted: i=1; AHgh+RoAmmA0vZDueHXq4FO5fbpH45l1gOY0J/gxmUYMFnoARDIyfOemz8LPJzJioOMvqYbTpw/g27xPvgPuqjIVRjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMG174M8Z5EImOxypjRKyGepDDU008K4Wg8z7xDq0mSzxRVpP
	BxjtXBZMpQiw5CnuYFXGkAbCeqUSIqQiQYAR93KA6MtPfHoYpAPB3D1Q
X-Gm-Gg: AfdE7cn+V/BuhE+F/4D1QuDLJdeggDD4ucsJ4nQDsRYXVRlMnWxNBEK802p45rzXH9k
	rvXF4zzU2t81go8MIUWtUaYC7tXWmZWJoN/KWiBb/dHSuLxFrVGNe8O5RuUJWCbk8LHUj7Fc9il
	sHziZ76H56vuqLXADJ7VPFrhE4kOLMrMcVRyltiUpAF/jYPR2dl6yHdWHwyHvpSCSjpdyjGtebE
	xGx1mMSpIikGO6BDGLr/NaAdMXk5Jom8v6SwJeFa0+9PxhwN6+zaWBwQhaYj8tmyiBoc+QofQmv
	84rtUUAO+GuZrzl+YCJabppjx4RDSvDuljmiswEJThWbh3AeRDJ7six1iZ4+7CY3tsgoU8F/Hiy
	Og1pPDv+s0uqD/b3JmM4RQjdoHY7xyvb1s2u5FmYoaoD5U8ovZ0Qdb1Rd5Nc6Ss83WXT3x5eXfa
	+QqaRR5XW0t4wzT65OYAVV
X-Received: by 2002:a17:90b:530d:b0:387:e0cb:c8da with SMTP id 98e67ed59e1d1-38dc777c380mr3618351a91.35.1783785676250;
        Sat, 11 Jul 2026 09:01:16 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm55943287eec.27.2026.07.11.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:15 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
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
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 01/10] tpm: Initial step to reorganize TPM public headers
Date: Sat, 11 Jul 2026 09:01:01 -0700
Message-ID: <20260711160110.267780-2-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711160110.267780-1-ross.philipson@gmail.com>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9910-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:ross.philipson@gmail.com,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,trustedcomputinggroup.org:url,vger.kernel.org:from_smtp,apertussolutions.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB8A1742129

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
index 13513819991e..331b1bad6581 100644
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
2.55.0


