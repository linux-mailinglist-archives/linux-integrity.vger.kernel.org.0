Return-Path: <linux-integrity+bounces-7814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63102CA6086
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 04:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF34D31DB2CB
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C10286D40;
	Fri,  5 Dec 2025 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLATkxfP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7166286417;
	Fri,  5 Dec 2025 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906534; cv=none; b=DA3Ut7Nv3AymzLJUkuGs6Y9cOFesASSnKrGl5Qpqmy4Gsv2BF0Wj01tmisq44foCcZtISZSrmc1LYjbzKQeQ9xhxQCgp6tRvxKCyroxrMT7lQ8FMDDDOcmSP5bsNEEOCAlbBX0ZrFdYDwCgzARLVL10F47Hrofcqkgp0aagEdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906534; c=relaxed/simple;
	bh=m9THmyLxj3y772Db7toI8v6ZaSMr7I4J6LZ0yH6j3Z8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VJDN9QVTcNu+c+W20Wb4VaWcZ0JlVmeD1rVUMuEN/Db5+/nzjU/5IKF6P3wsQpeyiwQgZlFQ/gotE6UG2E59+tX5jqMpmpuLyMbRqMHSA+EaxuXtjNoWGgCvVPLnaVuDosbFfWohcuMCcocXZ4kdsbj8x++mTGxPjOz/XXEy/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLATkxfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84206C116B1;
	Fri,  5 Dec 2025 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906534;
	bh=m9THmyLxj3y772Db7toI8v6ZaSMr7I4J6LZ0yH6j3Z8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tLATkxfPz1Q0zohgFvefAC2PqeDV+WYdYW3XAaDOjchMF/DlPwtB4Idkhq0tzI5JG
	 uDlu6gpLGgFRbLXsuwHeUJIpUIU7yg/BJyNlSXRJqmr8j06fkNnJAbs53cpaPsXmKc
	 Agw+h6AsvkYv7lqLb+7tbp8LP1SUeJ1J9jrf5KrNHWn3qZoptzOcITOWciO9lV4KU4
	 p9fhuxUQGQKtZ3nLouGLVmXdnypvE+hygen5PlzJ3JrNWczYCX4FJW1UEpm8X2zYNz
	 3suZvwHA7Qho27ceDEu1Q1bP/H5D0QjLhc2Hw/k4+l+emu6/nkAexRo8aUnRgYm810
	 PXTM+i+N/YE+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58BA3AA9A89;
	Fri,  5 Dec 2025 03:45:53 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1-v4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTCpIL6H1eBlnnY_@kernel.org>
References: <aTCpIL6H1eBlnnY_@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aTCpIL6H1eBlnnY_@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v4
X-PR-Tracked-Commit-Id: 09b71a58ee355ae09f302bd0875a29ffbcbbe3ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 028bd4a14631ea2a1c923930bff96ffd0fda03a6
Message-Id: <176490635238.1091160.1538523269256543661.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:45:52 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Dec 2025 23:18:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/028bd4a14631ea2a1c923930bff96ffd0fda03a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

