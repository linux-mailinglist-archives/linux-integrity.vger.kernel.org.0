Return-Path: <linux-integrity+bounces-6308-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B646AC44BB
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 23:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B360E189CBB7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65CB242901;
	Mon, 26 May 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUQ9BQKg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB17244691;
	Mon, 26 May 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294390; cv=none; b=IOYo9dhbkT/JFdtP7xmRL08J0aU9GWocRcduryMlk3XhAL9OG8g2bSq0riXKK2TlnBKA7wCoR1pyShQOLwQ1jiv0T1R5xPG+OGgenaInIb8XOUBIu7561/cGuGhawnE/dNclVCxxCufRkPPxAPtivJOpiMwjlT0Jzn+QE0o1GO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294390; c=relaxed/simple;
	bh=UitDIQnDbHxnxuO+2DmjOVSsZwusuZzW2R4jhvhTu6c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RgpGg4vJ+WMZEgWw5eXDE/6Lh/IBLPCLRHjmQ4Dgr1uz0XAZqioD/i/YFNDqSTW/aILsycv1H4rYcLS5A+8atFn+RlyMkuwuvWcriMQeyqQAR9d8O7dJz0ez6eDdHdWk/SEZ7gxL8u5Yc/6taq5B+kUJq31e4lezbLc/3sYsqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUQ9BQKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E528C4CEEF;
	Mon, 26 May 2025 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748294390;
	bh=UitDIQnDbHxnxuO+2DmjOVSsZwusuZzW2R4jhvhTu6c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kUQ9BQKgTzVHE4tptg6in4G8af03z4hzo6i0UyhN07kYQ6Za2Ebr4KZ8VY6n3Fgqw
	 gxeC6JCB1JuYBOI6Kh7Oj2BTwXSLqUyynx4o92skQIxPKtZmpffcpNaClrY1SgJ42b
	 9vt4fOfYTyFHCAC/6dSi9tPW7JT+06R1vJOU7AcDSb0FpJ3jfC968J8o88rFR0xsui
	 fkPXp/6qIeDxcn8rG81irazX1tA57FoctvoN9Nf/ukaA7dN9FbPcC5gAd9/EkIbSIe
	 i0PKJMsYanDfy2fIFBMj/yjA53Wu68kAbku2cLzXY5N1DW4pSmWQyxbHVlKSGGSwJW
	 B9dlt9uStkSkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 28C06380AAE2;
	Mon, 26 May 2025 21:20:26 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <DA3SIK592YXY.LG3BS9A4XH6K@kernel.org>
References: <DA3SIK592YXY.LG3BS9A4XH6K@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <DA3SIK592YXY.LG3BS9A4XH6K@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.16
X-PR-Tracked-Commit-Id: ecc1ca9185c377822c66cbf61ecfed914455d884
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66fd704da45429e40aca6b4b09ca0267e27b29de
Message-Id: <174829442509.1051981.1883269779537257502.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:20:25 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 22:34:19 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66fd704da45429e40aca6b4b09ca0267e27b29de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

