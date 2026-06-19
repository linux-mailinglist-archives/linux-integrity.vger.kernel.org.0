Return-Path: <linux-integrity+bounces-9817-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EoGrOZqXNWr+0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9817-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:25:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697236A782F
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XApynUs0;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9817-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9817-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8049C302687E
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C334348898;
	Fri, 19 Jun 2026 19:25:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54953346FB0;
	Fri, 19 Jun 2026 19:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897107; cv=none; b=PtZiJbSeSKUvyqCePL+Kesd6K2/clz4TjR1xEu+D05pNgNF1oQBjDgRUkatYtGCwPZIhdWgLxhdmMY/cr8ApiR6yL4NyhyKlepqnmNm8EFNiyfhyiKVHNo8TkBbRKjISUj5i252x0Dk3sUgeY/rRWxxjbX+HkCRDQdCWW+wAiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897107; c=relaxed/simple;
	bh=UGnk2RC54tSfyMoaS0aqJkgMFxdUmHvhGBk0q4mIJjQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZBIDq5WDgp6gktCQUgkNUV8030xn6uW3Cl3RYOA6LtvqueHFKgtNWARACz8/XvtcC457ZqzORVdvgC2hRlLxg6LC+u9P9/bVzm819IT9ohol4WnaV6fH+e+Fk27gQBNbiasggyn+JUy0Rg8S5vH75lMWxikqQspg6b9vkYPRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XApynUs0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AC61F000E9;
	Fri, 19 Jun 2026 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897106;
	bh=Z3FydwmTWJXvoQ8BEXqGFu8msvCVysTXPPI1kYYSP3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XApynUs0Lw41YqfxJS45IlncGoHGSeTUrFbGal7/fK8ttAUV3uVexQVf7UhncpBd1
	 0VuVLyinOIymHQzueBIlMGXPuWE6sxR/MYKcdNOVs5WdtJ+108V/kLipHUmQH9kOcj
	 ORwxtYfluUBw/TY6RwrsdJ1AXVI0cdYoB2NyRUO6kbleOHmJv/+RyU/LTiR93xdkby
	 7sLjrODX4qCKZ2j6Pzsvr7OW765kBIzZXfhf2GhUqZWPjBsWrKMNNhxF4JB8KZxkZM
	 2CTUx/KpzJ0kkJXSaSmtrkvCy8eTgh4sW42AzLdvPlURoN/K0qB/06HBimkloVhLMH
	 qnadrfW+eGIFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B663AAA0F6;
	Fri, 19 Jun 2026 19:25:00 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-keys-7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajSR22PC_X6HWjo2@kernel.org>
References: <ajSR22PC_X6HWjo2@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajSR22PC_X6HWjo2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1
X-PR-Tracked-Commit-Id: 1b9524250996b1f2f49833a1b2ae21c34e486f85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2c0595b56e9526e67ddd228fc35fa9ff20724ec
Message-Id: <178189709892.4037507.15759304723989789471.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 19:24:58 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9817-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:torvalds@linux-foundation.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:dhowells@redhat.com,m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 697236A782F

The pull request you sent on Fri, 19 Jun 2026 03:48:27 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2c0595b56e9526e67ddd228fc35fa9ff20724ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

