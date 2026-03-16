Return-Path: <linux-integrity+bounces-8999-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AhCIm9UuGmKcAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8999-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:05:19 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9429F7C8
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 20:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61C53309D1A1
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF733C198;
	Mon, 16 Mar 2026 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR+H/ft8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE30313E18;
	Mon, 16 Mar 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687763; cv=none; b=J7GaGIe+NrDKwDcHEAaeApRKrAHJ5eRnnTjAHw1bvRjxg+64gRqKTpfDI8uqC+NLrtbOkIvIyqZZgaOE1hVGQxWbzhVwQ4/xXx1Pxqt1YjVzmxnQc1VMpIr6v6EXa/fetA16NPoypjU6aUzudlXTr48xQLgy3LluGdM/YM6wfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687763; c=relaxed/simple;
	bh=ZyeZEtzWm5fF5TgpvnnaurxIwCKgenFpc6X+Sz5xTeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bIsU+8nt84sMAVJdJmCn4H6foE45Rsbm9XR5w8pFRsT/jLamgsffHKmpEyxaYMwvOTFEXZ1QSIdA6dYbUu0CTYryUyczjTK97RoUWGj/441DQnlhA4MHMJzauT82omIr96I+mB5vZU2eThO0mGVY6g6skYjAXzbV9TKLrxZacZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR+H/ft8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327F1C19421;
	Mon, 16 Mar 2026 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687762;
	bh=ZyeZEtzWm5fF5TgpvnnaurxIwCKgenFpc6X+Sz5xTeQ=;
	h=From:Subject:Date:To:Cc:From;
	b=tR+H/ft8eYc/WsxAeOIQqP5RVfjXT7WoDaxZwtW/DNsQGUKgoGNtlMj5lD+/CA0R+
	 SWmFVv0Iuc/YM/+i1iVxgevIMXE7lLfWkZjb+kl1kn9uNkRK99lWhXLpInQiq9QcT2
	 bPPMK07uzMMLSak9hUIJUmD6PgiC20dc0n3wBbgNly5jO24PGPcldiD5etESXGUif7
	 UVQ+z8jCgE1kRkFSoWbS3BL+/sPnAWe95CbEn5vL2PK8sFDxu/c2rSRRNy84CpYC/4
	 DbI72IW0yacupMsWWqi3JUcps1V3eAilKZMW2lVu3gDtlUVAJIfrBXQDX/5615IR9j
	 9uCJx1N9dOxVA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] vfs: follow-on fixes for i_ino widening
Date: Mon, 16 Mar 2026 15:02:21 -0400
Message-Id: <20260316-iino-u64-v3-0-d1076b8f7a20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMyw7CIBCF4VdpZi1mBIqXle9hukAZ2okGDCjRN
 Ly72MS4/E9OvhkyJaYMh26GRIUzx9BCrTq4TDaMJNi1BonSoNqgYA5RPI0WWmpv+y26XY/Q7vd
 Enl8LdRpaT5wfMb0Xucjv+kPUHylSoPB7e3ZWaqNdf7xSCnRbxzTCUGv9AAuUoYShAAAA
X-Change-ID: 20260310-iino-u64-424fa570d850
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZyeZEtzWm5fF5TgpvnnaurxIwCKgenFpc6X+Sz5xTeQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuFPKpPHQ4lp736L/4vx/yO0EJl7vQADORozB0
 BSp4oTQFaeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabhTygAKCRAADmhBGVaC
 FQcCD/0ab438BecykP01JfZcNQganygQOIyCPvxymFXyJ+cJ2GIru1mqmQWFRNbDQl9pBTqnkO1
 g+KGajB5WMc+xep5kwyrFcImSg4F+Plz9T6HKh/KLbJ/9fJkp6RUGvj3JH/bLhSdduRmCs8ZB29
 1+h5JKu8Cs96Emx8ksO/k+ZITFHL1DccmV83V0/MgEOhHr0AZR1KFJ/KN6ILRh8tn3o8REf6zSS
 +EoyN9tFS2xVY0W+TBpR5XNd8sEMdsDSuERtwNYTqwiCPNwvGR6Em7P4oSJSYXGpXQa9jIrCqnS
 yFroXHTW232o4FmrJsaFEW9G8JTTPDvz0WlDE44K0DTbd9u/ooBcF/WhXqWnpUecSK6mQSCwtQH
 CjNU7MZhcJIewE/+BWYsHOb1gtwIKkANK2pYgBAQvJIfra/IFf2TlgOFsx5XRynIVAkJ16cfaks
 1GVGXbne83jVAsxt19k1QbWctUuhWonvobwl6ZoraK7ovZr2mdmrhuhdI0aB8fpq5YsV9+IV+AN
 vsaUZ7T8oEGqOceEGtIEvtNU2EYVxsYvpzcnzsYsQxN4N6wL08lMrZptbMrzBu3RrWpgJrxWv8k
 vKX9D3Hhss6Tw40AqxAbrQ8CYFDloa9zoaM/mAWwBXw5SOthNaCiJ8nBvq0u32LollHRwKMG8gA
 L7PPXbw2GCvotQA==
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
	TAGGED_FROM(0.00)[bounces-8999-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31A9429F7C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just some patches to fix follow-on issues reported after the
inode->i_ino widening series. Christian, could you toss these
onto the vfs-7.1.kino branch?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- nilfs2: find index with bitwise & operation instead of div_u64_rem()
- add compile-time assertion that NILFS_BMAP_GROUP_DIV is power of two
- Link to v2: https://lore.kernel.org/r/20260313-iino-u64-v2-0-f9abda2464d5@kernel.org

Changes in v2:
- rename variable in nilfs2 patch from "rem" to "index"
- reword comment and commit log for better accuracy in EVM patch

---
Jeff Layton (2):
      EVM: add comment describing why ino field is still unsigned long
      nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()

 fs/nilfs2/bmap.c                    | 15 +++++++++++----
 security/integrity/evm/evm_crypto.c |  6 ++++++
 2 files changed, 17 insertions(+), 4 deletions(-)
---
base-commit: 9840bb66e7e5dffd72b03201318f154a10b06b4a
change-id: 20260310-iino-u64-424fa570d850

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


