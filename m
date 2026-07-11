Return-Path: <linux-integrity+bounces-9911-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sbVsJP1oUmrWPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9911-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:02:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C2742142
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o40VIej+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9911-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9911-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2B6302F69C
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FD3C872B;
	Sat, 11 Jul 2026 16:01:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E543C76AD
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785682; cv=none; b=jXICXXu7DYVR+bhfT7k8tKZ822P1KV9ueVHySZEOh40QYej4/yYJCV+F5l/+WLJIkBDzFmwI7tLxRTaqFTWMmBKuMB8/4inpN0MAJufwlJIPhDy05RDHStBrAGZxLegfDGe5BfvrFGub5pWJgbrRhr+pSaxJca6DYRp+EY+BI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785682; c=relaxed/simple;
	bh=J+MrCWSPV4ZCMimU6UsgunNV7ZySwc54ShRN1XmqoDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM9hKdqMrX/60Z3BrblytiDbF+LP+B4Slft3kJOudycfT/f7Mtje1azSTgYurPMUw+M2y5ZLy/QB6OniTi6Hu6pVCpVpxoabwEhNSvrAvNyRElCj6UkV3t/D7SuUhbNPTR2/QEHT2bynMb+OpsvXEGvzyadboMPldnC5UXuG6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o40VIej+; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso1883773a91.0
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785680; x=1784390480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opJhpuuk9zMrojs3AlImH5S6+0xC78C9deSZHIirR/U=;
        b=o40VIej+Ncu9MwTWcaY0oIn+pb5b/jjY040EiW3R0dQoC2M5zuOSJXXopRHi7rXm0Y
         wsLYZrYiN+nSxdiwzhszgsI/wAKIDzdLwX61xGWsFRW4g3Qsl2/qbv8mFL0NpYpEOvvm
         gHfbw/9zqc5k77FqIBcd1DhnCxJOGucVhaiK/LAgOMN26UR8RcFuEz1GskH/iF//GvO3
         CKF1JhCPnaU2URpfsQrBL9aEADM3yuXwlkJBnI5yVwcww6WNEOomraxCWMR5+uLg6Wqj
         3bgPsetHII39NyT+TjwyiGwWu0A8PVThzFeM290MyMO9Gz1r2NnWqlEZ4SRuUPFKv3LR
         fieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785680; x=1784390480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=opJhpuuk9zMrojs3AlImH5S6+0xC78C9deSZHIirR/U=;
        b=UEgLFSbSi7i32GcvxMRMxX8gjlqq2MXPJj4R6z0N/vYvsyfuFZ7+MOue+wB/HDjD1B
         zfhm98jhBw0/x03UFVHXh8Oeo6q3S+sDzFu9TprhIdjcp3+S99HBWKAOEG8aGCqo6Epj
         u8tvb0RnKuoE9Pe276vK5ZIg+rNZMgDKH2RK7upL+Jv9u7xGK1RSE8miR4wVtX0A/hMP
         gfL4i6402UFZwTThjWw6YzfdpLdvSGB98FW1rZUYFWf57Fd0hQGZnLNeBMc1AKL/yJwm
         2sXbV4Tuqg1eOANlyiwzBmXOzJFk7K4BIXWsEwZVHxgBpnINWPBqsNIG2fmn8tXD5HvY
         61xg==
X-Forwarded-Encrypted: i=1; AHgh+Rpqt8fI8CrC7k61fn2YquAZfNVgglsS/Z28v4OIA/qli9HEBg8MqFuuECrYLFPqHRHLymupYbzjkH2VMPFfc0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxWt2Oj7YPgURXuxir639Q4y7FT0Wj1jUZjg8rendBy5hdGeM
	8IN+rIkAbpb+ShcTtYYeUsdw/iBGUEUUXyUgCX9P/922SaruPqjiQvi7
X-Gm-Gg: AfdE7cmVFUpTpDtdRWiStAEQHgjsuQIvQQLqIJ4Dsb7u08vP1PinTlpRvSuPC4JPypq
	KSXITlEr8CRLFS1SCBrTn5BBwBJ3MQFgJ1JwYORYPSgnzCYIc1eCVi6mNoZN4D6zd100dLmE0l2
	M+0puHsL3l4FwdLINNRbRfI7uD0bw2RAI5xZoHfRRCeqe+Ay30wxK+/tO/iNcd/Zl7MNjnuD2xc
	Q+lcKoxDhZbuThj5JR3QzZkNrEVNrF04SuDdN6GPeg3qAHliCFUybe/YnQOqldUC9juKtUVuzFz
	eqeiyW7P17tYqPklTRIw30XlWIjUGW4syrQxGjZDAbdCLJjvQj2HG5yv6fteoRf86q8Pt6UNuy/
	1COK0cE7v20lqhGol1wUmdSg+nlvmV8PDIJoy5Ne4ibTePVr9WknE+dMwdyxDk2+q+TcyjuPIo7
	58zEzjFkWsLK/+kzTd1HW4
X-Received: by 2002:a17:90b:2242:b0:381:85c0:1d9d with SMTP id 98e67ed59e1d1-38dc777b8b5mr3314540a91.27.1783785679745;
        Sat, 11 Jul 2026 09:01:19 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm36313014eec.17.2026.07.11.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:19 -0700 (PDT)
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
Subject: [PATCH v2 02/10] tpm: Move TPM1 specific definitions to the command header
Date: Sat, 11 Jul 2026 09:01:02 -0700
Message-ID: <20260711160110.267780-3-ross.philipson@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9911-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,trustedcomputinggroup.org:url,vger.kernel.org:from_smtp,apertussolutions.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 135C2742142

Gather all the TPM1 definitions and structures from the internal header
file drivers/char/tpm/tpm.h into the command header. In addition, bring
in the single RNG structure from tpm1-cmd.c.

The definitions moved to these files correspond to the TCG specification
for TPM 1 family:

TPM 1.2 Main Specification
 -  https://trustedcomputinggroup.org/resource/tpm-main-specification/

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm.h      | 102 --------------------------------
 drivers/char/tpm/tpm1-cmd.c |   5 --
 include/linux/tpm_command.h | 115 ++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 87d68ddf270a..043d78a9617a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -52,105 +52,9 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-#define TPM_WARN_RETRY          0x800
-#define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
-#define TPM_ERR_FAILEDSELFTEST  0x1C
-#define TPM_ERR_INVALID_POSTINIT 38
-
-#define TPM_TAG_RQU_COMMAND 193
-
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
-struct	stclear_flags_t {
-	__be16	tag;
-	u8	deactivated;
-	u8	disableForceClear;
-	u8	physicalPresence;
-	u8	physicalPresenceLock;
-	u8	bGlobalLock;
-} __packed;
-
-struct tpm1_version {
-	u8 major;
-	u8 minor;
-	u8 rev_major;
-	u8 rev_minor;
-} __packed;
-
-struct tpm1_version2 {
-	__be16 tag;
-	struct tpm1_version version;
-} __packed;
-
-struct	timeout_t {
-	__be32	a;
-	__be32	b;
-	__be32	c;
-	__be32	d;
-} __packed;
-
-struct duration_t {
-	__be32	tpm_short;
-	__be32	tpm_medium;
-	__be32	tpm_long;
-} __packed;
-
-struct permanent_flags_t {
-	__be16	tag;
-	u8	disable;
-	u8	ownership;
-	u8	deactivated;
-	u8	readPubek;
-	u8	disableOwnerClear;
-	u8	allowMaintenance;
-	u8	physicalPresenceLifetimeLock;
-	u8	physicalPresenceHWEnable;
-	u8	physicalPresenceCMDEnable;
-	u8	CEKPUsed;
-	u8	TPMpost;
-	u8	TPMpostLock;
-	u8	FIPS;
-	u8	operator;
-	u8	enableRevokeEK;
-	u8	nvLocked;
-	u8	readSRKPub;
-	u8	tpmEstablished;
-	u8	maintenanceDone;
-	u8	disableFullDALogicInfo;
-} __packed;
-
-typedef union {
-	struct	permanent_flags_t perm_flags;
-	struct	stclear_flags_t	stclear_flags;
-	__u8	owned;
-	__be32	num_pcrs;
-	struct tpm1_version version1;
-	struct tpm1_version2 version2;
-	__be32	manufacturer_id;
-	struct timeout_t  timeout;
-	struct duration_t duration;
-} cap_t;
-
-enum tpm_capabilities {
-	TPM_CAP_FLAG = 4,
-	TPM_CAP_PROP = 5,
-	TPM_CAP_VERSION_1_1 = 0x06,
-	TPM_CAP_VERSION_1_2 = 0x1A,
-};
-
-enum tpm_sub_capabilities {
-	TPM_CAP_PROP_PCR = 0x101,
-	TPM_CAP_PROP_MANUFACTURER = 0x103,
-	TPM_CAP_FLAG_PERM = 0x108,
-	TPM_CAP_FLAG_VOL = 0x109,
-	TPM_CAP_PROP_OWNER = 0x111,
-	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
-	TPM_CAP_PROP_TIS_DURATION = 0x120,
-};
-
 enum tpm2_pt_props {
 	TPM2_PT_NONE = 0x00000000,
 	TPM2_PT_GROUP = 0x00000100,
@@ -225,12 +129,6 @@ enum tpm2_pt_props {
 	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
 };
 
-/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
- * bytes, but 128 is still a relatively large number of random bytes and
- * anything much bigger causes users of struct tpm_cmd_t to start getting
- * compiler warnings about stack frame size. */
-#define TPM_MAX_RNG_DATA	128
-
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 664ca1fff2e8..96f189b5fd6f 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -504,11 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-struct tpm1_get_random_out {
-	__be32 rng_data_len;
-	u8 rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm1_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 174b043d8bbc..30d01953a6f8 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -36,6 +36,121 @@ enum tpm_command_ordinals {
 	TPM_ORD_UNSEAL			= 24,
 };
 
+enum tpm_capabilities {
+	TPM_CAP_FLAG		= 4,
+	TPM_CAP_PROP		= 5,
+	TPM_CAP_VERSION_1_1	= 0x06,
+	TPM_CAP_VERSION_1_2	= 0x1A,
+};
+
+enum tpm_sub_capabilities {
+	TPM_CAP_PROP_PCR		= 0x101,
+	TPM_CAP_PROP_MANUFACTURER	= 0x103,
+	TPM_CAP_FLAG_PERM		= 0x108,
+	TPM_CAP_FLAG_VOL		= 0x109,
+	TPM_CAP_PROP_OWNER		= 0x111,
+	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
+	TPM_CAP_PROP_TIS_DURATION	= 0x120,
+};
+
+/* Return Codes */
+enum tpm_return_codes {
+	TPM_BASE_MASK			= 0,
+	TPM_NON_FATAL_MASK		= 0x00000800,
+	TPM_SUCCESS			= TPM_BASE_MASK + 0,
+	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
+	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
+	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
+	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
+	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
+	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
+	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
+	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
+};
+
+struct	stclear_flags_t {
+	__be16 tag;
+	u8 deactivated;
+	u8 disableForceClear;
+	u8 physicalPresence;
+	u8 physicalPresenceLock;
+	u8 bGlobalLock;
+} __packed;
+
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
+} __packed;
+
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
+} __packed;
+
+struct	timeout_t {
+	__be32 a;
+	__be32 b;
+	__be32 c;
+	__be32 d;
+} __packed;
+
+struct duration_t {
+	__be32 tpm_short;
+	__be32 tpm_medium;
+	__be32 tpm_long;
+} __packed;
+
+struct permanent_flags_t {
+	__be16 tag;
+	u8 disable;
+	u8 ownership;
+	u8 deactivated;
+	u8 readPubek;
+	u8 disableOwnerClear;
+	u8 allowMaintenance;
+	u8 physicalPresenceLifetimeLock;
+	u8 physicalPresenceHWEnable;
+	u8 physicalPresenceCMDEnable;
+	u8 CEKPUsed;
+	u8 TPMpost;
+	u8 TPMpostLock;
+	u8 FIPS;
+	u8 operator;
+	u8 enableRevokeEK;
+	u8 nvLocked;
+	u8 readSRKPub;
+	u8 tpmEstablished;
+	u8 maintenanceDone;
+	u8 disableFullDALogicInfo;
+} __packed;
+
+typedef union {
+	struct permanent_flags_t perm_flags;
+	struct stclear_flags_t stclear_flags;
+	__u8 owned;
+	__be32 num_pcrs;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
+	__be32 manufacturer_id;
+	struct timeout_t timeout;
+	struct duration_t duration;
+} cap_t;
+
+/*
+ * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
+ * bytes, but 128 is still a relatively large number of random bytes and
+ * anything much bigger causes users of struct tpm_cmd_t to start getting
+ * compiler warnings about stack frame size.
+ */
+#define TPM_MAX_RNG_DATA		128
+
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
+
 /* Other constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
-- 
2.55.0


