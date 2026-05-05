Return-Path: <linux-integrity+bounces-9437-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAa4G2i2+WmNBAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9437-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:20:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822C4C97DD
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58A1F30216DF
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECC3E2743;
	Tue,  5 May 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="peK6gKbp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA530E0E5;
	Tue,  5 May 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972247; cv=none; b=dm+H7mDuEAJ6aGjDw4IxvAeDy+7vTPbyMq4mscxbBio7oHG7wcbyYi+obF9PPjaVx3WRVYnRA6AkmLaqIa4xGKw1E6h/Poxnk2MmNda5BGDxk38Ib/u53sfwWxsO02jwMVS5pQAntXCgQ9ttID/TB8j8U368vsbHZ46nuk+ryZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972247; c=relaxed/simple;
	bh=yof0b38w6FUaPXaXJVuEYnR5HxHXG6atxby+tUyoxFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqLj9R60iU7sO+UA7VgCGObOAXzohBDUiy+W+6GP+eTbJeaV7cZu69B4GPVM5InFpF8Q4G4u3T03sgTK4s54p2Gbi3dOf+yf3t2dZcR9lixAUVX7ByB3aoIy+6YYgu1ZJdpOL6cAzlSjr6VaGHAdZFH3An4bJbCVxXFPCA10K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=peK6gKbp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777972242;
	bh=yof0b38w6FUaPXaXJVuEYnR5HxHXG6atxby+tUyoxFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=peK6gKbpZy9I2phipLr55Fcmd9gtrGuZOeNZtSVObfqt6DpO/b/TAPVcRP8FOdZs3
	 +FzamGKC2tLwT1aeF7e76QEhToz/xMmPPR2LtOk0y4dB7c99N+h6iXpMIPM0P6+V5e
	 71yemcE5YnO7t0cR3Y7DlzDSYtFxX8DhHB/XYvps=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:16 +0200
Subject: [PATCH v5 12/14] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-12-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=31710;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yof0b38w6FUaPXaXJVuEYnR5HxHXG6atxby+tUyoxFE=;
 b=siIepplh1FilcLPn8putesLGCzUZGqtVhKp+bmtp42MnyR8HeJmS+FNxtZift5z7h6LEcmcCf
 IP6vBhYlk0YCllMcWb/mTsdHcfZS3SpufWRnpAfpah+MUlMt99oibUB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 8822C4C97DD
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
	TAGGED_FROM(0.00)[bounces-9437-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,breakpoint.cc:email]

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds. Either the module signing key
is generated at build time, which makes the build unreproducible, or a
static signing key is used, which precludes rebuilds by third parties
and makes the whole build and packaging process much more complicated.

The goal is to reach bit-for-bit reproducibility. Excluding certain
parts of the build output from the reproducibility analysis would be
error-prone and force each downstream consumer to introduce new tooling.

Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a merkle tree root of all modules built as part of the full
kernel build into vmlinux.

Out-of-tree modules can be validated as before through signatures.

Normally the .ko module files depend on a fully built vmlinux to be
available for modpost validation and BTF generation. With
CONFIG_MODULE_HASHES, vmlinux now depends on the modules
to build a merkle tree. This introduces a dependency cycle which is
impossible to satisfy. Work around this by building the modules during
link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
but before the final module hashes are

The PKCS7 format which is used for regular module signatures can not
represent Merkle proofs, so a new kind of module signature is
introduced. As this signature type is only ever used for builtin
modules, no compatibility issues can arise.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                                   |   1 +
 Documentation/kbuild/reproducible-builds.rst |   5 +-
 Makefile                                     |   7 +-
 include/asm-generic/vmlinux.lds.h            |  11 +
 include/linux/module_hashes.h                |  29 ++
 include/uapi/linux/module_signature.h        |   1 +
 kernel/module/Kconfig                        |  21 +-
 kernel/module/Makefile                       |   1 +
 kernel/module/auth.c                         |   6 +
 kernel/module/hashes.c                       |  95 ++++++
 kernel/module/hashes_root.c                  |   6 +
 kernel/module/internal.h                     |   1 +
 scripts/.gitignore                           |   1 +
 scripts/Makefile                             |   4 +
 scripts/Makefile.modinst                     |  11 +
 scripts/Makefile.vmlinux                     |  32 +++
 scripts/include/xalloc.h                     |  29 ++
 scripts/link-vmlinux.sh                      |   3 +-
 scripts/modules-merkle-tree.c                | 416 +++++++++++++++++++++++++++
 security/lockdown/Kconfig                    |   2 +-
 tools/include/uapi/linux/module_signature.h  |   1 +
 21 files changed, 677 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3044b9590f05..78cf799401e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@
 *.lz4
 *.lzma
 *.lzo
+*.merkle
 *.mod
 *.mod.c
 *.o
diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index bc1eb82211df..b15019678aae 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -84,7 +84,10 @@ generate a different temporary key for each build, resulting in the
 modules being unreproducible.  However, including a signing key with
 your source would presumably defeat the purpose of signing modules.
 
-One approach to this is to divide up the build process so that the
+Instead ``CONFIG_MODULE_HASHES`` can be used to embed a static list
+of valid modules to load.
+
+Another approach to this is to divide up the build process so that the
 unreproducible parts can be treated as sources:
 
 1. Generate a persistent signing key.  Add the certificate for the key
diff --git a/Makefile b/Makefile
index e27c91ea56fc..def4a2413c43 100644
--- a/Makefile
+++ b/Makefile
@@ -1650,7 +1650,9 @@ ifdef CONFIG_MODULES
 
 # By default, build modules as well
 
+ifndef CONFIG_MODULE_HASHES
 all: modules
+endif
 
 # When we're building modules with modversions, we need to consider
 # the built-in objects during the descend as well, in order to
@@ -1666,8 +1668,10 @@ endif
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := y
+ifndef CONFIG_MODULE_HASHES
 modules: vmlinux
 endif
+endif
 
 modules: modules_prepare
 
@@ -2068,7 +2072,7 @@ modules.order: $(build-dir)
 # KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
 # This is solely useful to speed up test compiles.
 modules: modpost
-ifneq ($(KBUILD_MODPOST_NOFINAL),1)
+ifneq ($(CONFIG_MODULE_HASHES)|$(KBUILD_MODPOST_NOFINAL),|1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
 endif
 
@@ -2162,6 +2166,7 @@ clean: $(clean-dirs)
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
+		-o -name '*.merkle' \
 		\) -type f -print \
 		-o -name '.tmp_*' -print \
 		| xargs rm -rf
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..661881e5ef96 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -508,6 +508,8 @@
 									\
 	PRINTK_INDEX							\
 									\
+	MODULE_HASHES							\
+									\
 	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
@@ -913,6 +915,15 @@
 #define PRINTK_INDEX
 #endif
 
+#ifdef CONFIG_MODULE_HASHES
+#define MODULE_HASHES							\
+	.module_hashes : AT(ADDR(.module_hashes) - LOAD_OFFSET) {	\
+		KEEP(*(SORT(.module_hashes)))				\
+	}
+#else
+#define MODULE_HASHES
+#endif
+
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
diff --git a/include/linux/module_hashes.h b/include/linux/module_hashes.h
new file mode 100644
index 000000000000..53b34fa12f2d
--- /dev/null
+++ b/include/linux/module_hashes.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_MODULE_HASHES_H
+#define _LINUX_MODULE_HASHES_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+#include <crypto/sha2.h>
+
+#define __module_hashes_section __section(".module_hashes")
+#define MODULE_HASHES_HASH_SIZE SHA256_DIGEST_SIZE
+
+struct module_hash {
+	u8 h[MODULE_HASHES_HASH_SIZE];
+};
+
+struct module_hashes_proof {
+	__be32 pos;
+	struct module_hash hash_sigs[];
+} __packed;
+
+struct module_hashes_root {
+	u32 levels;
+	struct module_hash hash;
+};
+
+extern const struct module_hashes_root module_hashes_root;
+
+#endif /* _LINUX_MODULE_HASHES_H */
diff --git a/include/uapi/linux/module_signature.h b/include/uapi/linux/module_signature.h
index 634c9f1c8fc2..78e206996eed 100644
--- a/include/uapi/linux/module_signature.h
+++ b/include/uapi/linux/module_signature.h
@@ -16,6 +16,7 @@
 
 enum module_signature_type {
 	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
+	MODULE_SIGNATURE_TYPE_MERKLE = 3,	/* Merkle proof for modules, opaque structure */
 };
 
 /*
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 84297da666ff..acbbda58e7c8 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -272,7 +272,7 @@ config MODULE_SIG
 	  inclusion into an initramfs that wants the module size reduced.
 
 config MODULE_AUTH
-	def_bool MODULE_SIG
+	def_bool MODULE_SIG || MODULE_HASHES
 
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
@@ -291,7 +291,7 @@ config MODULE_SIG_ALL
 	  modules must be signed manually, using the scripts/sign-file tool.
 
 comment "Do not forget to sign required modules with scripts/sign-file"
-	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
+	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL && !MODULE_HASHES
 
 choice
 	prompt "Hash algorithm to sign modules"
@@ -406,6 +406,23 @@ config MODULE_DECOMPRESS
 
 endif # MODULE_COMPRESS
 
+config MODULE_HASHES
+	bool "Hash-based module authentication"
+	depends on !MODULE_SIG_ALL
+	depends on !IMA_APPRAISE_MODSIG
+	select MODULE_SIG_FORMAT
+	select CRYPTO_LIB_SHA256
+	help
+	  Validate modules by their hashes.
+	  Only modules built together with the main kernel image can be
+	  validated that way.
+
+	  This is a reproducible-build compatible alternative to a build-time
+	  generated module keyring, as enabled by
+	  CONFIG_MODULE_SIG_KEY=certs/signing_key.pem.
+
+	  Also see the warning in MODULE_SIG about stripping modules.
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index c7200e293d04..da9420f140e9 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+obj-$(CONFIG_MODULE_HASHES) += hashes.o hashes_root.o
diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 2ee512d26790..cf3fe3f8bd89 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -42,6 +42,9 @@ static __always_inline bool mod_sig_type_valid(enum module_signature_type id_typ
 	if (id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
 		return true;
 
+	if (id_type == MODULE_SIGNATURE_TYPE_MERKLE && IS_ENABLED(CONFIG_MODULE_HASHES))
+		return true;
+
 	return false;
 }
 
@@ -72,6 +75,9 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 	if (ms.id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
 		return module_sig_check(mod, modlen, mod + modlen, sig_len);
 
+	if (ms.id_type == MODULE_SIGNATURE_TYPE_MERKLE && IS_ENABLED(CONFIG_MODULE_HASHES))
+		return module_hash_check(mod, modlen, mod + modlen, sig_len);
+
 	return 0;
 }
 
diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
new file mode 100644
index 000000000000..3d3cf0366f75
--- /dev/null
+++ b/kernel/module/hashes.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Module hash-based integrity checker
+ *
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ *
+ * The structure of the Merkle tree is documented in scripts/modules-merkle-tree.c.
+ */
+
+#define pr_fmt(fmt) "module/hash: " fmt
+
+#include <linux/module_hashes.h>
+#include <linux/module.h>
+#include <linux/unaligned.h>
+
+#include <crypto/sha2.h>
+
+#include "internal.h"
+
+static __init __maybe_unused int module_hashes_init(void)
+{
+	pr_debug("root: levels=%u hash=%*phN\n",
+		 module_hashes_root.levels,
+		 (int)sizeof(module_hashes_root.hash), &module_hashes_root.hash);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_MODULE_DEBUG)
+early_initcall(module_hashes_init);
+#endif
+
+static void hash_entry(const struct module_hash *left, const struct module_hash *right,
+		       struct module_hash *out)
+{
+	struct sha256_ctx ctx;
+	u8 magic = 0x02;
+
+	sha256_init(&ctx);
+	sha256_update(&ctx, &magic, sizeof(magic));
+	sha256_update(&ctx, left->h, sizeof(left->h));
+	sha256_update(&ctx, right->h, sizeof(right->h));
+	sha256_final(&ctx, out->h);
+}
+
+static void hash_data(const u8 *d, size_t len, unsigned int pos, struct module_hash *out)
+{
+	struct sha256_ctx ctx;
+	u8 magic = 0x01;
+	__be32 pos_be;
+
+	pos_be = cpu_to_be32(pos);
+
+	sha256_init(&ctx);
+	sha256_update(&ctx, &magic, sizeof(magic));
+	sha256_update(&ctx, (const u8 *)&pos_be, sizeof(pos_be));
+	sha256_update(&ctx, d, len);
+	sha256_final(&ctx, out->h);
+}
+
+static bool module_hashes_verify_proof(u32 pos, const struct module_hash *hash_sigs,
+				       struct module_hash *cur)
+{
+	for (unsigned int i = 0; i < module_hashes_root.levels; i++, pos >>= 1) {
+		if ((pos & 1) == 0)
+			hash_entry(cur, &hash_sigs[i], cur);
+		else
+			hash_entry(&hash_sigs[i], cur, cur);
+	}
+
+	return !memcmp(cur, &module_hashes_root.hash, sizeof(module_hashes_root.hash));
+}
+
+int module_hash_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len)
+{
+	const struct module_hashes_proof *proof;
+	struct module_hash modhash;
+	size_t proof_size;
+	u32 pos;
+
+	proof_size = struct_size(proof, hash_sigs, module_hashes_root.levels);
+
+	if (sig_len != proof_size)
+		return -ENOPKG;
+
+	proof = (const struct module_hashes_proof *)sig;
+	pos = get_unaligned_be32(&proof->pos);
+
+	hash_data(mod, mod_len, pos, &modhash);
+
+	if (!module_hashes_verify_proof(pos, proof->hash_sigs, &modhash))
+		return -ENOKEY;
+
+	return 0;
+}
diff --git a/kernel/module/hashes_root.c b/kernel/module/hashes_root.c
new file mode 100644
index 000000000000..ffb6adfc2193
--- /dev/null
+++ b/kernel/module/hashes_root.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module_hashes.h>
+
+/* Blank dummy data. Will be replaced by the read data during the build */
+const struct module_hashes_root module_hashes_root __module_hashes_section = {};
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index aabe7f8e1af4..259e8ca5cb25 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -336,6 +336,7 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
 int module_sig_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len);
+int module_hash_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len);
 
 #ifdef CONFIG_MODULE_AUTH
 int module_auth_check(struct load_info *info, int flags);
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 4215c2208f7e..8dad9b0d3b2d 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -5,6 +5,7 @@
 /insert-sys-cert
 /kallsyms
 /module.lds
+/modules-merkle-tree
 /recordmcount
 /rustdoc_test_builder
 /rustdoc_test_gen
diff --git a/scripts/Makefile b/scripts/Makefile
index c983e09be78c..b6291595d9e8 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,6 +11,7 @@ hostprogs-always-y					+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
+hostprogs-always-$(CONFIG_MODULE_HASHES)		+= modules-merkle-tree
 hostprogs-always-$(CONFIG_TRACEPOINTS)			+= tracepoint-update
 
 sorttable-objs := sorttable.o elf-parse.o
@@ -37,6 +38,9 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
 HOSTCFLAGS_sign-file.o += -I$(srctree)/tools/include/uapi/
 HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+HOSTCFLAGS_modules-merkle-tree.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTCFLAGS_modules-merkle-tree.o += -I$(srctree)/tools/include/uapi/
+HOSTLDLIBS_modules-merkle-tree = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 9ba45e5b32b1..68708a039a62 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -79,6 +79,12 @@ quiet_cmd_install = INSTALL $@
 # as the options to the strip command.
 ifdef INSTALL_MOD_STRIP
 
+ifdef CONFIG_MODULE_HASHES
+ifeq ($(KBUILD_EXTMOD),)
+$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+endif
+endif
+
 ifeq ($(INSTALL_MOD_STRIP),1)
 strip-option := --strip-debug
 else
@@ -116,6 +122,11 @@ quiet_cmd_sign :=
       cmd_sign := :
 endif
 
+ifeq ($(KBUILD_EXTMOD)|$(CONFIG_MODULE_HASHES),|y)
+quiet_cmd_sign = MERKLE [M] $@
+      cmd_sign = cat $(objtree)/$*.merkle >> $@
+endif
+
 # Create necessary directories
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 6cc661e5292b..a0332c06bde1 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -78,6 +78,33 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
 vmlinux.unstripped: scripts/sorttable
 endif
 
+ifdef CONFIG_MODULE_HASHES
+targets += .tmp_module_hashes.c
+
+modules.order: vmlinux.unstripped FORCE
+	$(Q)echo "  MAKE    modules"
+	$(Q)$(MAKE) -f $(srctree)/Makefile modules
+
+quiet_cmd_modules_merkle_tree = MERKLE  $@
+      cmd_modules_merkle_tree = $< $@ .ko
+
+targets += .tmp_module_hashes.c
+.tmp_module_hashes.c: $(objtree)/scripts/modules-merkle-tree modules.order FORCE
+	$(call if_changed,modules_merkle_tree)
+
+targets += .tmp_module_hashes.o
+.tmp_module_hashes.o: .tmp_module_hashes.c FORCE
+
+quiet_cmd_modules_merkle_tree_root = GEN     $@
+      cmd_modules_merkle_tree_root = $(OBJCOPY) --dump-section .module_hashes=$@ $<
+
+targets += .tmp_module_hashes.bin
+.tmp_module_hashes.bin: .tmp_module_hashes.o FORCE
+	$(call if_changed,modules_merkle_tree_root)
+
+vmlinux: .tmp_module_hashes.bin
+endif
+
 # vmlinux
 # ---------------------------------------------------------------------------
 
@@ -95,6 +122,11 @@ quiet_cmd_objcopy_vmlinux = OBJCOPY $@
       cmd_objcopy_vmlinux = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
                             $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
 
+ifdef CONFIG_MODULE_HASHES
+# Patch module hashes root into vmlinux after modules have been built.
+      cmd_objcopy_vmlinux += ; $(OBJCOPY) --update-section .module_hashes=.tmp_module_hashes.bin $@
+endif
+
 targets += vmlinux
 vmlinux: vmlinux.unstripped FORCE
 	$(call if_changed,objcopy_vmlinux)
diff --git a/scripts/include/xalloc.h b/scripts/include/xalloc.h
index cdadb07d0592..8294bc0b836f 100644
--- a/scripts/include/xalloc.h
+++ b/scripts/include/xalloc.h
@@ -3,6 +3,7 @@
 #ifndef XALLOC_H
 #define XALLOC_H
 
+#include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -50,4 +51,32 @@ static inline char *xstrndup(const char *s, size_t n)
 	return p;
 }
 
+static inline void *xreallocarray(void *oldp, size_t n, size_t size)
+{
+	void *p;
+
+	p = reallocarray(oldp, n, size);
+	if (!p)
+		exit(1);
+
+	return p;
+}
+
+#ifdef _GNU_SOURCE
+static inline char *xasprintf(const char *fmt, ...)
+{
+	va_list ap;
+	char *strp;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vasprintf(&strp, fmt, ap);
+	va_end(ap);
+	if (ret == -1)
+		exit(1);
+
+	return strp;
+}
+#endif /* _GNU_SOURCE */
+
 #endif /* XALLOC_H */
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f99e196abeea..0edec5ee34dc 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -103,7 +103,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${module_hashes_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # Create ${2}.o file with all symbols from the ${1} object file
@@ -183,6 +183,7 @@ fi
 btf_vmlinux_bin_o=
 btfids_vmlinux=
 kallsymso=
+module_hashes_o=
 strip_debug=
 generate_map=
 
diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
new file mode 100644
index 000000000000..10e3455d5d7a
--- /dev/null
+++ b/scripts/modules-merkle-tree.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Compute hashes for modules files and build a merkle tree.
+ *
+ * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ *
+ * Structure of the Merkle tree:
+ *
+ * The full built modules are leaf nodes. They are hashed pairwise in the order
+ * of modules.order to create internal nodes. These in turn are also hashed
+ * pairwise to create the next higher level of internal nodes. This is repeated
+ * up to a single root node. In case of an uneven amount of node on a level, the
+ * last node is paired with itself.
+ *
+ * The single root node can then be embedded into vmlinux to validate all modules.
+ */
+
+#define _GNU_SOURCE 1
+#include <endian.h>
+#include <err.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <openssl/evp.h>
+#include <openssl/err.h>
+
+#include "ssl-common.h"
+
+#include <linux/module_signature.h>
+#include <xalloc.h>
+
+static int hash_size;
+static EVP_MD_CTX *ctx;
+
+struct hash {
+	uint8_t h[32]; /* For sha256 */
+};
+
+struct file_entry {
+	char *name;
+	unsigned int pos;
+	struct hash hash;
+};
+
+static struct file_entry *fh_list;
+static size_t num_files;
+
+struct mtree {
+	struct hash **level_hashes;
+	unsigned int *entries;
+	unsigned int num_levels;
+};
+
+static unsigned int log2_roundup(uint32_t val)
+{
+	if (val <= 1)
+		return 1;
+	return 32 - __builtin_clz(val - 1);
+}
+
+static void hash_data(unsigned int pos, unsigned char *data, size_t size, struct hash *ret_hash)
+{
+	uint8_t magic = 0x01; /* domain separation prefix */
+	uint32_t pos_be;
+
+	pos_be = htobe32(pos);
+
+	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
+	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
+	ERR(EVP_DigestUpdate(ctx, &pos_be, sizeof(pos_be)) != 1, "EVP_DigestUpdate(pos)");
+	ERR(EVP_DigestUpdate(ctx, data, size) != 1, "EVP_DigestUpdate(data)");
+	ERR(EVP_DigestFinal_ex(ctx, ret_hash->h, NULL) != 1, "EVP_DigestFinal_ex()");
+}
+
+static void hash_entry(const struct hash *left, const struct hash *right, struct hash *ret_hash)
+{
+	uint8_t magic = 0x02; /* domain separation prefix */
+
+	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
+	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
+	ERR(EVP_DigestUpdate(ctx, left, hash_size) != 1, "EVP_DigestUpdate(left)");
+	ERR(EVP_DigestUpdate(ctx, right, hash_size) != 1, "EVP_DigestUpdate(right)");
+	ERR(EVP_DigestFinal_ex(ctx, ret_hash->h, NULL) != 1, "EVP_DigestFinal_ex()");
+}
+
+static void hash_file(struct file_entry *fe)
+{
+	unsigned char *mem;
+	struct stat sb;
+	int fd, ret;
+
+	fd = open(fe->name, O_RDONLY);
+	if (fd < 0)
+		err(1, "Failed to open %s", fe->name);
+
+	ret = fstat(fd, &sb);
+	if (ret)
+		err(1, "Failed to stat %s", fe->name);
+
+	mem = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED)
+		err(1, "Failed to mmap %s", fe->name);
+
+	hash_data(fe->pos, mem, sb.st_size, &fe->hash);
+
+	munmap(mem, sb.st_size);
+	close(fd);
+}
+
+static struct mtree *build_merkle(struct file_entry *files, size_t num_files)
+{
+	unsigned int num_cur_le, num_prev_le;
+	struct mtree *mt;
+
+	if (!num_files)
+		return NULL;
+
+	mt = xmalloc(sizeof(*mt));
+	mt->num_levels = log2_roundup(num_files);
+
+	mt->level_hashes = xcalloc(sizeof(*mt->level_hashes), mt->num_levels);
+
+	mt->entries = xcalloc(sizeof(*mt->entries), mt->num_levels);
+	num_cur_le = (num_files + 1) / 2;
+	mt->entries[0] = num_cur_le;
+	mt->level_hashes[0] = xcalloc(sizeof(**mt->level_hashes), num_cur_le);
+
+	/* First level of pairs */
+	for (size_t i = 0; i < num_files; i += 2) {
+		/* Hash the pair, or the last file with itself if it's odd. */
+		const struct hash *right = i + 1 < num_files ? &files[i + 1].hash : &files[i].hash;
+
+		hash_entry(&files[i].hash, right, &mt->level_hashes[0][i / 2]);
+	}
+
+	for (unsigned int i = 1; i < mt->num_levels; i++) {
+		num_prev_le = num_cur_le;
+
+		num_cur_le = (num_prev_le + 1) / 2;
+		mt->entries[i] = num_cur_le;
+		mt->level_hashes[i] = xcalloc(sizeof(**mt->level_hashes), num_cur_le);
+
+		for (unsigned int n = 0; n < num_prev_le; n += 2) {
+			/* Hash the pair, or the last with itself if it's odd. */
+			const struct hash *right = n + 1 < num_prev_le ?
+						   &mt->level_hashes[i - 1][n + 1] :
+						   &mt->level_hashes[i - 1][n];
+			hash_entry(&mt->level_hashes[i - 1][n], right,
+				   &mt->level_hashes[i][n / 2]);
+		}
+	}
+
+	/* FIXME assert single hash in root */
+
+	return mt;
+}
+
+static void free_mtree(struct mtree *mt)
+{
+	if (!mt)
+		return;
+
+	for (unsigned int i = 0; i < mt->num_levels; i++)
+		free(mt->level_hashes[i]);
+
+	free(mt->level_hashes);
+	free(mt->entries);
+	free(mt);
+}
+
+static void write_be_int(int fd, unsigned int v)
+{
+	unsigned int be_val = htobe32(v);
+
+	if (write(fd, &be_val, sizeof(be_val)) != sizeof(be_val))
+		err(1, "Failed writing to file");
+}
+
+static void write_hash(int fd, const struct hash *hash)
+{
+	if (write(fd, hash->h, hash_size) != hash_size)
+		err(1, "Failed writing to file");
+}
+
+static void build_proof(struct mtree *mt, unsigned int n, int fd)
+{
+	struct file_entry *fe, *fe_sib;
+
+	fe = &fh_list[n];
+
+	if ((n & 1) == 0) {
+		/* No pair, hash with itself */
+		if (n + 1 == num_files)
+			fe_sib = fe;
+		else
+			fe_sib = &fh_list[n + 1];
+	} else {
+		fe_sib = &fh_list[n - 1];
+	}
+	/* First comes the node position into the file */
+	write_be_int(fd, n);
+
+	/* Next is the sibling hash, followed by hashes in the tree */
+	write_hash(fd, &fe_sib->hash);
+
+	for (unsigned int i = 0; i < mt->num_levels - 1; i++) {
+		n >>= 1;
+		if ((n & 1) == 0) {
+			const struct hash *h;
+
+			/* No pair, hash with itself */
+			if (n + 1 == mt->entries[i])
+				h = &mt->level_hashes[i][n];
+			else
+				h = &mt->level_hashes[i][n + 1];
+
+			write_hash(fd, h);
+		} else {
+			write_hash(fd, &mt->level_hashes[i][n - 1]);
+		}
+	}
+}
+
+static void append_module_signature_magic(int fd, unsigned int sig_len)
+{
+	const struct module_signature sig_info = {
+		.id_type	= MODULE_SIGNATURE_TYPE_MERKLE,
+		.sig_len	= htobe32(sig_len),
+	};
+	const size_t sig_str_len = sizeof(MODULE_SIGNATURE_MARKER) - 1;
+	const char *sig_str = MODULE_SIGNATURE_MARKER;
+
+	if (write(fd, &sig_info, sizeof(sig_info)) != sizeof(sig_info))
+		err(1, "write(sig_info) failed");
+
+	if (write(fd, sig_str, sig_str_len) != sig_str_len)
+		err(1, "write(magic_number) failed");
+}
+
+static void write_merkle_root(struct mtree *mt, const char *filename)
+{
+	unsigned int num_levels;
+	struct hash *h;
+	FILE *f;
+
+	if (mt) {
+		num_levels = mt->num_levels;
+		h = &mt->level_hashes[mt->num_levels - 1][0];
+	} else {
+		num_levels = 0;
+		h = xcalloc(1, hash_size);
+	}
+
+	f = fopen(filename, "w");
+	if (!f)
+		err(1, "Failed to create %s", filename);
+
+	fprintf(f, "#include <linux/module_hashes.h>\n\n");
+	fprintf(f, "const struct\n");
+	fprintf(f, "module_hashes_root module_hashes_root __module_hashes_section = {\n");
+
+	fprintf(f, "\t.levels = %u,\n", num_levels);
+	fprintf(f, "\t.hash = {{");
+	for (unsigned int i = 0; i < hash_size; i++) {
+		char *space = "";
+
+		if (!(i % 8))
+			fprintf(f, "\n\t\t");
+
+		if ((i + 1) % 8)
+			space = " ";
+
+		fprintf(f, "0x%02x,%s", h->h[i], space);
+	}
+	fprintf(f, "\n\t}},");
+
+	fprintf(f, "\n};\n");
+
+	if (fclose(f))
+		err(1, "Failed to write %s", filename);
+
+	if (!mt)
+		free(h);
+}
+
+static char *xstrdup_replace_suffix(const char *str, const char *old_suffix, const char *new_suffix)
+{
+	size_t str_len, old_suffix_len, base_len;
+
+	str_len = strlen(str);
+	old_suffix_len = strlen(old_suffix);
+	base_len = str_len - old_suffix_len;
+
+	if (old_suffix_len > str_len || memcmp(str + base_len, old_suffix, old_suffix_len) != 0)
+		errx(1, "'%s' does not end in '%s'", str, old_suffix);
+
+	return xasprintf("%.*s%s", (int)base_len, str, new_suffix);
+}
+
+static void trim_newline(char *line)
+{
+	size_t len;
+
+	if (!line)
+		return;
+
+	len = strlen(line);
+	if (!len)
+		return;
+
+	if (line[len - 1] == '\n')
+		line[len - 1] = '\0';
+}
+
+static void read_modules_order(const char *fname, const char *suffix)
+{
+	char line[PATH_MAX];
+	FILE *in;
+
+	in = fopen(fname, "r");
+	if (!in)
+		err(1, "Failed to open %s", fname);
+
+	while (fgets(line, PATH_MAX, in)) {
+		struct file_entry *entry;
+
+		trim_newline(line);
+
+		fh_list = xreallocarray(fh_list, num_files + 1, sizeof(*fh_list));
+		entry = &fh_list[num_files];
+
+		entry->pos = num_files;
+		entry->name = xstrdup_replace_suffix(line, ".o", suffix);
+		hash_file(entry);
+
+		num_files++;
+	}
+
+	if (ferror(in))
+		errx(1, "Failed to read %s", fname);
+
+	fclose(in);
+}
+
+static __attribute__((noreturn))
+void usage(void)
+{
+	fprintf(stderr,
+		"Usage: scripts/modules-merkle-tree <kmod suffix> <root definition>\n");
+	exit(2);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *kmod_suffix;
+	const EVP_MD *hash_evp;
+	struct mtree *mt;
+
+	if (argc != 3)
+		usage();
+
+	kmod_suffix = argv[2];
+
+	hash_evp = EVP_sha256();
+	ERR(!hash_evp, "EVP_sha256()");
+
+	ctx = EVP_MD_CTX_new();
+	ERR(!ctx, "EVP_MD_CTX_new()");
+
+	hash_size = EVP_MD_get_size(hash_evp);
+	ERR(hash_size <= 0, "EVP_get_digestbyname");
+
+	if (hash_size != sizeof(struct hash))
+		errx(1, "Invalid hash size");
+
+	if (EVP_DigestInit_ex(ctx, hash_evp, NULL) != 1)
+		ERR(1, "EVP_DigestInit_ex()");
+
+	read_modules_order("modules.order", kmod_suffix);
+
+	mt = build_merkle(fh_list, num_files);
+	write_merkle_root(mt, argv[1]);
+	for (size_t i = 0; i < num_files; i++) {
+		char *signame;
+		int fd;
+
+		signame = xstrdup_replace_suffix(fh_list[i].name, kmod_suffix, ".merkle");
+
+		fd = open(signame, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd < 0)
+			err(1, "Can't create %s", signame);
+
+		build_proof(mt, i, fd);
+		append_module_signature_magic(fd, lseek(fd, 0, SEEK_CUR));
+		if (close(fd))
+			err(1, "Can't write %s", signame);
+	}
+
+	free_mtree(mt);
+	for (size_t i = 0; i < num_files; i++)
+		free(fh_list[i].name);
+	free(fh_list);
+
+	EVP_MD_CTX_free(ctx);
+	return 0;
+}
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index 155959205b8e..60b240e3ef1f 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -1,7 +1,7 @@
 config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
-	depends on !MODULES || MODULE_SIG
+	depends on !MODULES || MODULE_SIG || MODULE_HASHES
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.
diff --git a/tools/include/uapi/linux/module_signature.h b/tools/include/uapi/linux/module_signature.h
index 634c9f1c8fc2..78e206996eed 100644
--- a/tools/include/uapi/linux/module_signature.h
+++ b/tools/include/uapi/linux/module_signature.h
@@ -16,6 +16,7 @@
 
 enum module_signature_type {
 	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
+	MODULE_SIGNATURE_TYPE_MERKLE = 3,	/* Merkle proof for modules, opaque structure */
 };
 
 /*

-- 
2.54.0


