Return-Path: <linux-integrity+bounces-9040-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIdxMncDwWlUPgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9040-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 10:10:15 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E842EEBC7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39885300C59F
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874338553B;
	Mon, 23 Mar 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9IYcWu4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A538552F;
	Mon, 23 Mar 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256458; cv=none; b=ZGvDvJ1QSk2cUFRfpdISpcg8aKscQ4U2SIKdZt29kgAxrFbH6spm0jmC8VkTZewX/U9KI5kbgJxz/b9IOGvw+DIEwd//ufAsWk7NWonaye6EQONJh8JBFRPK1uSSEtKhVHZnV4B81w+b0PqUFX2sdq+JDnF4PeaPQgME2BuZ8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256458; c=relaxed/simple;
	bh=boHUn6iDG0dYkEh2Bc6qGCC4x8BwAF4mz+H4mphbm4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTtE5NrUzhi3I0iwJsqBjNHTZkLOXqN+CdVY2sdyErjcaun5PstnEsTpGUTXDcrLB0/G4HWSM0EYWhSA0aykRbmHo56n+ujTt6PXE7SYK+H4i/4PvaL6T2FC135Os/VHqLLFUmcE9BFdJERhPNgUPRpekVYUmvybCTxK/w5j8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9IYcWu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B95C4CEF7;
	Mon, 23 Mar 2026 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774256457;
	bh=boHUn6iDG0dYkEh2Bc6qGCC4x8BwAF4mz+H4mphbm4A=;
	h=From:To:Cc:Subject:Date:From;
	b=d9IYcWu4Vwk7DSHM66W4jYLJzidh7vb6V4geecZ0VVt9aUKgTUxdQpvPS1P+MrFhr
	 ioqWXt7gurreooaz2N46eY19jIFLxGTLl8GhTIn0oM9ceHE2BnDa44ATkW1wnSS5aa
	 Mzt023GKQMrZKy+kWQzQrAI6q6dGrK6um9aPM1TLhmAvAkSuB9gT50kzQvdO7vzW2K
	 vjS0tfP/It1l7rYlcTYBGMI+cvWT3Vh0N7FNOLA9DlJoaO2NPGxUWw1dnEHwqeSvmR
	 Fs/U8nxGrBZkT9w3C8L6sX2LeU/I9t8yEyNAeOq13ySFEkNSNJdAbTLGPudkGtDGe9
	 8Vn5BqYatOZww==
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
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Protocol debugging as a feature
Date: Mon, 23 Mar 2026 11:00:46 +0200
Message-ID: <20260323090047.632499-1-jarkko@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9040-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: 36E842EEBC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TPM_DEBUG is a non-standard way to specify a feature in Linux kernel.
Introduce CONFIG_TRUSTED_KEYS_DEBUG, and use it to replace TPM_DEBUG in
TPM 1.x trusted keys.

Given that protocol bus could contain sensitive data, harden the feature as
follows:

1. In the  Kconfig description postulate that pr_debug() statements must be
   used.
2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.

Traces can be enabled e.g., by providing trusted.dyndbg='+p' for the kernel
command-line.

Cc: Srish Srinivasan <ssrish@linux.ibm.com>
Reported-by: Nayna Jain <nayna@linux.ibm.com>
Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/Kconfig        | 10 +++++++
 security/keys/trusted-keys/trusted_tpm1.c | 36 +++++++++++------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index 9e00482d886a..0e53bef1343d 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,6 +1,16 @@
 config HAVE_TRUSTED_KEYS
 	bool
 
+config TRUSTED_KEYS_DEBUG
+	bool "Debug trusted keys protocol"
+	depends on HAVE_TRUSTED_KEYS
+	default n
+	help
+	  Drivers that support debugging the protocol dump, can opt-in that
+	  feature here. Protocol dump must only use DEBUG level output, as
+	  sensitive data may pass by. In the kernel-command line traces can
+	  be enabled via trusted.dyndbg='+p'.
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
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


