Return-Path: <linux-integrity+bounces-3412-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666E961E38
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2024 07:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54CF1F24EAC
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2024 05:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5714D29D;
	Wed, 28 Aug 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDb1l480"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B414AD25;
	Wed, 28 Aug 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823140; cv=none; b=S4H9qoqDP2WRfb+UCLRhUgX0yaq1pnqMre2WP5+rIbyGhql+WfxcyeI7Lt71RFfta1ZdWCu1ncuVYt4/5D2lu+JJCxDNEUcJHQyBUjmbwp1spePrkyQ3PUZZKNdXjvQCGEQQVq6uRSrsz1cbS9KYBcFvqjFOsetQE5c8Fkx0FUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823140; c=relaxed/simple;
	bh=olmmimMEbwDxYfJ3/akHUI21VGIKzZvVUXeUuGj+0WI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L/++jdJT4151elDAUxTNU62X7By1fdoLJ+6TFoo71JQ7+FT1gPo0YF9MEw20/WKZqHWJcbqAlG2zrrbDA0rydQwKf+9A3+LW8wBryw1EuPKdqXNUagz582sXtwVAHTOzPGsa5PIArS0hQ9Ndm7Y0jKjt4hR0dIuJqmAZpU70ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDb1l480; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B0EC4AF19;
	Wed, 28 Aug 2024 05:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724823140;
	bh=olmmimMEbwDxYfJ3/akHUI21VGIKzZvVUXeUuGj+0WI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VDb1l480Cks0yXzbSebTymGYQhmtZ/U9YSBbjpnGRGdmHEtVfmjMd76lju0LBtEBy
	 Bh9Y9VJg2aHY+jXiczPTDS32BLLxo2g0VmbJ0LcwQVbIEU8fBS3RyPP5ZOl3y9RUaA
	 2hJkCdZpQe+NWnZVb0SmWYrPC4eAc+oRdihfd6PHm0idli+HdCC5e+d/WanEq9vzZe
	 uqX7X8DrftlMcEO0EefGQ+PCdB0koQJQOtSZwfAAfoXhQ1RSMJhUxdLSFSFCW5q1AA
	 4TqmPhymrb1eMYi+Tep8wFN061f9bzR9iMxRzLJl7ea/heDHLwe4IU1nFCO2YYVQGS
	 LZjdrO/PcVyyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F493822D6F;
	Wed, 28 Aug 2024 05:32:21 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <D3QXXCFHY73S.26C2JS9ZOV7IQ@kernel.org>
References: <D3QXXCFHY73S.26C2JS9ZOV7IQ@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D3QXXCFHY73S.26C2JS9ZOV7IQ@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc6
X-PR-Tracked-Commit-Id: 08d08e2e9f0ad1af0044e4747723f66677c35ee9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46d22bfdf0bc76429f596c58ca74a8f67d0f6251
Message-Id: <172482314011.853602.7428886411403749943.pr-tracker-bot@kernel.org>
Date: Wed, 28 Aug 2024 05:32:20 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan
 Berger <stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 Aug 2024 22:28:13 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46d22bfdf0bc76429f596c58ca74a8f67d0f6251

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

