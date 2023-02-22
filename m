Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300969FD45
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Feb 2023 21:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjBVU7L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Feb 2023 15:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBVU7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Feb 2023 15:59:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3143447;
        Wed, 22 Feb 2023 12:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AED31B8184C;
        Wed, 22 Feb 2023 20:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D08CC4339B;
        Wed, 22 Feb 2023 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099541;
        bh=+pdmaJ00Dk6lYEzvAY6HsJf1RnU6Ccih4ElIdsnLnM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gOA5fHyIMq3wyGSrdjOtU18Xjle40XYzFrnKrSqgmBFxEHvS3WwkhvDfsKkbLuErv
         BH676D5ufBE+JnGk6MV4CwL0SB58Caj0hul2q/bR189WCW60iMgbafFNQxOIQS3ELG
         PMz7iN0j50ewR+9rgJvycK7aonOH/s7MfuMwHLPsM/E/+gmInRqeGzG7Uhw0d9tq8N
         +pR1FlEelfLHz5Q3/BR3tei3r7GFc0Yjayl8cVYy85OsNjmTNPe6HyvXM8WmuM7K0A
         xhdWOQxH/BNbabdVrUBbZOhuRZOKT7kI/wUV2j6XZtgoh2js/lPOicov7AtTd0BkYd
         +NbC1OO2rkgdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AC24C43151;
        Wed, 22 Feb 2023 20:59:01 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbsytem updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1c1482de9ab0573f0ca4bef0a47260026264e926.camel@linux.ibm.com>
References: <1c1482de9ab0573f0ca4bef0a47260026264e926.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1c1482de9ab0573f0ca4bef0a47260026264e926.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.3
X-PR-Tracked-Commit-Id: 4958db3245fa655bf18251bd2a83bcc164071c39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67e2dcff8b21923d48f5ca835773b2f005389e69
Message-Id: <167709954123.1614.15259745165303002485.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 20:59:01 +0000
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

The pull request you sent on Mon, 20 Feb 2023 12:00:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67e2dcff8b21923d48f5ca835773b2f005389e69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
