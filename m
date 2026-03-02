Return-Path: <linux-integrity+bounces-8694-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP8ANmuHpWkeDAYAu9opvQ
	(envelope-from <linux-integrity+bounces-8694-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:49:47 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87F1D9195
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE60C307E0A2
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A5375ADD;
	Mon,  2 Mar 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BLk/xXoG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75OfVh0a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40268375AAE;
	Mon,  2 Mar 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455378; cv=none; b=I/jYEEUWSywuGBnKsJD5Xzv8WjHVSOeOhWyS5dK2NG67AkvqnfLoBx2t5zv2Jtyg2DdAy6323dcvkH+5Aw6N7O2JgZxSneSmlUbOKYepQAnwDxcaLBQUKFol4RDUUmnBJnLYBkNU2cqdFPXWa8+BysZ3QSS1m0+kBfcv8SFFSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455378; c=relaxed/simple;
	bh=t3YEdFhievGgjPrh+JoyTF4MmrBNZ2JawZjvghP6A6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=regC5WYGj3Sgh3ezg2jGJZAHK4WpNRH41BoXT8MG2b2v19F0zsQ+Kzm5WkK/m/DdLFKLBNV6FqOEMnKuf1P/I8fZGEpkfC0kCxsFPToLpew/OvW8IGBGKqbi5Whh2E0RpFAo5pX0yFmZkiHPTTmecc76YxqZeB6j9CDkcilWh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BLk/xXoG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75OfVh0a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772455375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vgM4eUBuuvZTHQKnaRZR5N5ZJRxX5SYFZrT6cL/hA1w=;
	b=BLk/xXoGh3U87DSepJi8SrRKVWfb2suh8pvZsc8e26vXdvF3NB57sBMHW5y6Sj7ZL6OQPB
	/piRUc4wpvz6r3yNKdluSzdLqgftdi9TlHlUSgYy2S90mgWNOgO9nERj7QpzJRJARGqLrh
	Mdyq5ygvu/bGjL6etZmtTYLN1us9QJezk6rlxnYQyno9eU5NotHKlY2a5xYO1ro9hnyyl9
	o00NXTcAvVMYuuZtfrykBeKE6C8CYpBez9eI9GyK6wMn+6ZqUsZNtlOlW94TCoUU/cmeBQ
	FCHNCy85z/bqr9KT6woxr3EGAHwyl+lP/qHD79ys9vXBA651gataUfgolUKUTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772455375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vgM4eUBuuvZTHQKnaRZR5N5ZJRxX5SYFZrT6cL/hA1w=;
	b=75OfVh0a9pOCuH2UiskTuOJogTd6GW0qviF6ubk8opfDLj3ebtZRT2NTqpCMljF0/RvKI+
	LK9pNcyHd+daj/AA==
Subject: [PATCH 0/8] modules: Move 'struct module_signature' to UAPI
Date: Mon, 02 Mar 2026 13:42:36 +0100
Message-Id: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQA4muEi20RhsoC80IwrsnL
 d/i/xcSRaYEQ/NCpJsTH6FCtg3MqwmekJdqUEJp0QmF+7HkjTCxD+bKkTCbk1FLZ3phJSlrobZ
 nJMfP/x2nUj4UMfRaZwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772455374; l=2076;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=t3YEdFhievGgjPrh+JoyTF4MmrBNZ2JawZjvghP6A6s=;
 b=azXYTOEJzMkpBdQiuEC4PqD09LRtjy4+KaXEptlK5L0aUGSg+NmrvC0KnaSWsP+/lyF6M/lPa
 aqTkVbZMWmiCARJzA/TdMmTsgbGDeEN/pxlKznH6kaS6fmunqg1+RbX
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
	TAGGED_FROM(0.00)[bounces-8694-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F87F1D9195
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
Thomas Weißschuh (8):
      extract-cert: drop unused definition of PKEY_ID_PKCS7
      module: Drop unused signature types
      module: Give 'enum pkey_id_type' a more specific name
      module: Give MODULE_SIG_STRING a more descriptive name
      modules: Move 'struct module_signature' to UAPI
      tools uapi headers: add linux/module_signature.h
      sign-file: use 'struct module_signature' from the UAPI headers
      selftests/bpf: verify_pkcs7_sig: Use 'struct module_signature' from the UAPI headers

 arch/s390/kernel/machine_kexec_file.c              |  6 ++--
 certs/extract-cert.c                               |  2 --
 include/linux/module_signature.h                   | 30 +---------------
 include/uapi/linux/module_signature.h              | 41 +++++++++++++++++++++
 kernel/module/signing.c                            |  4 +--
 kernel/module_signature.c                          |  2 +-
 scripts/Makefile                                   |  1 +
 scripts/sign-file.c                                | 19 +++-------
 security/integrity/ima/ima_modsig.c                |  6 ++--
 tools/include/uapi/linux/module_signature.h        | 42 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    | 28 ++-------------
 11 files changed, 101 insertions(+), 80 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260302-module-signature-uapi-61fa80b1e2bb

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


