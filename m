Return-Path: <linux-integrity+bounces-6227-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38210AB7BAC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 04:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54478864818
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B00242D61;
	Thu, 15 May 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR0KGSaW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE944B1E5A;
	Thu, 15 May 2025 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276645; cv=none; b=DU4QbkzPH0xHNgmxsAYjhmw7QPLOQiDzHY5GX2jeBufigaUP5S4G443BzV17+BbHJhuRMgpKzv56t9Erc9uCxNCHQIDyHFi5582tQCU/NjU4uqZ0KRVVO9qEBelEe8VssLlQ1Ky7AqjFhzlKojknYkIRIe1u9gDox6wRXJYTnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276645; c=relaxed/simple;
	bh=aG87I6VtUQzpRF4GGNWtva/xTXdYWuaNrAo5luDHnso=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XaYDTVHRvUnTiK8MybHN9adA4i6pGGLVgE3Ie5EIVEeS3nllSrc3QTiYln2YoRNTqIlI8VoDNDC0Qz+C5Ucv0XDjtEQfUcjaKaNIDxKpZXHh7CyG9Ov7z7tKbklGDwSYc2JBi3NMgFZuRWWk9zFffiscOtSpVBwcS/veEaA9C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR0KGSaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB320C4CEE3;
	Thu, 15 May 2025 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747276644;
	bh=aG87I6VtUQzpRF4GGNWtva/xTXdYWuaNrAo5luDHnso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oR0KGSaWrajQ1ZZ4zGdXb+ZAYKpXB/vWOqWvH+f1L8FyB8RmMINY9E7Ui0lzF1Gu9
	 SVTCg2WO1Fe//SbT4djcmptKCkw6fIEXzNy0BOwVGeKySHgLgDkYLiv4VL0SUuQgUn
	 coFHYQgjJiCAP1psezjH9YZwFDVY1wWnUxro5af64MKnRrQbYNqao5lKnoL+rsCU5T
	 +zRnX6Q6No+4+WAFo22HuPHsB1qOkR+S24qGDmkF3sfzi9+y3EQvKTvQJYuMPFlOd2
	 3k7jlBrx3xPvb328q9GoCmVyFY6JDus0UBbT5+rlOgIJoze9rkv9hfEOoc4SA+c4vq
	 DSOIjrVJaPoRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3458D380AA66;
	Thu, 15 May 2025 02:38:03 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <D9WD3016M557.1ZXO3GLKGUIIF@kernel.org>
References: <D9WD3016M557.1ZXO3GLKGUIIF@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <D9WD3016M557.1ZXO3GLKGUIIF@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.15-rc7
X-PR-Tracked-Commit-Id: 2f661f71fda1fc0c42b7746ca5b7da529eb6b5be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 546bce579204685a0b204beebab98c3aa496e651
Message-Id: <174727668162.2586033.1505326654161211668.pr-tracker-bot@kernel.org>
Date: Thu, 15 May 2025 02:38:01 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Sasha
 Levin <sashal@kernel.org>, =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 May 2025 05:00:04 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/546bce579204685a0b204beebab98c3aa496e651

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

