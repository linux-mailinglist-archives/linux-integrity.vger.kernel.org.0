Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3008148B958
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiAKVYu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 16:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244811AbiAKVYu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 16:24:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68935C06173F;
        Tue, 11 Jan 2022 13:24:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A0661778;
        Tue, 11 Jan 2022 21:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F352FC36AEF;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641936289;
        bh=wyGgYCXRHCxpe66UzXa/dRUFuZdMrnjcvVwY6fmwsWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gkzvqVT7ibC4B1ZUFNFmU2SdZvEfvpUyfIFQjpoHXS9KbzyKPepffD2Oet2OtP4ci
         D1Vo2LkqKWhumYKX0WVaha43AnB4E7yE6EdmDecuEYgXrylU0ZYSsNUkXD4tOsJzHx
         IOvR1O44yRmMsulgJygWmVzmzIdU12IagqUBOdlfHke5EJpPWwnX9lrjYg1I97bWTJ
         nBiHoWD7XVkGrWFhrNWE6G2HfJXftb5/5SaGGdtsX+Bp4Q63EABg1QkF9s/RjpwU+c
         kecAf1XF3+msgUTSdTOUTBZflFv06zGbyxj6RfqEtKQNgEKqo5QQ2vuy8WXGTnWm9D
         pKjJkcWIVwgwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCDB4F6078A;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.17 (fixed)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdzhGWLSIbc4muBZ@iki.fi>
References: <YdzhGWLSIbc4muBZ@iki.fi>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdzhGWLSIbc4muBZ@iki.fi>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.17-fixed
X-PR-Tracked-Commit-Id: d99a8af48a3de727173415ccb17f6b6ba60d5573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dabd40ecaf693a18afd4c59c8d7280610d95b66e
Message-Id: <164193628889.30592.9863042920180678465.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 21:24:48 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 03:44:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.17-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dabd40ecaf693a18afd4c59c8d7280610d95b66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
