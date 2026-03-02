Return-Path: <linux-integrity+bounces-8701-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLZ/AQyIpWmWDQYAu9opvQ
	(envelope-from <linux-integrity+bounces-8701-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:52:28 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD01D92F3
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA183053A7C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857853ACF03;
	Mon,  2 Mar 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pwwlmVv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+OQjfkC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014C3AEF53;
	Mon,  2 Mar 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455383; cv=none; b=VUHnmaQh3Tu4Awia94kdBHL5htL/P4vpqf0+NwtRzMWhuKDl5dkbUBLIznBck1VX7n5Ao+9XmH7Bpt8CRdm0iVycfAXjXCgTrlDubKTGzNPKv9I9Xh/xn7lkL2plKCWi1buHiPXgBnFWGxAxNgz/awlAcAIzwNkpmVtu1Y/N87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455383; c=relaxed/simple;
	bh=ItrkaxTtOGN835/CvSgTznvD7+k8FwNKGNYkkXbX4/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkotBndK4V8lH/TLpMaBKsjYvJ/+KWNNNgUP+x/8wyawVXdh3amxd8X36clR4CCTXpjRm0dlqAuHQValgl8TN1v91DQqYj0drLzG3PasS2MQP5YX01JW+1zebRCayc/g/1soHnNj9rsMPh8uwWMFUifA3XrQMo+MPwjUGWHqKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pwwlmVv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+OQjfkC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772455379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEJzQOd+GVy7XQbRHuQT8TK8iig3Hy/UQSzsFJ1bbLU=;
	b=1pwwlmVvgmnn/8y5rs+MMNuVtblHbF7gpoF/MxUdPN7Dii8xFaVXgEAM5U5fisE0yP05q2
	A3r1kpNdw9QHUFFYypzUDrmPDOqCYNWIiFsjnLUry2OaYQYInUcM0JNuVp+HJJ+Aw/8Zpj
	nJbw9UXhtBf6CMWRERM5a/0lSAz3kG3hTxuGMZdZaiWmxCk7RKbWkrHZJ+rI/sAHS4M8b5
	CeflgryZQYQUBnjzYpnuYTu2xNj+BVSVHF+7HT8Bgj7Hqf8gMZ+VERxFvDXcdZLhv8ZK5m
	zdX02jyRooRafVrOdme8+9coZW9Qp1wZQ7dKtzx/EUXAwwcBL5M/IyU5z93xdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772455379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEJzQOd+GVy7XQbRHuQT8TK8iig3Hy/UQSzsFJ1bbLU=;
	b=v+OQjfkCUa7covzlpfwodNat04cWqFUfn3C92JCGcv1DDv8je6v3VbNVFxtM4Iyc2v16nN
	JZxyyOxlcEKs9bAQ==
Date: Mon, 02 Mar 2026 13:42:43 +0100
Subject: [PATCH 7/8] sign-file: use 'struct module_signature' from the UAPI
 headers
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-module-signature-uapi-v1-7-207d955e0d69@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772455374; l=2557;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ItrkaxTtOGN835/CvSgTznvD7+k8FwNKGNYkkXbX4/Y=;
 b=gCptxACP9XhqG+fL0MNxwtjK8/aCAC2/pSFqGalQ49vlqdNVNZyEfZaI7iI5eu8wy2oj9NUSQ
 +uVsn0RIo9AAN3l7411vFn5U5IZBXY5F4AjUw8TRxmenwO+rF0RyeLb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8701-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 71DD01D92F3
X-Rspamd-Action: no action

Now that the UAPI headers provide the required definitions, use those.
Some symbols have been renamed, adapt to those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/Makefile    |  1 +
 scripts/sign-file.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 0941e5ce7b57..3434a82a119f 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -35,6 +35,7 @@ HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTCFLAGS_sign-file.o += -I$(srctree)/tools/include/uapi/
 HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 ifdef CONFIG_UNWINDER_ORC
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 73fbefd2e540..86b010ac1514 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -40,19 +40,7 @@
 #endif
 #include "ssl-common.h"
 
-struct module_signature {
-	uint8_t		algo;		/* Public-key crypto algorithm [0] */
-	uint8_t		hash;		/* Digest algorithm [0] */
-	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	uint8_t		signer_len;	/* Length of signer's name [0] */
-	uint8_t		key_id_len;	/* Length of key identifier [0] */
-	uint8_t		__pad[3];
-	uint32_t	sig_len;	/* Length of signature data */
-};
-
-#define PKEY_ID_PKCS7 2
-
-static char magic_number[] = "~Module signature appended~\n";
+#include <linux/module_signature.h>
 
 static __attribute__((noreturn))
 void format(void)
@@ -197,7 +185,7 @@ static X509 *read_x509(const char *x509_name)
 
 int main(int argc, char **argv)
 {
-	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
+	struct module_signature sig_info = { .id_type = MODULE_SIGNATURE_TYPE_PKCS7 };
 	char *hash_algo = NULL;
 	char *private_key_name = NULL, *raw_sig_name = NULL;
 	char *x509_name, *module_name, *dest_name;
@@ -357,7 +345,8 @@ int main(int argc, char **argv)
 	sig_size = BIO_number_written(bd) - module_size;
 	sig_info.sig_len = htonl(sig_size);
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
-	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
+	ERR(BIO_write(bd, MODULE_SIGNATURE_MARKER, sizeof(MODULE_SIGNATURE_MARKER) - 1) < 0,
+	    "%s", dest_name);
 
 	ERR(BIO_free(bd) != 1, "%s", dest_name);
 

-- 
2.53.0


