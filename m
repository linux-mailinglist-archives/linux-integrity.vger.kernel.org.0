Return-Path: <linux-integrity+bounces-2378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BCC8C467B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 19:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8431FB2190E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A14249F5;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUVDU8bh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E22C1A0;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622651; cv=none; b=oVctUpar5ae1KeY1LnEvfbpRpC5QFxLrphM6mV0bbA1z5GT8LbbR+Kv6VD5iQzNq04y6fNHRFf+4PY/S2cv/2n78hpfO1Sw9+2kV4IRBE1VIHU7WxDbT46ylNhr/btFEl/skJ6EO38MjAdgU/PcBXZMYt5Frq9qVyvl4sAHrJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622651; c=relaxed/simple;
	bh=sorOqKKQzlPlj81aXlKqUF4fhbygrU4LdHfsRxZb6ps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bEveujnUdDJ0S6YpaPMRs+0/70sNAw7T+5Mv9LWm5sP1znXWw3d8FjYYwCHYA7bQNs8Qzueqjn+RjMzTZfjXMFUiAeGUXh6olpJkG/HH9CFse9nYX6IFH64uPCa2AoYDJshAdpHHOEcaO2udoi/3GBzLyJ+P45XPJH0KH4NZ8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUVDU8bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0969AC113CC;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622651;
	bh=sorOqKKQzlPlj81aXlKqUF4fhbygrU4LdHfsRxZb6ps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oUVDU8bh4VukF++5TWp31mmmpbNqtplFwlqd63ViwgiZd4WSJranGYL9hlZsw+dov
	 q15dr0J9a0FroZleM0C+s4yXEmkJ2YEETx++9sb5ZTgaG40lj58e+maMoNO7SvdqVC
	 g2K9QQyVobUseL72bcf7H4KBgdxoCXmRo2DR8MAfWnpxc1tfvacuDN9YIIcEYhtk1M
	 Wrt07QfpywtHxFpJHEo9ucERFWHcSR0AQxHUmvKDSLwHyPRSoaCB8GTwn6MY1CMNkl
	 TpNhdOqBKJ36tNuGxHjYHxBjz93WAAvAGLIELgSoXdKD0B3MvQUV61GwtPJWKRJE8u
	 HJzf/z1i7oMyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02041C433E9;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Subject: Re: [GIT PULL] keys changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240509142517.2787-1-jarkko@kernel.org>
References: <20240509142517.2787-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240509142517.2787-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.10-rc1
X-PR-Tracked-Commit-Id: 9da27fb65a14c18efd4473e2e82b76b53ba60252
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25c73642cc5baea5b91bbb9b1f5fcd93672bfa08
Message-Id: <171562265100.10937.11267638500736998467.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:50:51 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 May 2024 17:25:17 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25c73642cc5baea5b91bbb9b1f5fcd93672bfa08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

