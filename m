Return-Path: <linux-integrity+bounces-2423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95D8C6ABB
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 18:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D30284D73
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B58481A6;
	Wed, 15 May 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9LxPMb3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F52D052;
	Wed, 15 May 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790911; cv=none; b=u4K0LNPzrDhscqEcyc6kIkP4Xj7sZV2mypXlKRYcR/C/K7hHqnXiRuLSn5wo+DQhGK0OgIz9LRT8Qq9xv9Y3ifzXIKPNrqF7Ce0sLr4aESwsTpcHWuIcxpnyBeFHqcJxt7UxZprMopAemQ//NYdtkOsj2VGAlyu5fQHnao/PZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790911; c=relaxed/simple;
	bh=jyVVUJSwo6c+v3Buq1nMc68pdaHuljQeMCavuuB3no4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hMmy15FDuih9mxragGqXTjCpm03UB03rKTHO8R+2CI39bwJciYOhH4VvUBSa+uKp9auN6MmPdqrSS7qTuXB8jgwi/P8VIlY4PzocnfiOBrPkkAFPzM0qPkXXzuT3xdN8ugbx27w9govI8HBS9G1pEcdzb0jy15VUBfaHPh89aCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9LxPMb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17768C32789;
	Wed, 15 May 2024 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790911;
	bh=jyVVUJSwo6c+v3Buq1nMc68pdaHuljQeMCavuuB3no4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u9LxPMb3ek5adgi47oo6iMa1DiU6bYYes7S8ipU9P3JynwyBfw4IEuoT99WqSpo20
	 3StiIVqRYMma5VDobWJAHS52WoPnIGzCQuaj9Vuqm9EgkLpXnazrGj26nWMVCdnwyO
	 JaMQsPUhlKkCe97JuCs+G4OJOFCNxi3wUT3gNXzVfu7OQav+croW5PTLtzdyXtwZhQ
	 ZrNmiyhZqELDqBabNiAI+8Y4PipKBIpre27pmg2OWauTEaXnT3AgXG92VMqPFkFknG
	 iYyML89ptpq4KC1w6mtWlA7jLYvg9b/wy75ozgrhkRU5XFelJzMZl/U8j9Xt7JSvGp
	 jBsivWBq7TFCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EBE4C43332;
	Wed, 15 May 2024 16:35:11 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <1887e28b6bcbe1eca72028432c9e0fee7a72fbfe.camel@linux.ibm.com>
References: <1887e28b6bcbe1eca72028432c9e0fee7a72fbfe.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1887e28b6bcbe1eca72028432c9e0fee7a72fbfe.camel@linux.ibm.com>
X-PR-Tracked-Remote: ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10
X-PR-Tracked-Commit-Id: 9fa8e76250082a45d0d3dad525419ab98bd01658
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 353ad6c0839431146fdee3ff16f9dd17a2809ee4
Message-Id: <171579091105.28973.13692185848418256314.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 16:35:11 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 07:55:47 -0400:

> ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/353ad6c0839431146fdee3ff16f9dd17a2809ee4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

