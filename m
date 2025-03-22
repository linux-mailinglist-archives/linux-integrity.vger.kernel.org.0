Return-Path: <linux-integrity+bounces-5383-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC5FA6CCDA
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 22:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4696C16E0C5
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18123535E;
	Sat, 22 Mar 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7f21Doe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788023535A;
	Sat, 22 Mar 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679874; cv=none; b=Ec1p7UoVjcLEPZJfTCKvAiK34ULeYtPiANAzQ9FDXmFaC0LiOfq1IOyDzaX5s6Aoe9gJQDmqqfmKO5MnLBGH+Jamd4XxqKF0FuR3ePqRD22GXdkQTPCe3ipYIzdkpzkdsXdgu295Y0LS4GlN9u/uopEE4fa63jU/qYg3R2Aq7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679874; c=relaxed/simple;
	bh=LvCvkuHAdfBLIew0ZN060ISXCtcPvXMO2HArwBEk15A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J1uB8pSYLtf6p56bCMbJGV+P9vYhyCPTiqN/7uzEl1TRQw7A3zlg7IGPfTO8edng9Exr/xVb0UX3iqjB40PDBw8Nn1DddZtQXVvkHkcy5TRMw8hMid5dJeTZV7y4UrFHY4pDENTeI2kURtn2uDRDEm3hhchWd2lU1Axgj2TaOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7f21Doe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DE3C4CEDD;
	Sat, 22 Mar 2025 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742679873;
	bh=LvCvkuHAdfBLIew0ZN060ISXCtcPvXMO2HArwBEk15A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B7f21Doe5gJ+gnKbNUOmUC8yNo1mkOCaJ8aUWc/x3+CwDqB2o/FgYktzp6nPUdToO
	 NJ2y+/4k9rgEXl6UGR8vo0rkxvwCqEz9NyArIwf32EDpLYG+I5KRzvM92ntPRCHtLy
	 eJRyIHrHMa7DRJBL/PMf/SaeFIHzntFkQMF1OoFGl4MOr7F2x+SzMJieAWBfyqrqUJ
	 CJ+d4aOlyNC8TWU3Uh31FJFGkZpySWHo4dEfSXFoweecot070UqHFrTYvfXILq7zST
	 KM344BHg+FFwZDjfjR27Z6n5UAQJqVy1yHvtKfK9R8j/8Aw2nZs6uNQcxxUb5pUTC4
	 Grx6tlGztcHIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3A380665A;
	Sat, 22 Mar 2025 21:45:11 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.14-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <D8N1VMZVITFY.127IEQZN0J9KZ@jarkko-kan-01>
References: <D8N1VMZVITFY.127IEQZN0J9KZ@jarkko-kan-01>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D8N1VMZVITFY.127IEQZN0J9KZ@jarkko-kan-01>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.14-rc8
X-PR-Tracked-Commit-Id: 75845c6c1a64483e9985302793dbf0dfa5f71e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcea541800539899ba0073259cd35d615488a415
Message-Id: <174267990990.2912834.12041174692054631116.pr-tracker-bot@kernel.org>
Date: Sat, 22 Mar 2025 21:45:09 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 22:01:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.14-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcea541800539899ba0073259cd35d615488a415

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

