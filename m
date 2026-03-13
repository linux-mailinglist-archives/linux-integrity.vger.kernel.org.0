Return-Path: <linux-integrity+bounces-8991-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JXVHmNbtGklmQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8991-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE49288E2E
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEF52302444A
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2833DFC6D;
	Fri, 13 Mar 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnRXa1VH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E473DFC62;
	Fri, 13 Mar 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427531; cv=none; b=HvXt6hdJ/97mbJ22GE0dYgA/ig4TWroXMOrkKpOQdY/Nc5d2X+Bu9duZ5oAbs56jt58aoeq4p5RCoA+M7THqM8qiZ3LUlc1QifBeZ5hRVIIYSQsSsUkq5OaD5xKJ76rgSsKYrFcuHDqEXv84xH6kfTWQl8nwiqy9oESTGYK4ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427531; c=relaxed/simple;
	bh=VsdJVy3sTJ50eCmktjm1NaHsn25vDLcl0SM75ClV9Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDx3AFJPfufMbsq7JOB//mGmI5s5LkBcBBh0VtFzOD0p6WgJdgpkQt5d1kIb+uLeRV1PJ8BO3hYQYsVOHnkwXLZX8kpKEiuUwRSAq7ZcGSl8N/jd74eTgHqhzHwiEt7d9sY79avYWdVXiDEg3DULBlCYuW4sh5FprC9WakQHSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnRXa1VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7497C19425;
	Fri, 13 Mar 2026 18:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427531;
	bh=VsdJVy3sTJ50eCmktjm1NaHsn25vDLcl0SM75ClV9Rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bnRXa1VHVvVJD916byi9EspKw1wm50hd014CssWBokfTTHS1RQj/fqei8TbUaoPxg
	 I3LSXNM9UnNvI8m60HKTCnOazhIYR8K78zrs1OYuozI7ANEibH9dtBNWVyZwqRNcpo
	 +0msMrdNWpDZ9gxY4cuoxifKeDHM7BZizx474vAd5IkserERo60ei+nM7m2jRpXR80
	 2zpzOsqrRl3p20fqV7KDoAVgITQUQ8CgIl/XbUib1czO92SJdn5penuSby2I+CDAXY
	 qgfWzl+L2YVoT7ZbVZlPGC4HBq0jex5Z645nswqphtR2ni9uR7Mpcng8fI6vJ1tgef
	 gmSCu+0XuKuwA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Mar 2026 14:45:20 -0400
Subject: [PATCH v2 1/2] nilfs2: fix 64-bit division operations in
 nilfs_bmap_find_target_in_group()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-iino-u64-v2-1-f9abda2464d5@kernel.org>
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
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VsdJVy3sTJ50eCmktjm1NaHsn25vDLcl0SM75ClV9Rc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBptFtHgVz5Ez9M7BPwQSQgBYWYjhduyOwgFLCpY
 DWRyWnpzcmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabRbRwAKCRAADmhBGVaC
 Fbd0EAC63ze4Y0h/N6pFbgd2cBbOYxz2B088CZNe2BUbP6nCDHTiMjMZBD949ZSjLAqHANjmlWl
 A8FjxrrfrtoMY9xC+yKL0wVcosbXxfo6J0+kiJIlINPpXBo72tRLyAPZHE16STU6NRN8VRzWY5S
 +ApvfCBKSKYhm3GlHILWjjdee2MGaqzyVr7psG4WM7A1DVWQzE1RxLuR/shmUih2fi42wN8DUIF
 0+8igziop0SJ75ZLqpXK7IYbCe6mCCyjR4cJxdSYq4yRXb6udacHo2ZuapYkuTAGBpU8XDlPpbq
 rdP/FDAIi2PJbnVr4tnN0lQDnwRx/dYI33OdNL1FsJRiXeG1zusWopJ8kR6fiSNUayixVcsvpi5
 oS1CbRuNzWL9t1HAUwWd20kfofn6914xtln044ygpil9j/Frc5ldXwkMlXfDAUtfrG/ORFobQxV
 LYX8VLsX6O8J8UoeUwHilauukPE1khN7vck+okftq0X6cSMrha5L70zH8ykWjUjp/TLKCJv6USc
 NFr5GAzFSYlKuKRGQnJgh5bhZEf6HSivYH0PlV3Gh6E8z1KR6JzlGP36ZBz7yJiZN8Ug9xHrxlb
 97qIfn/YWt4PBfCUX0BTEAjWjTrbKcv9+4mVZl27WFIulUyyi5FUU5ObM/XIzq5nF/89/8M4DwE
 skgJ2M8X2JKptZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8991-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,kernel.org,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FE49288E2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the change to make inode->i_ino a u64, the build started failing on
32-bit ARM with:

    ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!

Fix this by using the 64-bit division interfaces in
nilfs_bmap_find_target_in_group().

Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier conversions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@intel.com/
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/bmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..abcf5252578ad24f694bfccf525893674bfcb4bc 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct nilfs_bmap *bmap)
 {
 	struct inode *dat = nilfs_bmap_get_dat(bmap);
 	unsigned long entries_per_group = nilfs_palloc_entries_per_group(dat);
-	unsigned long group = bmap->b_inode->i_ino / entries_per_group;
+	unsigned long group;
+	u32 index;
+
+	group = div_u64(bmap->b_inode->i_ino, entries_per_group);
+	div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &index);
 
 	return group * entries_per_group +
-		(bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
-		(entries_per_group / NILFS_BMAP_GROUP_DIV);
+	       index * (entries_per_group / NILFS_BMAP_GROUP_DIV);
 }
 
 static struct lock_class_key nilfs_bmap_dat_lock_key;

-- 
2.53.0


