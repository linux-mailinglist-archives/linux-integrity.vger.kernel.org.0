Return-Path: <linux-integrity+bounces-7786-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476ACA171D
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 20:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0F47302B764
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83B338F4A;
	Wed,  3 Dec 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ9qO1VE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FC33890D;
	Wed,  3 Dec 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790545; cv=none; b=m1mbKliKunnNtGgtkcwrCKKrDoZr75JxwXQCb1kp2JBSbJCjgzFnzW3JDBYBTHLnHmaRqfpTOdiuRbXdsL6TUcmuH6J4vbljOtzYnZoWbDWRJnH7qr+/SrefHmta7gUuxLngE867thNdHDBwNB2fAsRv8TQLbylezGks2vO/kPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790545; c=relaxed/simple;
	bh=EMrPZ5p73j7ZWAvVLfHrf1QBZMAOZGZf59iomwZu8OA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NtwR1mni1Gv5813YVyVrPIEzZSvqFCYjYWoILoTn7nsoB7maOZPeoAsIX30NQntd+YDGjXhgpqjFfEPqTns60xfz0cWrs9ACwUJmKxCIC73hkThgaf7dBJejeoI/E7GVZ5U50kOG7eRiMszWmzXf+3rOUqyHxb2EMFuwKBBpHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ9qO1VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566DC4CEF5;
	Wed,  3 Dec 2025 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790544;
	bh=EMrPZ5p73j7ZWAvVLfHrf1QBZMAOZGZf59iomwZu8OA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KZ9qO1VEW1PcjnHsRZufZlhOGfzrjnyxCIdvrArs0jVeB0/qYf3QovlrZC7ZH1htM
	 Z88Rvq78VJRf351lL2PlUfNZVoNczmv2Uo4OfNuDDO4eIgLvHd/fQE/msQyga6GQR2
	 efw7C8blfzFZCdAFlx8z+MFgccC2RI7eqFtvWdiAwycQwUujDpRTKEBfRFebTGrfX2
	 AHdxoTr98VUOafrRffDjdwPr8zcHkb5OR2/3GMwxGPaC9y3kkJxBry+9f4PmWzmYpA
	 zZ1h6GLf6BcgXISAc4JTkYl1cpZWWZmDsXrG9io7zXcLtVQzt6TRZabT3t7FCJr7Ux
	 DUwLHAW3pgb5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B57913AA943C;
	Wed,  3 Dec 2025 19:32:44 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <58c716aa7e18d107590f98705c29e5a0434cbcbf.camel@linux.ibm.com>
References: <58c716aa7e18d107590f98705c29e5a0434cbcbf.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <58c716aa7e18d107590f98705c29e5a0434cbcbf.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.19
X-PR-Tracked-Commit-Id: 738c9738e690f5cea24a3ad6fd2d9a323cf614f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 777f8171602d5954cac024b66afa1b5b030641a4
Message-Id: <176479036324.47894.11486447353512922578.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:43 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 02 Dec 2025 16:55:12 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/777f8171602d5954cac024b66afa1b5b030641a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

