Return-Path: <linux-integrity+bounces-9053-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNRrNLhwwmmncwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9053-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 12:08:40 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E063307058
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C747430E56DD
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A13E8660;
	Tue, 24 Mar 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqOVcwLE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803A393DD1;
	Tue, 24 Mar 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350060; cv=none; b=lq4yJfBWJiKFMGvZ2gH6hkJFV2qZPjkx8Rf8Q0P4mpYRR0uEe2JczocqUUPXR2a9rMiE3rQWnMH5ELNF1I52Fp+dAbKXKhkNWObgCgHCMgijkacLtSgy7gGah1InVr6fG2XK5GtlWgwibhP/kXpR/kZgKQ+G/Mld9JUo1aG9+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350060; c=relaxed/simple;
	bh=YW9shs/L5EFC8ZMfP+jjcBW3dgrut5uF1OXxXMpXw+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUSr8SZAfvyc+XB+89UyiWy7SI+UhO3I+Cq/IUpIQlCBSkmUPmMGp8M0PPvH+7l8Rl50NIJLM3zfT28UgXQ0C4e6sWm/AIjq7/Zu3kR66uB0aucV4q6OJx3fE7ME5+MVYDBb5JUt/b88M2cXyJw13mAujBsn8v1r/TMFLferqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqOVcwLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4744C19424;
	Tue, 24 Mar 2026 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774350060;
	bh=YW9shs/L5EFC8ZMfP+jjcBW3dgrut5uF1OXxXMpXw+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=KqOVcwLE1O2TpeLqVRHOBPnhh2qBIFPckuTKvzb2PL9XGTEJcVJTvAFUR75yeOci9
	 OdwLt1rKgAtRyKDdkgtOnaz+Yls/p23HFDJVR6AZ96gANC61900kBGX87hkEJZZKLx
	 rYA7h7dO+JbzwIea7dO7RJbEhUX5oKZbWsl7SlFNj/AnrY4QxLGMqHywNLafu00ni8
	 MV/ZWDPWPJKSS6RNnilULZEh8DOfbx9EJg+kAlHQdBT8tGL3J/BtiXRe8l/dewlYV0
	 A5B8s9TdxTWTBGahANxir+Zj7KD9GA/4w8VeOIiAe/WeHIq7yzw5toDLqAO+hYiago
	 bijwClDr/Nc7w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
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
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2] KEYS: trusted: Debugging as a feature
Date: Tue, 24 Mar 2026 13:00:40 +0200
Message-ID: <20260324110043.67248-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9053-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7E063307058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TPM_DEBUG, and other similar flags, are a non-standard way to specify a
feature in Linux kernel.  Introduce CONFIG_TRUSTED_KEYS_DEBUG for
trusted keys, and use it to replace these ad-hoc feature flags.

Given that trusted keys debug dumps can contain sensitive data, harden
the feature as follows:

1. In the Kconfig description postulate that pr_debug() statements must be
   used.
2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.

Traces, when actually needed, can be easily enabled by providing
trusted.dyndbg='+p' in the kernel command-line.

Cc: Srish Srinivasan <ssrish@linux.ibm.com>
Reported-by: Nayna Jain <nayna@linux.ibm.com>
Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Implement for all trusted keys backends.
- Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
  coverage.
---
 include/keys/trusted-type.h               | 18 +++++-------
 security/keys/trusted-keys/Kconfig        | 19 ++++++++++++
 security/keys/trusted-keys/trusted_caam.c |  4 +--
 security/keys/trusted-keys/trusted_tpm1.c | 36 +++++++++++------------
 4 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 03527162613f..620a1f890b6b 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -83,18 +83,16 @@ struct trusted_key_source {
 
 extern struct key_type key_type_trusted;
 
-#define TRUSTED_DEBUG 0
-
-#if TRUSTED_DEBUG
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_payload(struct trusted_key_payload *p)
 {
-	pr_info("key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("migratable %d\n", p->migratable);
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
index 9e00482d886a..2ad9ba0e03f1 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,10 +1,25 @@
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
+	  Trusted keys backends and core code that support debug dumps
+	  can opt-in that feature here. Dumps must only use DEBUG
+	  level output, as sensitive data may pass by. In the
+	  kernel-command line traces can be enabled via
+	  trusted.dyndbg='+p'.
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select CRYPTO_HASH_INFO
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_UTILS
@@ -23,6 +38,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
@@ -33,6 +49,7 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
@@ -42,6 +59,7 @@ config TRUSTED_KEYS_DCP
 	bool "DCP-based trusted keys"
 	depends on CRYPTO_DEV_MXS_DCP >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's DCP (Data Co-Processor) as trusted key backend.
@@ -50,6 +68,7 @@ config TRUSTED_KEYS_PKWM
 	bool "PKWM-based trusted keys"
 	depends on PSERIES_PLPKS >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS_DEBUG
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of IBM PowerVM Key Wrapping Module (PKWM) as a trusted key backend.
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 601943ce0d60..015cddc6b53c 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -28,10 +28,10 @@ static const match_table_t key_tokens = {
 	{opt_err, NULL}
 };
 
-#ifdef CAAM_DEBUG
+#ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_options(const struct caam_pkey_info *pkey_info)
 {
-	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
+	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
 }
 #else
 static inline void dump_options(const struct caam_pkey_info *pkey_info)
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index c865c97aa1b4..8fe889c7cdd1 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -46,38 +46,36 @@ enum {
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
+	pr_debug("\ntpm buffer\n");
 	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
 }
 #else
 static inline void dump_options(struct trusted_key_options *o)
-- 
2.47.3


