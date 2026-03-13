Return-Path: <linux-integrity+bounces-8989-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCSyBi1btGklmQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8989-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A647288DE4
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81A283011A59
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB33DDDCA;
	Fri, 13 Mar 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6CvaMNe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954073DD525;
	Fri, 13 Mar 2026 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427497; cv=none; b=erOzKmO78l/YhdotMqJZWGR7taK7EK+p78k+RRUOoFqquKWn5z5S+B84/QKVEa0qJ3O8jObN0SLA6Q2DcLTjvwinWKJW8nLD3/NZmVvMxXdeYcGc6R2COKxnAFNvE/bUQxE5bOG0hTg9bw+B+AlbJZQdZVGMF0cZryWhzw6XFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427497; c=relaxed/simple;
	bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SsGSZupL1DaCcvenPPmrv1bcf6RR/BvGMS1ppxw9nEidqs0P8GcZEcNHbjQYUIIFV6uOc6dpbzErU8MIUvcGc1rCiwFnvm4PQk7GxZwQdzV9qbGFEpCHiDkJdwHgioAgCjBKpCsYRb5ijM3wj5icOEZr388HMQkJjj+dl/P7VO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6CvaMNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9133AC19421;
	Fri, 13 Mar 2026 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427497;
	bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
	h=From:Subject:Date:To:Cc:From;
	b=K6CvaMNe+6DBfv2hYIqvCgY8B4lUxNlXpYtVM2pAYE3DvCdV0nWmVjYl9gKnO2tPp
	 QwqxMSPQoez6icBuXj7/tiqfQeK2L9LYUDGozR+d3eWZo2IkD2yWTGVn0QeNQo+799
	 0H4j7I+PRV5BMuz7F6rNyC7C6stJn5wezO+9Lbg1E0PWwW0fADREDCUq0+X+gPkDD3
	 72XeNL1sVWWbStnSlxkbaWrmywVlOqfNDB3CGIL7UE2VU+wWw+OiYC7tuU0d9KNd81
	 dhv8uvrgUvJkn+r2D3xm31vQh5fjvVGn3EeA7HvnsJxyy3NGHuYZfS47M4amdM+bU1
	 rq8PVB3Rsjw3Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] vfs: follow-on fixes for i_ino widening
Date: Fri, 13 Mar 2026 14:44:45 -0400
Message-Id: <20260313-iino-u64-v2-0-ece4cd732ce5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MD3czMvHzdUjMTXRMjk7REU3ODFAtTAyWg8oKi1LTMCrBR0bG1tQC
 vepD1WgAAAA==
X-Change-ID: 20260310-iino-u64-424fa570d850
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBptFsmI1SKEEJiMW9bFqlD31C/H04/oAhO6PkKF
 K+4sjyaijuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabRbJgAKCRAADmhBGVaC
 Fe/GEACD68fMOV0YpR3uPHhP/C3uXxaJ6vFooskpsxErRd6dKYtVQZeAM3gHBkolssuC8d9bsPC
 uU9zA3krHBVr+8QwjHDVamFMsSXlsCp0utu4G+Knx6PEMVq6Vox9PHmBiqxSkjGon6nVtv/XCF7
 qiEJceNa7PqKfJAFtnGaUxfBkC/BmMkygL5YCy9ts8011dFJ5ZBILt2UAuR+90gsNuxDtQpuWqN
 4EMzOs92mAJnLdkmaF2s3IZL+vm7dbQREF72E++pUB7jJoLanPqcs0ReMfMtXuB7RL8DicA0YB4
 j0NHmbXI6wm2mZXF2rBfAhH72p44VDGorwolYRxmv4O4NxoHn3cfM14jIzYqNFEJjaZ6e+94eCD
 rOwj/KqeYuIlxI1Y2c+EFdcwMWk1TLNl7kXdGnUdrkqvLQLa4j3hGR4WfzV5CKl2DV67UJmGHcE
 TbMJcGUiTe1/wcLpJzsVqaulT5HA74FY6bhl0pS594NSiIzDNTXEfOHGzA9YvB67AwZ3TIRxMWJ
 UICBcYJvNKtH45Oovz5kWPS+vYIU0Ar+mDcRBpSeyVq8rZOdQrrCNbMSCFe5gx8vCu6IlDReBrj
 rbjtKIW3chXO693zYFUsQiWlfxuaub/wTJVNVxYunM9gBO2cwP1kLvSGy+9MKkLUbsey7SKd7rL
 gyfjqPQI3eAZ7AA==
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
	TAGGED_FROM(0.00)[bounces-8989-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A647288DE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just some patches to fix follow-on issues reported after the
inode->i_ino widening series. Christian, could you toss these
onto the vfs-7.1.kino branch?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- rename variable in nilfs2 patch from "rem" to "index"
- reword comment and commit log for better accuracy in EVM patch

---
Jeff Layton (2):
      nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()
      EVM: add comment describing why ino field is still unsigned long

 fs/nilfs2/bmap.c                    | 9 ++++++---
 security/integrity/evm/evm_crypto.c | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 9840bb66e7e5dffd72b03201318f154a10b06b4a
change-id: 20260310-iino-u64-424fa570d850

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


