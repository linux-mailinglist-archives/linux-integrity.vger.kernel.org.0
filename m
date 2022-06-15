Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8054D1C4
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiFOTlJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 15:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFOTlI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 15:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE22E0B5;
        Wed, 15 Jun 2022 12:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D93E60EB1;
        Wed, 15 Jun 2022 19:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 016E2C34115;
        Wed, 15 Jun 2022 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322063;
        bh=RzP3qZTZJINHqTKFXOClmmCHrILPHRVdARLSckRDLu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sPr3tIrT00EMIjz/ONdLIRYJ+CB3UQOmsXySLdFOSmMVE2PIqmKgbXhYyH32JQZOj
         f6o4nwcpo1SxAbGU4TcsxsaJ6rLXGSSmag8Q+kJlSv2x/nHwW+EXm33zaZiLMoVba/
         XyUP4fWev//LsLGc6CqxUc/QPEU6VyFffwW010XBEEVSHnQG74LfDlu6/TyNaBRe/d
         wL6xNNbxbp38Yf2kJrfPjTVJVyseia0LPYGREuqKzE/gtOt0X+Q0ErfsJ8F+n6qSfn
         ZpyGr0xWlE/fK5Fwg/q4GZf76t52zYvIz156FNbzmt1ErWyOQlrDVbqYz25AxHW0Hq
         Vzs4DM4Pq/Urg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0890E73856;
        Wed, 15 Jun 2022 19:41:02 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd updates for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220615185912.40987-1-jarkko@kernel.org>
References: <20220615185912.40987-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220615185912.40987-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.19-rc3
X-PR-Tracked-Commit-Id: 27b5b22d252c6d71a2a37a4bdf18d0be6d25ee5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afe9eb14ea1cbac5d91ca04eb64810d2d9fa22b0
Message-Id: <165532206290.28565.8327730742132157264.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jun 2022 19:41:02 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 15 Jun 2022 21:59:12 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afe9eb14ea1cbac5d91ca04eb64810d2d9fa22b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
