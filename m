Return-Path: <linux-integrity+bounces-8920-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP8EJztPqWk14AAAu9opvQ
	(envelope-from <linux-integrity+bounces-8920-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:39:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E9520EABA
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BF130E6C80
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8D3793B1;
	Thu,  5 Mar 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1wtCuT4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oIH8L7Ca"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8337AA76;
	Thu,  5 Mar 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703107; cv=none; b=EXld9y+14/V/i62McgSRrCShFf3KjDFBgePlUh+RpGD+D0iqp9cz5s8/8Ce6d2Rq+ODjODf5H0uMDCHoFkaQN24CfHAC+5qLOzrtrVa8SdH7kM6wqbZHeRp7ka4ESCx8g+cWyMkMTp+fv7qqLUdSimkpDI4zAU32WhHMmSs4HQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703107; c=relaxed/simple;
	bh=82oL3WtgAN64LHuHNcsjPBuF0YKIbNmJsitQ2BVqkYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+PWn0BNH1MuaR423Ic2tGhczasLoWWBXeterYnsYLVkh3i0JPwLyUHK5Dqq2rB4YpaSL/c6QwNh7dw53qE4jCSIlNwgzbbjN5+4npWQkXlANMEVVZFXn4kJGWA90AjpNX5DPam3bmh/DeOWxRaDLRfHveajXnj8T9x3qGvIn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1wtCuT4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oIH8L7Ca; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772703101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9omS7dgQ8BXV+q++KcFWhKgcxzIXmvC9J+vXgoKmAc=;
	b=a1wtCuT4kbdfqFBMSFsUN/+Jv5gS3A2ijamCz78QGDuVJjgfBMTOyfhSF2b6QXP7pfEKDg
	DHXnQU+6pyFD5fDlttMREOvNCk3vjh2K9nY0gvjY7O90DFjTCB/SbgOZz0AkXPLZmzAQmu
	HOZ/OIJkIEGjBddrtpM2cS2diZcpOMKhC1RDLGdrKuJNsiVMWPt5oVVy25kA/4kV/cvzwR
	ppkqPQD9IGWYFzHP4pIn5rukSpn5n/eIfcOzUwkFW4ok7PuEEb8RGwz2k73wVz7H+U1Ucu
	s4aRvqF7FYuqgxRnSfLGGGciWSTIR4ZoVnAiBGoaETIuZwGSQoVe9l6NVKGamw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772703101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9omS7dgQ8BXV+q++KcFWhKgcxzIXmvC9J+vXgoKmAc=;
	b=oIH8L7Ca04BHMvndYJhlfynKj/xQQIXNBQI1L9G8ANj4P5hJK9BKK6DPvvhg9jaW2N1+8p
	v87O6WFnnBevDACg==
Date: Thu, 05 Mar 2026 10:31:41 +0100
Subject: [PATCH v3 5/8] module: Move 'struct module_signature' to UAPI
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v3-5-92f45ea6028c@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772703098; l=3350;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=82oL3WtgAN64LHuHNcsjPBuF0YKIbNmJsitQ2BVqkYo=;
 b=b7OnbRvjkCM/Ukho8W12uwactly22IwUxgp+MCGw8str44A0U30SwJC1GT+wl2r5nicWUr7Nm
 KMoqSDIWDg0C38kZW5Q61vEJQwBqNNdxuZQcONaPYuuBQXANJZTkQoQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 04E9520EABA
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
	TAGGED_FROM(0.00)[bounces-8920-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This structure definition is used outside the kernel proper.
For example in kmod and the kernel build environment.

To allow reuse, move it to a new UAPI header.

While it is not a true UAPI, it is a common practice to have
non-UAPI interface definitions in the kernel's UAPI headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_signature.h      | 28 +-----------------------
 include/uapi/linux/module_signature.h | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 915549c779dc..db335d46787f 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -10,33 +10,7 @@
 #define _LINUX_MODULE_SIGNATURE_H
 
 #include <linux/types.h>
-
-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIGNATURE_MARKER "~Module signature appended~\n"
-
-enum module_signature_type {
-	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
-};
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
-	u8	algo;		/* Public-key crypto algorithm [0] */
-	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [enum module_signature_type] */
-	u8	signer_len;	/* Length of signer's name [0] */
-	u8	key_id_len;	/* Length of key identifier [0] */
-	u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
+#include <uapi/linux/module_signature.h>
 
 int mod_check_sig(const struct module_signature *ms, size_t file_len,
 		  const char *name);
diff --git a/include/uapi/linux/module_signature.h b/include/uapi/linux/module_signature.h
new file mode 100644
index 000000000000..634c9f1c8fc2
--- /dev/null
+++ b/include/uapi/linux/module_signature.h
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


