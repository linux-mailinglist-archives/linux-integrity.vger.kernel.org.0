Return-Path: <linux-integrity+bounces-8990-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IvzLk5btGklmQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8990-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:34 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9A288E08
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51E70300D6A9
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCB367F5B;
	Fri, 13 Mar 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUiETtrr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D9282F34;
	Fri, 13 Mar 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427530; cv=none; b=abhZHETUq+2etr/HpzUECWkKSQIKs0+2EAmS6+xLyTcsCTk4sezGedpvz9z5op8SwnDxdO1Y5VV+VXFoo9879AukMyVDXjlsejTNAbELausvYDoYazbDEEUnujIASeHdYQdzrt9Y7dvhPbS8EJdyYx97sru9h9RA8GonUDeGkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427530; c=relaxed/simple;
	bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NEhLi9bwtur6jTQe38Ozqw8n90bou6yQWMutTyAA9QPEwhVhAqDSZ26AfXEfNPl88yB8slbwYlAsQYW3kBu46N2tJoKQ4Ea5GPS0GAxx413T8Xfg1YFZ9q6X1Y1JBxfgUKmH9VUFLXxJcFO/yRn2mjYvSuYQZ2PLNfr3itzCLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUiETtrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14610C19421;
	Fri, 13 Mar 2026 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427529;
	bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
	h=From:Subject:Date:To:Cc:From;
	b=hUiETtrrFfX4JAKcTWG3F8Z8UBwRtf6N8idyaIzzA/hDLr7YmaQ1rwXLOeKerUErU
	 o7ihXjHOkSioKhz+HsZvB84nud2SnNgH5j6Aj1lCNSd/1D7puG1i+YgwqWgJtAIjCN
	 uoldK+NsH+ZroFbEmtUQ6DF3CtTxW93tvZaw6ubyYlbvJFZuhOiVdwehF39ffpLMqm
	 KF5ezxpK97XxtcHBbPSzq/LOWtuqCdBP0w7qn0YoIlM/IBE9rrhLPLzmJxhQO1rKtm
	 l3uWABkj7lu+qXHSLzwWvaKxaEcVWwHGZspybBw4Angl3KwQwo/rZDq3yChMVsx9gh
	 vdo4I7NMtQp8A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] vfs: follow-on fixes for i_ino widening
Date: Fri, 13 Mar 2026 14:45:19 -0400
Message-Id: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
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
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c52ecjXBNfvaBKWieos3LwfN7UI3qdeME6FQS5bMFnA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBptFtHOq+53GJDkKSQmUySnoTsOP8I9NGhDGTXT
 SqXyGyThi+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabRbRwAKCRAADmhBGVaC
 FehfEACaYWy6Fg1TQ4WM0cowZrX6VqAX5hLGaACrTj3wA4+25+yxB2QGS00DlFcroyBfKLvjVYJ
 sJAkl5UudZc4gdgeFABLL9sHKbqvertwVA8oYwBdlJ/t14o4zpZ488j6psgSnhES67yvzA1Mkz8
 2hZpTOoswcGNQCXWfcts7vZictZPWRXxNfm4rmBGfnLSg+3wKS3fSmcfjhgsdDcQ0wkjFLdzZGE
 jkFmlitsEMLWVbGzccWTA4td8XdAPB9xOYqxC9P1IS9LZt2K4VjlqV9eEwlPmquPpGy7CJ0UiHw
 uXv6z3Q+C3rscpWpaJISeitsb4RPJX172QjoINhDO5aPBov+FlUY5PHPB6sp69yJ0Iwmxr3yeDM
 tfP6hUfDptdIqW4Qio80yzb9pVuzWki/9kswh8of6cP+h+Ucg1aMjED6/39NmcQRjqmz01GI9JO
 /NXBBRJ7yI/MdTP1zCmV23G8L8t6onIbTlWH2c37eQyGoiTYEgv3JtjOOpzMHBF9ezx256VK/c3
 2D64/rG+OpHy1xX0xzvfZZgKyjv+QoW9HSlqBNkYI/mwlCiPJAJk9RbNj+KkDHiBxQGgKQuexWT
 JQC3Lw7zt0SPJxbqjxouWhBhWhU5s4z+HquLoFbZ2M2KqtDmuT4rg6TpPqOp74t0k9CQxFHgLqM
 R2tSturqFGdalrQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8990-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CF9A288E08
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


