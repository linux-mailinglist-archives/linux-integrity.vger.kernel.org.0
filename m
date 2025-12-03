Return-Path: <linux-integrity+bounces-7784-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D24CA16E7
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3634F304C283
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35260307AD1;
	Wed,  3 Dec 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CezHCw2Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15032E137;
	Wed,  3 Dec 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790520; cv=none; b=AtcYWmoTCjjfoYRdDdZkzmB8RwSyYZ/9eIf00EWZe0sibQfgjUTLcBwwNht7MIJXF0xZfI0A7r2Jc+id59BWzJ0d7eBFhNTgTB+hgPBMoVTQlAmsi980koxumLrY8qi45/0zxpVShCkOOw8ShSVu+Ohj/IhHjWrpO0wbqwOcd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790520; c=relaxed/simple;
	bh=bnVEd1HQOoKWVxyj86GScvP09ecPdij9l08OwcaKy84=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pETIkMCLrr4L767MmPbPe/D3AEcND+j79O+hUTPHidVMC+J+TppwtufvAVb9nMjcpNHKOOT7fZibCAZXab+SMVvA4SfZoGS//SJ7q1GqNrMCOf+2NyBEjFZgaZD34NH5T85y7mhjRva29Kau71m3/DUJJrL6C3g17JJIptyoqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CezHCw2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFE1C4CEF5;
	Wed,  3 Dec 2025 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790519;
	bh=bnVEd1HQOoKWVxyj86GScvP09ecPdij9l08OwcaKy84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CezHCw2ZuhlCZvtyH72/IKQGzR7QoKqhXOLpAEkPOZ6krIQPpaBfMdlfhRUli2Xlu
	 qG3E+5S+oBfDekQ3g1Z8ajmgOAXWMPqNwGydooLv5qdiyL+KD5ECuUif4mANXPiKyc
	 AH1RDzq4MfQRZnJaYG9XIIqAkgFgoGtqvZN56hgpFJue5S4RSN28aL34lunX+awD2q
	 Dyh8P75cwgVOUi4g0Z7gZuDEL+puGJux7yvFpsf76oInSBbkK3XnnEp+aD7JZegtKK
	 ep5vHArv6/97fR0dWAkCKvm47dBgoJ6Vj7PUSdXiSGszlhnZ0+AiNWspU3U6JCFexR
	 SKF1VQ+c8om8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AFD3AA943C;
	Wed,  3 Dec 2025 19:32:18 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aSjSZj47-p_3i_Xn@kernel.org>
References: <aSjSZj47-p_3i_Xn@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aSjSZj47-p_3i_Xn@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.19-rc1
X-PR-Tracked-Commit-Id: 8c8e3df3d2f51e9a3f6f1a1112adf250f7652d42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b082c4b06056139b2f3e0a8a0fa3235e145fba80
Message-Id: <176479033762.47894.2166491787429188502.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:17 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, Thorsten Blum <thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 00:36:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b082c4b06056139b2f3e0a8a0fa3235e145fba80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

