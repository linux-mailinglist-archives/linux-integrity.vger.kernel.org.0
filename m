Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB24E30B2
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Mar 2022 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiCUTUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Mar 2022 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352670AbiCUTUC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168F1A83B;
        Mon, 21 Mar 2022 12:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77737B819BC;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 371E4C340E8;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890313;
        bh=ArkClvUCZskbMOIXEjW8rI9P1xr4L6dathcbaVzk/EE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kTI1C8NNpiegz9VogHhozttG5clFIkFN/EhEkPIwDWxP/NWxh9+1RyWFogSy6dQOu
         j5CfSpCRyTdWbMs1UxyJ1hHAczhcZLVMbhGUX1DDAPLgI0OOQFz4XgCu4rRDljyHup
         cUk0bxLUSFfu3yQyPPVuQ0Oxc7p16AknX4STPdceBw+GjjNytUKscV8cwyuskw+Ehe
         4NJgiJjoHmxu4SQFC+GabjbMyGvPp6fYDF0EYy0GERSUoWcGq+Ti5ZE+f8IgECFSmD
         y6+KHW1D4rCeW3od04zQg5QhHIk0naF1z/GLdWjY1g/wWTipUDM3ABlsF8L3icSODw
         mk50GyioqYYtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23BA9E6D44B;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
Subject: Re: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yik9VIcfuhW5Kd73@kernel.org>
References: <YidTCX0NOgDfHCp9@kernel.org>
 <YiecF6W2XAcpC7dF@sol.localdomain>
 <YieldvygMyiqmZbT@iki.fi> <Yik9VIcfuhW5Kd73@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yik9VIcfuhW5Kd73@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git refs/heads/master
X-PR-Tracked-Commit-Id: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d8e7007dc7c4d7c8366739bbcd3f5e51dcd470f
Message-Id: <164789031313.24158.4821226428823047004.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:33 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 01:50:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d8e7007dc7c4d7c8366739bbcd3f5e51dcd470f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
