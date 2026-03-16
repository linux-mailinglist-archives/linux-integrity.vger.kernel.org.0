Return-Path: <linux-integrity+bounces-9001-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIIuEslUuGmKcAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9001-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:06:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C829F81D
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F0730C1C07
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D53ED5B6;
	Mon, 16 Mar 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJW4Vh0H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75C3EC2E2;
	Mon, 16 Mar 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687766; cv=none; b=r+22LtYqhp9CKG/EycSCqW9zRE10H11MUsIhPksQbk3wDSM3TjlmvTpyCLN2QaXkT30ZfOR+/R5zlHAFv5HKKu/tMserWL4jf8L8JbanOMqnVbDnWTn9ShY+2wkwgzr7aeHG/ucGqj1ZqyXUTAmtpmEE/hFJOAbPpmu8k5g4Jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687766; c=relaxed/simple;
	bh=CUkhw3xl8xIRjoR4RbMKIcmO3c0dZFO7usOuKJlm4c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co8BaSrH4OJ9PbTt9IOPyuTMiOUQ5qO7uF/aP36NSNlwov7MMZtU+LfU5YxAbFgHYo8qgvEX0Et3Ji+8aHl4u9aPMQr3yYbPbQn+jlKmkzjzHQDbzZXlyQcHFX651wy7585kix524+25+04vy1Xe7J9lPP+6OuTILh/MvC6BINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJW4Vh0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B275FC2BCB3;
	Mon, 16 Mar 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687766;
	bh=CUkhw3xl8xIRjoR4RbMKIcmO3c0dZFO7usOuKJlm4c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJW4Vh0HAFzhHgFoWvUIXGQKWxXFMsnpcqEiyNCLCT3r9CSByh3g0E0fND07bqgRb
	 0Hb1/kBe+iFnKWX0GeqaraDUgsCr26BkJNw8y0jepowt3oWEKI6XlGubU2aNf4FV+T
	 MaGVsXE5OfF/nu+sGW4eYjCggEDdSbn1lGoAVtCH3f2TssdyXZ9nFPfhJyhw4TO5aT
	 HeFEzmdP3r491jMRfD3yhl7CQCiRNE/qzgWRCtYKnp0fOOK3PqSrpl2jRpf+ZyHtbu
	 +FtVYvn+e4ucu/WfVKkzpjv8y4IqkVTPNhad4QZ4gwZV3J+pPEUX2b+REKYDripGw3
	 mLJz/25prB3iA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 15:02:23 -0400
Subject: [PATCH v3 2/2] nilfs2: fix 64-bit division operations in
 nilfs_bmap_find_target_in_group()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-iino-u64-v3-2-d1076b8f7a20@kernel.org>
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
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CUkhw3xl8xIRjoR4RbMKIcmO3c0dZFO7usOuKJlm4c4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuFPQVZMUYX+O8fn7SpAIPVmqwkRvPuMz5JaPj
 Tv7vfY/ClOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabhT0AAKCRAADmhBGVaC
 FQZ9D/9E+wUpb9S2ol0rfVLUqP434oMLE4Z/2pT0pJ8AOVE2CMqfbA/2KzU2Y3HrHnYJAirEMNN
 v6WbqhZFaeVxOomaU9Gb5Kyasvd2dBEFWgjXc0U39kzMsyAhE3WRUGEk66Eqvi0bzdKYCpyfjbO
 fSO1JrbT9RPgHhlv2KCWiGhm5/5LRoaYd8k65+YMi4mLkIRhxInG6v9DCfMwjKStdoK37I93Rgq
 eUF78aT52ToEax/9u1vW+my6MkKSm9nXzvDsioOE2o5GoFAt2Nk1fxuO0qWHyCzVYKGN8i2ksvr
 bxODCyGUoOCQ3mq327mQeMlGAUOoXFwmV5nVstqNFhZIRIdsk281GbAajSZc1ScDrrfR2CDbzmp
 z1CbSRGcEs9h4OoJEho7gi4uldeXUAE3YDIJK68UaTAZJS6J+1aa5XXLTNrUGrN2lk4lzhIOWxZ
 kqv31A8mDElVKBLeF4c7/OwTGCi4cKDEFgK1sDVDpmOykQ+m5trn8jwUYwUVLQmF2pZ18gExtn3
 9GEfptvkU/Hg/GUtoK+8nfuFNq6KHuAkxNHMXxSCjIYJxNURiy725EnzbTg7yzDshNOeeKbX8EU
 anxZv7rNTnkkyKqA5QiwbyAFmgbzIx5NlsDHGsrSuki0nrK+IxKwhU3dqFi78WkRCdTO+84Lcaq
 +s47Dz1vuvvgACA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9001-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,kernel.org,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email,intel.com:email]
X-Rspamd-Queue-Id: 981C829F81D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the change to make inode->i_ino a u64, the build started failing on
32-bit ARM with:

    ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!

Fix this by using udiv_u64() for the division.

For finding the index into the group, switch to using a bitwise &
operation since that's more efficient. With this change however,
NILFS_BMAP_GROUP_DIV must be a power of two, so add a compile-time
assertion for that.

Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier conversions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@intel.com/
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/bmap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..5f0f1f283af0208e1879e2e84b0b5b9629fd6b8a 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -450,18 +450,25 @@ __u64 nilfs_bmap_find_target_seq(const struct nilfs_bmap *bmap, __u64 key)
 		return NILFS_BMAP_INVALID_PTR;
 }
 
-#define NILFS_BMAP_GROUP_DIV	8
+#define NILFS_BMAP_GROUP_DIV	8	/* must be power of 2 */
+
 __u64 nilfs_bmap_find_target_in_group(const struct nilfs_bmap *bmap)
 {
 	struct inode *dat = nilfs_bmap_get_dat(bmap);
 	unsigned long entries_per_group = nilfs_palloc_entries_per_group(dat);
-	unsigned long group = bmap->b_inode->i_ino / entries_per_group;
+	unsigned long group;
+	u32 index;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(NILFS_BMAP_GROUP_DIV);
+
+	group = div_u64(bmap->b_inode->i_ino, entries_per_group);
+	index = bmap->b_inode->i_ino & (NILFS_BMAP_GROUP_DIV - 1);
 
 	return group * entries_per_group +
-		(bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
-		(entries_per_group / NILFS_BMAP_GROUP_DIV);
+	       index * (entries_per_group / NILFS_BMAP_GROUP_DIV);
 }
 
+
 static struct lock_class_key nilfs_bmap_dat_lock_key;
 static struct lock_class_key nilfs_bmap_mdt_lock_key;
 

-- 
2.53.0


