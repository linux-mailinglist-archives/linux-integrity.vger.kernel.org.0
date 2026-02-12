Return-Path: <linux-integrity+bounces-8487-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M5TKw8ZjWkwzAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8487-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 01:04:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFBB1286CD
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 01:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A964630B5BC6
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 00:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826AF50F;
	Thu, 12 Feb 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LULYkR93"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75512EEAB;
	Thu, 12 Feb 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854654; cv=none; b=tn7wuPkXAFaB7wPVZ+qhlTZ2ULCphR0EeKaZjXll7pVnU3Vb0+2/ZB4kVCsddooA7frfoC1Dkkrl0oPW10YUFQJvtiGWac0gfIxP5rnC8S/BGeibTABYZHiMBkqvoEAym2Rt1BslJwa3RtP8ILsqxzei48nmi8Hyl1/2mLa/8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854654; c=relaxed/simple;
	bh=tm31/nzUvhc/4Ww+yDScRDT6wgFUsXFUcSi/jLsHU+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X4z7e9WU9JMKyvA/My40PrTOGZKoGSJd2wd2pXhPPGFgEsJtzyw94iXVy5CzdCBBQvizOYDs8ERnNuYqTSNXbPzqV/hHxIHPJMUJMYtjQJE6+68qxZipgS4NQBsh22tewzrphGm91BjOkRH+WVIQT3Mfz+wujmaII5U0v3RXMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LULYkR93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CB7C4CEF7;
	Thu, 12 Feb 2026 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770854654;
	bh=tm31/nzUvhc/4Ww+yDScRDT6wgFUsXFUcSi/jLsHU+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LULYkR933u/wqcOi2lrDYAlaF7c/s0mFUS9FkF6pr5Pmz1dGgR7ZAdo7Xod13jmkn
	 g2plHYfzMqXuQ1Xj0Jaj6pq4zy0G92hMjlbk42P2X6eedjFus9sInV5HvjLqbFjMbY
	 lVdC80HWya8nqOOF+6HX7P6VrMdPDHdUMx8MowcqwPrmajBjT0GVU07mJmf4je/Zqv
	 dwZeY2TOjMg0kx+soP8O9bVYycgiodF7lAwxpLGzzg5c2YcZa/Ppe1lBRVhsU/LIxO
	 yO9lwpIjoTJGe0+bN9OMqC7r0HGCc5ecilBONeI0jUvm86vRX5vqQdmWp2dqEYiaTh
	 2Lozd5cCwErbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4823939EF966;
	Thu, 12 Feb 2026 00:04:10 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <a6da3d9309492557026cee3b5a50c6aea8967365.camel@linux.ibm.com>
References: <a6da3d9309492557026cee3b5a50c6aea8967365.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a6da3d9309492557026cee3b5a50c6aea8967365.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.0
X-PR-Tracked-Commit-Id: 0496fc9cdc384f67be4413b1c6156eb64fccd5c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0e91e401e31959154b6518c29d130b1973e3785
Message-Id: <177085464892.803048.6387495979058605718.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 00:04:08 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8487-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEFBB1286CD
X-Rspamd-Action: no action

The pull request you sent on Tue, 10 Feb 2026 09:54:41 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0e91e401e31959154b6518c29d130b1973e3785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

