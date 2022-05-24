Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33865332A8
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbiEXUxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbiEXUxv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 16:53:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB391719C6;
        Tue, 24 May 2022 13:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C66ECE1D61;
        Tue, 24 May 2022 20:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AB63C34100;
        Tue, 24 May 2022 20:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653425627;
        bh=dGCERO7mHLWk8NHpeP7MAGHw4wAGAvs4eK9K6Atkh7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cS0ni5CEwuQBFdAGYOzjpRXOzxZJ4+IvETT7alUKOViTq2vzWHpz0RGj9KYcNWvTq
         6VoxVdPTF9hGXWvV2DAMsCtzS8bueO+7vPIzJ7YwG5l+qnrJz3jTSD/yQxX2nw/ZQe
         HZSd+CIaVzgdYHTmuNwR+C8NaSOeiyzbmBZlwKyqO3tgCq6RCQ1DgwsN1hIvRCtP3u
         sMBILjdoKx/bGj7IrzTu6VQKP4y4xQi9C77MUYr35wmA3zu0DR6xLS9n4Fs6/0qPW7
         5pRbJaPlh735OAqut4DcyDZo50LDQiUjv5O4nJ34IwcAuMdhucIsB6UUOohGEEDWWc
         zyMKjDqmJ8AWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 731A9E8DD61;
        Tue, 24 May 2022 20:53:47 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <223e46039b44b2f31814be02a3c2b75e84af3823.camel@linux.ibm.com>
References: <223e46039b44b2f31814be02a3c2b75e84af3823.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <223e46039b44b2f31814be02a3c2b75e84af3823.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19
X-PR-Tracked-Commit-Id: 048ae41bb0806cde340f4e5d5030398037ab0be8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0350785b0a092c99c5ddd2ace0260dbe7b3f919f
Message-Id: <165342562746.19576.15003303284276169248.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 20:53:47 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 16:46:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0350785b0a092c99c5ddd2ace0260dbe7b3f919f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
