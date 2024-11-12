Return-Path: <linux-integrity+bounces-4096-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78B9C638E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 22:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FD6284A90
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0421A6E4;
	Tue, 12 Nov 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL92qj8T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBF21A6E1;
	Tue, 12 Nov 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447509; cv=none; b=VPyCHqP7NBOjErfXvDsInS2invd5sYLxY1UNqZ40O48EHMzoazA+i14rtOINe6zIgLku/ob/zvmkghORKWNMeGkDA7qC/jdVd6sOo/8Pa8p5+0GwzgLJ6vrLy3eNkm8osN+UfSdR8EHGSD9puhJNU+Dlshjhx6HKCX3fFafERWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447509; c=relaxed/simple;
	bh=TKda9x4iT8tD/GLwRrobM9jKI4Kds3nnN4UVaZ3TYpY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EyBs549dLAwsmoI6kkZanlt9sJhTmq4K0wVRIhw/rhbfcQHVN2cvaUZrNHE81ZB/2YaO4VeBVOwtN9omlShqDanRp2DKKjHC3mMFdJzuMEr9lMrn3ZHOEphdZ1Yi9rz01stgjbB+yXw/oQbdLOlWjv7OxroEtosUFycU4KDpz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL92qj8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF52C4CECD;
	Tue, 12 Nov 2024 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447509;
	bh=TKda9x4iT8tD/GLwRrobM9jKI4Kds3nnN4UVaZ3TYpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rL92qj8Tyla9e7AR0InT4/UPrk3IHeEfW0npU2tEIeoHpThufyrqyX7UWUx/BxS88
	 NnacSUvaOBB5U56KBs4OfXjusyWoYNTA/aPw9b0LM3Vz3tYywOHIsRRAdqoJxc6MH5
	 lbYWcaJRrjBdilA7l56lHTzw3hclXrwzflCWFZ7jQaM8b1q17cklyTK4uANe0gyZhn
	 AIzUx6OMm6QJkXHxGPcxUr6++NhcbBX0bAlLT4UnDoExCUerxfdjPcveIOr2VrQvw/
	 97maU5IH6dYkI8H+jSOuWgxrY0ZZGLqXlMHBB8UwfqHfhBGqI3tu2mnbfWNB2hbHMu
	 xeBD4UKtzQ4Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04A3809A80;
	Tue, 12 Nov 2024 21:38:40 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <da138eda4ad9d96a8e8d1d1cfb9cc5ac380b94cb.camel@linux.ibm.com>
References: <da138eda4ad9d96a8e8d1d1cfb9cc5ac380b94cb.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <da138eda4ad9d96a8e8d1d1cfb9cc5ac380b94cb.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.12
X-PR-Tracked-Commit-Id: 08ae3e5f5fc8edb9bd0c7ef9696ff29ef18b26ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93db202ce00c07ca78121478b26dc77a6a72bce3
Message-Id: <173144751941.678506.10598827179538653821.pr-tracker-bot@kernel.org>
Date: Tue, 12 Nov 2024 21:38:39 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Nov 2024 11:36:00 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93db202ce00c07ca78121478b26dc77a6a72bce3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

