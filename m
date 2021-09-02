Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAD3FF495
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Sep 2021 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhIBUG0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Sep 2021 16:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344026AbhIBUGZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Sep 2021 16:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 90577610A0;
        Thu,  2 Sep 2021 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630613126;
        bh=xRNZPBuVp2t/cQqvoFHmwN0MEQwV+pu2fjPgQl0UcFQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y7rv4H2m18KG00tbFB5XCoXm1XFgYZJqYlPmpmNqDYWBbqDgV+z+dN1bmpRypFgc7
         uMfROSquFhtoT+Z1zMAivIMmYXgdZ8ORcfqEFWtsj9EkaIqJa+CePl6GGbjZ5/+To3
         +oOKRlTOZ5V+2WvlataCZeeVCya7mjLwq+94TRs/ogkwk8lb7oT94BPTAyIcvjeeI4
         h8fUs5+8JAgvJTGsLu41MtOviQ4TpD4U3JSHMVp3TnMXICN+hCEr6Bw0HeouCO6Vgx
         4AxCD1mRM0gZ/AUDKCAjJJpqYFEGmKukPtBPEkHmgfrNQxg7bABKOv8yPnly3y83GZ
         Wvk3OO/xZjRjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 854D860A0C;
        Thu,  2 Sep 2021 20:05:26 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5b3eedc2dcd03a8d16a8fbed3f4c2466521e1bdb.camel@linux.ibm.com>
References: <5b3eedc2dcd03a8d16a8fbed3f4c2466521e1bdb.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5b3eedc2dcd03a8d16a8fbed3f4c2466521e1bdb.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.15
X-PR-Tracked-Commit-Id: cb181da161963eddc9de0000de6ab2c7942be219
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aef4892a63c248c31718d23941536b86829a49f0
Message-Id: <163061312653.10011.11187886826098889539.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:05:26 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 18:58:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aef4892a63c248c31718d23941536b86829a49f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
