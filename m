Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448EE5F3AE5
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJDBDv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Oct 2022 21:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDBDs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Oct 2022 21:03:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BF1C43E;
        Mon,  3 Oct 2022 18:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D01B818C9;
        Tue,  4 Oct 2022 01:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFACC433C1;
        Tue,  4 Oct 2022 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664845424;
        bh=usy/t4797y26+2qPHJ6Nr19dd7TKe2UZcev/3gyy/yQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bj8nAcBs08BDwsfXuZyJ4ESji3ZX1+sbA7tsHv9VwU1iwgrv4RLs7M+A/sNNjjsiQ
         w+ijP2tvRZuKaOB6spQsGAMVmSe+6LIl/6BTsedYxbk4iCt5ppnilWiy/bDKqWtI3A
         HDtO0t5x3felzx+s/w/EwZGz8g976kr7dmahpq+x366/IL2EkksyTtMwKR0Gh0tNaP
         GUdLn0P3r4na88kmOQw35uehsEnJGmdnSqwAaDoJRSN1idE3+iDx0vQ5qQxHfOSBHO
         swet9twCMKHHLSN6KfNc5FyT3xEHvwkSeu+5/pS3fS+1ioG6d+T+oxDq8Tw4dKd51S
         NjHPOb6PN8BNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9CB3E49FA3;
        Tue,  4 Oct 2022 01:03:44 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbsytem updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fc8f279ee3ac05e8adbaf10974bf8eda57824f57.camel@linux.ibm.com>
References: <fc8f279ee3ac05e8adbaf10974bf8eda57824f57.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc8f279ee3ac05e8adbaf10974bf8eda57824f57.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.1
X-PR-Tracked-Commit-Id: bab715bdaa9ebf28d99a6d1efb2704a30125e96d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eafb121ec0dbcd9a5a1ab0e78dfc06a67af7d536
Message-Id: <166484542469.7481.18421257689421276204.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 01:03:44 +0000
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

The pull request you sent on Mon, 03 Oct 2022 14:27:16 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eafb121ec0dbcd9a5a1ab0e78dfc06a67af7d536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
