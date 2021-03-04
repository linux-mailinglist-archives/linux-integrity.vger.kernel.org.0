Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970332DBA9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbhCDVRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 16:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234894AbhCDVRU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 16:17:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 41D8264FE9;
        Thu,  4 Mar 2021 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614892600;
        bh=cuT3N1LMmVnp/etZDRus0pCM8J/fko76QJcojRdcQZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lNaYjKM0KjilalgC8bjPRu+XoaLYbBqkngxvxDac3ww7nhqHPatJmH+mkVebyoSPA
         6ZOqEjPKtROy5g1/fBkfDmkyHnKsYaCjmt3qC85XQSZz1pRssXQn9vKBPwK8lGAmk3
         XI98L71b+D+OATZMkyDzhYgBcmpbysw/3XwLt1QijtaBR35HS7zWFaedUXgQMBs+5b
         dftsvbr2V5jrRbMALESEhMiGPjRB7tzYrDmk78YpacGbVKvRy3wIQ+Ci8R4tuj/MAd
         nRty57GbZ3zG+ehk9IoGWJ/ntMLj4o1OKZy+H6dhzj5WzJKZqxT7zQ72nL6Q06MbWw
         y3Sh44N5cHq/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 329B3600DF;
        Thu,  4 Mar 2021 21:16:40 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YD+wyJzpguBWP33i@kernel.org>
References: <YD+wyJzpguBWP33i@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <YD+wyJzpguBWP33i@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc2
X-PR-Tracked-Commit-Id: 232a37ea3aee9cb37bbc154fb1440a66ae4743f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cb60ee6323968b694208c4cbd56a7176396e931
Message-Id: <161489260014.11784.3671916755358918237.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Mar 2021 21:16:40 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 3 Mar 2021 17:52:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cb60ee6323968b694208c4cbd56a7176396e931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
