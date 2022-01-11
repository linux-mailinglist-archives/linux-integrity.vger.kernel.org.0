Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB48B959
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiAKVYw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 16:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiAKVYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 16:24:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462F3C06173F;
        Tue, 11 Jan 2022 13:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B6A8B81D55;
        Tue, 11 Jan 2022 21:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37D0C36AF2;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641936288;
        bh=6gC7amCaGxT5nAyORwPh7RF35YSnZcnB8Inz+bwSY3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ror0N2Jvyqq7I6IOzbM2j3L3c/5/lxWKRGAIVP06vaUnSJKHkWO4Y54NXjIb1Iz80
         +RLTWapA5vyHTyJ8lN+H8ngpuYQ51K3OzbIEJSgFv8d7zWaHBGDQnputPwtlMUFrl8
         lVxkLSGrXVxEZB31xzJLp8e6dl7Zv1wO9Ua6fKy36IUk2VRMbY8UUXFEIW6vGTUJdd
         6uwFVHIbggXpQlK28dw45msd5AQcHeJiPpD7gYt4EKYx2CPeYFyChs3HwfTp40/47t
         kijIVczdG046HnSYzSV+9Y8rg7osHBFGFGriLEbFvbP2Vpay/bpH5hM8n/pOPepMDm
         kdyY7EbnPUPSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2BEFF6078C;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
References: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17
X-PR-Tracked-Commit-Id: 65e38e32a959dbbb0bf5cf1ae699789f81759be6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84bfcc0b6994057905cf98d2c5cedef48b3322b5
Message-Id: <164193628865.30592.8779597718570749178.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 21:24:48 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 17:02:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84bfcc0b6994057905cf98d2c5cedef48b3322b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
