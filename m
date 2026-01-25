Return-Path: <linux-integrity+bounces-8320-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA+DEm97dmloRAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8320-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 21:22:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F6825E4
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38E013001001
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6D2FFFB7;
	Sun, 25 Jan 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjhL8Gdv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B32FB99E;
	Sun, 25 Jan 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372523; cv=none; b=D3NmwI/xOAraEVeV031cgd60wTM3Mgo0dGevBoGUH+/AqQsbIS9Djlt4/B6orhX4z9UUzBYsJ60cJgOWquDbDVcVTyayXOr+noI5zlupBnm6df7Jhr4ekLwkUwle5PHKZ3ThAKviCVytL/eQolq81wFL2yv54Afz7Zkw278tzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372523; c=relaxed/simple;
	bh=9PNgjiFiygsg4QvM2DCJP98ppkfz/y+denhk0Lm3sVM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qoUtgoTZjqxzzkAXTA6fBGe65ZmO2iUV9G+TMHYEvni6zZZ4b03evWtVRQGhNeFg7CWfIFYEYDlDxWtmRcvg9wxtWCcHL3DUqsCunpPQfPDA4/glXuScX2gnHty6cY9noqyYsAd74Oa2KbU4wMo0RlMiekXgKws5n/IPtf07KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjhL8Gdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E45C4CEF1;
	Sun, 25 Jan 2026 20:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769372522;
	bh=9PNgjiFiygsg4QvM2DCJP98ppkfz/y+denhk0Lm3sVM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GjhL8Gdvu4TgbVDBjipZ2JzdGLrfiXY2OOOwN1FQfVWz5SHlyiq+NAxKshmOhH1JX
	 oDO5mOVjImK3JbzhtP/OA0gP5qibmQK0T5FfS3gVaoofz/+xL/ZcOWp5OLtFG/zdb4
	 NqsosN9B+EW0NvGuYJVofjO3jehx+3izXgoNjhMcq169djFl+mrIRFReZAodKAcSjv
	 VZrPqtWRtuExpydh4ifTq6yCbH9xi965OinLpGPPNoTDO1l43tcr+AA9XQzGGhCS1R
	 RBo/8Nz/NWbZIpx0RS/oc/yTxGExoa3DaU/vwude3PJ3hqq5I1RCqNQQL+nOpBYooO
	 7OJJkentzZ9EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1205F3809A15;
	Sun, 25 Jan 2026 20:21:59 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: trusted: keys-trusted-next-6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aXZPW1HnC0kM-VDC@kernel.org>
References: <aXZPW1HnC0kM-VDC@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <aXZPW1HnC0kM-VDC@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.19-rc7
X-PR-Tracked-Commit-Id: 6342969dafbc63597cfc221aa13c3b123c2800c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9e6e6d210669f24697e615b68b5abbae9d7a32e
Message-Id: <176937251762.3579671.2917315931806575.pr-tracker-bot@kernel.org>
Date: Sun, 25 Jan 2026 20:21:57 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8320-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org]
X-Rspamd-Queue-Id: C70F6825E4
X-Rspamd-Action: no action

The pull request you sent on Sun, 25 Jan 2026 19:14:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9e6e6d210669f24697e615b68b5abbae9d7a32e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

