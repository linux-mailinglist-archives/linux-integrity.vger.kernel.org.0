Return-Path: <linux-integrity+bounces-9826-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMcqMDWrOmrQDAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9826-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 17:50:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E66B8703
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 17:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k5bpv2l6;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9826-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9826-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25861317549A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7422EBDFA;
	Tue, 23 Jun 2026 15:40:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27862DF3D1;
	Tue, 23 Jun 2026 15:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229248; cv=none; b=ICs15PIhCodVosmcaGXMV0CE1NkvI3MZiNpqkUVBng44uOy6jb1b+a+FOR0P67GHmCmegBOtvLunOPG8Y8NhZI2LHIJhG3mNQVGM86FKdW2i39UZESMoLvWJ7RMi9J8ptKkZXl5HFAE889evZ6LwFpriuoYtdEZPMn5F1uD5MdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229248; c=relaxed/simple;
	bh=pt860OH5AR6ZKdljKEMygXqw/2q2D1hmbbqO7RLzuL0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mBMTY/yA2ST/fJKSbVgXvFlerRyPRv8nuLPcwQ1utm7suMjN7JEv19RbCXJaAAZAieeKQLwtKadSjRiCeRAN5jD6x5tWp7oyb8esfwv++gx4IX2IRQLbjYDJFPN/bJefheWQp+bRIzOzWK+GaSdMulpMFCU+DO8gHczzhzDcirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5bpv2l6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9771F000E9;
	Tue, 23 Jun 2026 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229247;
	bh=8++o3UlhYjCRomaPFfXNVU9p520aUgRcPkwLbZixhh8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=k5bpv2l6+KpAjxdzxrdJ/EBl8cYgh0fCyjoVXZlpPXq1AmkrGhKyB+rgiUGdOduk1
	 JdmK+yvqkdRDi1SJzNhcULBV9XdbQzVpx8dDVEf8V/Kl8GXef/6r6BrrszaQnOjCWv
	 8dvUVNpvFPzTejASt7MWKZxcUKHdbqYaQnVzZGy5a1glUn/ld285fbDyVCPyyTv2w5
	 a4x5cZyQwq4UJQOpA9XaYHyKbcGjxCUW+Z2a9McxVmTQMfN7qtmhW05xwZUDq86xjh
	 kKslnN6PT+w8CUDzMiZz1bdhEsuHTwFRmGP9Gif/J0URsb9ef6lwbAPkEZvCI5ORQ/
	 mvCB+blWYD6UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ADA3930E57;
	Tue, 23 Jun 2026 15:40:37 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.2-rc1-fixed
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajlVR8okpQirKw5-@kernel.org>
References: <ajlVR8okpQirKw5-@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajlVR8okpQirKw5-@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.2-rc1-fixed
X-PR-Tracked-Commit-Id: 1a58f6115bfb34eabcc7de8a3a9745b219179781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16b2087efdddd0bf042accdbdcc8eedc21bf9227
Message-Id: <178222923646.2291728.13119683741727809136.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jun 2026 15:40:36 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9826-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:torvalds@linux-foundation.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:dhowells@redhat.com,m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 202E66B8703

The pull request you sent on Mon, 22 Jun 2026 18:31:19 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.2-rc1-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16b2087efdddd0bf042accdbdcc8eedc21bf9227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

