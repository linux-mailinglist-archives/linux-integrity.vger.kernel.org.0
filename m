Return-Path: <linux-integrity+bounces-9537-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHSeLByNB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9537-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:16:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55255557BD2
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6077F3009FBD
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB43ECBE7;
	Fri, 15 May 2026 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru0WDDcL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191983ED10D
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879661; cv=none; b=AdtDoGgBewi2gqB5l1MHuTwIOqyghqvw4KJz9VfRmKYR4WvZgv196UepYFjLRwxaULT5CSceWYFFf4AMIdBrhy+8hLp3ww68Kznv9dGLnVKhj7csohnX5oxJRNUsrHrasFa25qY4/CJgYJb+CF5PuBaYmubIVS+LRZgFL3NXSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879661; c=relaxed/simple;
	bh=SggoenfzsCsY+pb4Ek78lCUJ5LNnpYbdU37TQ8AdKSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf2V9OgsM5SeWBMebVABto58btcqT4+X1TDGYjiSLO0oL5O2k05ExSTymV3mfSk9KV/nJUK+d3bXjSdgV8r1L1iQGiXe1/mXdq85x6LPkuCj+vcjL//AfZuXLgAJksEktMg47ROZl/g95AIOtBaC9Ra/kaWoLGR5pp4SakObisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru0WDDcL; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f3c623322bso1041115eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879658; x=1779484458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv+Nw7PPpS+EKWG0VbfKgMCfu5HHf7cWkQjqPeveVJA=;
        b=ru0WDDcLWSL1Gi2iGhC0i4R5j++PKiDQbs2a5p44PBgkduWP1zGlxPLEsi5Nbu/tuk
         yUnsKoeQynrMvWXQ74RWCpe9JPvSHppDZ/EYjRzcAYql7GYi43ht5lnq4LjwNOzBr5dU
         dw4+QG5xXd3xsXtM5kz+iOwyY7AmLVAinI7k/8kmCYhy0H+Kj8deBo8Z780myQuGG7A4
         a4wgQdm1FEHEIC9nMSEWBGSzU79/w+8g/4GdwKo89A25vzEIR3CvuQSYmmOjoAQDO3X6
         /NT8sGr6QWUtbEUMdiVKzI2rEChXXMgoVV1WRMovs+HecQXTmfdVTcMO0Uuo0qsPjrCa
         JCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879658; x=1779484458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nv+Nw7PPpS+EKWG0VbfKgMCfu5HHf7cWkQjqPeveVJA=;
        b=D2jE5rvqM1Onx7oAYKYvyU7hK860cYin3+IySjruzg2UhSUwC+3cWyJ2z5hyrpezXc
         ZJ2H5iedoCt55qV+JgC/8xqMbYBHTC/JcS5iUyAXEWx2UaLamEESiff72PSuUeYFh5r/
         QeAVZwc/pcoWUw5eBXO4ljAJrWz23EfdZkiEglyG0Q7ln5tt9LkxGvXI2NlN7QLK5XlJ
         lkWruW/wFOZpJAIhpu0K7ZD271oudBfaJd4bZid01QI1xXwRpeduezbTrhuXaBOV8CQL
         FvhK1QArAaadP4GY0p9z2uPI7VEc1wGYiy5W/Rb4Zla9ZMyVjQVpYGc/qJqylzSqj8Eu
         c5LQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kXYsbiQGLST2g19ZsfKX7ayOR5T/Nia+StIx0OYzhLYhZYkIjyGHDBhSqLisvOwJE97IJRJgMCD//I1OEP1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlsSqWNjd+PZbXNjN/tTEXOsoHrFjIKH9790bQWidb2L1e3dWC
	I4JfKgLgW4vUhx4e8XtCIgXYJPNowQrewbSInqmKQfmQi4f9EfVsf14l
X-Gm-Gg: Acq92OFan7xsTho/e+/Os1nIgBxsl0mv4/jfWhluXRPY4VSh3PznQet6C4T72bgsedl
	ZCncSMIfHx22GXNKt5ozH5XGnwehokUvBZT5kZN/TZFWiUBUycP5ux69vhOTifaTtZLIw43JGia
	ZlQSFy+kaFzL/QRA3V9ZGv+ehZtcurK6e8Nxu27hrsAsbf1Bs5Bui7b7rRyv92perdluSf9/asJ
	zJHEBxfRbq42+L0SbX8cjkAX9q6Is+zk/pUQBGSlq/Eb3iUljJAGAvQhyE1oMBeuJgs/dQM4W0Y
	ZOZluuxPBeyiBikN/UdbXGyjnbvuNneLylZh+bn74dpJE3hDgAd2hXvPt9su85JQuVtbFHGv51U
	FqdA1RE3gSG4x6XGI7q0VvgwSD7RoaH669aGGx9tSD0tR2MnUgQTZbgGpwtakDPAd45Rl+XcHeE
	DAYExRBJs5QGrgYmXTaM2DlwNOWlJdKJNSk+NlGOEOrg==
X-Received: by 2002:a05:7300:e6c6:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-303982b11bbmr2831503eec.11.1778879658197;
        Fri, 15 May 2026 14:14:18 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8153511eec.25.2026.05.15.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:17 -0700 (PDT)
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
Subject: [PATCH v16 02/38] tpm: Move TPM1 specific definitions to the command header
Date: Fri, 15 May 2026 14:13:34 -0700
Message-ID: <20260515211410.31440-3-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 55255557BD2
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
	TAGGED_FROM(0.00)[bounces-9537-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url,oracle.com:email]
X-Rspamd-Action: no action

Gather all the TPM1 definitions and structures in the internal header
file drivers/char/tpm/tpm.h into the command header. In addition, bring
in the single RNG structure from tpm-interface.c.

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
2.47.3


