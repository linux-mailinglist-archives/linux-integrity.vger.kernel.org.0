Return-Path: <linux-integrity+bounces-3028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B3928F84
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 01:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4B1C21A9B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126F1459F7;
	Fri,  5 Jul 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1y1LIDN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAF79F3;
	Fri,  5 Jul 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221898; cv=none; b=IUetKCnfxowUpUJwQFOledpGSpuJNNrZZvADqEnkQ4toEHxWlsPUFOn/4RLmXYEJ4kzRWHl3VEeWUTtp1cL4J5Uk7g6fXH6hI4ARM1zgQ58098ro4TrI2CmQh/0co6rlHPCX7HvTYH6pMnPsPbOt+UaVsvFn4iznBB/wgsi3jqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221898; c=relaxed/simple;
	bh=6dfmR1e/fcU7jwvDaK5WLLj7pfWBbDQpzmEO6uLxl5Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cHDffhr6fKdimSx8J+ocWGUo74b+FBAgfmpDkLovYm0BOH4oxe/PTbaRRipNNptHsmrBF+Sn4bw7D7TQkyst+18W9O274PS9mt9vSFMBbhgFtVBtm4Xlqpt2wk5M5yamyzjCOaFn4TCa1IJlY/4MKxzrYVyU4qR79IhipCpFeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1y1LIDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07BEFC116B1;
	Fri,  5 Jul 2024 23:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720221898;
	bh=6dfmR1e/fcU7jwvDaK5WLLj7pfWBbDQpzmEO6uLxl5Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X1y1LIDNfUe2mR2Zode0Jxmp8U+Oiflq65YH1J1NnwIgrkck/Yqde8tA9LozLhKiF
	 jybXzsyu7z4ck0xB2E7C+rHTA3JzhDxaOH1rDKLkxB7LVfHYTtHp/8iS5slLvWt+Vp
	 25G2PPbzqLlP9yAHfN4rtwjQa1qI0HptJC8XdHlRrmSRjh5p4mFBA+yhNWBtgptFHA
	 WOVTj5HynLlpmnkuQ59T//nx9Nf/dUQZA5bBJWasZWQOpFlzfxtXbsev3mFwzs5tZd
	 bTT7bQT/L+9rfXpzdaZLU+1ag2XSZflf7ayhwe4TgctIvcvesbOBZrlx91pK3C7p/D
	 iMjEYSCdJjj9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0CA4C433A2;
	Fri,  5 Jul 2024 23:24:57 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem update for v6.10-rcX
From: pr-tracker-bot@kernel.org
In-Reply-To: <6b98a933682b443f0c16a4c8b3c5cd6db59d8f17.camel@linux.ibm.com>
References: <6b98a933682b443f0c16a4c8b3c5cd6db59d8f17.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6b98a933682b443f0c16a4c8b3c5cd6db59d8f17.camel@linux.ibm.com>
X-PR-Tracked-Remote: ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10-fix
X-PR-Tracked-Commit-Id: fbf06cee60876d50f259d0689e3c03940750f0d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dd28064d4164a4dc9096fd1a7990d2de15f2bb6
Message-Id: <172022189797.24316.10106089174939986565.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2024 23:24:57 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jul 2024 16:20:22 -0400:

> ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dd28064d4164a4dc9096fd1a7990d2de15f2bb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

