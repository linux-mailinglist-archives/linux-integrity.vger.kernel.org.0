Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4368A575678
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiGNUmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiGNUmh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 16:42:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CF4B0E1;
        Thu, 14 Jul 2022 13:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80C26B8258C;
        Thu, 14 Jul 2022 20:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17276C341C6;
        Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831354;
        bh=l1FoGDoakqveIxnnDB6yJP8BYI677lqpBbxBVYBa+zY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MzeezQq3Rs+VZhlG7tEZM9xPmEfTSpUjdJxPnDrHHkRyj/oOFwuE6Widg6J3TsvDM
         0U/CIRrsOE8md3VM1/augurL8ykEAs+88Gggkm26TJe3MCoJfKFkavlaBspk8hFDWo
         BlEaxO/DrGtQk6p4EJOtqdt2n/n7PmJe+n8TPIGbLOjrF9CMQCEE51E/tJajx3zfZC
         UEflcS6nP7U+0dv+Bap1SzH14XjybJZr1gEleMPbXcT6VC+unYOlR6jduCqCQQc+5n
         EnYGCNwBZuZ4PEOw7cFnwkDGI73YPmC54btI6P8ihupWGvz1bxgUmxCxw03Py+Kq2I
         avJE+l3esqV8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0225DE45224;
        Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32baeee1b12e620693c10d89dac5a8c1de6d61a2.camel@linux.ibm.com>
References: <32baeee1b12e620693c10d89dac5a8c1de6d61a2.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <32baeee1b12e620693c10d89dac5a8c1de6d61a2.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19-fix
X-PR-Tracked-Commit-Id: 067d2521874135267e681c19d42761c601d503d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4adfa865bb972d38d35a6fb19e59a86074d25a75
Message-Id: <165783135400.13350.16981956716917437886.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jul 2022 20:42:34 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 11:58:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4adfa865bb972d38d35a6fb19e59a86074d25a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
