Return-Path: <linux-integrity+bounces-8910-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIwCANQtqWlN2wAAu9opvQ
	(envelope-from <linux-integrity+bounces-8910-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:16:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 556BE20C6C3
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00B930CEC32
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07933031F;
	Thu,  5 Mar 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V5ivcWTU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxmerasS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF408327BEC;
	Thu,  5 Mar 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694720; cv=none; b=r0l5HWCtMDPYMeYKRUrmt/ZTUrbwzYQaQLsqqYm7HrUlbb1RydHT5k5v/w/j/Vv5QCTbNo1yYtPELbmLLptOzZUYH8b+QL33HoAKgrgNKBf4VS42bdXXpPS5I4SfjaoIvenX0kzefxN6PsdtCD49oMk8gY620AtDHb3T/34GVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694720; c=relaxed/simple;
	bh=tKTmRc6HrP6/OQRgSe9OxodcJLXzMpfhw17bqU4f6CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Abx7aYVxeTLHTZWd3p/QFwTAbDZlD9tHIb/+WAQ4U5x8tzgnpDfqWZBNXlJ4peVDDiGheAFnqmdbcH4Yh87XhZKQchsIbLZXzFKeZSdfjX0a2Cp2QxscfKBhLSADv4s4hI7F67Ev7wjTObBRziph0yDWRmBdVvYnY3gmdUmuliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V5ivcWTU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxmerasS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772694717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMGtWqBpnjIDTR6LwAmpIJP3Qy4dhjS1J0sd7mm9aeM=;
	b=V5ivcWTUxZdr2tgqC3CMI87kBCtdxsY8OKA0tDClfzs2Ft2/mvShq3r7Fma9F92SJyVyOm
	diP+7SO/GNs9PiytONJPowX2vVlNVgYzbzXRoWTeZnjGKT/aoIlesKjDebv9yJIY8r+ux+
	7ox0Xq0ivYWMu7nNaI52bEsWOHDTw3DmaCdsFE0WquvJVZJ7w7f12YYjX0ptBWHBvcPZdW
	VpNTH91ZHd1Ym2ouhXpL9Zh+M94JYGo/yo25nbLZVp8p36uXLmPQ7qX3Kzes/n/7bSFOS3
	ZXGT2Nl1B+7ZB7JpAI+nee+BBZa9KtH1CuMD0FWJ8LGZFHduaLlGlkOGHT2TTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772694717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMGtWqBpnjIDTR6LwAmpIJP3Qy4dhjS1J0sd7mm9aeM=;
	b=UxmerasSiLW+g2DQe/h+4Mm83vdTkk1OJO82afLBAcpNFKtwGsYJPvAS+qKNUWIQ9UUyOO
	e8Iadm4tLjJDC0Dg==
Date: Thu, 05 Mar 2026 08:11:56 +0100
Subject: [PATCH v2 6/8] tools uapi headers: add linux/module_signature.h
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v2-6-dc4d81129dee@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772694712; l=1785;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tKTmRc6HrP6/OQRgSe9OxodcJLXzMpfhw17bqU4f6CI=;
 b=+3vx3bSpCHoEVgsOHlcluBxd4hRQB0nBZk3B61kDfpgy+y3FGxTrsKS2h/B47UxL3vDTYRL8k
 RH6ppRFUMHVDVIURHuF+F2Ho8USBx8BQCEKJhmaQlYdKzysXCvrLMq7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 556BE20C6C3
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
	TAGGED_FROM(0.00)[bounces-8910-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,suse.com:email]
X-Rspamd-Action: no action

This header is going to be used from scripts/sign-file.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 tools/include/uapi/linux/module_signature.h | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/uapi/linux/module_signature.h b/tools/include/uapi/linux/module_signature.h
new file mode 100644
index 000000000000..634c9f1c8fc2
--- /dev/null
+++ b/tools/include/uapi/linux/module_signature.h
@@ -0,0 +1,41 @@
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


