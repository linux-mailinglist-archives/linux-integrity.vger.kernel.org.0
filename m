Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3C6B6C91
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCLXeB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Mar 2023 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLXeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Mar 2023 19:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49933F770;
        Sun, 12 Mar 2023 16:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D60E060F84;
        Sun, 12 Mar 2023 23:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40203C433D2;
        Sun, 12 Mar 2023 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678664038;
        bh=9hQ64muwXIXfO9NNRhHxBVK0eY6fJamQWVhPBL5Esck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RwOactAP1ueypWL0A9z34kwqCd0d0BeZQaOuIZkXlgsEqOhup490NAAhRMmw0aWTU
         wV6f790mruKHNJrf32HycCvT6t9vOFoZJLO3FgZ+DNckqbW6CeqQIeEhQl4Em2sck3
         2bL5QBOkyYwFBybW92VJh31VQ741npxK/BlV8NyDgUkGNmhgPe5++/JNtJOvvafV9k
         HAFpubrdfUTHvRpLisCDfnvGsNHJE5pMmpThCe0zq4rSXkH4fO89K1UT3wWP9ji7CX
         v6sNZf6nyp4gRi7USkA9j++HOn1WuajCqhueyqkTxImjcd+IMZ+sJD57Y7aBbCzVUx
         AN569amIu6keA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD34E61B75;
        Sun, 12 Mar 2023 23:33:58 +0000 (UTC)
Subject: Re: [GIT PULL] tpm: changes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <698049d487a816fe3579200b2e02648d8d60b2be.camel@kernel.org>
References: <698049d487a816fe3579200b2e02648d8d60b2be.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <698049d487a816fe3579200b2e02648d8d60b2be.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc3
X-PR-Tracked-Commit-Id: f1324bbc4011ed8aef3f4552210fc429bcd616da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4ecd87f75ec4d5ac3006ef21ce07e812982e46e
Message-Id: <167866403817.1417.646090000604786585.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Mar 2023 23:33:58 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Sun, 12 Mar 2023 23:34:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4ecd87f75ec4d5ac3006ef21ce07e812982e46e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
