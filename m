Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9036A69D4EA
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 21:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBTUX1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 15:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBTUX0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3A975E;
        Mon, 20 Feb 2023 12:22:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7FF60F31;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5F44C4339B;
        Mon, 20 Feb 2023 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924404;
        bh=j4kQURX4WS0lECAPcH03am1jXh9wlpgaECtk9AyOUHw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GCeh5nGznoQpdOaQYhdkTgRj/fyEF/3QZ7usO121HBO4aAeiYlsvBb2z43yR0rXay
         aeZ7psh3yCmw2Gr6Uw+oV/bya8EznP8JkahP8YYm2RQfI4aFM3PVQU6REnAayknvoi
         CJ8xSW4ydHGHVBlfNaxa4w5nvMn1vXc7ugnwxBAiPa+vy0M/H8UY37eiLdHNL8Ohnx
         WZxMwcurJWZ5pY8IA6DCIUtY3mdm40mitU/B//Q8A5VkwyAkFe2SCRndkx+5ADhrZx
         aGyIRBxnZHMrcd6Fh8W15im+KJoJK8nxoZ1OG+5BHaju2BLQiic/BwujO3i6wB0rf3
         o2V5GOiyQahDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCBADC59A4C;
        Mon, 20 Feb 2023 20:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] tpm: changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+n3AoInyQkuyTfM@kernel.org>
References: <Y+n3AoInyQkuyTfM@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+n3AoInyQkuyTfM@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc1
X-PR-Tracked-Commit-Id: 85b93bbd1c9768d09adebbe9f33bab0d4ec94404
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 219ac97a486c1ad9c110cb96ebdad7ba068236fb
Message-Id: <167692440476.19824.16930382764898377969.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:04 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 13 Feb 2023 10:38:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/219ac97a486c1ad9c110cb96ebdad7ba068236fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
