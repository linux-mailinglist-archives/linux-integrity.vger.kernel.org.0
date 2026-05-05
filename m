Return-Path: <linux-integrity+bounces-9435-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADIrLz+0+Wm6AwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9435-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:11:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A384C9497
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B91730468F1
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137223FAE07;
	Tue,  5 May 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aIgpWDKX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BD3DC4C2;
	Tue,  5 May 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971939; cv=none; b=EdtA7t/Ti+FBBumvyDWne9L5EBxvQUFrhKO2NpQ/VnRbjRWYFi7hqPZ5+BSmKcMQ3rTTFhk68PULODP9L0I1lYxqAcwA58CMoHKcOUeRrD38el6u2LL3L942jekk4O7MxYgBedPdNOKFU/B25gSIDvvsJ47x0P1WVmJ3CVS4aEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971939; c=relaxed/simple;
	bh=z587DQf7ydM5gOPKNIBxSBWu9EUeBOTRuUfIH6UhiJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOHt9CyB/yR3txJMsmxyAHQ2e7xeITzBSNBNpTVPM7BSC6eyVkLP8NyqJRRKBwiexNg4cTYhu+b8hIPNmCXKbB7e6i1495+QXoet+aHMBeLK8Cri25Hh0agRVzC/64Z24y+hefh85t1+oIzzysGzVJK2fq1B+9uqcJWZK6/PumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aIgpWDKX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=z587DQf7ydM5gOPKNIBxSBWu9EUeBOTRuUfIH6UhiJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aIgpWDKXrg76P12O4zkGtJLBuZn8YCeI7ZzPJs6xm6dzdrhNjHvlCsyJmUEjNrCDX
	 nnsToJ9+zngAbg5KnB2apzV2zul/tNtdLxtFkKFMh/CCZJG5ISZHQPcUMzBA/S/C/H
	 yDIMRiiPrmSBoXKa210qmdtwe3j1bEA6l8n1iwS4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:12 +0200
Subject: [PATCH v5 08/14] module: Move authentication logic into dedicated
 new file
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 debian-kernel@lists.debian.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=8567;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z587DQf7ydM5gOPKNIBxSBWu9EUeBOTRuUfIH6UhiJM=;
 b=0QD9Bo5ArZ/toPAgrZ/Kwp8g1MN5vGvLlI3JacHftC7LXDAwqZfm7Tb5hscKQ74Tdp4pPzyNi
 hUJ9tsUkDfZBUtISxftgnKStnD51XKADZgJpNxcoo2sKOBdHsu9omPS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: F3A384C9497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9435-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,gmail.com,linutronix.de,lists.ozlabs.org,lists.debian.org,weissschuh.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The module authentication functionality will also be used by the
hash-based module authentication. To make it usable even if
CONFIG_MODULE_SIG is disabled, move it to a new file.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/auth.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h | 14 ++++++--
 kernel/module/main.c     |  6 ++--
 kernel/module/signing.c  | 90 ++----------------------------------------------
 4 files changed, 103 insertions(+), 92 deletions(-)

diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 956ac63d9d33..831a13eb0c9b 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -5,10 +5,16 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/module_signature.h>
 #include <linux/moduleparam.h>
+#include <linux/security.h>
+#include <linux/string.h>
 #include <linux/types.h>
+#include <uapi/linux/module.h>
+#include "internal.h"
 
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX "module."
@@ -30,3 +36,82 @@ void set_module_sig_enforced(void)
 {
 	sig_enforce = true;
 }
+
+static int mod_verify_sig(const void *mod, struct load_info *info)
+{
+	struct module_signature ms;
+	size_t sig_len, modlen = info->len;
+	int ret;
+
+	if (modlen <= sizeof(ms))
+		return -EBADMSG;
+
+	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+
+	ret = mod_check_sig(&ms, modlen, "module");
+	if (ret)
+		return ret;
+
+	sig_len = be32_to_cpu(ms.sig_len);
+	modlen -= sig_len + sizeof(ms);
+	info->len = modlen;
+
+	return module_sig_check(mod, modlen, mod + modlen, sig_len);
+}
+
+int module_auth_check(struct load_info *info, int flags)
+{
+	int err = -ENODATA;
+	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
+	const char *reason;
+	const void *mod = info->hdr;
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
+	/*
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
+	 */
+	if (!mangled_module &&
+	    info->len > markerlen &&
+	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
+		/* We truncate the module to discard the signature */
+		info->len -= markerlen;
+		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->auth_ok = true;
+			return 0;
+		}
+	}
+
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
+	switch (err) {
+	case -ENODATA:
+		reason = "unsigned module";
+		break;
+	case -ENOPKG:
+		reason = "module with unsupported crypto";
+		break;
+	case -ENOKEY:
+		reason = "module with unavailable key";
+		break;
+
+	default:
+		/*
+		 * All other errors are fatal, including lack of memory,
+		 * unparseable signatures, and signature check failures --
+		 * even if signatures aren't required.
+		 */
+		return err;
+	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("Loading of %s is rejected\n", reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index f8f425b167f1..d923e31a5d8e 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -336,14 +336,24 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
 #ifdef CONFIG_MODULE_SIG
-int module_sig_check(struct load_info *info, int flags);
+int module_sig_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len);
 #else /* !CONFIG_MODULE_SIG */
-static inline int module_sig_check(struct load_info *info, int flags)
+static inline int module_sig_check(const void *mod, size_t mod_len,
+				   const void *sig, size_t sig_len)
 {
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
 
+#ifdef CONFIG_MODULE_AUTH
+int module_auth_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_AUTH */
+static inline int module_auth_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_AUTH */
+
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
 #else /* !CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index cd8a74df117e..55a010383a8d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3428,8 +3428,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	char *after_dashes;
 
 	/*
-	 * Do the signature check (if any) first. All that
-	 * the signature check needs is info->len, it does
+	 * Do the authentication checks (if any) first. All that
+	 * the authentication checks need is info->len, it does
 	 * not need any of the section info. That can be
 	 * set up later. This will minimize the chances
 	 * of a corrupt module causing problems before
@@ -3439,7 +3439,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * off the sig length at the end of the module, making
 	 * checks against info->len more correct.
 	 */
-	err = module_sig_check(info, flags);
+	err = module_auth_check(info, flags);
 	if (err)
 		goto free_copy;
 
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 07a786723221..a49317e3c66f 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -5,98 +5,14 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/module_signature.h>
-#include <linux/string.h>
+#include <linux/types.h>
 #include <linux/verification.h>
-#include <linux/security.h>
-#include <crypto/public_key.h>
-#include <uapi/linux/module.h>
 #include "internal.h"
 
-/*
- * Verify the signature on a module.
- */
-static int mod_verify_sig(const void *mod, struct load_info *info)
+int module_sig_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len)
 {
-	struct module_signature ms;
-	size_t sig_len, modlen = info->len;
-	int ret;
-
-	if (modlen <= sizeof(ms))
-		return -EBADMSG;
-
-	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
-
-	ret = mod_check_sig(&ms, modlen, "module");
-	if (ret)
-		return ret;
-
-	sig_len = be32_to_cpu(ms.sig_len);
-	modlen -= sig_len + sizeof(ms);
-	info->len = modlen;
-
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+	return verify_pkcs7_signature(mod, mod_len, sig, sig_len,
 				      VERIFY_USE_SECONDARY_KEYRING,
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-
-int module_sig_check(struct load_info *info, int flags)
-{
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
-	const char *reason;
-	const void *mod = info->hdr;
-	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
-				       MODULE_INIT_IGNORE_VERMAGIC);
-	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
-	 */
-	if (!mangled_module &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
-		err = mod_verify_sig(mod, info);
-		if (!err) {
-			info->auth_ok = true;
-			return 0;
-		}
-	}
-
-	/*
-	 * We don't permit modules to be loaded into the trusted kernels
-	 * without a valid signature on them, but if we're not enforcing,
-	 * certain errors are non-fatal.
-	 */
-	switch (err) {
-	case -ENODATA:
-		reason = "unsigned module";
-		break;
-	case -ENOPKG:
-		reason = "module with unsupported crypto";
-		break;
-	case -ENOKEY:
-		reason = "module with unavailable key";
-		break;
-
-	default:
-		/*
-		 * All other errors are fatal, including lack of memory,
-		 * unparseable signatures, and signature check failures --
-		 * even if signatures aren't required.
-		 */
-		return err;
-	}
-
-	if (is_module_sig_enforced()) {
-		pr_notice("Loading of %s is rejected\n", reason);
-		return -EKEYREJECTED;
-	}
-
-	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
-}

-- 
2.54.0


