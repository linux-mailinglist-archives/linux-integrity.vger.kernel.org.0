Return-Path: <linux-integrity+bounces-5489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8AA75185
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Mar 2025 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C000188D454
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Mar 2025 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2051EDA0C;
	Fri, 28 Mar 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAMivlti"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47B1EB5F8;
	Fri, 28 Mar 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194446; cv=none; b=jf+gnHYau3blpwgEXAmgDRvzDruM5DXX0/9dpX7HnyZfBRsBvEpNt02mX5BAU3YQF0Z3fQ221x01jgP3vdF5HgyItlzyCzWNvBQECb1TfrSfpJu+LoGaFH9ZRXnV3yYbFvos4S8dMYcTNOBxab6dLLcDcewKAI798tyvU1CmZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194446; c=relaxed/simple;
	bh=GqvMIUVQ4zkToklr8mI0g/R9WWzJ89QBy0SHVkSN6Pk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dlz+pf04wXPSPovK7PT5MqG2f5qwmjpcuHTGobYMgCAqgkSy+AVGSLtnYnFrGQyMQwV+jEVP0Zca4XPPk0EbRqxpkE0R3Y7IEtNjHMKZjF3tEgjESgoGmkDrFpEVJcNEWo+0tuUPjEns4BgymK90CFTi5f04ZaQnk8+dkd64nzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAMivlti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BDDC4CEE8;
	Fri, 28 Mar 2025 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194446;
	bh=GqvMIUVQ4zkToklr8mI0g/R9WWzJ89QBy0SHVkSN6Pk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hAMivlti5+SOio8xCvVN/horkh55mLWOaFiW0vA+E8VtNKYnh76FpxuLLhO5EYTPu
	 /OJf1wUOC6DI1bltxIQq2umZoNTAqJHqUvhoWowussYdOKKhIsROxmu+h6VbAA3l5J
	 WteEe13aoLgXxxuxzz9gnqV8xv2gMwdcrTRdmPH30pf6cl3Wl5uAoCnZ5U6Qx/jh2a
	 rh4dR8l4MqhK/nNYvHT0JEdS+Lr6w7MgxJij/kFb20Deb3dajNu3GebJdZ73oZf5Le
	 FTAtwkKQvmFUMYvqIiQVGHx/I7NltybaJfRMEZYO/7cFEOYkNnxwQYeVGpotMQjQZ4
	 nFiDhVDXtudqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFC82380AA79;
	Fri, 28 Mar 2025 20:41:23 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D8R5SUN9YYXG.1RL5OEAJPN0GO@jarkko-kan-01>
References: <D8R5SUN9YYXG.1RL5OEAJPN0GO@jarkko-kan-01>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D8R5SUN9YYXG.1RL5OEAJPN0GO@jarkko-kan-01>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.15-rc1
X-PR-Tracked-Commit-Id: 980a573621ea4b5032123937df0115bdbec6b2de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15cb9a2b66fc623843c68bd508e2731782ae6570
Message-Id: <174319448279.2953471.15797276718391332884.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:22 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 17:38:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15cb9a2b66fc623843c68bd508e2731782ae6570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

