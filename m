Return-Path: <linux-integrity+bounces-4190-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B29D6706
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Nov 2024 02:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC161161673
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Nov 2024 01:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC7165EFC;
	Sat, 23 Nov 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdRjpY8o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22D1632FA;
	Sat, 23 Nov 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325399; cv=none; b=POYDP53FVbzsgreMLwBNF4sgL5CD+g91iF0Vcid5qvb0grSXw3d/EMtSkcEqUfWzNxRxdOP3ZesydGn1rz9bWMcolrsAEmfNE6sM//HLH6MA1v3GoE5aj5PaWXUtcS55OsbGRl8IwD5HkL2+KjM0bhVj0p8sNiHE6L2xy9HlMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325399; c=relaxed/simple;
	bh=60amuwJeWKMn2wu118Hx7N21nxzN3QbMwtbd5rrSn18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fkloFNGgAWj2j2BTqxSl7mDvvjDTriIK2Kf/O4jHkieFeZ59fGI8M0n2x+u5LeTRa449qJCfnYTBDkwfppnKJLejqCXi4vctmtcX0rE3vHrHV0g8KZ1F78Q0tP4KeVD3ba2GqzwVNolyXbv1qONoB3kCFiasiTIiA6lzy3Lw/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdRjpY8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03608C4CED0;
	Sat, 23 Nov 2024 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325399;
	bh=60amuwJeWKMn2wu118Hx7N21nxzN3QbMwtbd5rrSn18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WdRjpY8oAJyQmIls8PeK8x7Efgxb1PY7YD8VUpEUsuFvgNPQV8HJ6bIqDJrO1s/7o
	 lAluO7go3D2AiG+3SDZjP9TwOLVqOfp66Sh+2lfVyvjnE8cCxWYUb9+8kCp2z+15JB
	 yqidY2k7R0koS9RQXgBfELQI9wRfuuL5maygUdw4ce/YqkT/iiYrSsm98FBi9il+QA
	 sLMw3o2nFbLAMPVIS+A15TyM+N9jFVMtDt/WAd8KVZFFI0Huaq5dPWGuEng7JkhE8Q
	 LxaxwuQGLtNwRcS7Jx+rrhsHTDERE5Vr6ql8q8xHRS+QRm1SCOhtE37PDTljSxKVv9
	 kmM9AN0vpLESw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713E13809A00;
	Sat, 23 Nov 2024 01:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: linux-next-6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D5S95V90MFOZ.4LGI0I0F9QP8@kernel.org>
References: <D5S95V90MFOZ.4LGI0I0F9QP8@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D5S95V90MFOZ.4LGI0I0F9QP8@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.13-rc1
X-PR-Tracked-Commit-Id: 5578b4347bb5d5dfc8eeb8ee2eb8248658707d9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 619d996c86421da1057d589123a28e2da0bf0785
Message-Id: <173232541130.2863978.6328455370106125781.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:30:11 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 01:41:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/619d996c86421da1057d589123a28e2da0bf0785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

