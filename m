Return-Path: <linux-integrity+bounces-4614-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9CA19DC0
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 05:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045B53AC173
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C6191F89;
	Thu, 23 Jan 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opWQfCCH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7435975;
	Thu, 23 Jan 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737607716; cv=none; b=ePzPMQqCX4IuoqS7VhwlIHuMO8ncisAT++QkbWVTa/HAg0OhwaIpGsZlBXlrI4BOaf+MJwUeWq9DXaSygKIiRcpg4DGuHVsoZ53mBZC6UbOzvpm0rUaZ3VKGBUl732yY76Vu1QWp3FW+K4FZXbz/dVgllUh9Dg0Pt28bNplgsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737607716; c=relaxed/simple;
	bh=MGVhInXazJKw8zZINpNxMFD6LMwFIG7MbTn5+cnS+S4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W/7+euC9ibvkOpNQj/sQ/+w5nIcOMdnkHp/JRZ+bRihlqTJVj+KZRCtz9qqP2SeI2BQvyRMnzmPEZJte7fuPHMoQYFy9gEdFo8xnPRhvNbwB/9zKc5ZNYlwC6vafdD43ZMxdwIPXeVHyDRR/X9rdUtFKuPM9MuoT/gmE6EB3BsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opWQfCCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C03C4CED3;
	Thu, 23 Jan 2025 04:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737607716;
	bh=MGVhInXazJKw8zZINpNxMFD6LMwFIG7MbTn5+cnS+S4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=opWQfCCH+QmZ95urcLPI2lRgmW0pwN4XrNUpol1333CprY+eHxQzITB1tkpsmD4Yw
	 TAFyOECz8mP8cQSFB++w4Lpg2BbrvmGAAARYS9FcOA6y8shXKBkEMOQZUhG/IJHi+v
	 KRBxjHP9Kp0kEtqdV/JMCj7gEQL9YuSuKaI/byQj00nC3YT+HdYREsRYjaF6djbn77
	 kHJhAEUMYdf9YXSP8DgHqhSZUNEbazt/G+TlopFyVW8gUEQNJMrQ7zAgJSh849nRTe
	 m/1uAlmp6TMfSCLPzMbZnOVayAeoBIkUn4PQlrYaGKQnvW8XLhSM6qn9kUm02d51kN
	 O5QpGBCBlaj6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF0380AA70;
	Thu, 23 Jan 2025 04:49:02 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: keys-next-6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>
References: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.13-rc1
X-PR-Tracked-Commit-Id: e8d9fab39d1f87b52932646b2f1e7877aa3fc0f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cb2bf599b2ce832127fa61fb430cc00a724d371
Message-Id: <173760774079.924577.13685941656583380395.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 04:49:00 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 11:36:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cb2bf599b2ce832127fa61fb430cc00a724d371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

