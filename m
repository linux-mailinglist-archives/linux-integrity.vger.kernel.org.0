Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7A706EE4
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEQQ7F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 May 2023 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEQQ7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 May 2023 12:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277A44A3;
        Wed, 17 May 2023 09:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A73163BC6;
        Wed, 17 May 2023 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3952C433D2;
        Wed, 17 May 2023 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684342742;
        bh=ERXUBXNpQ1MjhATCNmLtRdswE1u494Y+EiberA5l7zA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uYy8ihrQj1klfAplJHR/dG+NykmbQn0SBEqzRPUCuwarrx8wSq/MmmcLSl4vrULF9
         TGEwpMLPIPE9BO43LkW/Fx2geC2Qm+4/CxaFKx6nrHAWZDPiyGYWXaWF6xoD33/EIZ
         A82cAZK0KLtuzmqt5f87FanrIAUWUhiGUJPHyG3LRDkxFw1CCoAFVZf5ZvE0BUWKpf
         VelXzXH14jeBVu2emHd8pyYRPBGlyrG5qFs3i9IWA0xDL9j/tOK3W3tJcqYCIlu/dL
         59H5NZ80QpbB8b26i3W9Xwr8YocTAYiq9eKVVaOjrKDk46nPu5Vbyw2z+5deafyxNK
         EPrkykkHlsnPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1B60E5421C;
        Wed, 17 May 2023 16:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd: three bug fixes for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230516000208.4008443-1-jarkko@kernel.org>
References: <20230516000208.4008443-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230516000208.4008443-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.4-rc2
X-PR-Tracked-Commit-Id: e7d3e5c4b1dd50a70b31524c3228c62bb41bbab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cba582631ee40772c6dbe24e945b9173572dfca0
Message-Id: <168434274271.11371.345913756875656071.pr-tracker-bot@kernel.org>
Date:   Wed, 17 May 2023 16:59:02 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 16 May 2023 03:02:08 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cba582631ee40772c6dbe24e945b9173572dfca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
