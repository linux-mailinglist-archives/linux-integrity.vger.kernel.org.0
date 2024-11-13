Return-Path: <linux-integrity+bounces-4113-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9859C7DB4
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7433A1F22C8B
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3A18BC10;
	Wed, 13 Nov 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyPXLPpF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39361865FC;
	Wed, 13 Nov 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533759; cv=none; b=TBsxdmDFWmuFwyR0LwPYgSDWEoS9EoAV0zjreu8+ZDFsjRVLFVs2ABObKOtVspiEH7mn0bxc9kq/rjqAX/tlFfo//vdC/g0LanXsHMD08Yld79wekLW6yvr8AvCtgdlvho8+aPq9kAV5RdTKNgqUZzfdnx6fB36glObY4kyTNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533759; c=relaxed/simple;
	bh=kFUf2WiBHLV7e9+O6AbQ0bJDckduwRhjdX073xkDfzA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tcNavmD3cbq+ygz+l78n/xEwyPn3swr8JE22C/Hk9/h2v0WybGTCiqU5Vz+GJMVfJdj4Dj6hAbL9lOUS96dQn9hQRmR0rnr/w5Swwn1sPfddcUWUiZLzlBO3PIlzWgi6UH3ie4ncaGVnwrhfEwfXH6Dw7ow6rq1k4SN/puv72qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyPXLPpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BA4C4CEC3;
	Wed, 13 Nov 2024 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731533759;
	bh=kFUf2WiBHLV7e9+O6AbQ0bJDckduwRhjdX073xkDfzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TyPXLPpFzQJS13RcBjYBErmO0VhVkO2xfEll+c9hrXj2ecQcBnuUuyAQLN4lRLsmr
	 KrHi7sTEgLZ7Qs1alacaLNTuppN9V8Lbc46vQgde1PWbwY0nHCZ3QuCD1Hqf24YAc1
	 kX+W/bs2wrCHEDl6fXrh+MUr7RhcVP27J1rRvSoO3kql8e30b9C1W89BgR6ueyKMv0
	 nnM56GVGYi7ErFl4qwV8pMUx4q//hWVfHdd7cYmrkvJpNjkAVH1pi4GYLRmeiJgAJ9
	 e809G8JliKK9zO14fv9nKEA7Ct5utVQhELxM1A1UqEoD+sZGFPJG8pSPOPDpEIyCdT
	 dtRL98Avzr0KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC43809A80;
	Wed, 13 Nov 2024 21:36:10 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <D5LASMVLQDYH.2EDC5DH6YIDTG@kernel.org>
References: <D5LASMVLQDYH.2EDC5DH6YIDTG@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D5LASMVLQDYH.2EDC5DH6YIDTG@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc8
X-PR-Tracked-Commit-Id: 423893fcbe7e9adc875bce4e55b9b25fc1424977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ba05b0e857d1f78f92084a15e618ea89a318089
Message-Id: <173153376966.1393977.13024225536362594859.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 21:36:09 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Anton Mitterer <calestyo@scientia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 21:29:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ba05b0e857d1f78f92084a15e618ea89a318089

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

