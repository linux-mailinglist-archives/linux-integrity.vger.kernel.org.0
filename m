Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E3441F3E
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 18:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKARbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 13:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKARbX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0236060E52;
        Mon,  1 Nov 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787730;
        bh=u9/YqL4okeaq06nWtVTHi0mXPdkw3Gt5DbFWaZOmVj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G8xSv+EnRKDHhJqMJ8wBNgOSMP1xba0WwC1KmsfgyDooZbisE8f3YdiX3Q6JVIjea
         2qhf8U8+fUB7cwW9BTAq3J4S36taHX86iuxttU+Tivn7rIIoK49/HGGGA51DSCXLUv
         hYQRkEC4eCbL1QNvPdNNQ/kM6BDJqSCQ1o+SFKOSdU6mSuwHzLGfqyCXgO+SE0sP0q
         6nf9cv1QUU2pEDqP7vhiKDVFkrfx5FRyF6+dU+/aZvTKceSrzA1xlHMTX2eztEk3Z9
         UzNjxyObAuKTiyY7gTGCboD0VbLZHpL8efX5LFPHxM+Yr63H/HMdCPXks8dPlEb7AZ
         dz/lL7xRtgxqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EFC36609B9;
        Mon,  1 Nov 2021 17:28:49 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXdkK4IH9J1xcMXb@iki.fi>
References: <YXdkK4IH9J1xcMXb@iki.fi>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXdkK4IH9J1xcMXb@iki.fi>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.16
X-PR-Tracked-Commit-Id: 7eba41fe8c7bb01ff3d4b757bd622375792bc720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad98a9246616e736504d1ebc2f3f35c2c0dcb806
Message-Id: <163578772997.18307.941320912979431776.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:49 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 26 Oct 2021 05:12:59 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad98a9246616e736504d1ebc2f3f35c2c0dcb806

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
