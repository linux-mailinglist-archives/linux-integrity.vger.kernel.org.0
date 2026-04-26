Return-Path: <linux-integrity+bounces-9340-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD/9L1xp7mkxtgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9340-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Apr 2026 21:37:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4346AF42
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Apr 2026 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48DC302571C
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Apr 2026 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084938F624;
	Sun, 26 Apr 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbtd1cii"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DABA2D1931;
	Sun, 26 Apr 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232175; cv=none; b=CQLp428nZNCPZShfc+mOfQQg7rr+DdrvO7TgUnSlMX58BISRDgc7PY3uDjvWf1nb0x8yeFQFt9ARPhYdv7AA/GGb7RyDwFcVZwGKE6khGOxs7GrlEVhh0VLGza5Bpv5sLycsjIS1p36crxbiXZAoeZI0QDCGGX1u1nqZ5/1wJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232175; c=relaxed/simple;
	bh=tB7OeQ6KDxkkX71AM0BnZLAiq0rMIjup0yCrI/TbUbk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LM8Vc/1Jv7TTFE/szeYpi/+sECmkz6pQVioNG/1Z990JQpdvVmPhnFLpp0sYMd65zVOVdpEImVEYNX8A46axv0hEakNvMaqcflLY8dvzOCTQSmDHtsxzFj/YzhCserg7E+hOVWFAdaGEOqKUdbl334Jey2sMRJjOzlmsvKBN1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbtd1cii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00297C2BCAF;
	Sun, 26 Apr 2026 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232175;
	bh=tB7OeQ6KDxkkX71AM0BnZLAiq0rMIjup0yCrI/TbUbk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xbtd1ciiGhrXiP2N+9s6+viH3B7XEaHsyu5Ozszj1xBLD0Is9whYkWO+2aK5noYSy
	 8Mk7NebDF6abaGhUm34C0FpG5dtRnr0YplA87/lFRp1f6A2+j0CgqyWn0GtQwJlCbO
	 Nqqs+1MqQ1HXCBiILp5csYAItkD4EoFmkHtxK+pW/xk3nm/JIs4AfxSGmc5YTNr9qu
	 lR5I+Nw2Pr1JFw6jUW1Vkk2Ltqc23MxyunpZUx+V4ZISeuIDFqkNg6QcgZiBKtJtU4
	 1XWMxrrn45J8oEbgmXk16+xTMS+qGGG34jHAYlxKL3ItZEnnvpYQcMILulR0pV806v
	 8a4kY0KrAbMmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6038119E5;
	Sun, 26 Apr 2026 19:35:34 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aezY2QpQiSQvnpCf@kernel.org>
References: <aezY2QpQiSQvnpCf@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aezY2QpQiSQvnpCf@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.1-rc1
X-PR-Tracked-Commit-Id: 949692da7211572fac419b2986b6abc0cd1aeb76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d9f1b5e4374c6b40df1a56b35901312ec98c9af
Message-Id: <177723213336.2364874.8512645158684897088.pr-tracker-bot@kernel.org>
Date: Sun, 26 Apr 2026 19:35:33 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 63E4346AF42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-9340-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The pull request you sent on Sat, 25 Apr 2026 18:08:09 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d9f1b5e4374c6b40df1a56b35901312ec98c9af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

