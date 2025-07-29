Return-Path: <linux-integrity+bounces-6746-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE67B14618
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jul 2025 04:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EF954134E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jul 2025 02:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA761E47B3;
	Tue, 29 Jul 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7mBRrNb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EF20ED;
	Tue, 29 Jul 2025 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755857; cv=none; b=EnoXXmUt+OWHYIjVvJREoR3XzQr9IOeJIT1mgVSwuV4DsL04N/Qw9bQNchQnmm95MAo69C/KHBHaZkleJAxAtPXgN7vLReNTBZQ1JPagv4c5UxtQAPkuZzY3SnCMJRkVg1HIYJ5ZTfuEZaVsMNq8XGR9wQqn1XUndd9PC6fqrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755857; c=relaxed/simple;
	bh=MEl9oiXHuZXLDTCTZQ7vgeP8P/oqPzXqPryDzOxJqVA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L1vh1RcAV5Ezc/wEgYaK47nKnuosxItVUZMfbGfbGT07bSxLvnSphd4Gt8nTZrdIR4UTImCe7O2eiOaZeVQHjkhx2IhTEdZjWr69YfTsXv+Ir4zI7pi1gA3OTdANxjf0bjFx1VnBULOEfdpV+DRlMEDlw+qtRHNiChLzPXGKLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7mBRrNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46C0C4CEE7;
	Tue, 29 Jul 2025 02:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755856;
	bh=MEl9oiXHuZXLDTCTZQ7vgeP8P/oqPzXqPryDzOxJqVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o7mBRrNbDq393cdXvhoKadTzll+l4FFFjrepHAEsNCfKaHN6rhDbeu0CZKZ6erFyJ
	 dSYYC7msQPirX3IyfqsVKaGeRRwL0YyxMZZAWnJT6cyJ678HW+DvBJaoGHtWNj3I4K
	 JEUGhzaJN0UN3iESfeljHn4PL4m+KqS3569/fm8f/rWcDxwoXnAYp7p1m5w+gTneyd
	 yeZS/1wUIhami2Hp9dzAD3V/nDanm9x/Tz/ahpgTHAh1k50NzuMEuPEotGmGkYHuk8
	 ATq84qtRoAh+YWdJEqTuSLbd1xPIadvFu7dUhaiJfG7GMBg/WCWHjKsAdDBobcbovp
	 jkEJy3bvdF+Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC0383BF5F;
	Tue, 29 Jul 2025 02:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIAqX1qFnxUzayTR@kernel.org>
References: <aIAqX1qFnxUzayTR@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIAqX1qFnxUzayTR@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-6.17-rc1
X-PR-Tracked-Commit-Id: 7f0c6675b3194461ad7bb8db1d822445121fb029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d40b59d8b0568769d10ac9b2a97e0af0a39d371
Message-Id: <175375587311.935612.1471229988567269593.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 02:24:33 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Jul 2025 03:18:39 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d40b59d8b0568769d10ac9b2a97e0af0a39d371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

