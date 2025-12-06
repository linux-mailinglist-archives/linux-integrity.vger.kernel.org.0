Return-Path: <linux-integrity+bounces-7828-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF5CAA184
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 06:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0199300E784
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 05:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274982C3271;
	Sat,  6 Dec 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im3si2pS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB02C2368;
	Sat,  6 Dec 2025 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764999909; cv=none; b=K0eVZRI1oJ/0FfzEqqkTn9xatYHQPfGXLaDd6gYqiHPTbZwuRaZVxW7bTAtSjIsDvMNnXhDEgrw9SfErJkwfM2LYH+SyxbG2NZmRMuvJ2cRnmtl2nI135Gvl7kVrUW6B2nsSyIeJOmhNCV6ZD+zVnXDLPgxiwiSRmvZal8zETpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764999909; c=relaxed/simple;
	bh=geLQ8ipD89qLYuQop4Ne1NSIFzq+xZt4ReGllwK5zIQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OGIHNyiOw28Ot+lr21KJJ5Bdd6RYcqmk/BfDH02S8tPFgtOS7jMulnxg90m1JP84qSOsr0V1MSZri8aQxWMNJamz0r3TLyW+F4EKRlA4KkMRkU2mhWORGKx+TfeEUh0whfH0yXNW/nwAwnv1K3anZ8ZtDUdkWWTYb7Cya1Z13xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im3si2pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA5BC4CEF5;
	Sat,  6 Dec 2025 05:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764999907;
	bh=geLQ8ipD89qLYuQop4Ne1NSIFzq+xZt4ReGllwK5zIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=im3si2pSSqD8fRFLfw5fFvf87xdSx+98vWEi08NEaDb6eIkatJI0H/kVayNwEEIP8
	 evw6GfxEPdGUj1Dgy4DiFN/6tESDQD4Z/BJ7oF5+nwgvntW+qzBU6gY+PYSmY+bEku
	 B3CjtUNBAc+nYb4A6S5xFZQ1uElarOCtFlILpkJE93Mm947Mz2kQ173hUvF3qdH7TT
	 bPPXElGLcnTvYCabf3cJXB4QpNvOWIEunTyve6mV1dgBBdQKgm8SiNGj9weCFnzkX2
	 FN4EmSaN/+WrhUfIZI1mhTn95Zmsljo2aiRoUww4QMoDRR9NMZnrT/w0E1WuYVWbOW
	 z3/Hshenoz72Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F387E3808200;
	Sat,  6 Dec 2025 05:42:05 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-sessions-next-6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTJy3xx3DEFS5Gr-@kernel.org>
References: <aTJy3xx3DEFS5Gr-@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <aTJy3xx3DEFS5Gr-@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-sessions-next-6.19-rc1
X-PR-Tracked-Commit-Id: b7960b90486139022d2d39caad90db252c469bab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 001eefb503901603de48b8dcaf06155036ed7452
Message-Id: <176499972457.1994707.15453342240901524903.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 05:42:04 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Dec 2025 07:51:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-sessions-next-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/001eefb503901603de48b8dcaf06155036ed7452

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

