Return-Path: <linux-integrity+bounces-6750-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F554B17677
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 21:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8077A1C224D3
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E792459F6;
	Thu, 31 Jul 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb76o1mt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C292459D0;
	Thu, 31 Jul 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988843; cv=none; b=aOMMkUB7N5JunwvoZ15je+GrcNdbmaut5AHO0feQv/zyBl96UjSW+2T5A1EzoMCzn/+DNrV2qdUd92z24iovHQZ8oCERzMdDcoMo2n5JdMnE2M/gGS7y7rGRR+8HUJcVLtzmQgYZy0yHITGjzQgSH4wlAjvKBrVvfZsm8hAiGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988843; c=relaxed/simple;
	bh=X2Ksqqo+uOegE07rui5sIopMBb2BzNUaNOngKnaLpYQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FHncFp1r+GxnugsQciZ40jorldcOiPgw/zowrekp9I66l7P5JYNrsw1l+ZGJvn3JEjqiIxz29cuJVceNdfFmeooVoj2mZQM5Fj8OT7cXb99RynMakm3c//t7PhmnYaPzFw++CdqeOUjlX8/FVyeg049Wvc1DF5BNhTumQvNdXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb76o1mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B8C4CEEF;
	Thu, 31 Jul 2025 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988843;
	bh=X2Ksqqo+uOegE07rui5sIopMBb2BzNUaNOngKnaLpYQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rb76o1mtfoq+2NM8S3MzJ9g1X2Pbpw3F9LDI0pus8ic2EnmfF4zSu01Jywyh5LS+c
	 t6APCeqbexwDy3fh5hlDb9xaWf6IoqsCIuTzZWUwcCnGBByqY4ov2UX1x2XfFPsilH
	 CXo2yATrPCEYmZQYLOeOcI/SQzTAmSD1OW5W8FAc2nTN+TCGOW9xDk8wgQsJazKI8E
	 9BUE9I9b+Gcx+xLn3jDNGTHkn4frojOsoQZgP5QE4kn+aSEAKYc1InIIPBMehWuIjR
	 ziFhQP0YfTbT3HLdt40/3xlOz/TXTalpZqZ9DD5o4sGbPqJFGB10VM2gUC+X8mNpcx
	 SSdl26vo/BZRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C09383BF51;
	Thu, 31 Jul 2025 19:07:40 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <807ead8fdb2761721a4d79b89efb385420a0d6f0.camel@linux.ibm.com>
References: <807ead8fdb2761721a4d79b89efb385420a0d6f0.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <807ead8fdb2761721a4d79b89efb385420a0d6f0.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.17
X-PR-Tracked-Commit-Id: aa9bb1b32594cd67cafd29b330b158128b503882
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02523d2d93b9c825dadc0f93cf77c1622cd64a86
Message-Id: <175398885886.3259326.8836108501359435438.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:38 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 08:52:07 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02523d2d93b9c825dadc0f93cf77c1622cd64a86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

