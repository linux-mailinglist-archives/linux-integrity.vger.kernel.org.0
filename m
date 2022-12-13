Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDB64BF71
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Dec 2022 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiLMWfv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 17:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiLMWfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 17:35:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339EDFF4;
        Tue, 13 Dec 2022 14:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61C79CE17D2;
        Tue, 13 Dec 2022 22:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC52C433D2;
        Tue, 13 Dec 2022 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970938;
        bh=lGVRNVRhf5M7Vz650NbhzXQVyemLgroJQWakWG1/Xbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dic1OL//vR+fAE+Jv8pRR9YmXq6BLp2PszcfP4mxkIAPkjMmqKoLxZEksU6IvGqRx
         pP2yTmw4KQoMMWaIzMjY0DpcRVkeyVGUVqqOLSinT9TKyAQ+nmJgjCQm6gfawsqgiv
         pRMOfYESTswLfZFJUF/5Spwl7H8JTm5Ht8Wbn3EMqhSiMzODp3CVLZgAi1hC5Rp5yO
         P+E/CbM22SmpwvtSKoyIOSmEmDkbpWcU4Vg+FdFRNxRNSQIot+wxMP4dNyTLyCQd4p
         xKDEx46PfCzjHigHFb5cKSviNcCu45DY3MM6j0llywG0Msd8JQajrstbQUtB0euzoS
         Y/hHur1KFL8oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68EE9C41612;
        Tue, 13 Dec 2022 22:35:38 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbsytem updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7b388195aa5e10f1da934ed251809a6f21bf427e.camel@linux.ibm.com>
References: <7b388195aa5e10f1da934ed251809a6f21bf427e.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <7b388195aa5e10f1da934ed251809a6f21bf427e.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.2
X-PR-Tracked-Commit-Id: b6018af440a07bd0d74b58c4e18045f4a8dbfe6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 717e6eb49bdd98357d14c90d60a3409196b33cfc
Message-Id: <167097093842.5412.12310501870234717256.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 22:35:38 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 15:20:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/717e6eb49bdd98357d14c90d60a3409196b33cfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
