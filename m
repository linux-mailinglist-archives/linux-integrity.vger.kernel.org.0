Return-Path: <linux-integrity+bounces-9000-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH0ZEJZUuGmKcAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9000-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:05:58 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6729F7F6
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB9A30AB847
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689B3ED10D;
	Mon, 16 Mar 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqTc/Kaf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217E3ECBE3;
	Mon, 16 Mar 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687764; cv=none; b=mMXoLOydtb6MDfHa9PQlNqaGa+v4MHq2y9VR3IyQJkHGdiYI28SP6mhUY0rSoiyA6hgJiz0ni00vpyk8s05Eofnao/kE2k6cgkiMaD8nuaK5in4W0hqNCo7V3pJNIL7/B/e/a7mIFIZUZWbAcQh1VDyQY/L3aJVEbvXM0peJ3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687764; c=relaxed/simple;
	bh=gSLugL4BJCVukfdg59685JzW/b7n8IM3GIiR8tdfS+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmSXyO78g9rESsMo3b0RyeNSOZc5K4oABpD6k2P1r28F4xxmGP2Y5L+3jQovFqxVsEnGPjxGyeDM6XmUw6f7dFSw2vk9R7HY8pbzs8TEjtOwOQlDA68ZAywwWExRX6Rnl6UObcEKsulpZTP1UvHnHpGUv/4FG4b1dRLMCbxo9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqTc/Kaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07249C2BCAF;
	Mon, 16 Mar 2026 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687764;
	bh=gSLugL4BJCVukfdg59685JzW/b7n8IM3GIiR8tdfS+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dqTc/KafGUCd0QdOxr/mQ/By4rqW1LvQt5vYhV6pPqKy13Q8zeqjxdqw0uT6X+LA9
	 ne1ak1Ob9RpgFzvy5n18fBvnHL4rBPdH3uK3+afvMq7rUstg/ZwJhvVC3g/atpwXek
	 BRjAIdCt6keOlfQu9Wq+N5WyXCDAbyI6GyidIHUWQeRr05yZiih9r8dXhlU5+YRUTJ
	 3YX9V3wL3hc/R5jO2DepSXHUTSwJqYjgui9oz7ki8JKf4Eee5oMW4gE2K7asfE4qV5
	 1vrOn1ZkWBV2WFJXvvet/MZULZ214nPzqcmsSeQ2vQZlqn/8e7qsOx+byjANiLI96R
	 sm71yHExZqn0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 15:02:22 -0400
Subject: [PATCH v3 1/2] EVM: add comment describing why ino field is still
 unsigned long
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-iino-u64-v3-1-d1076b8f7a20@kernel.org>
References: <20260316-iino-u64-v3-0-d1076b8f7a20@kernel.org>
In-Reply-To: <20260316-iino-u64-v3-0-d1076b8f7a20@kernel.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
 linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gSLugL4BJCVukfdg59685JzW/b7n8IM3GIiR8tdfS+Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuFPQk4U2alTaKDSeZ8zDz8gRNMT3bQExQbuzT
 vFFvuYXrz+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabhT0AAKCRAADmhBGVaC
 FV5fD/9OS1XCz+MpwaKK7fUQ7qRYIebmzSkc52PxDlJ/E7wxdn2BJULD6d52lY+AJI0HsQW+uGc
 Ted8+FadniZfxtMPI48cXHcfGEvVIV5caN3AdjgRGO8AxwdLTyQUXpS3JWmLpkDrRdMMxYD+kOV
 WJaCwmFfMUNpzHbNOCeGqav+af0U2zEoxUAwlyhmX1xloA/gXWdRgw5FZQjNXmtMS3/IzKlf1JA
 y+ZVuJr2gcRUkGLr6F5BR/2vLcN4W9PnNcPeO0dNJEPO8bGBGnctoGg3y74k8vLDOd/iy+PvM7F
 I7oMVnF8cBBMvcKXV3ZrZsRRYyMDaaaO45rqgjkFIgGLzUJrh7X0rurt/aaAadGpUs5PtZVeYtP
 Nv5VVMs4rJwGY11AbuiF8KuVXQpkan2i9ZUOT8oe3x9nrh520s72yDZLbxOe16AxSlPZR5U95ZS
 pu/tKrdj8pBuJGjldNWOgh5wqx+7zLwRo2O2ymC/TtBcMOz3sWxfC4tNszYkQPWq0bn1LkUVHEp
 cqWIWGOSZc12G6xS+kCcaKjLIL/RMB3aVySAc0D4Aoz+vHjKNIbxauL/E+l5Rl5Y7tWqLHY2cdR
 bLJV0o+50Z4hSUGrmnjXNzLw43TvskZeD4p0On+VhNsAnWcVvCfgJ2ZFY3ayIYbJQ9SLjuGzuvD
 bk6Lqd2CdUvLbAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9000-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,kernel.org,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBC6729F7F6
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

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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


