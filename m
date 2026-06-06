Return-Path: <linux-integrity+bounces-9766-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LLhaB+GDJGrE7gEAu9opvQ
	(envelope-from <linux-integrity+bounces-9766-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Jun 2026 22:32:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A464E45F
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Jun 2026 22:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="bH32w8 C";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9766-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9766-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD9AD30782C5
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jun 2026 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A63D330C;
	Sat,  6 Jun 2026 20:27:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989C3CCA13;
	Sat,  6 Jun 2026 20:27:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=bjakOOxoOSi6h5uGyMsWC3RyvzXcBKCQbJWtJpXlYFHnYFmW+N4GVU92iqIooLVmAzaZiq8/RHPwrH9Gw/9jK40AbAAoGmudBIQhxBnMNwjfEtKYmxSGOqzU39mGMbVMhFrJXfNnjPTXneUiLUpy07i2N3hdoE2MhluOSpcCf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=yVaQLuXvuO1U/EDzM4sU/Zv0ZJik7tGVS8+oIVTent4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvwiTR2w5C+28VBUCYDPd2BWlpEc67kVrYtfAkuZBDHTRGe4wd9h6l9k9d1BPkhWZ6mlJ+3f08Rb8EpBit+91dxP0hG5kEcA50ApNhHpNDrOetvK80POitpTsptptWhbEUR6kkoAKNduyyvMtuq94o1kFjeDNwYxrl/d6wyNbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=bH32w8Ck; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxc2-007NUB-6C; Sat, 06 Jun 2026 22:27:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=vGXFn2UvdIj9ETYsFlwDVkmlfUzPfMtPUYXWNHsGXF0=; b=bH32w8
	CkcpR+W561Oy/cQW4Evzp1bIO+GgsLgR1U4uvkJPsqMePP/CsWuhCUfDPMv8OxW7RLZvo49e84VZO
	6vKxCpMHpQQH+w4X3ivVMCFpcYfioNOcBQ8ftFsan1z/Gp8c5AFRTEg0ElMawBYF0zdvEvEh5cXj4
	fE7Yv5TgEPjf9YemdP1G1YO9fWJEa5clUm+RhmPNymkI5oTuejw04F5R6jPGInfqZSq9D39Vq9ojW
	B6iJ5dkowRIJjAnr8ZODvI1T31J1os23FslwmVSlOmUOxRUxPVdBSGhPnoV+Lj2DnApql68gZugRS
	/qY3qqF8+Ty01nvJkyllPJmK6OzA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbw-0005DT-Cf; Sat, 06 Jun 2026 22:27:16 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbc-006V18-IS;
	Sat, 06 Jun 2026 22:26:56 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)
Date: Sat,  6 Jun 2026 21:26:03 +0100
Message-Id: <20260606202633.5018-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9766-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dhowells@redhat.com,m:jmorris@namei.org,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:paul@paul-moore.com,m:serge@hallyn.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,namei.org,kernel.org,linux.ibm.com,paul-moore.com,hallyn.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B63A464E45F

From: David Laight <david.laight.linux@gmail.com>

derived_buf is guaranteed to be HASH_SIZE - and it is more than enough.
The strscpy() degenerates into an memcpy() (as did the strcpy()).
Do the same for the associated "ENC_KEY" copy.

Removes a possibly unbounded strcpy().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 security/keys/encrypted-keys/encrypted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 56b531587a1e..59cb77b237b3 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -343,9 +343,9 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 		return -ENOMEM;
 
 	if (key_type)
-		strcpy(derived_buf, "AUTH_KEY");
+		strscpy(derived_buf, "AUTH_KEY", HASH_SIZE);
 	else
-		strcpy(derived_buf, "ENC_KEY");
+		strscpy(derived_buf, "ENC_KEY", HASH_SIZE);
 
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
-- 
2.39.5


