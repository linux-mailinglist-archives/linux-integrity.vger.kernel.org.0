Return-Path: <linux-integrity+bounces-2838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5B8FD5AD
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 20:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A86528982D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496528379;
	Wed,  5 Jun 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJfqOkCz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981F168A9;
	Wed,  5 Jun 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611958; cv=none; b=CI5yvx6/CBH7xNCeK3i0qTti53WSirkDhH0loG78Bb/VlmycIthCkBvDKLBnR5MfNewQ+kEpzIZTSIlFd3oO2RcmqqwKb4weBjtKGKtcPNVghWMRi6EE8zhYzi5uLicE+Ij4OUGD7B3/hncMW9q7RM2OFOfWtpKcgaMt/ODH640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611958; c=relaxed/simple;
	bh=LWuaW8S8B6KH5+h5PjEoPQiFNw/4unQ+vwf/+7bM7jY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lfBuzcQ/Dqodcf0TgExxW6MC0BI7qfIb4Rq7JzzG9ZmvDfzNoNtp7hMoTM+b7VCiagGWWP4FXijW+XOMfbO+Ej5fhJAF1j8tqRipWD7EtOaFelkNRT4Qm5/sCQ14X5V05WsmVvdB+uO9Uo225lvEuTWD9dyML8JuiVItatSx7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJfqOkCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3893CC32782;
	Wed,  5 Jun 2024 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717611958;
	bh=LWuaW8S8B6KH5+h5PjEoPQiFNw/4unQ+vwf/+7bM7jY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tJfqOkCze2op391b829gcClXwcplmcVlggVwaXPujk45F3ofWiG22KjlhAZ3B2Xwy
	 DZESYTCTvzoWAk++bj/EcO5Xw1Drx2xh/dG4QNy1zNyoLqCZ/Y9HoiPqYnX/kV+RYV
	 1g2BHIqBo4QOMN1+ud9oP0o0UALOdkT9H3RPowRXAfb8d2ZCgqW7hmWtJ8EfoXj0Tb
	 bc5hIzag6zVcnyYyOixNxeqOp1FxOMqzLdVHsesZ0YAhOlO3cAwhMXrq5GH/Galkmk
	 FpCvwtMia/F8Q2W2590B4JpUo2gGpMJXBWN7lFlDc/7zQtvGCT+Yf8C+4DnzbI7FvY
	 cWaH2fT57iCaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E92FD3E996;
	Wed,  5 Jun 2024 18:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <D1RPYHQDJIOG.2KAI4PDY90PD0@kernel.org>
References: <D1RPYHQDJIOG.2KAI4PDY90PD0@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D1RPYHQDJIOG.2KAI4PDY90PD0@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc3
X-PR-Tracked-Commit-Id: f071d02ecad4cfbf3ab41807c90bd1fef1cbfd3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 208d9b65c0dfe619aa24c1942f4acc6e1112fc84
Message-Id: <171761195818.15423.1833387133228773606.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 18:25:58 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Tony
 Luck <tony.luck@intel.com>, Jan Beulich <jbeulich@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 05 Jun 2024 05:14:17 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/208d9b65c0dfe619aa24c1942f4acc6e1112fc84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

