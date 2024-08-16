Return-Path: <linux-integrity+bounces-3334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05149550D8
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F31F227EB
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DE1C3F29;
	Fri, 16 Aug 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv2DtPzD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515141C37B2;
	Fri, 16 Aug 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832909; cv=none; b=rhOeZocBLHf6uKc4q0gGsKZ8viZ3tv4PJ6DiczQKMVAxSjgvhdWnYIiELO5JKFn0+HytBxU6MQ6AGgiP80h5lrFmwKWzffoYt+FmrrPv+aPEn0ZzQhRQLpGuoUXMBspKQI1IHTz7p2KRS88r2rLDKcOuR+6CEjGwQLzKqtUM3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832909; c=relaxed/simple;
	bh=BZmQl+oxMjUcDLZqoD9zCIUK26RP/PYDWBrw3V5LaCY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GM32Ppub6LE5R42N4DopwdlE/md6agilefwmcL0Jdnb8Mw3jDg27hC08u7TnSdbQ8P8gCvCUyAUTg3lIZMSI2ysgbOojn+58sjHv22nk7Q+iiwm+1xiQaV9XWnmMoJyEsELJxlU45HJVTfIH7m2ArNrYCEEyCoZwW/lJw3ELokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv2DtPzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348C1C32782;
	Fri, 16 Aug 2024 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832909;
	bh=BZmQl+oxMjUcDLZqoD9zCIUK26RP/PYDWBrw3V5LaCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tv2DtPzDxhovDtPtWjmfE3Jdo2Q5fSQH0/TPDU8XzVW3S5LnjEnVXbjqRY0HWFutj
	 5CGBzyCxdaL5BBNarsSrEI/Irfdcv4rZKfpaKPm8jUWCE4rND5F5qqYw62yQL78ba6
	 mhH8hrnx2bP63W4HkAHzbVANfngF71FDanMxPoC2nZy0NCLFUzhwQHv7tXJK2jE/uz
	 TkhiivmVqi730S+uplepkigI43ODgGKDinVDm3wGfoXLpQeVQlvovknZUCE9rZdRO+
	 sws7mBFVLSpcppzE9ANg1Ft5upPWZCVvNxu/avdwWIMDjkpuieq/VUA/2klDQ5B7Wj
	 K+jQdb6uyA9xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C938232A9;
	Fri, 16 Aug 2024 18:28:29 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS-TRUSTED: keys-trusted-next-6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <D3HAJIMUJEVC.154RCMPVU2URD@iki.fi>
References: <D3HAJIMUJEVC.154RCMPVU2URD@iki.fi>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D3HAJIMUJEVC.154RCMPVU2URD@iki.fi>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.11-rc4
X-PR-Tracked-Commit-Id: 0e28bf61a5f9ab30be3f3b4eafb8d097e39446bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1486141ad8e79956e393f9af0ce076a5942e8feb
Message-Id: <172383290829.3597757.3536439627063817366.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:28:28 +0000
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, David
 Gstir <david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 14:14:45 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1486141ad8e79956e393f9af0ce076a5942e8feb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

