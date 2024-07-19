Return-Path: <linux-integrity+bounces-3210-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF2937C27
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBBE1C220A1
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549414A630;
	Fri, 19 Jul 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ21i7eK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127114A61E;
	Fri, 19 Jul 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412580; cv=none; b=JWNvSqJno0cOiytdNnvrw4tby3VqcnRkntridrhdonRQHtjB8mn/aKOm6nyfeWnCCvykwWfZsZv61mq+gb735ie7IVOBpa0cWgwKq6PS4/c5/iXWPfcD6UHv1O7cnBoT+s6cjRW5XFTbbop6iC2rqH6g9MtRj4fOqaUR3/QJC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412580; c=relaxed/simple;
	bh=P1Yl3eAUgRP0gXTMeChxQhYlpE5I23QjdR3j1FvwWNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cmmdR5bkpKYwWc1iH3hARQWyx0Vgu5aJXCBYeagtAaZH1FS4xUjuGaYiljXDPfXkU93ngYtWX7N6TwycVv9UGVlBJU+nWJSqIuwJ1k75QAulAt2LogxBN+ldD00hBs2UWi95HqX9GMzQ7nyP1xw6Fm2uHfot3XKj4CH13RxBMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ21i7eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B030C32782;
	Fri, 19 Jul 2024 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721412580;
	bh=P1Yl3eAUgRP0gXTMeChxQhYlpE5I23QjdR3j1FvwWNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DZ21i7eKRQ8IrhwFbkdoBKIw7ULtx5QoEsmFXZw4UyJXRIkWTRZwlQr0f/o54SW5U
	 ysHkyUr1ABqiwnWvoUpOMtNNmKT6iN+WQgtNE8VkFscjwNmk+xT+SF6/xBaZZig3sk
	 9jBXQ8Kwr0bsPF4OFtXBg+2UJQddCPCT74PzoXot1ki2xCHNKf2LHNwTPkl1uiHUf4
	 4e3PB13UeW3LNLkHz45O6LSZ6IDfgjHqQHEfXCpb9voRUqh92Z15HVNIMBJGrO6ZnF
	 EKkiZWzSyNms7MzXutb5EmKfPinrU3v9uE3r8K2iyegFUmaO53Kpwe785iIYCnGkjd
	 ZgcFVhbPfEP5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50577C4332D;
	Fri, 19 Jul 2024 18:09:40 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1-roundtwo
From: pr-tracker-bot@kernel.org
In-Reply-To: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>
References: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc1-roundtwo
X-PR-Tracked-Commit-Id: 7dc357d343f134bf59815ff6098b93503ec8a23b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07e773db19f16f4111795b658c4748da22c927bb
Message-Id: <172141258032.2862.1798136753529017652.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 18:09:40 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 16:11:04 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc1-roundtwo

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07e773db19f16f4111795b658c4748da22c927bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

