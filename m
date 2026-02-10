Return-Path: <linux-integrity+bounces-8484-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCxaEAiBimlaLQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8484-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 01:51:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E339C115C0C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 01:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E33A302F420
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEE267AF6;
	Tue, 10 Feb 2026 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llFkFSDx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4A2773E9;
	Tue, 10 Feb 2026 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684613; cv=none; b=WBml5mFWrVXZqYn4h6h75e8jgcFFXjbfqfd2OswUvOdOl7l7cdcEwhYMjmSj9xrv60GQI8ccqU5b7nRG8LJN5C940phgjjQ9cqI45VmrEvuOpaBhFAdo2fnE8Gs0NWvoitljM0dtXChq3rj+Id8RWi7thePG1jwurwQjkB7SdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684613; c=relaxed/simple;
	bh=0EACnP0+FjAmYDSSNmggLIYGwEhY0NatfVra+vqhWPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ABfXNTbiaFpnbabGINZFO2QH21iYs7S4eCFEN5ecnUT20MBP/g6ETfPIvCQ5GkLndMqr+Y22aKMq80bKBfXveFTwc2uKI4azB3BOw/QFmqle2KAq+XKj3wpP8cqAhQ7oDh67UHGGNP9qkCSzNP9oYMdn5HA5ey4PH0I0gfira9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llFkFSDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B2FC2BC86;
	Tue, 10 Feb 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684613;
	bh=0EACnP0+FjAmYDSSNmggLIYGwEhY0NatfVra+vqhWPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=llFkFSDxs+qDay9RrO92qPkxvFrtzUv3ErpoDN/7vPGP1VBUhRmVAwvZUCWWyJl4V
	 zse1MXhpnNK+yQlcEwJ736obcUVqo6lpQsuckqAcjhEzJ8IEtbDos9cZUgKxSwfk8b
	 IHi56YYpzgzLW0ouJjf1YnuZc6bochlTZnvTMTJZeJMIJ5XQIa8dXuVrvOP6heFHDR
	 PCJMnjUtzBIEb3Sh/YGqETrsdoJx6DlcnaNg8/6Y8jBe65+KW6W2SbbAwYKrGe4GvN
	 tZy5rMTCA6jvzcikAp/x1m5WQobaDrJoAlAqz3ogQB9UD2aDZzV/kq4kYCXR6JEJsB
	 TUqOTgcHAQ/kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9F6F9380AA4C;
	Tue, 10 Feb 2026 00:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYFFfTwGGFFl6hn7@kernel.org>
References: <aYFFfTwGGFFl6hn7@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYFFfTwGGFFl6hn7@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-7.0-rc1
X-PR-Tracked-Commit-Id: 3e91b44c93ad2871f89fc2a98c5e4fe6ca5db3d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37b4fbf8dbdfb694f2972d1bd7fcd36304a520dd
Message-Id: <177068460951.3270491.10768737973961825906.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:09 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8484-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E339C115C0C
X-Rspamd-Action: no action

The pull request you sent on Tue, 3 Feb 2026 02:46:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37b4fbf8dbdfb694f2972d1bd7fcd36304a520dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

