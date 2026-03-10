Return-Path: <linux-integrity+bounces-8956-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGR0OIQFsGlregIAu9opvQ
	(envelope-from <linux-integrity+bounces-8956-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:50:28 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B924BA18
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8ED3193E6B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC238A71A;
	Tue, 10 Mar 2026 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alvrUb1R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632E389E1D;
	Tue, 10 Mar 2026 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143051; cv=none; b=OIyCehuGI4m+9yiLcMpZcnJYk7FiqKu4HvmavU/KDO6C0IlpaZkFKjEDTAY1ASVDOnO78VWupVXfItMNnWnt/MybIWxoqvUqh5IE3p8IeL9vsbztQX3Irg+Ju+u6I9jQkrRu2YjUwh9H3Qv48Nz8qmVLO6fERrx+k5Hz/0eh7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143051; c=relaxed/simple;
	bh=sGoyfhJXaG3l97G0c5w+wareb8CwaOtWbLOdJuvcSW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qDgYL+ijSq1iofCA9ZpevWt498jl/69BcMleoXG8rUnfebbWmZFnZZsoSj0o9VIgUJcr3crmS26hkeAIXzqIWKUdXiOW8koacsVd8oIpVc+5p5p1FRWzgZWWRTkRDx5bk71dqd8n1PMPXOcsxpbbLwvYNUMM2abg0pAokK8T148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alvrUb1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146A6C2BC9E;
	Tue, 10 Mar 2026 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773143051;
	bh=sGoyfhJXaG3l97G0c5w+wareb8CwaOtWbLOdJuvcSW0=;
	h=From:Subject:Date:To:Cc:From;
	b=alvrUb1RUJEhtu16Vv+3D49jxAOqxKhKgmOPWtPirUHXK4WMSlnon6zrL2aBtjDCS
	 D5F9TulnwBdlvO7D2HngldYgnwwtlfB/HbeJOfZ67403EDTEqQHE0WBou6fYrIUO0l
	 JNKqaqyoW04qByvVMBpUo+R7T0+ji9G9JrddTkkVRP9k39MH4tjpIwCgg2CgyZWze1
	 iizTBuN3+aRVZWX92SakiMPiiePH5qOqGRIp0KZfbpA7V2B3p3Wf9/ET4tLQlvvKxx
	 B01yxJQdwFL+6ErAxhF1IVSwKaMagNnZ7O8G919RmRYaGcGqIaiUiOjqm5GitaL2Cj
	 lvxg6ssuSEnog==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] vfs: follow-on fixes for i_ino widening
Date: Tue, 10 Mar 2026 07:43:43 -0400
Message-Id: <20260310-iino-u64-v1-0-18422a053b04@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MD3czMvHzdUjMTXRMjk7REU3ODFAtTAyWg8oKi1LTMCrBR0bG1tQC
 OjaovWgAAAA==
X-Change-ID: 20260310-iino-u64-424fa570d850
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sGoyfhJXaG3l97G0c5w+wareb8CwaOtWbLOdJuvcSW0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpsAQESYZlN6VQX/WLeVeCxxpqK4vMsdfAikVas
 k8WgHWsII+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabAEBAAKCRAADmhBGVaC
 FR3+EACxCohDUCAjxY/X1tMH3yX/WBoCddrQAePlwpH4Uj/A9QWIIWr4oUzf0ki0Nz+xUlRYy5N
 omtC4nWSf/1EgaoKHiVYm5w7SsY8gA1mk33hNzCeQG+qMv9iP/+AHqVmbLmUwNwgbwfQo2sZ4ta
 4WNZAEoGpHwe0lpenXxRinG2VxiCqSjt9OAWVyLbzy4tiTneRfYqoOvHoAOp8OwwAAHIPk2JgWX
 vIdYe89w0oC/Fc2GUklJhwGxbjD6ZwIskJD2+ekE9Dwp0a6S6mS4tGdftJJDRcNFyXvMwvCXImo
 LS9ocEk92gcQFD1atU9NG9g9rWsBBuEglsq1q1epTifiSaKJxfe/0l2pwK1RJ9NumNZX1rP2P0c
 8rXtJkD45jOMgW62oJ0DiQ5uGPjKTk/KG8FrZjCSqFDhhc/0zkv7Zb3QWi+0R6oJ34ISYNqCrtA
 ext9zY9qzpcejkK4KwfMECTm8sErLpWql34m9BERk6uqoZpsmeMGOiNAFXyW6tw98kdPkA2CIYg
 Zu580tMeD+nO8eFl4UscUzZ+gNoERgdHDqn/dVswq8pvqkOhA2hAPuBuStRR8Hn6MpqV/7fHEUu
 O/qQA1hWQsW0Jr9yrpyYgVI7PtFkhi61okb+ZhUwf9teDYRtsSibyuoQYWeM572VH0psnIuiC5s
 umLVsDFAt9Ab8KQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 386B924BA18
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8956-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Just some patches to fix follow-on issues reported after the
inode->i_ino widening series. Christian, please toss these onto
vfs-7.1.kino, assuming they pass review.

Thanks,
Jeff

Signed-off-by: Jeff Layton <jlayton@kernel.org>
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


