Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1414A36886B
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhDVVFQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 17:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236994AbhDVVFQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 17:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F192E61417;
        Thu, 22 Apr 2021 21:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619125480;
        bh=eqQJlhavlu1BWjx6x6jmXmd/EYQK0dtumFRO7a9Or7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L+rYjejtZGpNpzCHaEcTJarwgf8SyNXqQhUccQvB0WRGdNMgks6SZbKdLF3e3BB87
         ajhvBzAUPnzcvH5OkRM2TbABguzTIfLPGoqX0pW3u98KkYVZm2cem47bYTqgN/U3kY
         Dqrdtgek9cDJP0BEkxQ23CblNkGkABVG6XFFtU3T66atpMbq5mtBXvpUF/BEehw+Ok
         1nTS2S0U8/mimt4HB6fKMaNBeGiEvHn38JptIIw1Vo66QteAExIoEcIfiGKf+0SAgr
         cbz4AVFP4b2Ur29/n/RXliiNPCumHhRe6rZ31+ZF4AM5UnmCVlgE5lQsAso5VGK4sj
         y8F5wXEHwa2wA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E73F160A52;
        Thu, 22 Apr 2021 21:04:39 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: trusted fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
References: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git fixes
X-PR-Tracked-Commit-Id: 9d5171eab462a63e2fbebfccf6026e92be018f20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90c911ad7445ccec9936763f05fa5db6a3da53be
Message-Id: <161912547988.8509.13149972705464630691.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Apr 2021 21:04:39 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 22 Apr 2021 13:26:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90c911ad7445ccec9936763f05fa5db6a3da53be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
