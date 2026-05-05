Return-Path: <linux-integrity+bounces-9431-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEncHbO0+WnUAwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9431-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:13:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F64C9561
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8272305EF24
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785AE3F9F33;
	Tue,  5 May 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XkblmXkp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE703F23B4;
	Tue,  5 May 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971939; cv=none; b=B+wSO26bwtubBje75MRT1+ouMSa5GqQUACLSd8gzq5jSkq1SBXtFwBoCCtjI5GVnbQK87174KfomXjpzyOVG4OH+0ujIRPFu9ugH1m0/VwrQblZy0EAI0pY/7kJiU2yAon0zZy8KwrzQNgC9nMwrVRi1DWwlGHX8wB0d8i4U8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971939; c=relaxed/simple;
	bh=Z6oGRNNDPv7HY7Jwe2K5yTNZdEqWzrdbU1BcgGO8c9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKN5WJkN++UBmbeRwgyDoW12Y+lu2iXmZGqVd78A+2c+KftFhsiYX+Pdljnn206deVFyJEI3EwA7iWighPtTnEfh2SH18xZb60QuSLvUhVmDmgat/PxeKMZOTvoao6UY1qTG5xl457QsanlgN+4YwbvqUgDnyZC19PvHyjUyxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XkblmXkp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=Z6oGRNNDPv7HY7Jwe2K5yTNZdEqWzrdbU1BcgGO8c9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XkblmXkpzZZAvu9TAu6Fo8xGr7wGUQLffhlfPsrw/JunGdCmxKegomNJfYxkSvKrq
	 nY+Ah0UWy7MZtVE5pdWxGb2KLagXUd1+rXC3feh++QtJWTN2zCB+dX2wFX50KLr0rC
	 evPC6zYWtifj99O9PunB91EAD+OYk/kkSVv7oceU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:11 +0200
Subject: [PATCH v5 07/14] module: Make module authentication usable without
 MODULE_SIG
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=7097;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Z6oGRNNDPv7HY7Jwe2K5yTNZdEqWzrdbU1BcgGO8c9s=;
 b=gZ9L4Pv0bW11gPm0OadkMRRSd3fcG4bTAsBKfMt93FHeYTx6e3IE0Apbb9U2ZuKdpL6rwl+xH
 0w+pvk6DlWQB4Kj/mcYSKmEB5iRuH1DnEV/AbAzFaQus13MV8FaxoKp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 193F64C9561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9431-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid]

The module authentication functionality will also be used by the
hash-based module authentication. Split it out from CONFIG_MODULE_SIG
so it is usable by both.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 crypto/algapi.c          |  4 ++--
 include/linux/module.h   | 18 +++++++++---------
 kernel/module/Kconfig    |  5 ++++-
 kernel/module/Makefile   |  1 +
 kernel/module/auth.c     | 32 ++++++++++++++++++++++++++++++++
 kernel/module/internal.h |  2 +-
 kernel/module/main.c     |  8 ++++----
 kernel/module/signing.c  | 23 +----------------------
 8 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 37de377719ae..14252b780266 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -24,8 +24,8 @@ static LIST_HEAD(crypto_template_list);
 
 static inline void crypto_check_module_sig(struct module *mod)
 {
-	if (fips_enabled && mod && !module_sig_ok(mod))
-		panic("Module %s signature verification failed in FIPS mode\n",
+	if (fips_enabled && mod && !module_auth_ok(mod))
+		panic("Module %s authentication failed in FIPS mode\n",
 		      module_name(mod));
 }
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..b4760777daad 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -437,9 +437,9 @@ struct module {
 	/* GPL-only exported symbols. */
 	bool using_gplonly_symbols;
 
-#ifdef CONFIG_MODULE_SIG
-	/* Signature was verified. */
-	bool sig_ok;
+#ifdef CONFIG_MODULE_AUTH
+	/* Module was authenticated. */
+	bool auth_ok;
 #endif
 
 	bool async_probe_requested;
@@ -918,16 +918,16 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_AUTH
 bool is_module_sig_enforced(void);
 
 void set_module_sig_enforced(void);
 
-static inline bool module_sig_ok(struct module *module)
+static inline bool module_auth_ok(struct module *module)
 {
-	return module->sig_ok;
+	return module->auth_ok;
 }
-#else	/* !CONFIG_MODULE_SIG */
+#else	/* !CONFIG_MODULE_AUTH */
 static inline bool is_module_sig_enforced(void)
 {
 	return false;
@@ -937,11 +937,11 @@ static inline void set_module_sig_enforced(void)
 {
 }
 
-static inline bool module_sig_ok(struct module *module)
+static inline bool module_auth_ok(struct module *module)
 {
 	return true;
 }
-#endif	/* CONFIG_MODULE_SIG */
+#endif	/* CONFIG_MODULE_AUTH */
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(const char *modname,
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index f535181e0d98..84297da666ff 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -271,9 +271,12 @@ config MODULE_SIG
 	  debuginfo strip done by some packagers (such as rpmbuild) and
 	  inclusion into an initramfs that wants the module size reduced.
 
+config MODULE_AUTH
+	def_bool MODULE_SIG
+
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
-	depends on MODULE_SIG
+	depends on MODULE_AUTH
 	help
 	  Reject unsigned modules or signed modules for which we don't have a
 	  key.  Without this, such modules will simply taint the kernel.
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index d9e8759a7b05..c7200e293d04 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -14,6 +14,7 @@ obj-y += strict_rwx.o
 obj-y += kmod.o
 obj-$(CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS) += dups.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
+obj-$(CONFIG_MODULE_AUTH) += auth.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
diff --git a/kernel/module/auth.c b/kernel/module/auth.c
new file mode 100644
index 000000000000..956ac63d9d33
--- /dev/null
+++ b/kernel/module/auth.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Module authentication checker
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+
+static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
+module_param(sig_enforce, bool_enable_only, 0644);
+
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
+void set_module_sig_enforced(void)
+{
+	sig_enforce = true;
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 006ada7d4e6e..f8f425b167f1 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -68,7 +68,7 @@ struct load_info {
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
-	bool sig_ok;
+	bool auth_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
 #endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 17a352198016..cd8a74df117e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2601,10 +2601,10 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 				mod->name);
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
-#ifdef CONFIG_MODULE_SIG
-	mod->sig_ok = info->sig_ok;
-	if (!mod->sig_ok) {
-		pr_notice_once("%s: module verification failed: signature "
+#ifdef CONFIG_MODULE_AUTH
+	mod->auth_ok = info->auth_ok;
+	if (!mod->auth_ok) {
+		pr_notice_once("%s: module authentication failed: signature "
 			       "and/or required key missing - tainting "
 			       "kernel\n", mod->name);
 		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 69d4b1758540..07a786723221 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,27 +16,6 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "module."
-
-static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-module_param(sig_enforce, bool_enable_only, 0644);
-
-/*
- * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
- * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
- */
-bool is_module_sig_enforced(void)
-{
-	return sig_enforce;
-}
-EXPORT_SYMBOL(is_module_sig_enforced);
-
-void set_module_sig_enforced(void)
-{
-	sig_enforce = true;
-}
-
 /*
  * Verify the signature on a module.
  */
@@ -84,7 +63,7 @@ int module_sig_check(struct load_info *info, int flags)
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
 		if (!err) {
-			info->sig_ok = true;
+			info->auth_ok = true;
 			return 0;
 		}
 	}

-- 
2.54.0


