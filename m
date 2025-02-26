Return-Path: <linux-integrity+bounces-4999-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B0A46DD4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6525816C709
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A822425A;
	Wed, 26 Feb 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbLpqMe0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9421C18F;
	Wed, 26 Feb 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606370; cv=none; b=bJC3hsmFR4Nj1bOIv52Z54xAlTpVRAJV1/yAlr73aAofpsYcIuxTvOSraZeMwHxve/MBJcxsZlUqmktYCwvf018wodA0tkSahJCdVFgC9JQMdbQdMCYJEgORLT6lrPI1MKEm+ANct0iHek4SI/690LG5fjJ47b4te/AwrwMunWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606370; c=relaxed/simple;
	bh=zzGTM1odMXR5Adrfw5siMMwdPzoGDbeCpmVRXmJB1fo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EGOuhUc0DGs8RHdhujpZ7XmjjvkXWdhcFCRtIZx/5D27sOoJALs4bSV1wch2zL2Y7toAMi+/SKwLBhPSXNtzd57LtLeB5j/pcE71qN41BMDqjYaLfFNgUppWjJWolYCzD8x81bFPGltvFzv2uGrYOUdII5w+Kq5DVeUvKzI8VsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbLpqMe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C9C4CED6;
	Wed, 26 Feb 2025 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606370;
	bh=zzGTM1odMXR5Adrfw5siMMwdPzoGDbeCpmVRXmJB1fo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hbLpqMe0jimIMh/YqdZeZfhf6SOBJURiUXr73DQQSwtfVPNANYOH2/Rc7tjgmFjTF
	 Dr0692Eya3Wcpyo3L7UpUzAAEvVjyUrkB4+U79fbO3Xw2xD+JBMVgxSSLuGXVinlGt
	 0Gi2ifEqv7TcALtkKjRFx6qQlAox6k5Ocx8cn5VP44BVu7+fB38uQaZWv+4ZMra3WF
	 vGOpui+Q1XJpypxbPUjgIzqQ9b89vV9ey9EEtnIMWNoLieuEdCjfgMnLexNIdT2vA4
	 AtAWoh6PAHaAUDmiIjpTDEyOYI9aE9VO9KWjZQ3TnL/PKxB2qr4ZCkjZavWGkEikqi
	 f3jFsD5ygiaLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3E380CFE5;
	Wed, 26 Feb 2025 21:46:43 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <dc3b985a9324acf0455434943c2ead3b39945354.camel@linux.ibm.com>
References: <dc3b985a9324acf0455434943c2ead3b39945354.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <dc3b985a9324acf0455434943c2ead3b39945354.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.14-fix
X-PR-Tracked-Commit-Id: 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d62fdaf51b115f851dd151f7af054535890b5a0d
Message-Id: <174060640186.856033.15681744209833424564.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 21:46:41 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 08:41:01 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.14-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d62fdaf51b115f851dd151f7af054535890b5a0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

