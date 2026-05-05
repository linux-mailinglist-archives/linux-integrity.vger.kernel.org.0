Return-Path: <linux-integrity+bounces-9434-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJHtMqyz+Wld/AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9434-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:09:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CEB4C938F
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0F78301AA6D
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDBF3FA5DD;
	Tue,  5 May 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bQ5agIzB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AF3E5EE6;
	Tue,  5 May 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971939; cv=none; b=tocO4Qttnx/kyOl10VN3a+ir4Qi0HzlVHOUoHqk8jTqzKKR9aDTqLqCS6hoEZZxbutRMxSdIqtd1KpEer2hq2vRg9besY1Hrbr/QopeyNu15/VVertytlp7VHLvZj3KY6qD39U2yVu8QdtdcDx4d4LsDXvuQSv9DBaDfu+V4obA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971939; c=relaxed/simple;
	bh=elZqxqWASNPH02Zi8B2qimxrAyck+wx1GcCTAUaTf68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmqikKnc16AHEZ3vKNg1uI3EGlgC7xvoICcq0kSpOvver2JQ0aEo6Nvqm2vkqudeyN/mkwjGlil6D0tOzkmUffNSz+x7ilRO6k7kKQ+Ik90vinTEToR6TeUvs1mazg4ORtyj570Qqn3T7FVoXy0bad0umgAnWmUuXJnpYMaATC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bQ5agIzB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=elZqxqWASNPH02Zi8B2qimxrAyck+wx1GcCTAUaTf68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bQ5agIzBPRuFL7JWUhX7aDRNPbRhYiMMw3NdQA1wwclDcc9afVYMsG/75i/WNqhAA
	 hijo/UrDsuQnHCYS7acn94RhzsDs7Y51FfF3ckZNMmNlu5Jpy4KPF9/PiukPGcZcfg
	 X9HSI5nDm5v9ZQqJggt0rWkhUIJPYhzeHojeyMw8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:18 +0200
Subject: [PATCH v5 14/14] kbuild: make CONFIG_MODULE_HASHES compatible with
 module stripping
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=3316;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=elZqxqWASNPH02Zi8B2qimxrAyck+wx1GcCTAUaTf68=;
 b=VL/y6lxcfMaVVCAqnHqBHAsMZQRoRMAJFmErw+a7YjNMWb7GcK//q6XoNoKQXYhMyaE3gwwLJ
 is6WW72xVPJDMy3Dd1T+JiFrphn8xBMZBZ2NTjggWulGxg5uKuR6cHw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 93CEB4C938F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9434-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid]

CONFIG_MODULE_HASHES needs to process the modules at build time in the
exact form they will be loaded at runtime. If the modules are stripped
afterwards they will not be loadable anymore.

Also evaluate INSTALL_MOD_STRIP at build time and build the hashes based
on modules stripped this way.

If users specify inconsistent values of INSTALL_MOD_STRIP between build
and installation time, an error is reported.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                | 1 +
 kernel/module/Kconfig     | 5 +++++
 scripts/Makefile.modfinal | 9 +++++++++
 scripts/Makefile.modinst  | 4 ++--
 scripts/Makefile.vmlinux  | 2 +-
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78cf799401e6..6ce10623c5a3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@
 *.gz
 *.i
 *.ko
+*.ko.stripped
 *.lex.c
 *.ll
 *.lst
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index acbbda58e7c8..48be498a4452 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -423,6 +423,11 @@ config MODULE_HASHES
 
 	  Also see the warning in MODULE_SIG about stripping modules.
 
+# To validate the consistency of INSTALL_MOD_STRIP for MODULE_HASHES
+config MODULE_INSTALL_STRIP
+	string
+	default "$(INSTALL_MOD_STRIP)"
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 44a382689a5a..9924a7bb73c5 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -64,7 +64,16 @@ ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 endif
 	+$(call cmd,check_tracepoint)
 
+%.ko.stripped: %.ko $(wildcard include/config/MODULE_INSTALL_STRIP)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
+
+ifneq ($(CONFIG_MODULE_INSTALL_STRIP),)
+modules.order: $(modules:%.o=%.ko.stripped)
+endif
+
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
+targets += $(modules:%.o=%.ko.stripped)
 
 # Update modules.order when a module is (re-)built.
 # Allow using it as target dependency.
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index b95f613e23c8..fd1fb89bb0bd 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -68,8 +68,8 @@ __modinst: $(install-y)
 
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
-ifdef INSTALL_MOD_STRIP
-$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+ifneq ($(INSTALL_MOD_STRIP),$(CONFIG_MODULE_INSTALL_STRIP))
+$(error Inconsistent values for INSTALL_MOD_STRIP between build and installation)
 endif
 endif
 endif
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index a0332c06bde1..a2d170241a2f 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -86,7 +86,7 @@ modules.order: vmlinux.unstripped FORCE
 	$(Q)$(MAKE) -f $(srctree)/Makefile modules
 
 quiet_cmd_modules_merkle_tree = MERKLE  $@
-      cmd_modules_merkle_tree = $< $@ .ko
+      cmd_modules_merkle_tree = $< $@ $(if $(CONFIG_MODULE_INSTALL_STRIP),.ko.stripped,.ko)
 
 targets += .tmp_module_hashes.c
 .tmp_module_hashes.c: $(objtree)/scripts/modules-merkle-tree modules.order FORCE

-- 
2.54.0


