Return-Path: <linux-integrity+bounces-8914-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBxKOEdOqWk14AAAu9opvQ
	(envelope-from <linux-integrity+bounces-8914-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:35:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AAA20E890
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3A83019824
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D48379EE0;
	Thu,  5 Mar 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xytaAf2r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3h3+lgD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A4377ED7;
	Thu,  5 Mar 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703102; cv=none; b=pPcRC9IsUCQhBWL5Ej46NpS813rJ8+sZ2nRUPRxNsIADfeNAfCRafDT51FUNyaYJF1rwf8sRe+Due0BYGC4MqJV6FJ5eqKakBdzdWg5Lgc/0IJQfrn1HdfcJ3ZmNsZHiawGZaAkc9pMS3DPPanNQvJ90QqV8Ang+rwV/ewTlKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703102; c=relaxed/simple;
	bh=fgdmdf77b8hQOI441pKYdKFicdhvYLEChYvN03raTtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nBZXxOK+dauwzbTz75j9GcX3em936nUhneuuWzphq0Ecv8wsUEMhRqRp/afxRhNsIBfLu+TBHOwLEwYiHV7ODyvoWa3HngY6OWNgQGt7j4tBbWbQHHFY5lg1IeBQfM0fKdmQpFbYHb8IUao/eGZw7+Z+MHz3Nn5O2Np5T+qu30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xytaAf2r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3h3+lgD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772703099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bu8WiQKkNBMwU28xfl3txV1TIzZCzYlrhLm08RAUoXs=;
	b=xytaAf2rQjEZLTmTvairdv61lxtC7b0QvsvU7QQqMHIAPJd+fAWNG+mAyxuseqCTH983ep
	G4BMiuylTlFAz6M+kVa+yosMj+cV0mGtJ0/57/5PKoTHbUYaqIjkskjIvskcmZ9PoZwpnW
	lv2fzACqYjLtFgum+YtXdSCOkQEXvdeR/SW22AuHS6g2KwPYZdRicHw9InDvPchFfTCral
	wslaTJQrjzQwwfeidMP24ffvF8VnN8IxQrRwgRBekI7lkPOz6RNdHvMivJPe0UAoEl+/37
	qxDqqfnwLdLh9sMDZVS/k5nIPcz1V8RWFS5bhTds39OJvsT+xDY2g60gigJyOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772703099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bu8WiQKkNBMwU28xfl3txV1TIzZCzYlrhLm08RAUoXs=;
	b=r3h3+lgD/zejL3EcYa0zS2NepF6/Bzhk91kBp7FP2T1DWK8OkCe17rhH5Ov7JMzUPM4ui2
	qh/2XF05iCDzFMDg==
Subject: [PATCH v3 0/8] module: Move 'struct module_signature' to UAPI
Date: Thu, 05 Mar 2026 10:31:36 +0100
Message-Id: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBCF4auYrq1pB0Fw5T2Mi0IHmARb0tIGQ
 7i7hZUxMS7/l8w3C/PoCD27HhbmMJIna1JkxwNremU65KRTMxBQiEwAf1odBuSeOqOm4JAHNRI
 vZKtKUUuEumbpdnTY0ry790fqnvxk3Wt/E+W2/hOj5IKDuOgqz1HooroNZMLkrKH5pJFtaoRPK
 f8lQZJ0c9allFBpxG9pXdc3b+fMCQgBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772703098; l=2709;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fgdmdf77b8hQOI441pKYdKFicdhvYLEChYvN03raTtg=;
 b=s9GwrswTxqAeCrdGrvQfEgfC7LmIbNL8z1iS8wn8NtXjBtkaOvbCkix1V+4OPt3aX7UBqtjHF
 jyv4woFRhFyD9t2uIYxxJHpnY2YVFC+wfrTccfY88rNB/abo5o3vGLA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: 89AAA20E890
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
	TAGGED_FROM(0.00)[bounces-8914-lists,linux-integrity=lfdr.de];
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
Changes in v3:
- Also adapt the include path for the custom sign-file rule in the bpf selftests.
  (My manual run of BPF CI still fails, due to an BUG() on s390,
  I don't see how this is due to this patch)
- Link to v2: https://lore.kernel.org/r/20260305-module-signature-uapi-v2-0-dc4d81129dee@linutronix.de

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
 tools/testing/selftests/bpf/Makefile               |  1 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    | 28 ++-------------
 12 files changed, 101 insertions(+), 80 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260302-module-signature-uapi-61fa80b1e2bb

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


