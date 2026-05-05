Return-Path: <linux-integrity+bounces-9430-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qESKEJCz+Wld/AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9430-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:08:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1E4C933E
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94E133025E5F
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB713F789E;
	Tue,  5 May 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="owjODUEx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22B3C4547;
	Tue,  5 May 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971938; cv=none; b=mhZIemmH3ghI2cWk1Wj7a7T4Jo7H9uA6mCfyc8q3tgRnttUVFe1CNqlrMtMN2XCJ+HyjuUQqSB9aBYtru7RLBrbE3H/ePgUD3jteKHheEtEFfLisHABYq3gV7FiH3f1etlw4Nt/D2yCooTOBmZ0j6MeyIu9pY2ZdhnDnDy17Zws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971938; c=relaxed/simple;
	bh=6VJvYnOHZshtQlmEnWd/K1udWrIwe9dejx/5mZI/Wtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgnB2FLyEm1Bwoz3xRBeJ7ENapNcN4xuWixioZtfds2zkqMr/BL3YlKM7nKE+VWk8f8B/aFMpp/eKaPc+cxk35XkOxwd4JizWnZBtXMGiqUqMkQuonzwhg6BYBOpiD/hbjqcqSUE3WkNRdHQOhHZ5pCn79v8x1aVq6dfi/ISzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=owjODUEx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=6VJvYnOHZshtQlmEnWd/K1udWrIwe9dejx/5mZI/Wtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=owjODUExCCypec6TKWlnIwzT8DVnXMsfb+ZaEjU0MoKmKL+u/Hgk0XMLanRHlOS5p
	 MNeyeJ7VYX8n6e4baZNE/ejhPU8IePBOA5zatZB7qfpcaHAbaVKcUT7fN5vxhMYVdb
	 T5d4nFyczBMUPklVRaKpvkmaSNX/c9tzIRq1bRpM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:13 +0200
Subject: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=2558;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6VJvYnOHZshtQlmEnWd/K1udWrIwe9dejx/5mZI/Wtg=;
 b=CMdNpxTCGkVu3CYbUQ//Xh1Da5BfQXG6erPbBdP2NTFne3QRqh52DC/9CSjILoKbNrS8gBQHS
 8rcJfdzG3nTABuTlKzuzZV5cQk7a/PkWY+ZZAqFMl0YgtXmFbCISOTR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 20E1E4C933E
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
	TAGGED_FROM(0.00)[bounces-9430-lists,linux-integrity=lfdr.de];
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

Additional signature types are about to be added.
As each caller of mod_check_sig() can have different support for these,
move the type validation into the callers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/auth.c                | 5 +++++
 kernel/module_signature.c           | 8 +-------
 security/integrity/ima/ima_modsig.c | 5 +++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 831a13eb0c9b..21e49eb4967c 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -48,6 +48,11 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
 
+	if (ms.id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
+		pr_err("module: not signed with expected PKCS#7 message\n");
+		return -ENOPKG;
+	}
+
 	ret = mod_check_sig(&ms, modlen, "module");
 	if (ret)
 		return ret;
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index a0eee2fe4368..4d0476bcdb72 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -24,12 +24,6 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
 		return -EBADMSG;
 
-	if (ms->id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
-		pr_err("%s: not signed with expected PKCS#7 message\n",
-		       name);
-		return -ENOPKG;
-	}
-
 	if (ms->algo != 0 ||
 	    ms->hash != 0 ||
 	    ms->signer_len != 0 ||
@@ -37,7 +31,7 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	    ms->__pad[0] != 0 ||
 	    ms->__pad[1] != 0 ||
 	    ms->__pad[2] != 0) {
-		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		pr_err("%s: signature info has unexpected non-zero params\n",
 		       name);
 		return -EBADMSG;
 	}
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746fd81e..ebfcdd368a2a 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -57,6 +57,11 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	buf_len -= marker_len;
 	sig = (const struct module_signature *)(p - sizeof(*sig));
 
+	if (sig->id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
+		pr_err("%s: not signed with expected PKCS#7 message\n", func_tokens[func]);
+		return -ENOPKG;
+	}
+
 	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
 	if (rc)
 		return rc;

-- 
2.54.0


