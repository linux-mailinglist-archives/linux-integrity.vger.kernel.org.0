Return-Path: <linux-integrity+bounces-2527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BB08CB35C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 20:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49865282AEB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA7149000;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVw80Lvi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017D148FFB;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315229; cv=none; b=SMjr2etKVThkpAHboqCRAkx9oCzVdO+OqOfKiykR/m45J3RnxR7TWnPhR0l387parHsKErPWBf6Hujicqa+5dFdBw0l2GEPk7mWpHUROAXB9qESV1UimM2uOmXhZiaBOdkDPaYiMaiVBD7N6ahfrcJXFFLcnbfNYUOPdiSRtqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315229; c=relaxed/simple;
	bh=YA+QLrLrLq+2YbMbeAUFwBM6n7zUHzHQNzJJRUbk8CQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YjgIg1HbXxAEk1KVbEPw2UEq2/1l8iWaGVkEx7dCSy12I6iTYHHdMPgM0cfW9U507Cyrk2enLduDwk3fHkDfFZF6Ah3k1OkHGKYC6gZssLTUyf7lQhSYhoZnVMlsoEgm9D5xhKPegeYGqdD8w3E+GhhSnzw/XRTONYJfMNk47u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVw80Lvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A74FC32789;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315229;
	bh=YA+QLrLrLq+2YbMbeAUFwBM6n7zUHzHQNzJJRUbk8CQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JVw80Lvi/ERwh4o8Ft3tMzq77I/VxTAHTXJrP4ALFyqMu+aa6YtJdmrW4vEDYDCo+
	 67ns916A1RlQu3I6xF2j0bf0Ks6fuuVSbnaWUjF7gXBFcF/uCb4cxuqQH8zcyJ71hl
	 M+XkrMJDQL9mqpg2ahVudCzb8yhHfP9LFLLMoy2Rwvcbh8HwcxpPpTEUalseHllkvk
	 zdkmqaahDxc1G0T8qFIs6Ulopw26wU7gwDgRzII7tsDvKwkkWnCgxmW6oI/Cs+TUht
	 gq8Vd4F4TVF0cgawqCy+AB49ImjVoBVGxoz1QZ2Z85L8Y2eto8MaDbTRvu5FaEOjX7
	 iFgG6/yOoEtRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E401C4936D;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS-TRUSTED: keys-trusted-next-6.10-rc1-part2
From: pr-tracker-bot@kernel.org
In-Reply-To: <D1EVFNB6HJZ8.2ZRZB8Y0K3TV5@kernel.org>
References: <D1EVFNB6HJZ8.2ZRZB8Y0K3TV5@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D1EVFNB6HJZ8.2ZRZB8Y0K3TV5@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.10-rc1-part2
X-PR-Tracked-Commit-Id: 050bf3c793a07f96bd1e2fd62e1447f731ed733b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa8151cabfaa4166feeb6e8a4df428d7c3d9fecd
Message-Id: <171631522938.20025.3259192449680862693.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:13:49 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, James
 Bottomley <James.Bottomley@HansenPartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 02:47:08 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.10-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa8151cabfaa4166feeb6e8a4df428d7c3d9fecd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

