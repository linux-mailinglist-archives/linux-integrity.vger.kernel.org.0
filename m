Return-Path: <linux-integrity+bounces-9433-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDu/MKGz+Wly/QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9433-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:08:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C164C9372
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E94E3027428
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78773F9F4B;
	Tue,  5 May 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uSjcE3/7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00D3F54A2;
	Tue,  5 May 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971939; cv=none; b=aDxuH41b030EOOPwZw4f4iK5XtaYCjz4madKkpHjl7O3juB0XA84cr6zMDH99Si9Th9Jfop/V2XtEvINHVw4aWaQ23Z5SbSjcRl/kQ8c2YdrlnCRkbne9CogWs9mMfGsaD/QF9mKDdMs3QZQh4/Sg8NDRN3z4khnoV0nHBedX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971939; c=relaxed/simple;
	bh=chCyrFKTgdh3bqAx/mQ6lIysEIJoVqpFJGF/rlIkqi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2xA6FQm1R1FqGTHGBNqfbcxyBeX5yE48l6zjQcJlNZIh4ZQJkbokVGNVzLxzqRtLV3kHSUKOAGYAS3xlYaady06m5+0n1OS0kGiWGbtaQYbw9l014JTO7dO/5qv8diA1ogD2o/mxeczBOHX0A/laFND2s2gNyRI+TlMMC4LEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uSjcE3/7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=chCyrFKTgdh3bqAx/mQ6lIysEIJoVqpFJGF/rlIkqi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uSjcE3/7RPzqVxYeknvP09UES2PQcOS9VkYVVqueNpzecmFvo1an3XpkguzW1D0Bg
	 nFEHj3iswoLhusE/F96Ei5XojOmHw/x30HPACKMdW35EThCzDfqEd2VucH5aOjSyPt
	 ZadmbkICr/8be6TA7uVP9y8q16Xm891dDk9OoxpA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:14 +0200
Subject: [PATCH v5 10/14] module: Prepare for additional module
 authentication mechanisms
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=2563;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=chCyrFKTgdh3bqAx/mQ6lIysEIJoVqpFJGF/rlIkqi4=;
 b=AghgISpSvC9jFLJMASwIQ2fl2y7giwEV7IIPQJiNe92PMZ8lKZf0qC99jV/SdHmNA1NchS945
 I53O1yr0Ve6Cw+2TVu7rpkv9iMeNkP/+D4AMPAnvVv3dujuIZnIrT4f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: A1C164C9372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9433-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,weissschuh.net:email,weissschuh.net:dkim,weissschuh.net:mid]

Reorganize the code to make it easier to add the new hash-based module
authentication.

Also drop the now unnecessary stub for module_sig_check().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/auth.c     | 17 ++++++++++++++---
 kernel/module/internal.h |  8 --------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 21e49eb4967c..2ee512d26790 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -37,6 +37,14 @@ void set_module_sig_enforced(void)
 	sig_enforce = true;
 }
 
+static __always_inline bool mod_sig_type_valid(enum module_signature_type id_type)
+{
+	if (id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
+		return true;
+
+	return false;
+}
+
 static int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
@@ -48,8 +56,8 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
 
-	if (ms.id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
-		pr_err("module: not signed with expected PKCS#7 message\n");
+	if (!mod_sig_type_valid(ms.id_type)) {
+		pr_err("module: not signed with expected signature\n");
 		return -ENOPKG;
 	}
 
@@ -61,7 +69,10 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	return module_sig_check(mod, modlen, mod + modlen, sig_len);
+	if (ms.id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
+		return module_sig_check(mod, modlen, mod + modlen, sig_len);
+
+	return 0;
 }
 
 int module_auth_check(struct load_info *info, int flags)
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d923e31a5d8e..aabe7f8e1af4 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -335,15 +335,7 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
-#ifdef CONFIG_MODULE_SIG
 int module_sig_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len);
-#else /* !CONFIG_MODULE_SIG */
-static inline int module_sig_check(const void *mod, size_t mod_len,
-				   const void *sig, size_t sig_len)
-{
-	return 0;
-}
-#endif /* !CONFIG_MODULE_SIG */
 
 #ifdef CONFIG_MODULE_AUTH
 int module_auth_check(struct load_info *info, int flags);

-- 
2.54.0


