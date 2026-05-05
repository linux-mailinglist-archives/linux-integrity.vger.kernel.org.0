Return-Path: <linux-integrity+bounces-9438-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI34NxS2+WmvBAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9438-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:19:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE654C9784
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F49830A33B0
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE703E9F7B;
	Tue,  5 May 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Up2Yt+/i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D3347BD4;
	Tue,  5 May 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972248; cv=none; b=lgC4MFwyo1FD1pfZM48nchWgLWz0DkX2jN4CAP5FjatgWztg3gZpGDnQjca9CgfWwfJ8kgU/Yk3CO+rppHklLgp0UMlfsbfR+CMwpg0XE3ikxzrrrUebLTmSEAJ6nFZGAR6ApW98eLKR0R3tKdLDGardjezfnsmi4INngOnICxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972248; c=relaxed/simple;
	bh=4sym237a3wzjHBQDzN72ZtH7iFNxSpm8gXdzQ0UrWmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9ZzR9uTZDuIZFiJde7o/jZXWdJRkXjk/nT8S/JesTzQYzpMvn3C6v6y1EZfgE+Ll7HZmNcgoZrdXhki2TKxcku4XLd0FZQJSbVB8e9fjp6DqwsWDECgHolNQJ7/pLPHcPDhICOFM4WJRVVMQWblt68JselEf8SXBLFAzFQJYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Up2Yt+/i; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777972242;
	bh=4sym237a3wzjHBQDzN72ZtH7iFNxSpm8gXdzQ0UrWmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Up2Yt+/iewqFT4CdTJtEHClfccc2bXaZkDpSUGByup4Vjop5SUh30Qw8cs4enAqE3
	 ezzRxbNnLJYJrCGV+ryDaz+xSLJTy627+iEeBG9M2YPm1ZbEn/3tJi93kE1vSEhuZG
	 GHsrlN1CEma0J6DFPiAPBGPBIuHEuzWSdyzkEtF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:17 +0200
Subject: [PATCH v5 13/14] kbuild: move handling of module stripping to
 Makefile.lib
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-13-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=3531;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4sym237a3wzjHBQDzN72ZtH7iFNxSpm8gXdzQ0UrWmw=;
 b=yK767BHsapJV15dUfHNe8idRaS/QEQT7THkpmPRTFTWVR8JNmIEaIi786mZC/3G3QxzBTTSEr
 ElIP5qYLNiJD4Y2+AainUiunn1D7qpG9VUvSrTlTN7McIL/cM3ZvgES
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 8FE654C9784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9438-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid]

To allow CONFIG_MODULE_HASHES in combination with INSTALL_MOD_STRIP,
this logc will also be used by Makefile.modfinal.

Move it to a shared location to enable reuse.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.lib     | 32 ++++++++++++++++++++++++++++++++
 scripts/Makefile.modinst | 37 +++++--------------------------------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0718e39cedda..bb713a1a11be 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -484,6 +484,38 @@ define sed-offsets
 	s:->::; p;}'
 endef
 
+#
+# Module Installation
+#
+quiet_cmd_install_mod = INSTALL $@
+      cmd_install_mod = cp $< $@
+
+# Module Strip
+# ---------------------------------------------------------------------------
+#
+# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
+# are installed. If INSTALL_MOD_STRIP is '1', then the default option
+# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
+# as the options to the strip command.
+ifeq ($(INSTALL_MOD_STRIP),1)
+mod-strip-option := --strip-debug
+else
+mod-strip-option := $(INSTALL_MOD_STRIP)
+endif
+
+# Strip
+ifdef INSTALL_MOD_STRIP
+
+quiet_cmd_strip_mod = STRIP   $@
+      cmd_strip_mod = $(STRIP) $(mod-strip-option) $@
+
+else
+
+quiet_cmd_strip_mod =
+      cmd_strip_mod = :
+
+endif
+
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 68708a039a62..b95f613e23c8 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -8,6 +8,7 @@ __modinst:
 
 include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 install-y :=
 
@@ -36,7 +37,7 @@ install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo)
 install-$(CONFIG_BUILTIN_MODULE_RANGES) += $(MODLIB)/modules.builtin.ranges
 
 $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.ranges): $(MODLIB)/%: % FORCE
-	$(call cmd,install)
+	$(call cmd,install_mod)
 
 endif
 
@@ -65,40 +66,12 @@ install-$(CONFIG_MODULES) += $(modules)
 __modinst: $(install-y)
 	@:
 
-#
-# Installation
-#
-quiet_cmd_install = INSTALL $@
-      cmd_install = cp $< $@
-
-# Strip
-#
-# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
-# are installed. If INSTALL_MOD_STRIP is '1', then the default option
-# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
-# as the options to the strip command.
-ifdef INSTALL_MOD_STRIP
-
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
+ifdef INSTALL_MOD_STRIP
 $(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
 endif
 endif
-
-ifeq ($(INSTALL_MOD_STRIP),1)
-strip-option := --strip-debug
-else
-strip-option := $(INSTALL_MOD_STRIP)
-endif
-
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) $(strip-option) $@
-
-else
-
-quiet_cmd_strip =
-      cmd_strip = :
-
 endif
 
 #
@@ -131,8 +104,8 @@ endif
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
 $(dst)/%.ko: %.ko FORCE
-	$(call cmd,install)
-	$(call cmd,strip)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
 	$(call cmd,sign)
 
 ifdef CONFIG_MODULES

-- 
2.54.0


