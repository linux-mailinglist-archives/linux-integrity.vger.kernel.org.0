Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C480C2DC753
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Dec 2020 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgLPTpU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Dec 2020 14:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgLPTpU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:20 -0500
Subject: Re: [GIT PULL] integrity subsystem updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147879;
        bh=0OrysmBbr9MJ6XZhtmecax57fNXqhRoRa1bSh+K7sI8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tMK/UFatUWltG+l/W5eO2dzZpUnMagB2/wvsZ5bIbj6Uuhxe8irwa41bItGrycxAQ
         z/N/u/dTwtM6dtpQYl9F4gxZDQT/kR6Wq9Nabs1TCJdMSFj0A9DkoQ1am14YmQFmsQ
         4gk74UNFBpWQdNeLr7yz36qJN5gAWPf4gvPLnCZrM6PRS/W+8JKfvh+0tE4JyAq95s
         BgS+0tKa12XKmcJzAoBit3q/l9KooGxTCHnDin0vRmihUkeZKFN6HDJyb0VRCZj8W/
         2o3EwurI8ZG1Q0euONW9hUuREVSB0Mc1rAT3MdnRmMN1ntF/3XBRIQvPb4bDuPZL/i
         JgahFRn5WZRLA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1d4caa0d060caa9249d97acf5d8a9a0fe944076b.camel@linux.ibm.com>
References: <1d4caa0d060caa9249d97acf5d8a9a0fe944076b.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1d4caa0d060caa9249d97acf5d8a9a0fe944076b.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.11
X-PR-Tracked-Commit-Id: 207cdd565dfc95a0a5185263a567817b7ebf5467
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e20a9b92ddbfe662807622dbb28e1fbb6e0011aa
Message-Id: <160814787940.14944.7548852802140867240.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:39 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 07:45:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e20a9b92ddbfe662807622dbb28e1fbb6e0011aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
