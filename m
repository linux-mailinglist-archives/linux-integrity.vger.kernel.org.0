Return-Path: <linux-integrity+bounces-6002-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21BA97807
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F1C7A4FE6
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700ED2D92D1;
	Tue, 22 Apr 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6wiDdit"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB524467F;
	Tue, 22 Apr 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355237; cv=none; b=YGv92t056SVP24ygBadCAxS0lavNfn8Au4HNWyq8vYg8/yKk/y4CPIPTkryt+58DSLAHfUl01D5eCvdFs5fe65OTG64+PAOkhC/dwqyNQt203l6ZI0tw4cPiHTj0n6FQ2jZ4z0kL+fGePBAtAOrhk1WcnMD4P5ZGUDVJAa6hhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355237; c=relaxed/simple;
	bh=adSf8SEXY79LaBK4YqJd/4jet/jRcLzwl+YkNhNsZrg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dc+ISWlpufwHb7LKAllxuEgzyJiG9erktzjH7bCcwLZGZqFIf0DJ0Q0iQNX4TtL7uA7bKUIIv+JU/PUS/pCkyjQzp9x9X5YRoG3jXsFm3OFBLL5nIwXfw5JgLBkV9JIKlh5+LmVz9IRDwUeMU5X5ye4nMyELfxTgoJzR54oLsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6wiDdit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E6FC4CEE9;
	Tue, 22 Apr 2025 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745355235;
	bh=adSf8SEXY79LaBK4YqJd/4jet/jRcLzwl+YkNhNsZrg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O6wiDdit7ywPCIRmO5ShQxQsNrMrCgoGwM/QDCgK3eoxyjR8E1zsyPLo+CmKzT6fd
	 c4n1YraSGDWR2Yp0JW7HwLPG29rWSUgLnqkj2PxhRUthbKadRQm+bDvn1fhl0JN8Fz
	 s6eIJvee+EOg6xBsp+Oarr+uhciolwXTbCQdpLHC90VMPgfmQD1CtjPJWYGOWdDS0Q
	 MRlmJ+H5RSX+xjgWYUdNlOc2WA2643qf3+yOpgFK6UqFno00dcqAlMLkDkbnEnHhx6
	 A4xXwK+JV7bb1nuuOz2k2zLE31E2ygCyRsY0Oa9gOcEoN2BYHYvr2vcRg5bCbMcF+C
	 M+lSobJbii4uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716BE380CEF4;
	Tue, 22 Apr 2025 20:54:35 +0000 (UTC)
Subject: Re: [GIT PULL] Integrity fix for kernel 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250422154805.1817045-1-roberto.sassu@huaweicloud.com>
References: <20250422154805.1817045-1-roberto.sassu@huaweicloud.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250422154805.1817045-1-roberto.sassu@huaweicloud.com>
X-PR-Tracked-Remote: https://github.com/linux-integrity/linux.git tags/integrity-6.15-rc3-fix
X-PR-Tracked-Commit-Id: 30d68cb0c37ebe2dc63aa1d46a28b9163e61caa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4b51cb60e16f09b95c9ee567692aaec50087747
Message-Id: <174535527398.2047083.5663936107739866748.pr-tracker-bot@kernel.org>
Date: Tue, 22 Apr 2025 20:54:33 +0000
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: torvalds@linux-foundation.org, zohar@linux.ibm.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 22 Apr 2025 17:48:05 +0200:

> https://github.com/linux-integrity/linux.git tags/integrity-6.15-rc3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4b51cb60e16f09b95c9ee567692aaec50087747

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

