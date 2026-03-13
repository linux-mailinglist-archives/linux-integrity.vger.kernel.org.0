Return-Path: <linux-integrity+bounces-8992-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFMPMWhbtGklmQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8992-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:46:00 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F8288E3C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C333030FF2
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F223E022D;
	Fri, 13 Mar 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYtz5RvO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049403E0229;
	Fri, 13 Mar 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427533; cv=none; b=amibnnThqcWBu762wOpHBGh7RiW8qPZJzrCQ/iZT5kO1CDwSo1Uh6JXMyVPvcxPIVRTnUMLDyjtEZZjNCIew/9Zn4jsrJ9lZxhr6TYOiRcAOJGSrQXZHm6YxtRbHmkohp0kM/MaXrfy464RWQkpi9kOgGVBKIHMtgGP6Y2bSwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427533; c=relaxed/simple;
	bh=Vytham6oPFTdVP7zlc8wsX2dbeVuNOdhbpe3qUY80eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsAwdcjx5WHAo/3oBxc5Omx0+dCJqeYjdgyI9pbaE/7h6UDGQ/6m5PcPEfHcPbWPZ79G3kDZFTg363W+iJ/X9YEF6t+S21uNKdIxTCkeHKT7/3+FdCLEWJU1QPaQWUX3pV+Y2/a0xxJKSpURKvGFc76roiQV5Uu8SYe1lP1TBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYtz5RvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F053C19421;
	Fri, 13 Mar 2026 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427532;
	bh=Vytham6oPFTdVP7zlc8wsX2dbeVuNOdhbpe3qUY80eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYtz5RvOFHnpksyifzWqrlcNXD2mHixGwo2ZnIHp+6xKrAc1RCwElMZT56yO5H2Tn
	 6Yh05DQWwXyZ0nkoqVReUaEADDYXaRpXKZyxeNw4KylJY/jZdTQjXKIpMam5bPZCVp
	 +xMiXFpsOghYgE5iOYSx5JcQfBCno9D/HVWpRM0pgZZAK86po9ontPVMFif2N4jV5L
	 T4V07FVs7Sr76drRFa0OE5d48E2mJR8PvhrAoiWkRJy6wpSTroAQ2r9GXMg03Tq1Ir
	 OXSYyoxpU+qeBj0thU8pXO93XzgdLUT1oHWPcmhvVjuhz95LImcEalC3qcU4M+joMU
	 T0dVtuhn755zg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Mar 2026 14:45:21 -0400
Subject: [PATCH v2 2/2] EVM: add comment describing why ino field is still
 unsigned long
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-iino-u64-v2-2-f9abda2464d5@kernel.org>
References: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
In-Reply-To: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Vytham6oPFTdVP7zlc8wsX2dbeVuNOdhbpe3qUY80eE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBptFtHVGsrqAxYGtXuCQ/JYxGPfWUNgo1lLCSUj
 /YxSVapIHiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabRbRwAKCRAADmhBGVaC
 FX92D/9nua2e1HJ7hFrbi3pC4jkry5qKaxJSkox+XIxiA8MDyoZt64+/KPhETaU4oby4jAT9dJ2
 C3Go+zYOdk2t4kKIQ0UkhYEURTLkSW4/Rs8vyt/vchtzt8Fk5VPbY7Jv15rs6pMZLNx1FjZVBuN
 w7op0eT46v+tiPK3uoRAfE3nZu8bL8BUMriCATH8ySeCQRFiexmRJm2yJBZN1YtB1tgFUvSMfBt
 1zYagMr7xuZYGIsDcnYWe0H3ugfyOVB9ayg7c6WsIUwqF4RWxbvkSrLm6PRKSkq9tHgWM0Lwz3I
 vixeTLgHswtGFp9LohAct1BZA9lyc7o6NGoPt0xSATQdVpAUG8/IBLMryeiGpjJiiDDItDtR9yW
 f8gTIlz4WOBRUkAOD9tmtf/nyOC4z1jve/OGROLXvmNVh3wPr/sC4tlV6oEegioOGEkhikEsq9a
 t/PsX86yAyGvcDhBSz8Uv4+oo5jmIWaKVwXkPrommyaeglc45/RrrUj2fM6Nwrh39tTfhhOTbZV
 FIOkr67djnn41oHUqn3DRTWvUovkCp8Y79PycPOxGeQOGVwikyV+seLXezk1nvAb6GvVQ9c0Obr
 GZbgFsvnmocoGQtt0xk3n/lK+1nLSDf/QgDxig1O0pj8+RHxWvlRefaiR9IClqgJUQQ0sSghyi5
 zUdFI6+aED4iOCQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8992-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,kernel.org,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E6F8288E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mimi pointed out that we didn't widen the inode number field in struct
h_misc alongside the inode->i_ino widening. While we could make an
equivalent change there, that would require EVM resigning on all 32-bit
hosts.

Instead, leave the field as an unsigned long. This should have no effect
on 64-bit hosts, and allow things to continue working on 32-bit hosts in
the cases where the i_ino fits in 32-bits.

Add a comment explaining why it's being left as unsigned long.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index c0ca4eedb0fe5d5c30f45f515a4bc90248ec64ea..1c41af2f91a60a714878ff93b554c90e45546503 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -144,6 +144,12 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 			  char type, char *digest)
 {
 	struct h_misc {
+		/*
+		 * Although inode->i_ino is now u64, this field remains
+		 * unsigned long to allow existing HMAC and signatures from
+		 * 32-bit hosts to continue working when i_ino hasn't changed
+		 * and fits in a u32.
+		 */
 		unsigned long ino;
 		__u32 generation;
 		uid_t uid;

-- 
2.53.0


