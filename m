Return-Path: <linux-integrity+bounces-8702-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPhnCjyIpWmWDQYAu9opvQ
	(envelope-from <linux-integrity+bounces-8702-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:53:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8B1D9338
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FDC30FC90F
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3C3B8D75;
	Mon,  2 Mar 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IoqCtrXo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONAn918A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CD3876AC;
	Mon,  2 Mar 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455384; cv=none; b=AKI5w9fmajRatu8tSl1fpiB1148mdy52R8aebVi46Zteli7HLc4QJZQY/eP2Au2rpqva7vSIjQuhtGxPQkoyTsOUM2jKn097gKAbLregHTja8ClRva/IALJuBIBLAgX57Vuna/B8ied+p94hwDfJgPGn7rs71/0LCjo62lIE5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455384; c=relaxed/simple;
	bh=cSyXaR9CC/kzl95o4jDS3lCVCTRqIF6V40mtMwdZY4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=em8Hr5ONQL7Fu9vYU52mWlmAWT8W7XEOpGTInIzq06/Lb2+bwc5/YN3ZfGEbdfkGVtWYIUGK8eKSQ94Im2zdWYYabp4GGnFWBQ/oHB2ceMcIjPYNVeRu+sk27kj1wuHaltC5e2khNcHBK4UcHYfAix/nmeszIniS2KL7U+xMwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IoqCtrXo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONAn918A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772455380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zIQjC5c3Xpy63Pp68hHQZNu1F60+I8OSONI8GYykYA=;
	b=IoqCtrXoaJwzS6N6YTMfyUCj8OoW/1gp3fYpZspd73A5UUdimUnCT3INryfBOp/Uidvt2O
	fFZBSh625EH/xOiIUs7bliPhEW7eIe4oVRbndQ7JS0HExPt2BnyyJr3BBFi0HANX3JY+U6
	qFbpYUo/e8e9VwdmLq9ekhd6KfZylVBHlHOHTiuCuUrnCaZLG019mVSHnZ/Lyf+cWBhcsS
	T2eHYhWbptKMW1dTMPI03AVU7pIPWBhnVBFcsKpQ5KcueStobqAfhhAciAS3S0oxluNuGs
	3LTkoF7DadXFNeuYl1q9LHB9gjovU0Vq093pmu6Rfx1KcM0E3m55fqPDcKGEIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772455380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zIQjC5c3Xpy63Pp68hHQZNu1F60+I8OSONI8GYykYA=;
	b=ONAn918AO3qUbTFSO+cpvPOefdI2PFu7IqaG5s12rfqY+JxpiTHetkmBVDwhXDQ+tZasVd
	KGa3KguKgsiBfwDw==
Date: Mon, 02 Mar 2026 13:42:44 +0100
Subject: [PATCH 8/8] selftests/bpf: verify_pkcs7_sig: Use 'struct
 module_signature' from the UAPI headers
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-module-signature-uapi-v1-8-207d955e0d69@linutronix.de>
References: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
In-Reply-To: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772455374; l=2301;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cSyXaR9CC/kzl95o4jDS3lCVCTRqIF6V40mtMwdZY4s=;
 b=mt33KH6e4U4abWVfxbWix+ZkiYK/4AzVrqC4RxG9vRwCPeDfWtoMAsO7WQhrIzjBQx3/Orhg9
 AizCR+OrzOJDG/jUpSJSipbzlY/d2Yw2F4CzWtoPNcOrPYGTWaVIQux
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
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
	TAGGED_FROM(0.00)[bounces-8702-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FE8B1D9338
X-Rspamd-Action: no action

Now that the UAPI headers provide the required definitions, use those.
Some symbols have been renamed, adapt to those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    | 28 +++-------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index 4d69d9d55e17..f327feb8e38c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -18,6 +18,7 @@
 #include <linux/keyctl.h>
 #include <sys/xattr.h>
 #include <linux/fsverity.h>
+#include <linux/module_signature.h>
 #include <test_progs.h>
 
 #include "test_verify_pkcs7_sig.skel.h"
@@ -33,29 +34,6 @@
 #define SHA256_DIGEST_SIZE      32
 #endif
 
-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIG_STRING "~Module signature appended~\n"
-
-/*
- * Module signature information block.
- *
- * The constituents of the signature section are, in order:
- *
- *	- Signer's name
- *	- Key identifier
- *	- Signature data
- *	- Information block
- */
-struct module_signature {
-	__u8	algo;		/* Public-key crypto algorithm [0] */
-	__u8	hash;		/* Digest algorithm [0] */
-	__u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	__u8	signer_len;	/* Length of signer's name [0] */
-	__u8	key_id_len;	/* Length of key identifier [0] */
-	__u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
-
 struct data {
 	__u8 data[MAX_DATA_SIZE];
 	__u32 data_len;
@@ -215,7 +193,7 @@ static int populate_data_item_mod(struct data *data_item)
 		return 0;
 
 	modlen = st.st_size;
-	marker_len = sizeof(MODULE_SIG_STRING) - 1;
+	marker_len = sizeof(MODULE_SIGNATURE_MARKER) - 1;
 
 	fd = open(mod_path, O_RDONLY);
 	if (fd == -1)
@@ -228,7 +206,7 @@ static int populate_data_item_mod(struct data *data_item)
 	if (mod == MAP_FAILED)
 		return -errno;
 
-	if (strncmp(mod + modlen - marker_len, MODULE_SIG_STRING, marker_len)) {
+	if (strncmp(mod + modlen - marker_len, MODULE_SIGNATURE_MARKER, marker_len)) {
 		ret = -EINVAL;
 		goto out;
 	}

-- 
2.53.0


