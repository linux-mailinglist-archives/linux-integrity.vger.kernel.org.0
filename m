Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59A53326B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiEXU07 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiEXU04 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 16:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC544757F;
        Tue, 24 May 2022 13:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3225A6172A;
        Tue, 24 May 2022 20:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88799C34100;
        Tue, 24 May 2022 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653424013;
        bh=gN5l1x7bWCl0UkzKZKYrU0r6q+aOwjcdiBgrAyoiubc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lI/9NgvAF5+A8BrAMUGQb3jOcqctyNr115u1I32grgc4qYNuSVQSbkepXYWPbQh5F
         zS/4oLuUMoGjETge3EyYkHLDDGSZygCO7RYIbotHPdDk1qKKSndueyLGgXsdcJCCNW
         lGuYlNtKVp/3WKUEjmefhe/8ZiZQ8wsGJmmHATtIUPUlxhtrT4ZB8IlXBh3aX81BdS
         fCvm36rBY1BcGuIHNLNQuR5aF5pTW+T3kNmEcFGTam+gKjEltIk2ewW4UsAUArhyx2
         ebM27YAqhZA2pNeiNOJYh67WdtFVjHA683To4tjP+5yNxfL6xTLPcdymrL0droyuIh
         98w+AVJux4fOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7540EF03938;
        Tue, 24 May 2022 20:26:53 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523165744.48234-1-jarkko@kernel.org>
References: <20220523165744.48234-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523165744.48234-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc1
X-PR-Tracked-Commit-Id: 7f3113e3b9f7207f0bd57b5fdae1a1b9c8215e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cf6a8a17f5b134b7e783c2d45c53298faef82a7
Message-Id: <165342401347.5255.8345246571594961908.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 20:26:53 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 19:57:44 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cf6a8a17f5b134b7e783c2d45c53298faef82a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
