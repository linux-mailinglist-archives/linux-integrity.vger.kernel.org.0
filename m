Return-Path: <linux-integrity+bounces-4632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A12A1B9EA
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE79418831DC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D17156676;
	Fri, 24 Jan 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJrS6yl+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9C70816;
	Fri, 24 Jan 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734680; cv=none; b=kaz3YvT20+hF+waepbqbI6aNueBCJtOgN5iRDeNC4Gnq8eLz0gksyFKq05INyWfWwT+2gvUC0i22Ewb+kABlnegt13OWOfmz3mDjvXbJ5cuL70vge8u1MhdZQ1A/epQp/EjwjMnswYkpz3M4hRG14xWDWOObKTIPUY6KGkE9Mm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734680; c=relaxed/simple;
	bh=OeiEbT5K8cnDh1TWXoWJBvobV/f43GzaMibGIlZ5IH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hJlXziBM62NgJ3H9jJbkDSfFCp5BkTd8gEoAQIX/xA78picgmzPPX8of/0fyGlGuZ5GBbgZBBJvJhBVQN1U++ktdniFuofXrV6Cts6xRgULjh+9IqgxShWOz8NyzRXPlfo1bAf0HwSeosXbAEFfgocST5/yw6abKS5QB1uQRsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJrS6yl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2366DC4CED2;
	Fri, 24 Jan 2025 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737734680;
	bh=OeiEbT5K8cnDh1TWXoWJBvobV/f43GzaMibGIlZ5IH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MJrS6yl+YWgWkpv/MB/pkMsK48f9svMiHLIK2aTGdG4JrrVfVQsPFCedEoejsqSJj
	 c7P1e3ca96YNF7q67SMr7s7DpVIsDvf9Uknn4YZaIoVht/EizDYW3VdH556nNzOXMT
	 slnnjNaIDOeVctplqx+6sHU7xX6Evq633LkzWhOrvEr/+B6z8vXe0wRTBfZ9+pydvY
	 6kgBrb6B8KP1FK80yGn9Vg3M6CnVZgZYBRJeAZwZlLDYOM8rySYHiNHaRttb1jF2c1
	 ey5RaRpBZkiMxkQ4ajqWwUWSIJDEjwFCp80KbIsjiQFhg//sGWeeNz7zVlzElHaDRP
	 Mxn5shHp5r2KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3490D380AA79;
	Fri, 24 Jan 2025 16:05:06 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D79BYW5LF81P.3S7NLCWK7RAL9@iki.fi>
References: <D79BYW5LF81P.3S7NLCWK7RAL9@iki.fi>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D79BYW5LF81P.3S7NLCWK7RAL9@iki.fi>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.14-rc1
X-PR-Tracked-Commit-Id: a3a860bc0fd6c07332e4911cf9a238d20de90173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae2d4fc540cd27d667d10597b6ad8cc4c6ce622a
Message-Id: <173773470475.2087587.4723226889722538524.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 16:05:04 +0000
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Jan 2025 11:04:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae2d4fc540cd27d667d10597b6ad8cc4c6ce622a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

