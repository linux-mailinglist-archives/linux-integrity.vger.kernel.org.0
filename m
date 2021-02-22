Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD8320F0F
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBVBWQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 20:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhBVBWN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 20:22:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6AE1464EE9;
        Mon, 22 Feb 2021 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956868;
        bh=2GQNGHukOQx53pJvxlKMMdyYnGC51296sKH75XDliSA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RHtDy3sRrNJLab3FaJk/9hQXYGju8iCbAf6UF4aZmwiGga8ecd0pjm1W/w0SJjLOU
         pvGIszkFyQNb28Od/zZTN0Gih2NsAMMxseNFRTf4aqB4B7P6FYpMes0kdLXqAFHBWj
         j0hV9JDp+S2xRA+5HUWah1U2mp9373IYePQvJ0fe7b7QfCjCS/tJTsWfR8yWUdKW+l
         GYjI2S8heBUDjkNX4V7DB/jRMqk96/NtBREGuDeRSk2qgsxgBMQhP3TvMhDJmVLOdj
         Ffc61X2DwvWbrcg1TRYEWjLxyeu5UogXFo8bCjwl9X2wJ8Wvk75Rh+LZ+glJnRslOp
         5+tLFasU+ZqbA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 64E6E60192;
        Mon, 22 Feb 2021 01:21:08 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YC3fkU2pLncCkeps@kernel.org>
References: <YC3fkU2pLncCkeps@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YC3fkU2pLncCkeps@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc1-v2
X-PR-Tracked-Commit-Id: 8c657a0590de585b1115847c17b34a58025f2f4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2b095e0efa7229a1a88602283ba1a8a32004851
Message-Id: <161395686840.836.14179625938652754129.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:21:08 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 18 Feb 2021 05:31:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc1-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2b095e0efa7229a1a88602283ba1a8a32004851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
