Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE15B320F0C
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBVBVx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 20:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhBVBVs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 20:21:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E556864EE6;
        Mon, 22 Feb 2021 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956867;
        bh=eSycQ0AwM+y196fjfitSd0j4PJcUfSNvoEvqV26gbIE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jx9T8cemJkdHHMvRBblD4infkNB+txOpU0YmT/WXo+KvqDRAEnwlJLb/AP8HOVZw2
         fYo0QVOrz9Az3PV6WzQWwtBjAN4NgUyy9F7dtc1L7cHjEsPPqIx25h6tyr0sMJAAlw
         Pgu2Iur94FIALfAlP1misukE8XqgdYeQGBnyCluhYRTqHnr9ZZ+beM/uazvUI1W2Ph
         EEANlcpUhLFaQcrqj0ya0TSkNFpmzyMPsUvbemfNYtkkd+PHSPXNp9KNbZCdrin+rS
         qaNFVmDbEZot5jF4/vETSTegHmyP9a+DVkS5TO+fKnyyoCv9M1o8RlPD5ynucnkuZ8
         8DWtIARdzPeiA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DA51E60A3D;
        Mon, 22 Feb 2021 01:21:07 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d42636f6983ac73e8c36f727225b213688780d14.camel@linux.ibm.com>
References: <d42636f6983ac73e8c36f727225b213688780d14.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d42636f6983ac73e8c36f727225b213688780d14.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12
X-PR-Tracked-Commit-Id: f6692213b5045dc461ce0858fb18cf46f328c202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d643a990891abdb0fd93ff3740a6f7222fbb756c
Message-Id: <161395686788.836.12411399149685412400.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:21:07 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 08:52:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d643a990891abdb0fd93ff3740a6f7222fbb756c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
