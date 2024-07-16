Return-Path: <linux-integrity+bounces-3114-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD1931DEB
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 02:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A653282A5B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7E3FF1;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxO6D2XL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870417F8;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088191; cv=none; b=lFubF6VzHWXzIV1O77wXAhbzaH99tAhbGpb/hqAULZI1AcpDF6zF0Q259X3ZOJHDrvld3o8noIvzzwpjmdPBuKJ63aokOGmFSDHmv+v5JX7DSWMhljJxj6m6qAO0LZj6XGG0/9oBiLSvy6EtwNNhjyONNfbWcK4FZBaLReCvruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088191; c=relaxed/simple;
	bh=xubW4V2/0bLaxiTIDBjkerpj8xFnSdGZGQP+BooJvJM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ivy2BfJ6kjIqos1GUdqNvXKm0ogohT7d/fskpNI9MPEN6N1lRCda027J1c6ca5+ZvYrVJ3zOCYbARrzVznRZD3K8oMyen/Br2C8qysRLZrVDc0nGMwaVuuR4njBo3dE6/ycsXu/r/8QdOTXbJzTiCOyfyRajIWyG63Tb3pAm5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxO6D2XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B66AC32782;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721088191;
	bh=xubW4V2/0bLaxiTIDBjkerpj8xFnSdGZGQP+BooJvJM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GxO6D2XL+LYRaCG3vGciyn9qt+V0jGccBIXS/amEjQDEX+IGEupkkVR+VeLbrT9q5
	 RKVbuh4T0raGk7Rl0PHvwfhBv+fZqi8z7HtKP6S8XpuUN5gfWTOBOYbl/KoorHGD3f
	 DMGoajbWUvd6gymTn1WCL1glJr7tsiibZTL7lnqB8tCQOfkKbcC6wGwS1rZXJO/X+w
	 UGtpPsxjv6dbqeaeeCxchBvgW1awKZuOggJeNjPbnaG4H3kybP9p4OuAE+YQxiPIoE
	 CVVAJ8R6ADwzuRFKP4HtfqCyZJ/VQxtQfoITxvzRiz2EdESZQfC6y8Vdpw9PoMXA8m
	 N7QKtuFgV38EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DEE7C433E9;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D2EBGASKUM3T.23IIXSBIQPIKB@kernel.org>
References: <D2EBGASKUM3T.23IIXSBIQPIKB@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D2EBGASKUM3T.23IIXSBIQPIKB@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.11-rc1
X-PR-Tracked-Commit-Id: 84edd7adcc9de7c37d1d5f856601aa159a184c74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbb3556c014dc8ed1645b725ad84477603553743
Message-Id: <172108819137.30335.12513373581004659073.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:03:11 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Jul 2024 15:43:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbb3556c014dc8ed1645b725ad84477603553743

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

