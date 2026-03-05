Return-Path: <linux-integrity+bounces-8905-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJc9HjktqWlN2wAAu9opvQ
	(envelope-from <linux-integrity+bounces-8905-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:14:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81A20C51A
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 08:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCB7305A6F7
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F3315D35;
	Thu,  5 Mar 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0fkJZFN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Rkjhwne"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B23101B2;
	Thu,  5 Mar 2026 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694717; cv=none; b=AzRUoufifUZPE+Tfw/U40Ib8UDlpuU0jwMpb0cm0gCz/1oZb283gZl+FNGtizV0KfZxT2YVn14Ox2S/4mVneLJyyqsNxMbtToMfuQvcQe2qdRu26hoQbibwVPEZdU5CTc5scmB/o6vgu2eb7lDjCeqdF0QSnwm+7iLRI0XkNor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694717; c=relaxed/simple;
	bh=CdxA/lDoNCeJgiVSZNMfVTLoyKfuC5y8bX2gqNZcV84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rgHkRBTGu6KADXwb7yS/gzFultGsQDv12uiMkVyPYnoilqg+60OKFXt0UdkNfxVm9gjg44wocEtJnOwicYzqlzacRRvFpftbD3t5tRCVEaEtihdZsTlKooFcNeq1UbCwCedx4gGGHxUQTdQfLXFh/t2UhrxkYUhKHgc/jQdeXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0fkJZFN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Rkjhwne; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772694714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o9Rv/g2sSOXoBx4YOHT+TvErcM7jjAJLr2hFIDRxUAc=;
	b=n0fkJZFNW9Pzw4/56jcf0S5vOQJDa4Ty4URhhRjrX8F5sYZpH6cZ5BpEEmcePdxaE/u7Ae
	+mJNbwc6AKN5nC4tkXCeMmpjMPeAuwRRTp/yTQTd7OOWRugAt3TZllguLzalIIlp67Bm5O
	tC8tF94VTEdCOX6qESaJyXQzGhZ2P6P3rZ4qYm8V5k3sfx5qy2KbmOJ6Gy6mXEuakK4dD+
	lVqWir9+OtHBQFPoB0vdx6u00GK/BNuM/0fR5eyK0RPZFGmnvQn7gXFXpDh44vy2OcqjXf
	7zhSfRI/3FMngkovpr/Tx92cxp8dqerymRABoDMkc+2PMiqlvkOlYVTtjcnC0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772694714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o9Rv/g2sSOXoBx4YOHT+TvErcM7jjAJLr2hFIDRxUAc=;
	b=5RkjhwnejcuSRS2fW76R3LD3peZJAHQGav+2GwR+SMZX3QiQtepiZ0c5iQ4unK5hFIvrHV
	gFBh1TRGSQY2f/CQ==
Subject: [PATCH v2 0/8] module: Move 'struct module_signature' to UAPI
Date: Thu, 05 Mar 2026 08:11:50 +0100
Message-Id: <20260305-module-signature-uapi-v2-0-dc4d81129dee@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhpDSiuvIdhUewAk2BLWkowh
 LtbuYDL95L//gaRg3CEe7FB4EWieJdBnwp4Dcb1jGIzgyZd0YU0vr1NI2OU3pk5BcZkJsFKdeZ
 GrWLdtpC3U+BO1qP7bDIPEmcfPsfNon72X3FRSKjpauuyZLJV/RjFpTl4J+vZMjT7vn8B5pSBk
 r4AAAA=
X-Change-ID: 20260302-module-signature-uapi-61fa80b1e2bb
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772694712; l=2332;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CdxA/lDoNCeJgiVSZNMfVTLoyKfuC5y8bX2gqNZcV84=;
 b=9FyUClW24ZP0BNLsGOQjp6Vf1xA2ehbLzgQTtF4tcedOtFKzNXBx/elbEs7tPtDMI9KUk6nJ1
 zhyau38au1oAgqN/zKFdzdfil5CGff4Dh8k5PxwgrozQcMJX8JFuSop
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 1C81A20C51A
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
	TAGGED_FROM(0.00)[bounces-8905-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This structure definition is used outside the kernel proper.
For example in kmod and the kernel build environment.

To allow reuse, move it to a new UAPI header.

While it is not a true UAPI, it is a common practice to have
non-UAPI interface definitions in the kernel's UAPI headers.

This came up as part of my CONFIG_MODULE_HASHES series [0].
But it is useful on its own and so we get it out of the way.

[0] https://lore.kernel.org/lkml/aZ3OfJJSJgfOb0rJ@levanger/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Drop spurious definition of MODULE_SIGNATURE_TYPE_MERKLE.
- s/modules/module/ in two patch subjects.
- Pick up review tags.
- Link to v1: https://lore.kernel.org/r/20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de

---
Thomas Weißschuh (8):
      extract-cert: drop unused definition of PKEY_ID_PKCS7
      module: Drop unused signature types
      module: Give 'enum pkey_id_type' a more specific name
      module: Give MODULE_SIG_STRING a more descriptive name
      module: Move 'struct module_signature' to UAPI
      tools uapi headers: add linux/module_signature.h
      sign-file: use 'struct module_signature' from the UAPI headers
      selftests/bpf: verify_pkcs7_sig: Use 'struct module_signature' from the UAPI headers

 arch/s390/kernel/machine_kexec_file.c              |  6 ++--
 certs/extract-cert.c                               |  2 --
 include/linux/module_signature.h                   | 30 +---------------
 include/uapi/linux/module_signature.h              | 41 ++++++++++++++++++++++
 kernel/module/signing.c                            |  4 +--
 kernel/module_signature.c                          |  2 +-
 scripts/Makefile                                   |  1 +
 scripts/sign-file.c                                | 19 +++-------
 security/integrity/ima/ima_modsig.c                |  6 ++--
 tools/include/uapi/linux/module_signature.h        | 41 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    | 28 ++-------------
 11 files changed, 100 insertions(+), 80 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260302-module-signature-uapi-61fa80b1e2bb

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


