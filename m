Return-Path: <linux-integrity+bounces-4604-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698DA18AF2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2025 05:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FE07A3196
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2025 04:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C11684AC;
	Wed, 22 Jan 2025 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MewTe7+k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC104158862;
	Wed, 22 Jan 2025 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519306; cv=none; b=hJ/viI223QM/+eo2n6dsyXG7am74kodyvFJ7DwZaM/bw2mIXUN65vJyc/Apa79M24SuDdrk6zu3nDvazl5oDHXMfZxc0LQqllM9LLjTHYiVUo0sCr3mV9vIoe166WfOd+n2G+7yZYXJGSgOYOjF9q9zc+q2SRqsAFiJzCkIyyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519306; c=relaxed/simple;
	bh=zPg3OsJkmNp8nnwYV1AWx3Kbvuj4a0NnBvfUk4GqS5Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l09WSUcwB0sTB2XotUHtLgIb778niyCXfayQhcgzRrbpCim5UPnr2cXik/ZfhU6JpAtuJ3cZ8AhHfelwYM+r23BO/gfwFY4yBYnyN9pwde9kenNOEuYm4+26OhDW6BKG6blLCuF7ylpNJjg28sF7GpIrPpOdlglA+kFRcbuVczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MewTe7+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28038C4CEE6;
	Wed, 22 Jan 2025 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737519306;
	bh=zPg3OsJkmNp8nnwYV1AWx3Kbvuj4a0NnBvfUk4GqS5Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MewTe7+kUUVnAtYvxeMx51ymEA3LsEugVgISQ8iU7CQL2GI7Ic6iAvo2bZWQBSlfW
	 xvfMnqJqi+UQksb4n4Ybn/GcIoGkxtU8ffYaQ/9LWrVCn61o8chony58yP6TTFs9Xv
	 kdYeg+5VEqnfywK9dgrS1Obv0bEKoTU61ztr1EvAYpqRwsQPHuPsI5c8OOHKxM6L0d
	 dSc12JCROteFvY+IKiDWqs03612ovK3f9cCUfPrI/r6Id9RXJR0syqLfqwv1WFaNv/
	 B19faxoAjgIQTNsB9ga06A9pfMUdk+GmtCwUm3Iu2LEBq0jkxYr7c/XOBK3Hd2t+yx
	 z/mGu2iFhtyxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4C380AA6B;
	Wed, 22 Jan 2025 04:15:31 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
References: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.13
X-PR-Tracked-Commit-Id: 4785ed362a24d4f37ee0eb4403f587fee886f8da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ca0cf9f8cb16e3850e5242d68a1825d286e6a68
Message-Id: <173751933026.229101.7409335772969918480.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 04:15:30 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jan 2025 18:02:05 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ca0cf9f8cb16e3850e5242d68a1825d286e6a68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

