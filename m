Return-Path: <linux-integrity+bounces-2680-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD928D2304
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A415282B98
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A5046453;
	Tue, 28 May 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZehXwJGn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E344C7E;
	Tue, 28 May 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919709; cv=none; b=S0NCbskqMWn2Yq9Q/XOflJymD9k6PvPhZcWyfi1a7+xNOSnzVwv6wCOdGPehDHz4cZKXKj1OKZnk6m8gNqs8/ii+0VW48nPbAuZe9FlOH0Iv8y4jdTF99TeiKHz8tRWN7HdCiyp5P6ke5dcucIKzM4epfJRo9jp16plFCXIU9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919709; c=relaxed/simple;
	bh=qutGtXlBBsoU7wl92LYM/FW0hv77cewPFSMdJsPOEbY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cFJRMBmkt19Grmbjiylr+uPFU3g4IjbXSpAVywjLC/8GJ0pSwqnCRnwygbl72HSYnldu1Qi0aGfV8M5OaFCK1IbUK7nlcYCASlGq6XPNLKXXnoHLPsIPDwxbzLztgixos2PWKfgl9h94Mi8pKwBisobomLNVMLT6h7Mf6q4yyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZehXwJGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E482C3277B;
	Tue, 28 May 2024 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716919709;
	bh=qutGtXlBBsoU7wl92LYM/FW0hv77cewPFSMdJsPOEbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZehXwJGn5KBpGyL/G4cBqKc2I44eTdwRusm9y21z2P0sJbeyqN05kedFjmhx0de0A
	 c3jjhqCmlBSz7w9uVAsbynvrhAny8TvfOgweAvLdKu6lSti/I2sWiRjfNmE1EmbxRS
	 16g3DSELXEuBdzUiV7FLD0SPI7JaENcUvl3+uqTQwBmfCjB2l1z6CJ4+Pbs+PJJvTw
	 ogGLfSFmjtOZGxuKE9uX+IkQinKJ2b/v7zEy4Uue/1cweCC21bwpu/gB5yL/a0iDHY
	 CO0gHwpRQdL7CT0sIHiLwmHrpqSYjnviz3RpwkFP6NFKzynweDS/5bJ+jvBVZE7rNo
	 aDzUOTZPyl2GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 246CDC4361C;
	Tue, 28 May 2024 18:08:29 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <D1L7GV7M5K0E.2OPVM82VLFT10@kernel.org>
References: <D1L7GV7M5K0E.2OPVM82VLFT10@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D1L7GV7M5K0E.2OPVM82VLFT10@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc2
X-PR-Tracked-Commit-Id: d3e43a8fa43effdbb62c7edc206df7ac67772205
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
Message-Id: <171691970913.25401.1698178181266793455.pr-tracker-bot@kernel.org>
Date: Tue, 28 May 2024 18:08:29 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 May 2024 13:28:57 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

