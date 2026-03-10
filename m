Return-Path: <linux-integrity+bounces-8957-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AObeIUMHsGnNegIAu9opvQ
	(envelope-from <linux-integrity+bounces-8957-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:57:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A833424BE4B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77E08308127C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4140B6DF;
	Tue, 10 Mar 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6O+9c+e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCC3F23DC;
	Tue, 10 Mar 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143053; cv=none; b=u7lFd0rRlkjjXQwaB6yath93SDtTVa1bSnjO50OE5iQ8FxEoNhrIdz5qGHItLHrsHaZt9MrP2lWCKKxPJ311hxE7xt8EZ8JvNzAf8pcTkavojxo1qaFSzLx8XGcyF2Ev3T9G1YqNClunwHEzzjZnjQo0XRMjj1Cy1xzyWSQI1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143053; c=relaxed/simple;
	bh=aG1bsckWvsI6XdW2oq/+sffQOcFy7MrP5MMQ9NbMVcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbXhsxQqG5jox+tA9Yj2S1AEZMjDXTOi1QTRECt4JhDUAbsGruK35s5qQ4OKj7U9iTp837xrUOekfMW9w2OMCEbJQU/6eDjudC7k8tjw+KJEVjer++RxuPYCKws04s/Vj494M3ktnZzFvks6ZkcAXB3iY/tbBDHGiBwLBAMQS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6O+9c+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA327C2BCB5;
	Tue, 10 Mar 2026 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773143053;
	bh=aG1bsckWvsI6XdW2oq/+sffQOcFy7MrP5MMQ9NbMVcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T6O+9c+eZcgOWYhQ76lypVhWcbe0tWnsO8JIXOd3T66Yu7jbCcY/j2cOMaI60z6Dx
	 7nGJ1WQMoQQlMp3YOG5ovQ02uXi/OE3M7TAZzGoWZujAbq6CXRo3g4/VAYYoPytYs+
	 4A1H9w07NyfwwzfjqzLK+mYRoZp3rxY2iIReQI/z1GcE/DbGtrdJfP2lLGS3pxeqI/
	 SuW14m7cZzGc/oXfihtyenotY90fwA8VOZWKtETS9/uEvazw6tT9zlL5kkQb0dxerj
	 ELwLdXh+8/22zm9zihIVnaD8G6oUp6UK4ifXRq6jduff/eB8AfK66G6gs80j2oqEF7
	 5xzMHMj+CSXrw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Mar 2026 07:43:44 -0400
Subject: [PATCH 1/2] nilfs2: fix 64-bit division operations in
 nilfs_bmap_find_target_in_group()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-iino-u64-v1-1-18422a053b04@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aG1bsckWvsI6XdW2oq/+sffQOcFy7MrP5MMQ9NbMVcE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpsAQJGiNQe/OYjZ6t7Mr7eUh98pVnnkgOOgF5C
 z+g5X0IZr2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabAECQAKCRAADmhBGVaC
 FSmvD/4irF/uCRALfksheDuf0if0NvOID2cRUcH50SFh9b63TqKKi4Dy3FwPN5kTxh8XG/9onWc
 rEJbxmgXib2EYgqxhb70kFx6Kb4z1kDQAyzeH7LeoyeNTz3EgsAcuvryGPoOFv9JrSZRnGV1/OC
 RnVnr2ORzsVlujxmRZVBapP9RGmq/1LxIc3BIhnjpAR4aWBuCkoj65/YxVAHuReOOjXOWikciiW
 OY1RRcqqI/SEwIkX2nJerVtZOZQo2rWsinjtF/G4T2Ke6argtt877bkpTzimjYWffMwOg5iYx4l
 A1iQES5HNIG4KWbGnZCuaGT7MTZeUE0az8E+LlsuhHr1P0Kf+aZRVc7dHD74nyY8WZx2H3ZTnmC
 SMU04p6G6NS1P4qGLFtb9zpdJKTjxWpyQKsRz3G8ydWTaLSSw1UEnYL4Dc2VknqarRj10NNAs8c
 PtQ0+HDhivM/4eDK1GVMIebuab+K2tTII2D5nroixsPtt4IlmNXkjPCbmH5ebo8YuHEsfwLEzPr
 /qrLWNRuAkC9yufXkiJ9b9Z+mIS52xc5dNYtU7/Zte6Zr4VaISOSV7L1pdqGR9dBs+7eOrkdrkk
 x+aSs/Qlvhc2rSjt+eXQANSLP0/6TqrHiwJ7GeAq46d0r3xkdj0zgDzC0mPg4bT/Gc69epKoNxU
 v8U5bHW/hLcBV+g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: A833424BE4B
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
	TAGGED_FROM(0.00)[bounces-8957-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,dubeyko.com,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

With the change to make inode->i_ino a u64, the build started failing on
32-bit ARM with:

    ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!

Fix this by using the 64-bit division interfaces in
nilfs_bmap_find_target_in_group().

Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier conversions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@intel.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/bmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..4ce9a93149a5af13bc215cc1877a757e2c6cf49b 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct nilfs_bmap *bmap)
 {
 	struct inode *dat = nilfs_bmap_get_dat(bmap);
 	unsigned long entries_per_group = nilfs_palloc_entries_per_group(dat);
-	unsigned long group = bmap->b_inode->i_ino / entries_per_group;
+	unsigned long group;
+	u32 rem;
+
+	group = div_u64(bmap->b_inode->i_ino, entries_per_group);
+	div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &rem);
 
 	return group * entries_per_group +
-		(bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
-		(entries_per_group / NILFS_BMAP_GROUP_DIV);
+	       rem * (entries_per_group / NILFS_BMAP_GROUP_DIV);
 }
 
 static struct lock_class_key nilfs_bmap_dat_lock_key;

-- 
2.53.0


