Return-Path: <linux-integrity+bounces-7785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5ACA16C0
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 20:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40101301FA55
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8456327C0A;
	Wed,  3 Dec 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjnU2TIC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAE3081DF;
	Wed,  3 Dec 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790521; cv=none; b=J4INqhsTu4sVD4b5gn9tzeKGaeRKThsKyUWXER3PsRfOnXAr4CfJqiAQQNChKCSiV6DsLiHF4O1/6DYSDhpLxcxgzrEKEDAfifM2XoFrvckOBppntGqcATJGo8C4qA3LlWetKqLAs8iHp7yvMegBJ3LP0O0+C574s3uRSCQYMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790521; c=relaxed/simple;
	bh=Z7EPNFCKzzdgki7rX/jE9I8UKoxXloxYyiw3SH6f7xo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nckc0g5+yznVk+8vIDDoV+0hjZSWWsYZZfh2nNKmcyA53oShtua/EUyA1BetUFB89qhbbBQNrqBR0x9sQuv9Ecnl6Il/U/M3QzlRo1TJhXZW2UsxQtiKB0oQGZitJSkq7YDm53G3Ey5W3rCW88ESLVduDXjWTINTvTsuBPhOXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjnU2TIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8F6C19422;
	Wed,  3 Dec 2025 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790520;
	bh=Z7EPNFCKzzdgki7rX/jE9I8UKoxXloxYyiw3SH6f7xo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FjnU2TICT3qhox+0STY451bSsLNJOycywo8V9RRqafiFTqeLVOaaB0tFWd4gZib+X
	 iiQSGKdGJP/NsxCtSfl6eW5u9BcnyprY9rb4ABYMXw+ephsmsAnZeEHU0bB51ulK6x
	 /jmMyiRawGOISCD+HrVlVCFvE+pTKqFIwS1fobdWDFsYNX9YGQSibZOlfDUJvnZwJ7
	 MfWvqU/Tn2wMoGGe1dM/ugnxJXsLHN3Ex5/9XdazBDXu+4Gvia86MA07cdEmCyNOjJ
	 ndLetxRycvgwOQH8e1YErksEyjVGp8hgkT0+AfvfpZk7c9636u89xOpNscwkcq2whw
	 BYtGhzqqccpZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B579C3AA943C;
	Wed,  3 Dec 2025 19:32:20 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: trusted: keys-trusted-next-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aSthHCovbsDZANsa@kernel.org>
References: <aSthHCovbsDZANsa@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aSthHCovbsDZANsa@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-rc1
X-PR-Tracked-Commit-Id: 62cd5d480b9762ce70d720a81fa5b373052ae05f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fc2cd2e4b398c57c9cf961cfea05eadbf34c05c
Message-Id: <176479033930.47894.2322560066179937956.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:19 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Nov 2025 23:09:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fc2cd2e4b398c57c9cf961cfea05eadbf34c05c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

