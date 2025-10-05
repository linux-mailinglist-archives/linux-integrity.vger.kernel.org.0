Return-Path: <linux-integrity+bounces-7373-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53542BB9C9F
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Oct 2025 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAA18953EF
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Oct 2025 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219942A82;
	Sun,  5 Oct 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeRjzveT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E12AD2F;
	Sun,  5 Oct 2025 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759693527; cv=none; b=tVVUQWaLPu82KOfk//MJTDFj+PiGT0Q9tnB+t2RSp6qfTMP+5XlpW6iRpii/QZxmBowNvAq9d+iIRqv69UtoKUJIoGlWwddK7HDvwo/ms0DBgG7Z/UTLDTmKoVyMOK1eb/02TS9aGSNh5jGdG7c1owjPkrLbsTIW4B/BijRmqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759693527; c=relaxed/simple;
	bh=Cqn8dZDD1c+1X7qUsC5hnk/BE6Kqa+ts6gcf79fBUTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tzN98eaonkyx+A6mPgjH5hZa4Ocm3CEgTi3eDJ58qjAbZ3nKnhrr5l9mMctM+INZ0tn4neMp8DuHFAkl3SM5zrtolRDBWlK0VszPjWPH+DuK0SN0zMUJDzz3A9fDRvSuawmrFtYJwpEDzQ008YYBgPJo7e52Uw2lSl+zAKWtU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeRjzveT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D514C4CEF4;
	Sun,  5 Oct 2025 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759693526;
	bh=Cqn8dZDD1c+1X7qUsC5hnk/BE6Kqa+ts6gcf79fBUTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CeRjzveTcIqG8Ic2/Mdl9JYBIqQn3GU5C27K6j0XK2w1ovgsRhCVhh3kepkHPa7jo
	 nNDG8nHnNLLwiLuEimvJCZipUqAt7yspX2y6TULiXMvE5gRymel9T8E7I+a5zMA/rm
	 UAlkB7F1b5B/Frp8y5JgTBkmtvJGXd9NU9hSZHxqGbpnZqR/RYKaOhTLGAQ8v7QALd
	 b84A61GB8o+5ZnxV87pPly5Tu7NvnT1p7jYUqgvqlgrjcJPMVi1Vr4fiQXqCT6GPPw
	 Vx3Ocllz1YZW3llwiPuy3mq7sts7Ts/OFvHqvvQtFuNMGI6nLyVu+AO9DJEmDa2fO/
	 0qNxqUSYTEfpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C039D0C1A;
	Sun,  5 Oct 2025 19:45:17 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <235aaef81ca206c9ac1f69ece17dd9a15f826d85.camel@linux.ibm.com>
References: <235aaef81ca206c9ac1f69ece17dd9a15f826d85.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <235aaef81ca206c9ac1f69ece17dd9a15f826d85.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.18
X-PR-Tracked-Commit-Id: 88b4cbcf6b041ae0f2fc8a34554a5b6a83a2b7cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 678074f1a8e03598977bdeea10a4ce51c4f4a0c4
Message-Id: <175969351654.726026.12567652761402784570.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 19:45:16 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 03 Oct 2025 15:45:56 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/678074f1a8e03598977bdeea10a4ce51c4f4a0c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

