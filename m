Return-Path: <linux-integrity+bounces-7369-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2977BB926F
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Oct 2025 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF3E4EA0C5
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Oct 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9201F5851;
	Sat,  4 Oct 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok6c318H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71851F9C1;
	Sat,  4 Oct 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759617035; cv=none; b=qMm3VaCuqmq97BLXB4HAJda5QwZi+SBlOC7SxnI0qxmVM1OScpl99QhnecRamUvKQVaVP93xH5pIkrIRC31UA/7Raay6W9K/jlPgD/wgEVlr7tjyRrsn7JQy25BewJSQjW/RBMCbjqC8Rd9ZP+z45tRmuq5hzEEStMtaq8LUBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759617035; c=relaxed/simple;
	bh=6su20+BdqwvW/ecAtTYRPm1iaoXMOiOOunbJA572ZEk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W+Ag1Dn7GTbr1cnMCINaXlij4CAObm29r7KzqcVllbMDaGAt727VviqYRNSVEbhBmtfQWpYvlbG36bt7wqmu2rnBombyZD/rsiiX8GLjc4Xblpkt40S3tTusNjbiYG6iqkVMnesMIXwbH5kzhKP2O/K5M9o40yQ4W2Ejy1ZOKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok6c318H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B2C4CEF1;
	Sat,  4 Oct 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759617035;
	bh=6su20+BdqwvW/ecAtTYRPm1iaoXMOiOOunbJA572ZEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ok6c318HOETKFfRe4l6RKVtnyqy0v+onVl9PCiCloYVSlB01cI4PGmzQRViYn7C3z
	 wFl1f6e5Au/8EPcnxK1Ya+xB/V+pJyQeQS188LGy/x4Brl3pGvXo0+yDWGpePHIVLX
	 6olQqQrTTfU00os+qfj5opozk1hRA2lj3uzk3EOBImEYFLWvzdHqtSYVURtZBVvdSM
	 PH2TXGD4X7KHtdgH3XguKE0W+jD5C706ENCHUHBaKH/k3Ps6pvvcJwGbUGlBP5y68y
	 Mv6f1iQGD88Jut3C8BdT06G17ZDBhJt0BOUxFPsyeAKE9XE8T9ddHoQ6vR1j/aDN1U
	 naRF9zhxca8dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A4139D0C1A;
	Sat,  4 Oct 2025 22:30:27 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOEzU7dRErEmbUqN@kernel.org>
References: <aOEzU7dRErEmbUqN@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOEzU7dRErEmbUqN@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.18
X-PR-Tracked-Commit-Id: 8be70a8fc667c33e69257a72e8092f07c828241e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4e5bb555594826bb98aaf8bcd9f957f0428cb07
Message-Id: <175961702565.457981.15764054479423302324.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 22:30:25 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Oct 2025 17:46:43 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4e5bb555594826bb98aaf8bcd9f957f0428cb07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

