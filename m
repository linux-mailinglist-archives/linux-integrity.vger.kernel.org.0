Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2B6F36C2
	for <lists+linux-integrity@lfdr.de>; Mon,  1 May 2023 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjEAT12 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 May 2023 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjEAT1Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 May 2023 15:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD892733;
        Mon,  1 May 2023 12:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E9161EDE;
        Mon,  1 May 2023 19:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E0D7C4339B;
        Mon,  1 May 2023 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969166;
        bh=7MZ2MVRLq4Meevru6ymYnE9bcWrLvZQXxpYf6Cp3nkk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AJsXnRxaLD+X8FLwchuMIkNoKnk48UL/ir4A67OWpOMmlKTqjjcdhZAtCEyyspm7N
         Ii3FkYv418ThYorL3+RpNmWDH6sUGfnNvGJuQ8gTK9vBqC+aOkhF8mdss4XCZMoFJi
         N1yYl1/uOtIDNtLAHINNQkNhNgBkP6F+uAua8TuriwCavdieT6J9HfyKqJnMErZY2d
         3Cxz/NMhtrtJMrtfIY6S4tN9xk91sBV8fstcLNKZHWlBrD+nzMkck7xgBHt2L1OQ+o
         4TeoP05B3s8AeuE2YiOOD0NwNIOEKuSK2xjSUureq32tcC3R1QtuZdyc8GFARSs5Ib
         fUi878T6nN6Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B815C395C8;
        Mon,  1 May 2023 19:26:06 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1 (v2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230430143342.790113-1-jarkko@kernel.org>
References: <20230430143342.790113-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230430143342.790113-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1-fix-v2
X-PR-Tracked-Commit-Id: 0c8862de05c1a087795ee0a87bf61a6394306cc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed9a65e575cc3c52a7f130d824671fe48a72da0c
Message-Id: <168296916604.17937.12524264752923841862.pr-tracker-bot@kernel.org>
Date:   Mon, 01 May 2023 19:26:06 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Sun, 30 Apr 2023 17:33:42 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1-fix-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed9a65e575cc3c52a7f130d824671fe48a72da0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
