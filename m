Return-Path: <linux-integrity+bounces-7421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273ABCE36C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD0258233E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E95239E63;
	Fri, 10 Oct 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnaqN1Bi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5FE3594A;
	Fri, 10 Oct 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120717; cv=none; b=fwrFQBgDEdTCKBQg9cWAJrp8Zz74UHbyijoPwfI6pPTBNXSPOoHsZsPTGf9qixzDAiPHO/V8iEol8ECEAgxokzdtrND4QDJJQA+0g+15oe0CtOjTOYaXT2I+SjIy9428xZ2Vg/Giqp4HiLb0SzRGRBXQXoSG9oqvMrHSToQ0Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120717; c=relaxed/simple;
	bh=xUvxJC7CWV59HdtMcMGpp042vdVJlzAvIOU18M9NhSQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u/FwJ+/0TpeO+FXeMsCLPdes/uuO2wAjaRQFTNJJzaqKowl5Xg91azzo81A3mtllpyebrakQcIclH4MsMgdHmXpShmuiAkPN18VdYNAFsZQivNUC3Mbfa0XYPtpu/6YE6w62AKpZJaPwwACXSvIDLuM+N4KHxzCDeGRRwy52FoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnaqN1Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9842C4CEF1;
	Fri, 10 Oct 2025 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120716;
	bh=xUvxJC7CWV59HdtMcMGpp042vdVJlzAvIOU18M9NhSQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KnaqN1BiCSsxFJyDUnb6zo0kegCluwg28l99ix/pFCkFQ6+Ln/GC9AOF+p1FTSde+
	 hbsmUX28Tq3nJ9VbE/zqtieDDOmQsvkyeTCZpkF/NJ0OeqGxjuG6IrixpOanOe309h
	 bBbq3CuHRjE3t0214PHIXRWZjbrCMUoTVXn6qo/e9wkywZnApFOMG+FwpknkbqEb2K
	 C7tXyacK7qZsuAxF+vVpNVViBn+JkrIVDNuYkAkjqmsu2IMXBv+9OMcXcYLeqrfBTB
	 naW+tuZ2sn/IiJg4Js3Mfw3+yAhnLJm/YTo6jbL5V4DLK17zqR+FBJvo2PtAwtnCeO
	 z3yHVCIaNpjSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719F03809A00;
	Fri, 10 Oct 2025 18:25:05 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOibAOKu_lEsSlC8@kernel.org>
References: <aOibAOKu_lEsSlC8@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOibAOKu_lEsSlC8@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2
X-PR-Tracked-Commit-Id: a29ad21b988652dc60aa99c6d3b1e3d52dc69c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84d4e8b613e073d9dfde782c471aedbcefdede6c
Message-Id: <176012070396.1074429.12294527218652525477.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:25:03 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 08:34:56 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84d4e8b613e073d9dfde782c471aedbcefdede6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

