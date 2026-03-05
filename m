Return-Path: <linux-integrity+bounces-8912-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGs8HfksqWlN2wAAu9opvQ
	(envelope-from <linux-integrity+bounces-8912-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:12:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B020C46F
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3910C304AAC9
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84CF3346A5;
	Thu,  5 Mar 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHchs6MW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtvQylcp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DD31E825;
	Thu,  5 Mar 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694721; cv=none; b=d3jQ+I66hPlTFsL9DMNPJlHRSnLSLiM8/WLfjoMRro4K3J7LYgn5RQ4fSZWYc+tSZf7GIRCZKbmMJ2pIcec9adG9n8xIh+N5XlXUQ9btzVZnrgiNrhxnLwjL1vgj8U+tMyE6qjh8oAymQeMuZ6I+CE85inmZBFN5/nm5RjK583I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694721; c=relaxed/simple;
	bh=M41jEYdsfnsqEnfdtlrISVzlWoWoJRh8+lq5aeoW4ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8BZPjPk6mPzoi+Hy+C/iuSQ1a6W5WosFWgJsMziIO2H7c2Nt3kGeEWyg8kpQWH8s1BmHuhq7UTu4AjDatbXCuxYWCCbNAyzfjxchzx16i+3NXNuiLIpZoaRmTj/KPltalbZ0d7pgtU/9eOiQpKiwcGRJmhmWWtlMI+BYE/mock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHchs6MW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtvQylcp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772694717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+tFGStkyju+xTwo19bkVzFuNowP5SRhznp5jZXaJQo=;
	b=mHchs6MWinCQWCCo59O5LMKKaOtHYCFJng1Tftq0tkUamM1iEBvUOHOMnDN0d0yCh4Qyk7
	Ko+prvcF69DRXdPvARfyvBgRJHKpuZPXcniJbc3eN+j1r1WxGty4VE6dyZS7jHvHOVq0QO
	lVC5NNRdnSsLaAWT0UhR/NoV3tn4jBM9d1OrD4vpWk/W3eVlfQxEOH7xEqqi897RH9jLAG
	2M8FSNvYama1em04j/ViY/ulpRGg9H3rUH9yDVlnn9uu2F0C4TsMaZEQKoOZYDSRy/Dg79
	vME9eYoGUbnHMUqpL0u3+hEZZdUAfHPZcyLGYo4ahcDHRNjbgvrHGP65Xkrhaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772694717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+tFGStkyju+xTwo19bkVzFuNowP5SRhznp5jZXaJQo=;
	b=FtvQylcpCTPAC6mqvRddJyq//EGoMxXEfp/6aFR56q1Hsp7NmT8WBeWEj9nBoqtDOOUoPR
	4vI2OFPfU13coYCg==
Date: Thu, 05 Mar 2026 08:11:57 +0100
Subject: [PATCH v2 7/8] sign-file: use 'struct module_signature' from the
 UAPI headers
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v2-7-dc4d81129dee@linutronix.de>
References: <20260305-module-signature-uapi-v2-0-dc4d81129dee@linutronix.de>
In-Reply-To: <20260305-module-signature-uapi-v2-0-dc4d81129dee@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772694712; l=2604;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M41jEYdsfnsqEnfdtlrISVzlWoWoJRh8+lq5aeoW4ys=;
 b=onfaK7ADGnAWh9Qc4IH87fGmAxSnXANZE2WnC5cDFLAigmMHJmFTrWdKCLvdjGL0/3icU1FTo
 LUpYJBNrWwpCge3FAIq4T+mq0mLJyxHHildswy9xFOy2zj9plv2YjCx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 567B020C46F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8912-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,suse.com:email]
X-Rspamd-Action: no action

Now that the UAPI headers provide the required definitions, use those.
Some symbols have been renamed, adapt to those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
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


