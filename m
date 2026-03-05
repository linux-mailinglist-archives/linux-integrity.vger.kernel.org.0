Return-Path: <linux-integrity+bounces-8917-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKDHNJ1OqWmz4QAAu9opvQ
	(envelope-from <linux-integrity+bounces-8917-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:36:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1D20E980
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4161330D731F
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3166A37B018;
	Thu,  5 Mar 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rkwg3vMe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUuDjNzL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D93793DF;
	Thu,  5 Mar 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703104; cv=none; b=i+fFyiqaB0SFOs7jqAlbwGjolRuVTSQTstjSaIf+SCWSdMnr7BU/i1lzVVyKdUuVJpW3bQXR8pTBa2zfMv4Q25Ywek92JP3vOs9irIEUnVkUUlRdoX3EZXUImHpVdL590GDb/USQRaFf2I0W3Y6ssEeTPSr7h00PHu/+02gZsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703104; c=relaxed/simple;
	bh=0hFooFnHCbtyEcdlys+/j5z4JpvnkphkvXvFV2sQM+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQkVsYQU1jEIcqgSlzOI4osApzzGkI/G4yACrgdvSBwjBqCoCxsjL45OESec3KhwKKjv9opRB8ebEBxKnkxGT7d4UEHX9m033nu/NrC37tFLVbKZfw55H6vOw7BftWTmjqFDjOdx/T59+dJlojxSte9cVuK2+U8iNoup0aUD6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rkwg3vMe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUuDjNzL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772703100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6XHgze9+I6IR83T3SKiAcKjzRKh0KdaqB85aJ6dP2A=;
	b=Rkwg3vMe0MdC4gCfoVcSaZ5mWzBA6e5fHnxcekhw4iwMzUVWl32e1PC3XzgSUpaiHOvoWw
	0TFmeUT+/RGqCkgI7WzgAAyGldAbqHL9XYTAijBPVJ8Fe4adQZhQsS+qke4plk6azPNwJj
	Il2WGcv01OImKm3SXeLVWNoMDkfZwiSmZdog+Du0HvOGVBWz1nXZtYJXl1PqwXg/Del1UD
	2sGpYcIPawo327OK4rzdagdByOvfss4Me/3Yjr2kcltD3DLz3/b+Vr6FNfQ25gQC16W/87
	XFdWFXQCURmcPRYpGc4QaxoqN6/2M9Wzeua1L1Dhqyowu24mC0RtusQd0m5nGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772703100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6XHgze9+I6IR83T3SKiAcKjzRKh0KdaqB85aJ6dP2A=;
	b=jUuDjNzLt7wNfbxIsR62LomJW5Z2p3D2kmdhPpjaGB8leG+dwpENJ+OFaRAiSQ5S/kitRM
	eo1f5EsCa/2UFHCA==
Date: Thu, 05 Mar 2026 10:31:39 +0100
Subject: [PATCH v3 3/8] module: Give 'enum pkey_id_type' a more specific
 name
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v3-3-92f45ea6028c@linutronix.de>
References: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
In-Reply-To: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772703098; l=2573;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0hFooFnHCbtyEcdlys+/j5z4JpvnkphkvXvFV2sQM+I=;
 b=I179R6lUtQ1nbxaFgmpBytrX1gCYbvpwbGNMLJwpi0SzxXE7PVvvoQ/NMY4YlPzjP2MXAwzul
 r65clbK6k+nDlFG3dc0xtQWLIuNCYXbeK4ieCKY6hA8uJG2PHaxt3Kp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 76E1D20E980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8917-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

This enum originates in generic cryptographic code and has a very
generic name. Nowadays it is only used for module signatures.

As this enum is going to be exposed in a UAPI header, give it a more
specific name for clarity and consistency.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/machine_kexec_file.c | 2 +-
 include/linux/module_signature.h      | 6 +++---
 kernel/module_signature.c             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 1bf59c3f0e2b..667ee9279e23 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -53,7 +53,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EKEYREJECTED;
 	kernel_len -= sig_len;
 
-	if (ms->id_type != PKEY_ID_PKCS7)
+	if (ms->id_type != MODULE_SIGNATURE_TYPE_PKCS7)
 		return -EKEYREJECTED;
 
 	if (ms->algo != 0 ||
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 820cc1473383..c3a05d4cfe67 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -14,8 +14,8 @@
 /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
 #define MODULE_SIG_STRING "~Module signature appended~\n"
 
-enum pkey_id_type {
-	PKEY_ID_PKCS7 = 2,	/* Signature in PKCS#7 message */
+enum module_signature_type {
+	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
 };
 
 /*
@@ -31,7 +31,7 @@ enum pkey_id_type {
 struct module_signature {
 	u8	algo;		/* Public-key crypto algorithm [0] */
 	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	u8	id_type;	/* Key identifier type [enum module_signature_type] */
 	u8	signer_len;	/* Length of signer's name [0] */
 	u8	key_id_len;	/* Length of key identifier [0] */
 	u8	__pad[3];
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index 00132d12487c..a0eee2fe4368 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -24,7 +24,7 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
 		return -EBADMSG;
 
-	if (ms->id_type != PKEY_ID_PKCS7) {
+	if (ms->id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
 		pr_err("%s: not signed with expected PKCS#7 message\n",
 		       name);
 		return -ENOPKG;

-- 
2.53.0


