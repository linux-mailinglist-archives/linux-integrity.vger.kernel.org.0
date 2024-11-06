Return-Path: <linux-integrity+bounces-4035-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE69BF765
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B7BB22D75
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F920CCC0;
	Wed,  6 Nov 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz8J3he7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3D209F3D;
	Wed,  6 Nov 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921880; cv=none; b=oIPLLIhCGiwwC2AiRAAFEDC1Ual1MMwH8qK4ZEkjMdPVmNxnAeGCRttNpM+nUmBBn/juPQKSRoumvZUNbae34S6h3lCTNpJdev4ayVaKssYrpZa0k7iHacRfeIxUXYqjlG9E7Oge7Zm3T7VaQ1ssaCDxd78TVXb0F74ryb64dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921880; c=relaxed/simple;
	bh=mGlh48tZL1bBGAsoQiwsn0f2h0aoYC2dM7uvbxk8g0I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YuISawkmpygJI3rT9zxjBrmMQYa+JaM8XNjXrYQC+5dfwgPFqmEMwOdzuk/3hd1sPSdqw9+mmrqUh0bDoMo6CYvsBIEAzA66e64yZnvP3hSkg+vFoMuptN+WQPulr6S46/kewtY4FpVWYXnlK9Gn7jYCbmEBs4JixqZYNMnXCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz8J3he7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30549C4CEC6;
	Wed,  6 Nov 2024 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730921880;
	bh=mGlh48tZL1bBGAsoQiwsn0f2h0aoYC2dM7uvbxk8g0I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uz8J3he7YvfKegpVNZ+/uPeuSHgteFmqS9u3eW/4OoHAfeGv/l78pC1hBTshzKyaB
	 E2geQChIqXdAwMkEYijBQqE1gCqekvpCs5EjEe3HPBDY3tCJNY0UIDRnK7qJ7we2VN
	 F56TZwaVRfVmXWDzx4CowMFJCPjuYa0jBUvOyRm3LDj8AonN2FYSGEMT6Flk84N+M5
	 tg+UNHPcCN9Z9t4bg7SpvfcbvFr6+hteRFNqF3hvPOOmXdh9KyUT7xFEyorSgL39vx
	 +jBAX1OegjPs7+uwwJ1WnPvSlnI9EQTijig0MsJFnQtIRtAN9tCDwMLDtnjItAWvxP
	 sW/+XiFH/kYTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710ED3809A80;
	Wed,  6 Nov 2024 19:38:10 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>
References: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.12-rc7
X-PR-Tracked-Commit-Id: 04de7589e0a95167d803ecadd115235ba2c14997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f43b15692129904ccc064180fa2dd796ba3843a5
Message-Id: <173092188900.1393097.2042064650287641436.pr-tracker-bot@kernel.org>
Date: Wed, 06 Nov 2024 19:38:09 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 06 Nov 2024 20:35:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f43b15692129904ccc064180fa2dd796ba3843a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

