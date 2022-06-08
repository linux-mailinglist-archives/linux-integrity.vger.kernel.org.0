Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D12543902
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbiFHQ12 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiFHQ11 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 12:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104F4C7BE;
        Wed,  8 Jun 2022 09:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E1A3B828A4;
        Wed,  8 Jun 2022 16:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB8FEC34116;
        Wed,  8 Jun 2022 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705643;
        bh=jnV8D6F6t5LRcnIMrtuP3YnUfQqo0fSVsHE2ZEkxPAo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z6Wz0kLZI2+ET5dq0GNVXDxpQsRPz6p41+Iywc9q5zUVHCKT7FiMbtSV5q8TgW2l+
         chvgIMvFA8jeSzrEsytrJPJPFkeRFuwDqoaf+Cp/3UVqmdpxYCnwJ0kez9BuG9kNOX
         /EyXi63ANSFkCBVXp18+qh4tXjcWoPZ/pi740I+9i8G/hdSVW+VoPC8+RDQFGM93Sf
         7vpmPCyttwlGmSIUKJUC9o0gRLKeAfX4CRXtTmdffy0QvDvIYUxwsgjbirsloe0KSR
         IhrA19qO4yl2WK/ZeZrIC6XTxREX6TMCGh9Fssqc1qZfktsQkEucsoh7rXdUJv2Up6
         6/1ltHhnV+BDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3AECE737EF;
        Wed,  8 Jun 2022 16:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd updates for v5.19-rc2-v2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220608111418.3081578-1-jarkko@kernel.org>
References: <20220608111418.3081578-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220608111418.3081578-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc2-v2
X-PR-Tracked-Commit-Id: dda5384313a40ecbaafd8a9a80f47483255e4c4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32d380a7ef0254d65763408b955a5aa6848ea49c
Message-Id: <165470564365.4500.8712069598214562693.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Jun 2022 16:27:23 +0000
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

The pull request you sent on Wed,  8 Jun 2022 14:14:17 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc2-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32d380a7ef0254d65763408b955a5aa6848ea49c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
