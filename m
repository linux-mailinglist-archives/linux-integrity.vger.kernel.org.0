Return-Path: <linux-integrity+bounces-9006-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDTsONFpuWmZDwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9006-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 15:48:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5371D2AC4A7
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E88A3153791
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB763E51FF;
	Tue, 17 Mar 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZxYgYDn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18D3E3C6E;
	Tue, 17 Mar 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758366; cv=none; b=N7nGp/ZN7l64N1V6D1ZcPJXLjfHLsUzqS9/zfLl5d3qJjVCFASlejUKccIK/go6QaPCI5IQF8sUuREt03UlX9jsGZIOuXd0NEtG+misHlwZFXlSZLXjVAbrru6jBxIFZzQTusN0JnDm20o25DvzuW05UMsfV0wmo4qboEhuF56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758366; c=relaxed/simple;
	bh=PWfE+o5Hz+nic40jQHCKcE3T28Qk2FdkhdgeMe1G7Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGRgxuXc0jIurbPp1m6NpHxpN0NanOjm4+Tu+X0V0r5iOTfLs5IUUrGctyORFt2ifsgw3NL0yBRwIxpZckE/x+R/NQReE97AvgLBla4dkp4WXfmzpPbHrWs3rZeg1Y/ujWiYcia0awWhg405kZiWAIaya08MUXqYi7R+xdzAKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZxYgYDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEAC4CEF7;
	Tue, 17 Mar 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773758366;
	bh=PWfE+o5Hz+nic40jQHCKcE3T28Qk2FdkhdgeMe1G7Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZxYgYDnyUnQJBVCjIKBFtdKrR2n2NDrbhTvaPnowGyWoBVJekeM7cIgG+q1myQN0
	 Q3LaLPEsNuYB0/60IkP+b/ZQc+WFEI/JROmJfRmFVKm3ao+OixC+nKDHQhyeP89YhT
	 mWlJVI0tZhEVv1Ri05KsVEN7QkwB5o9jvOoNmo8+Yb+HJWh6ZUXo1nMf/zo6bOHDC0
	 N2QuhWcAwm0LaRrEMx8DuU9zjtS4kL0cz06zZwAdJ/ToHBt78o33mXZiTrQzuhns8U
	 nmErHEvDg9TEY8zFd2ckWIo+VmPouiHiZwlw8IDAVjJ8+On/NOY0cZs/BML0xNqAuK
	 sBolTqWEqo6kQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 0/2] vfs: follow-on fixes for i_ino widening
Date: Tue, 17 Mar 2026 15:39:13 +0100
Message-ID: <20260317-sinkflug-symmetrie-0f05964e6492@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316-iino-u64-v3-0-d1076b8f7a20@kernel.org>
References: <20260316-iino-u64-v3-0-d1076b8f7a20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=brauner@kernel.org; h=from:subject:message-id; bh=PWfE+o5Hz+nic40jQHCKcE3T28Qk2FdkhdgeMe1G7Jc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuTJ9uts1atzj19PQgX3uBpmW2KeHf5/RMYZrsfYLj3 r+nO3Z2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE+ijDX8mHen/cTkl2SNxT XyElLh3AushE/ufxeHfeSwYHv050EmVkOPteyPUTy+HPZzdsWJh86/sJzo4dvTyPf4Skn1wr+U7 Ykg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9006-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,intel.com,dubeyko.com,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5371D2AC4A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 15:02:21 -0400, Jeff Layton wrote:
> Just some patches to fix follow-on issues reported after the
> inode->i_ino widening series. Christian, could you toss these
> onto the vfs-7.1.kino branch?

Applied to the vfs-7.1.kino branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.kino branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.kino

[1/2] EVM: add comment describing why ino field is still unsigned long
      https://git.kernel.org/vfs/vfs/c/bef5b11087ce
[2/2] nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()
      https://git.kernel.org/vfs/vfs/c/81359c146fba

