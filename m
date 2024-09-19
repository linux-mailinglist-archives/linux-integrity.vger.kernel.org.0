Return-Path: <linux-integrity+bounces-3642-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6697C57A
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4030F284A23
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB60199249;
	Thu, 19 Sep 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jceGIhtm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2884199FC7;
	Thu, 19 Sep 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732809; cv=none; b=Ox1SzpptORrHy6xTpdl+XaDRSRk03B2GPDQ3rW1UTLZrVTc7Cz1ZHhFWEb1TfQb3gWcKeB1TTwKrWDnt53ySXqLkOLGflLwgKxXMXNZRzrM3QfAnwy5kL5f1l8xnePXwNK6XBc35nmQ4fhtH5l+UJnciqhhRqMui81MVbSlVmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732809; c=relaxed/simple;
	bh=I/G4k6y4i9DNO1R6tRk8uZ85Yb1u0CalDZlvaSRmhgM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MVwMfX+JSk950WvcarQzOkhmtcF/kSdj8Iab5c6onR+QhddUUI6/0vUgcosQNPRfDbzwokhlIaRdbLWkdvLbL6Uop4ib+xocqcs7mZ4nHdrbpXDyrkDzHf7OzGILKfe8d4yG7IQFbpFzizwq0iw14KGlvd2jvxeTxLy2iZK66ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jceGIhtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F360C4CEC4;
	Thu, 19 Sep 2024 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732809;
	bh=I/G4k6y4i9DNO1R6tRk8uZ85Yb1u0CalDZlvaSRmhgM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jceGIhtmTXYYUWUaehmwKhrqznRQxn23ytG13DMzyw7r3+Wi/CdSS28AfF/t3eF7W
	 tuQplsetNRm9I+EdKoO1LbjlETUWmV2IuXLpZl7oh19VlJnsyYp/2SiqCbWE9C4S6W
	 d5lKTNy7U7aNGBrjqDEQl6NTO5v2yIvFYZ2+3IRPAVePIKMp2HzYMmvJ4i+M1YD4d9
	 jef2mNyx0FDzpuwirVlxpXMW9JdfeKhSmA4H/FonNwp1BvXTI6bfKV/WVZGJ/2YAZc
	 fuyn3FE6c1ZhkGs3evazZg0PXilUbQwnZAh7Zjit6fLYL/QVfOioEhzeGpNZlanKnd
	 oOKSu4yB3z5lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 790003809A81;
	Thu, 19 Sep 2024 08:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>
References: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc1
X-PR-Tracked-Commit-Id: f168c000d27f8134160d4a52dfc474a948a3d7e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5e65d1fb75ffbe3aba33de81a72752ace28295e
Message-Id: <172673281140.1388805.17939526705738153161.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 08:00:11 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 19:15:28 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5e65d1fb75ffbe3aba33de81a72752ace28295e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

