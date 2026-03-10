Return-Path: <linux-integrity+bounces-8958-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEH6Bk4HsGnQegIAu9opvQ
	(envelope-from <linux-integrity+bounces-8958-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:58:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6324BED7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 757503088F0E
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3B41C303;
	Tue, 10 Mar 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2eNYlin"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DA38A739;
	Tue, 10 Mar 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143054; cv=none; b=nGuniT60fllSENlQsLQHwgFy1lo1lEKtjwKD04POFYhGIgS8ed+DNZKT87+5OAuT6ibDKkNb0emkdodfa3xdz7t0QZRaaDtWxQz9j7mipSevIUpnSh16ORbspxKMfuATRHbI/dXh+YIB8YOQIkRBCPaOcq6v265Ea/A/3idSihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143054; c=relaxed/simple;
	bh=tZVxDFpeo5B1O27Dnnln/LLZR+hDKidvFRk+FhjVuRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOORFI4OWDHujk4vq0B1SfzCTD04XQjNz03k3oavvHxka27qvlNbmh81kGJDwAW0MYHXJdh4Ut86V7gJ/nT4ge4nnmwohjeNB8//+9p0HciIRzSF/OAVliRHYsSgBy/Tr4aTr/1RVAe4Guw9zrgjRWsVCxS9U4kVhJqq0XS7wL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2eNYlin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485A9C2BCB1;
	Tue, 10 Mar 2026 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773143054;
	bh=tZVxDFpeo5B1O27Dnnln/LLZR+hDKidvFRk+FhjVuRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n2eNYlinmdaBFFcGcyoW1xfxp7kD5BHjVVQM70/mGjtyaM/pVpaT/rcHU3O49wkIq
	 GlYDlZlUlB9RjZJj68uJZKhNugrhIYrt/7LjfrPCkegXSWgWGiIgigntXlp680EWyp
	 GpF5DPuYJ1p7H+aitKYEUsndmjRL8GuVOXoRU7wsvCheTtiEaTwiS5nk5kpMEGUPQX
	 xvYzH3YZTzngwGPlz6KchhzbIQIGWq3cH1wyQwC9yUaN1fqz7IhgNpueZFEE1Jkvqs
	 /spLBCyZrL3Ys+NTUGTEEeVmnznJcBAsBXKayD9ZKjIPsHMokipqTg0RtcuIIUWXm2
	 DnS1M4tdywCzg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Mar 2026 07:43:45 -0400
Subject: [PATCH 2/2] EVM: add comment describing why ino field is still
 unsigned long
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-iino-u64-v1-2-18422a053b04@kernel.org>
References: <20260310-iino-u64-v1-0-18422a053b04@kernel.org>
In-Reply-To: <20260310-iino-u64-v1-0-18422a053b04@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tZVxDFpeo5B1O27Dnnln/LLZR+hDKidvFRk+FhjVuRg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpsAQJKgg3bpI0BXAN8rJeGN8lqpoaWsEpZdBh5
 uozuV+wgzSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabAECQAKCRAADmhBGVaC
 FSKID/4yFNE+m3iMmXf6FmFqbDDj9Sz/SPjGkeJCAoC04DIxPRuZJR2rv9s8qqU6aGkiZKWnPIc
 bBTL3fB7nh52DsdPCdY7mtGNG2johRxnpSRRZmxbfsVmZWXFi9kI8cm4XX1UHE/6m6RA7xrHI8e
 I8+9pW3u2/cL2laQWnuCKR0TJKvPWi/5YRnz+vRxWpeAhb5Y1RuBcgn8Cx2eCBP3IZ4tnDcJ4Xw
 cMXCEaIZcJuePxE3p69F4q5aBKEg/C/inq3diRgNvJhynhTW3PLntwQJr/svzgWo7Zlg39kJ6Ti
 W8aQS5liieqGxNbGhk4cF39pMzKLyhzkkMtyvoqzwFaQYegwqWvkHiVzS4LaSLZ/pPnYyKOWu1D
 rC7dIMnAVoczOaBuW2VjeIMDG+2lHG2+tyOkdEH1ixenWvDJt0Ck/MFxBNbGHeLqmTbgxZFM89n
 /OeykLVQSme9Bv/Lu2yNHzT+zzeoeb7gb0jHammIgeOQH4VIPh+etnBKS4zDZM0U17JkhlWKIFb
 Wy0nMknbmBf5IE9cN6ca37fPDDO5RYFM7QcbT+xudgYCIeDMzXz/DDLq0hugBo9g25UV07nLdnD
 nu2MJFCwNHUzPetpp8feRGNu7tBq+B+FPDO+Ph/aB6rmTJ/2Z6NW3cNTIDvAmza4AOPhmD8Q9Ep
 zOHzZldsVPj8p9g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 47E6324BED7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8958-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,dubeyko.com,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Mimi pointed out that we didn't widen the inode number field in struct
h_misc alongside the inode->i_ino widening. While we could make an
equivalent change there, that would force EVM remeasurement on all
32-bit hosts.

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
index c0ca4eedb0fe5d5c30f45f515a4bc90248ec64ea..3445f4c2097f7e8af61de6299b721fc4a1d8afb4 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -144,6 +144,12 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 			  char type, char *digest)
 {
 	struct h_misc {
+		/*
+		 * Although inode->i_ino is now u64, this field remains
+		 * unsigned long to allow existing hashes from 32-bit hosts
+		 * to continue working when i_ino hasn't changed and fitsxi
+		 * in a u32.
+		 */
 		unsigned long ino;
 		__u32 generation;
 		uid_t uid;

-- 
2.53.0


