Return-Path: <linux-integrity+bounces-8913-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AXOOP4sqWlN2wAAu9opvQ
	(envelope-from <linux-integrity+bounces-8913-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:13:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91E20C47E
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8BA2302A9F1
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407B33557B;
	Thu,  5 Mar 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DS1AH48t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4+Kz4fq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B932B989;
	Thu,  5 Mar 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694721; cv=none; b=OCzMp4ij6wXFt51gd+3HDr0AkvpcAB6PN30xYhS4bo+KzAFiqPbgDVJXFSdU86kdxZ/OVZC7XldS0SPwl73jHZhiCHSDcH3nwst3ycKXY6FcCJ4eAhR6aRrAXGQ83Dvc+W3I7kkX1JZnMMBRk0H1T/iO+9CMw/fdoTBCJX5WI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694721; c=relaxed/simple;
	bh=MilPBKT5qdBGv3KAqViaqGXVrPTSiq77sK756EO+4xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RE6ynkjk30u2qFijYKbXzy+yiGPXpCiypoEulBeYp9EYr5BLz7oVH5vtveByQyuzi0Ca/K6cdcBjITYlcvMmgd+3pfOjzj/2is/hbx9UfncYQme+mz7n0pSIjWXI1Eyr76/xFfTkdd/9Y4RLoLfoD/pd31yQrUMzBzsLY98AGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DS1AH48t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4+Kz4fq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772694718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RqUxSzmka9uuI1Wx1AJs8zJfLvQqhjOS+vbWhu9tD0=;
	b=DS1AH48tfugFJcWdxt+ntxub/fGyGX9FkpjLo0CJZeh/DwiZiPwPzFkUQjX9eixu4qa4Z1
	4+n/HmA6OQAT5bE72jpECNB6CvImHVYjhnrrPsSe5wKW4j0GZ5zw/sTjRBUbznTHu7X7O7
	4KB7lZChdL7BYF5Ac4nX3n97YxL44/rh7bJAh8rdyVVub+M8pcpuyFITzQECESW0XyMI+z
	LH9XDOcEFSmM0bnvL7hJ3O0RzD12zwrheNTCTsEBprVqHNrZpK8cyKKNJoGih5ciMWGL0f
	jpoJOGJAlQDUYWwdB4dyCBB4TDAbMophYuff2+Zhw1ExctzO+x5Zh8MRbVY3+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772694718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RqUxSzmka9uuI1Wx1AJs8zJfLvQqhjOS+vbWhu9tD0=;
	b=j4+Kz4fq6lQ/WAEovs2DrNNpIYCrkmQ1vXjADMdGWbWe//WpJ9tet50SZDwe5Ow0y308oI
	WKclOAnQM4JltQBQ==
Date: Thu, 05 Mar 2026 08:11:58 +0100
Subject: [PATCH v2 8/8] selftests/bpf: verify_pkcs7_sig: Use 'struct
 module_signature' from the UAPI headers
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v2-8-dc4d81129dee@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772694712; l=2348;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MilPBKT5qdBGv3KAqViaqGXVrPTSiq77sK756EO+4xk=;
 b=Y630crB86kIbqRltJn2BQgjYutCB5syuG9sQtPZvqCzlVINSBbItuoyZZJcFPjmhBOAlWwlAN
 rrzsRYozFmcBYiHIDYSmoW64Qvi3e5/0RWDujK3QgSIGuXAXEeF8c8d
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 6A91E20C47E
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
	TAGGED_FROM(0.00)[bounces-8913-lists,linux-integrity=lfdr.de];
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


