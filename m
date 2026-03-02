Return-Path: <linux-integrity+bounces-8700-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHaLAbCHpWkeDAYAu9opvQ
	(envelope-from <linux-integrity+bounces-8700-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:50:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FD1D9244
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F3630E23A4
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE313B3BE4;
	Mon,  2 Mar 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6ebrqxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7/HdWbUo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600533A1D01;
	Mon,  2 Mar 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455381; cv=none; b=oyvhhLVOb/sO5j3OPTXNh9bmkC+BhTBFm/r+rpoC3V5jmOFflIuPI6JLqs2FEda2yhEFSu9H9WMQVvbmJ2VRpBKrLZnynhMbI7SXQ60j2Iai/R64VVlc2M3YdNbekIL/paXn62QrUPB2adUmUD2h1GsMyYw+EiOQcvkFjbqAcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455381; c=relaxed/simple;
	bh=rPL2cqlC5kbseMgdT0Xm+ZJVRw6e8BXgriOnLqfKY6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwcWgRXdO3Bv6z0+0XYMJdpZdf/eTnnsOrymyeLwBAF6X5jVXoAgFxYvHqonCRoCoIiLLpvx0tIAUdgp40R4GVU10B5E2x6fU3SUuq/y7ELzPD9qdMrcgyyhl2s9ZVZsX25EqxxQfdbL/iNU8wSVu1EM70zvgXmslQayRb3NdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6ebrqxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7/HdWbUo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772455378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9pJ+vyM4KJKwO7mQQdL9FppHYZqklmr2LP1cMlXywY=;
	b=C6ebrqxXYpSKen82t8Yvy3w3BSQz0IDGpEQkmJEKTqLYZV/w7bvpNmLh5HtLqNoLj9yZTd
	nAjuM8MuuYC/4H8iWTYciFkq3jY6gWbS0mSrIdHGhnemiWJqJWw1erTlvJgGeGb0JW8w3O
	tpObJIDqhYgi2KzdSLxceUpwtpX1wu2ZZIgUT/94HrjXynt1w5G5POwCqFM9VVuFmQcRas
	StOe8k5uMW5345nV1y2pCGSeXSyZ/YUadlvlzkyqGRkwARSfoMO9DILFRsZLWZl5JTPlvz
	WPuBAasEJlSy1aCzyhjYnH6aleX1wVvI7ViGwc1qWygVDhoRd2Yt/qb2cds7mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772455378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9pJ+vyM4KJKwO7mQQdL9FppHYZqklmr2LP1cMlXywY=;
	b=7/HdWbUoTvl9gt/jY0n1X7e6YcgHBls7uoRKqAgxQWTCur9uvRAIJ8axnC9FaXKklYPuVV
	LQB03y4cJbsJF1Cg==
Date: Mon, 02 Mar 2026 13:42:42 +0100
Subject: [PATCH 6/8] tools uapi headers: add linux/module_signature.h
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-module-signature-uapi-v1-6-207d955e0d69@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772455374; l=1806;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rPL2cqlC5kbseMgdT0Xm+ZJVRw6e8BXgriOnLqfKY6A=;
 b=E4pAyDe4KeKmE6wPTrYvOL6Q96Kbxt34jW0gc9c+kEnxH971RpaJHU8oPzJvpJ83ytmfHNVpn
 Szp7aGGgmU0C1zmuz9FQeZiragOlalTcxRhnggV6X+4WOAlXar/1M5J
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8700-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A19FD1D9244
X-Rspamd-Action: no action

This header is going to be used from scripts/sign-file.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/uapi/linux/module_signature.h | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/include/uapi/linux/module_signature.h b/tools/include/uapi/linux/module_signature.h
new file mode 100644
index 000000000000..6f4f7539fe8d
--- /dev/null
+++ b/tools/include/uapi/linux/module_signature.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Module signature handling.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _UAPI_LINUX_MODULE_SIGNATURE_H
+#define _UAPI_LINUX_MODULE_SIGNATURE_H
+
+#include <linux/types.h>
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIGNATURE_MARKER "~Module signature appended~\n"
+
+enum module_signature_type {
+	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
+	MODULE_SIGNATURE_TYPE_MERKLE = 3,	/* Merkle proof for modules */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	__u8	algo;		/* Public-key crypto algorithm [0] */
+	__u8	hash;		/* Digest algorithm [0] */
+	__u8	id_type;	/* Key identifier type [enum module_signature_type] */
+	__u8	signer_len;	/* Length of signer's name [0] */
+	__u8	key_id_len;	/* Length of key identifier [0] */
+	__u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+#endif /* _UAPI_LINUX_MODULE_SIGNATURE_H */

-- 
2.53.0


