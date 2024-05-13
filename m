Return-Path: <linux-integrity+bounces-2376-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085898C4677
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 19:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6615286C54
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C892869B;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhvSuWMy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D752E646;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622651; cv=none; b=tH13sxvxmVMnVC2CRhwC51VKoq5nkmglJrB5T+zJStOiqhiCrjzYLzgE6VscfU4C1V6XAiBg4r+QVPFckuh4/v65RcpWWO8NKUGcreIGOZuS9muZhe2rlRjGg1W5IJXpLGnNjRBbnminMbUnB/CMJntM8wwLbyktQd46ULkIKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622651; c=relaxed/simple;
	bh=cGU21muLomTx6b3RkpnRSQSH1EbqgueeEZN/mflhJ8c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=natMeRof897PQ0B7vstpWAG3/03lEfU8/oxEuGuexPb0ffjFRElaY7MxcSWCTJR8mseGeiZ5x5z5qCphOPLPbuyF9By22MNIKCFJewbrdAveXMHIizR8wjBbrWFZGK+jFH7mYJYONFh1KsCar2JlZA1DQtulkGY+kCkogNR1pJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhvSuWMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 247B7C32786;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622651;
	bh=cGU21muLomTx6b3RkpnRSQSH1EbqgueeEZN/mflhJ8c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NhvSuWMyfpucJ1FaJxzF0F1B06/beOV5AbHHVlq3k2ea+lWeRg8/88fDVqAO/8SKE
	 czwvmo5kvRpqEJlkmBdfiJNSnN60v2/Srnwb6uwDhvXjdsPvCLg/YQRz0duaMu8YCd
	 kFkYs7IpqxpO4h0wshIN8PO9Kg2yNltZwVVuHf5cCpwVYrapwUopnFHtGtuClPllBr
	 Xcp+v5UgEujE91iw4A9v24R1t0m2n09aIW0UB/7OAB/oBXfiICtow+djzUwVNO6cgv
	 pdPxI3Mlu8WwfqAoKAkcBNOTyhU66UFN2zTKDHjLVer/vtRFRgKK8N6XEC0nA1Kz0I
	 ee8MmAC3EerYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19C98C433F2;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Subject: Re: [GIT PULL] trusted keys changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240509154751.25983-1-jarkko@kernel.org>
References: <20240509154751.25983-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240509154751.25983-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.10-rc1
X-PR-Tracked-Commit-Id: 28c5f596ae3d1790cdc96fa5fc7370f934abfb2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c024814828f72b1ae9cc2c338997b2d9826c80f6
Message-Id: <171562265110.10937.17676739352918213107.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:50:51 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 May 2024 18:47:51 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c024814828f72b1ae9cc2c338997b2d9826c80f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

