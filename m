Return-Path: <linux-integrity+bounces-3687-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8607984AA7
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB85B246A7
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF891AD9CB;
	Tue, 24 Sep 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q66543lY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7E1AD9C9;
	Tue, 24 Sep 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201052; cv=none; b=e8pe69qs6dfJzIPKaC8Zc81pljYHfkwZjfLTYtvCcyFGxD3O6icByFZsK6voHnfnaYDeTev6OBLbZzYZlQwe/eborPS2GmPDXINiB7cwPfEF3A5FQE5qyIa9yDFPuOV7uk3LK2r668rDbw7mGcMYOkELLNBurED3nj6j6LmCXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201052; c=relaxed/simple;
	bh=KA/eAwSEvG9s3WZSHQx6hXU1I0DvlMMxCEpt+wMcoiA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TJvg9kl5YCNjGNXG5TROVBG8drrncGtknwEjKCxJMgrawSF264S45yirQU2Emh5HP4gLu/A1yFIwR+z+KXiUnjWvCX3SXQSNnyItUHzpvnRXLYbrZZljSUD3RLjUBOeF2gcrekI01qsXvFu5T67DIeb2YVk2SpgvVtnN3VieiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q66543lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F108C4CEC4;
	Tue, 24 Sep 2024 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201052;
	bh=KA/eAwSEvG9s3WZSHQx6hXU1I0DvlMMxCEpt+wMcoiA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q66543lY7/bc1Q2yDU0yPb+aBdAiGEIrIm4/KExspr4uujffrckhspdc3HbxXC/Nq
	 QE+41IVYc7GfpI9Bf5honClUKOITdKaAtOl1x1ApNSjFvdmIp1+YY2vQ9gwjFB+KZ7
	 dN7ivy0eSolr1HbqRCbBitOE/De+WgWSzNJ64KiHvF6p5FxpZjYyCYVkTeKQal4w6a
	 OASf/qKnVZtnAKPyesBmVpIYPR74vgF+DP5XPoP+8wuba00agqHiL3JDvINj1Ur0XM
	 oSFL3vAh7EcfQhPe8Wz0WRnyljAD4HLuZbH1LoajvsSNg6Pq8TJk+pXD9HOZB8IUgl
	 7aEtL5ZC6ngVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE23806656;
	Tue, 24 Sep 2024 18:04:15 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D4B9WXZC9B9U.34I6BHWMYXOS2@kernel.org>
References: <D4B9WXZC9B9U.34I6BHWMYXOS2@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D4B9WXZC9B9U.34I6BHWMYXOS2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.12-rc1
X-PR-Tracked-Commit-Id: 558bdc45dfb2669e1741384a0c80be9c82fa052c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f772dec31591f9268a9c9e4943dc5dc47eaf9b
Message-Id: <172720105452.4145686.2130527786218091204.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:04:14 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Sep 2024 20:05:14 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f772dec31591f9268a9c9e4943dc5dc47eaf9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

