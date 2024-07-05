Return-Path: <linux-integrity+bounces-3024-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E376D928DD3
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53FE1C2099F
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3944174EE5;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVvSZdGQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE0174EC7;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208278; cv=none; b=csPb8X9U6znH/YBgroObghMSqe/4BG/Ex4LZowZTQzs8YquCBAIi5F8FneMQ0bdWbQZiSrBi49qDOMXR9DnEgv+jRghqMFG+V7GAHQtcW/xMql+R+/lwG3E2wMMb27qCMVqL6yezuJofW5vZaoXlxd62ME9GsWzNcrpeTPwIVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208278; c=relaxed/simple;
	bh=QNfMwN5qGJR/sgjj+OqBVsXNg/5MfQsYCveqepWm8gM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZpqyMFjvK/KyJ/Gv3bdiJ0CoKcdMaAluFMnnqjGiVQoPQB6rtCkxlvmgaVUitLNuwnkO81gpLNn/jvT7bE0ToZwdpuduMRf6NEv5C2fTcvRQLgjeq9b7niB0jCQfqP4j/Gogy9+zoj7uBBuwpitCODrw+Gs38Qij476vbmZ1gmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVvSZdGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 744A0C116B1;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208278;
	bh=QNfMwN5qGJR/sgjj+OqBVsXNg/5MfQsYCveqepWm8gM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qVvSZdGQ8lX8ynjtAVGESnRZcriNYkEW4d/AitdoK8P2yEmHyV1ugrJMByFAfjND0
	 Z3jvBnpj2V/uUrGN45KQWyRRzpPkl6j8pg0RoZ1Ln6NRioK5bYHjNDSO/kWR4+56IG
	 hXTJDBEVncqICXZf4+QBH4vt+neSpRy3L3EbIyH+gcGiyLKAO/eAnEEvfCZyPugbkc
	 yTqxYuJ6qA3FmzZHWUTAG/lDlkTQH2fdTS3pAUYItdNJovWJooZElkbsqhpaJawQCU
	 ci0nPN3Q0ToB3Bn46xNYj3MKIUnQlh3ilNRkPKVxugmR+JO2+1uSW8cTXCdXD5sRjf
	 67uaszKnb5Lsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60498C43446;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <D2HKE740MWCK.2O7S4KF56L929@kernel.org>
References: <D2HKE740MWCK.2O7S4KF56L929@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D2HKE740MWCK.2O7S4KF56L929@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc7
X-PR-Tracked-Commit-Id: 7ca110f2679b7d1f3ac1afc90e6ffbf0af3edf0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cc467117e61272c522f5922b04dd984deb2411f
Message-Id: <172020827838.9250.5938565628970546965.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2024 19:37:58 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, James
 Bottomley <James.Bottomley@HansenPartnership.com>, Michael Ellerman <mpe@ellerman.id.au>, Stefan Berger <stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jul 2024 14:22:00 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cc467117e61272c522f5922b04dd984deb2411f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

