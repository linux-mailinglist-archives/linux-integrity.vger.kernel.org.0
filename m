Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68C65FA69E
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Oct 2022 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJJU5G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Oct 2022 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJJU4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8050726;
        Mon, 10 Oct 2022 13:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D632661027;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46302C433D6;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435397;
        bh=gD/RNkGki+nKosGNPSgm0cUt77MPBk2qELNOwNPFOu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b3mhGbL/0WXlGx9bkQDih3NtfDXDV7dQ+uS68uomnXh2qDdqx6Shmdts8mwP+nKuC
         rMDvrJNuWA74z7JHKA7InI6INUVBGG5ZtJ61oY/LFOhnXHMS+McR1y0BclA87fawX6
         n/1c5SCqpGuOODRmeVdqDwXGhiF3MSH1uNGWqfiHW38l3xYNJCxaHQfhAfk7SRoyzL
         nSjIXTmEk/JSImWliIRi8DJPILw4WJTDpudVUj/mHyCj2vHaXRrBqg/E7XuswjAVut
         zZUv5Its0N7ZeUt3XCBEAdb2y4e5U5Vh8+ZowSHw2qNYk4vasE32wQuaGBUd2a6itk
         ScdJY4g64lSmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33CC0E2A05F;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd updates for Linux v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221004213003.57166-1-jarkko@kernel.org>
References: <20221004213003.57166-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221004213003.57166-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.1-rc1
X-PR-Tracked-Commit-Id: 2d869f0b458547386fbcd8cf3004b271b7347b7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ada3bfb6492a6d0d3eca50f3b61315fe032efc72
Message-Id: <166543539720.11766.18059815416011359689.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:37 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed,  5 Oct 2022 00:30:02 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ada3bfb6492a6d0d3eca50f3b61315fe032efc72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
