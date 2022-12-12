Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40264A5F8
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Dec 2022 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiLLReB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Dec 2022 12:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiLLRdh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B20E0F;
        Mon, 12 Dec 2022 09:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E11A7B80DDA;
        Mon, 12 Dec 2022 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86641C433F0;
        Mon, 12 Dec 2022 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866400;
        bh=ft4aDjFJHeZuNGSmxeQr0943w5/fqhCuyQHjByWHOeY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mcV1CJ48A6qUKm13wDzy3neNjcc3CJlC594X2mcb1nemzSHil7ZYyW9q+DSCBnY7N
         7WUuuY1QMob7h/1joDj6wYNq0TyDMCnTJ1cdpDYGQ4JAbXehwj1ksUhfeWR1tjYKvU
         pb7Ot97Zxf9ZUc0fzMJelxc/+9ufvG+FYpbs4PLTueYzuC0t2fN7DU4ys4Sdp/LC/Y
         je/L9qUj/+qDWwNCVwjRQslouF91iCh/EeKGV51h9qkDwgm5joz0VvnrsteelEb3Xm
         rf0KnXu2ifudEoYw3GNhInmjmF83Cb2I3mEs65bHkDdgS81AV3AmGCPgy6bIDxZ2s0
         vPVwBNEEANbJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73656C00448;
        Mon, 12 Dec 2022 17:33:20 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd updates for tpmdd-next-v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221208163308.9989-1-jarkko@kernel.org>
References: <20221208163308.9989-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221208163308.9989-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.2-rc1
X-PR-Tracked-Commit-Id: eaabc245b02a0e0063068178624d2fc12ba91d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43686598b55785bfc1f961b3731b2302fe08f393
Message-Id: <167086640046.22610.8680028343589584461.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:20 +0000
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

The pull request you sent on Thu,  8 Dec 2022 16:33:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43686598b55785bfc1f961b3731b2302fe08f393

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
