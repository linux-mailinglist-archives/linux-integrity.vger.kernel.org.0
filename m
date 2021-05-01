Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2261C370940
	for <lists+linux-integrity@lfdr.de>; Sun,  2 May 2021 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAWus (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 18:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhEAWus (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 18:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C2D061409;
        Sat,  1 May 2021 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619909397;
        bh=82eWlceGI55fQ3Qub29OMBT2jOMBdnA4b9bliDQF4HE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bRE4n61QAh5IagtfwPfDMD3km3j1+oFzpw2GTdH+GW/KRuh5cAvg2+JBak/fX5eZm
         uT/p1VnSqrFF4YFf3h/heOBBr1GdZpIv4aaX1VI+ycZaDEUvO0UPR0IOG0UIagGSuW
         iOg68JAT2RkOIBklkSURcTvvQ0DTs43UKdTlk4ntw5jXCFE6uAIIvUlOgNvm3FQmVt
         J5LZRxduAtq1Avu/ZeaVzMTwGDoKg53gK8pKK8TTGjvN6zty4QJWQLm/QA2At4DThH
         GCPfuiUP05WMOZ/LKvB3KEl0g+TFVcrxZQUvHna3m10fcyoUMdYxvgFNkG6k3jOREL
         s8OMiq5Ev1CKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 55A0660A3A;
        Sat,  1 May 2021 22:49:57 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
References: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.13
X-PR-Tracked-Commit-Id: 781a5739489949fd0f32432a9da17f7ddbccf1cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6f0bf09f0669b3c2cd77fa906830123279a0a21
Message-Id: <161990939728.12607.3075496329166566135.pr-tracker-bot@kernel.org>
Date:   Sat, 01 May 2021 22:49:57 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:46:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6f0bf09f0669b3c2cd77fa906830123279a0a21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
