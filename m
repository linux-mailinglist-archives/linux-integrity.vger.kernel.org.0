Return-Path: <linux-integrity+bounces-9151-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEN+IaLQ12mrTAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9151-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 18:15:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB093CD80F
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B873F3025924
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2026 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342734752E;
	Thu,  9 Apr 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeNb+GFX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C72DEA89;
	Thu,  9 Apr 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750881; cv=none; b=S9fkg5QrTZV+DfJk+G7YACOxEj+ANd5ruvhX8HHMItjEUuvcV/T5fttlv/3ypOcTyHrLFwUZwPiye+bRE7ZX7n5mIMb8qX43BqzeMZkSvReFESIM21NDybFC9X4gpfnWKRgHnRd04mIwubETSShhUkGg5X4te/Mb/QCTD8X3j9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750881; c=relaxed/simple;
	bh=x0/JEhLtTxz3D2AOHxBhkjdpSaAoxrlbb3O+q/VUPKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtDe5vdaEUySUTs+7ObFYr+T3IpDMO8dqt4EAneHZtbuJ/z792wx5go5zDMqrohJINZLqQ8V3fepYdLIY8Dlm18KPBQvlIb132OkNcZM1w/RVkF06TqME3DO6gvyDMFVlAV/EZxj1OZXbfCeD1Yg4+2HjP3Rd5L2DcFPHcnSTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeNb+GFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE865C4CEF7;
	Thu,  9 Apr 2026 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750880;
	bh=x0/JEhLtTxz3D2AOHxBhkjdpSaAoxrlbb3O+q/VUPKw=;
	h=From:To:Cc:Subject:Date:From;
	b=MeNb+GFXXwFRmD/VA0llkRhpb9ceUUy15KcYbD+cV7GKR1iX2Uh2Yf70+qtxSN+tY
	 J9hrx9MspQLJsrR/U7MhgDo95z08ItRe5Jd0vLIPqmIQX6WJSX0A0jzXtZ+iv0/w5D
	 wvCpIfDgIV9yaqmLe+hDG1ob8vz5k2xALp+tgsE+f6JcMkxAdh/I14dM9Hx3UIjKza
	 S4Ky/wg8qOB33Vk/G8lsuM9E8wO8FJiiESJXHie4Pz8xriUe53u7wavmP5x/pwyKk8
	 xBBkBmVJxm4VsE82La6ILcUsT29me8IMN9VIOLyIYUJtomzEm4RuO82OsCpmxLbMQ0
	 3coEKtX/2BNGw==
From: Jarkko Sakinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	Nayna Jain <nayna@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3] KEYS: trusted: Debugging as a feature
Date: Thu,  9 Apr 2026 19:07:51 +0300
Message-Id: <20260409160752.988713-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9151-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFB093CD80F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jarkko Sakkinen <jarkko@kernel.org>

TPM_DEBUG, and other similar flags, are a non-standard way to specify a
feature in Linux kernel. Introduce CONFIG_TRUSTED_KEYS_DEBUG for trusted
keys, and use it to replace these ad-hoc feature flags.

Given that trusted keys debug dumps can contain sensitive data, harden the
feature as follows:

1. In the Kconfig description postulate that pr_debug() statements must be
   used.
2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
3. Require trusted.debug=1 on the kernel command line (default: 0) to
   activate dumps at runtime, even when CONFIG_TRUSTED_KEYS_DEBUG=y.

Traces, when actually needed, can be easily enabled by providing
trusted.dyndbg='+p' and trusted.debug=1 in the kernel command-line.

Cc: Srish Srinivasan <ssrish@linux.ibm.com>
Reported-by: Nayna Jain <nayna@linux.ibm.com>
Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Add kernel-command line option for enabling the traces.
- Add safety information to the Kconfig entry.
v2:
- Implement for all trusted keys backends.
- Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
  coverage.
---
 include/keys/trusted-type.h               | 21 ++++++-----
 security/keys/trusted-keys/Kconfig        | 23 ++++++++++++
 security/keys/trusted-keys/trusted_caam.c |  7 ++--
 security/keys/trusted-keys/trusted_core.c |  6 ++++
 security/keys/trusted-keys/trusted_tpm1.c | 44 +++++++++++++----------
 5 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 03527162613f..9f9940482da4 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -83,18 +83,21 @@ struct trusted_key_source {
 
 extern struct key_type key_type_trusted;
 
-#define TRUSTED_DEBUG 0
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
+extern bool trusted_debug;
 
-#if TRUSTED_DEBUG
 static inline void dump_payload(struct trusted_key_payload *p)
 {
-	pr_info("key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("migratable %d\n", p->migratable);
+	if (!trusted_debug)
+		return;
+
+	pr_debug("key_len %d\n", p->key_len);
+	print_hex_dump_debug("key ", DUMP_PREFIX_NONE,
+			     16, 1, p->key, p->key_len, 0);
+	pr_debug("bloblen %d\n", p->blob_len);
+	print_hex_dump_debug("blob ", DUMP_PREFIX_NONE,
+			     16, 1, p->blob, p->blob_len, 0);
+	pr_debug("migratable %d\n", p->migratable);
 }
 #else
 static inline void dump_payload(struct trusted_key_payload *p)
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index 9e00482d886a..c1ae7db1f612 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,10 +1,29 @@
 config HAVE_TRUSTED_KEYS
 	bool
 
+config HAVE_TRUSTED_KEYS_DEBUG
+	bool
+
+config TRUSTED_KEYS_DEBUG
+	bool "Debug trusted keys"
+	depends on HAVE_TRUSTED_KEYS_DEBUG
+	default n
+	help
+	  Trusted keys backends and core code that support debug traces can
+	  opt-in that feature here. Traces must only use debug level output, as
+	  sensitive data may pass by. In the kernel-command line traces can be
+	  enabled via trusted.dyndbg='+p'.
+
+	  SAFETY: Debug dumps are inactive at runtime until trusted.debug=1 is
+	  set on the kernel command-line. Use at your utmost consideration when
+	  enabling this feature on a production build. The general advice is not
+	  to do this.
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select CRYPTO_HASH_INFO
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_UTILS
@@ -23,6 +42,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
@@ -33,6 +53,7 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
@@ -42,6 +63,7 @@ config TRUSTED_KEYS_DCP
 	bool "DCP-based trusted keys"
 	depends on CRYPTO_DEV_MXS_DCP >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's DCP (Data Co-Processor) as trusted key backend.
@@ -50,6 +72,7 @@ config TRUSTED_KEYS_PKWM
 	bool "PKWM-based trusted keys"
 	depends on PSERIES_PLPKS >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of IBM PowerVM Key Wrapping Module (PKWM) as a trusted key backend.
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 601943ce0d60..6a33dbf2a7f5 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -28,10 +28,13 @@ static const match_table_t key_tokens = {
 	{opt_err, NULL}
 };
 
-#ifdef CAAM_DEBUG
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_options(const struct caam_pkey_info *pkey_info)
 {
-	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
+	if (!trusted_debug)
+		return;
+
+	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
 }
 #else
 static inline void dump_options(const struct caam_pkey_info *pkey_info)
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9046123d94de..9ce2459d14b4 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -31,6 +31,12 @@ static char *trusted_rng = "default";
 module_param_named(rng, trusted_rng, charp, 0);
 MODULE_PARM_DESC(rng, "Select trusted key RNG");
 
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
+bool trusted_debug;
+module_param_named(debug, trusted_debug, bool, 0);
+MODULE_PARM_DESC(debug, "Enable trusted keys debug traces (default: 0)");
+#endif
+
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee, caam, dcp or pkwm)");
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index c865c97aa1b4..b9fa2b4205cf 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -46,38 +46,44 @@ enum {
 	SRK_keytype = 4
 };
 
-#define TPM_DEBUG 0
-
-#if TPM_DEBUG
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_options(struct trusted_key_options *o)
 {
-	pr_info("sealing key type %d\n", o->keytype);
-	pr_info("sealing key handle %0X\n", o->keyhandle);
-	pr_info("pcrlock %d\n", o->pcrlock);
-	pr_info("pcrinfo %d\n", o->pcrinfo_len);
-	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
-		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+	if (!trusted_debug)
+		return;
+
+	pr_debug("sealing key type %d\n", o->keytype);
+	pr_debug("sealing key handle %0X\n", o->keyhandle);
+	pr_debug("pcrlock %d\n", o->pcrlock);
+	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
+	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
+			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
 }
 
 static inline void dump_sess(struct osapsess *s)
 {
-	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
-		       16, 1, &s->handle, 4, 0);
-	pr_info("secret:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
-	pr_info("trusted-key: enonce:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
+	if (!trusted_debug)
+		return;
+
+	print_hex_dump_debug("trusted-key: handle ", DUMP_PREFIX_NONE,
+			     16, 1, &s->handle, 4, 0);
+	pr_debug("secret:\n");
+	print_hex_dump_debug("", DUMP_PREFIX_NONE,
+			     16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
+	pr_debug("trusted-key: enonce:\n");
+	print_hex_dump_debug("", DUMP_PREFIX_NONE,
+			     16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
 }
 
 static inline void dump_tpm_buf(unsigned char *buf)
 {
 	int len;
 
-	pr_info("\ntpm buffer\n");
+	if (!trusted_debug)
+		return;
+	pr_debug("\ntpm buffer\n");
 	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
 }
 #else
 static inline void dump_options(struct trusted_key_options *o)
-- 
2.39.5


