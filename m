Return-Path: <linux-integrity+bounces-4019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93F9BBCE4
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524BF1F22D15
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061811C9ED1;
	Mon,  4 Nov 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXQmtJMi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2C179958;
	Mon,  4 Nov 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743824; cv=none; b=ufl2EdQkv0+NZEuzaaJ1daiPcgUEZX3Ep8pbTNKGk4OxDKh/BkCWlkypDIcVzQhIH/W9rFm5DKiQ6G//vS2pAtuhlkgZ+0EJIDSZxkoakWR1iGat8jR161M+uiqDTMNexjobwHPtH3xKiuc/Km1GRsZiAs/nbm9777s5RCbg79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743824; c=relaxed/simple;
	bh=8yn2FMoBBbT6Y7C0W/3NVLTfZrFDqhTmxfd9R5SOWPk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MrtHC31BSuVofBRgNkHO6bj/HafC8CH+EHKBYpecK6xdpSFU/vin7dArZjHo0haHAFitPBsbgNa01i5LY7w4dT2mAZdumI5AsDrzypVbqP+Sz5aO94GEzQ9XfOPuFIHQUdT/LuzLFp8UMQSf9Fs+Pk1XkGXtrRpECG/BVGeZTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXQmtJMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F38C4CECE;
	Mon,  4 Nov 2024 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743824;
	bh=8yn2FMoBBbT6Y7C0W/3NVLTfZrFDqhTmxfd9R5SOWPk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rXQmtJMiUT1yWTKXposWrBZFP6tnRvEicbEwTfYNWEOcEsZ/OT1aPjLQ03BBvH4fQ
	 r2BWdubn1XRCd2DSi156ANbFONkTxO57M9JdDPudzhDUDV8Uv+W7BXKJ62ev2BrDHN
	 t0/ntik3TGlSKEHsW0iVNS8kEkJtlPDCk4W+1IFlnnx6EOY6GAHPrPXBjL4uYWXB0K
	 0OGGMOp19JLDkXkhhZMcA+gIxwYKhTg2eGLTWnvPNAt82fWKSpItpl5wbkNbXq5UKN
	 L8T3pwiyuyJ4+FppkCmTMgRWXBsd6gDXgAR709p3krgR5tKHumKkThWNwtLk5h3bxf
	 oyfoypnOgUKmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342143805CC0;
	Mon,  4 Nov 2024 18:10:34 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <D5CYH0IJXX72.35A25M1YICZRP@kernel.org>
References: <D5CYH0IJXX72.35A25M1YICZRP@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D5CYH0IJXX72.35A25M1YICZRP@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc7
X-PR-Tracked-Commit-Id: 9265fed6db601ee2ec47577815387458ef4f047a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0339404fd2753c042eb7ea11bd3288dbfc38107
Message-Id: <173074383275.4156990.7746614523205746915.pr-tracker-bot@kernel.org>
Date: Mon, 04 Nov 2024 18:10:32 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 04 Nov 2024 02:08:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0339404fd2753c042eb7ea11bd3288dbfc38107

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

