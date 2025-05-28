Return-Path: <linux-integrity+bounces-6334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AAEAC6D0A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BCB4A855C
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDD28CF71;
	Wed, 28 May 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB/jUuvp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5B28C87B;
	Wed, 28 May 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446892; cv=none; b=LpY0Js1+iP/TTfc2UVqhfOFe0WkrAggCziJ+i8ndP2Cn0qrmUfInoktthd1+P45/FqUCacBnnD1nzBbdNwiFMTOCP3lR0XJpubrHBo1lO5zu+/QxtO+r33IaNj42r/CASN23FKH8ne2u4n/9e8pNzoXplbmksd0KT6PikMGI1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446892; c=relaxed/simple;
	bh=7K/y6JyC8q/ZeJma3Gm8frJuyZtLuLkkgxIM5zKBwG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J5oCkh5ZfmtUM69FmmkOzctZDgGPEpaPtlUs2pdYNBnahpf5FsTBBVEflQmH2F58+r3xmC2ytKfyEoc5Lc9riCOrBjDtzqH9kCG5u5BwX9ps0OJ2k1jRrmVLOlszyOyJnGWYE2WSc4Ogy1Y000HiVn0YiAupB8eObgD+3rYl0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB/jUuvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB26C4CEE3;
	Wed, 28 May 2025 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446892;
	bh=7K/y6JyC8q/ZeJma3Gm8frJuyZtLuLkkgxIM5zKBwG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dB/jUuvp1FQzN/QXMPUEu6ZOrbAWctAP89SvkIm3Qi+kJFogwE8I03SZvXJzeWqWq
	 ItKzPVnXViwL4g+UnUyZ287Rl5f8khl64giDWhVC7jd32XnBSfi3XzTzmBvLPg0NhW
	 JFb7TodKko546uLA636ib2GnIVdp6bSDu9TRikte7EtLZrKiWFN3g4P8tWMyOZ6WcL
	 PI4vhuLW31YIIrXsJK829IXLfM/4kJkngW/OtSZX22Wpwek6tkvIIT4fObu0HUFS8n
	 AEywcaM2U7n0EGEJyFYLvQCaGexkB7cqpHD1ZfCh/1KxYKQgaEIRbPslQYz5xwe/kS
	 p4pXfM7hjAUFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8A3822D1A;
	Wed, 28 May 2025 15:42:07 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <283be073924bd046f180880b5912338744550884.camel@linux.ibm.com>
References: <283be073924bd046f180880b5912338744550884.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <283be073924bd046f180880b5912338744550884.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.16
X-PR-Tracked-Commit-Id: fe3aebf27dc1875b2a0d13431e2e8cf3cf350cca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7af6e3febb919e8520a5946649993f7edb0495c7
Message-Id: <174844692631.2441113.3410356071953487182.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 15:42:06 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:08:35 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7af6e3febb919e8520a5946649993f7edb0495c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

