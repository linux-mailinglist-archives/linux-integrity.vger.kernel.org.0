Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9158844F
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiHBW33 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Aug 2022 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiHBW32 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF494F64B;
        Tue,  2 Aug 2022 15:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D42C8B8211C;
        Tue,  2 Aug 2022 22:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2E32C4347C;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479364;
        bh=YnKV03xu821k5LBl2xeeu3LSgqxk5ADRIXU6CcZKi68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uKbixom/rIkDkmeMWe50cRy8d0hdBQhLMUoSPJoE0i5f6Bceu0uc44hv05PZWGvay
         QTD95zhXp8XCFUzWdsJFmGKCsOGXB7w6/5jgF82NbdcN25CAaxsZDLmXqtk5lGd95z
         PE/TqZvRl/U4OP9KvEDxriNxJ1z4JX0pQkItXXQ6BrQmQYG2ksQM1210BqhvIqkqor
         Drz6N3NTKaE9t4TcYCHjuJeCPLM9/iN3ue0jUPYa3QXJicXYaCQGCaRwpzLnZeib9s
         3JHVm6IP46m1NF0c3dlP8nfKZzPNwKr+JI4aEKzYdnFVd/qhgCKWeWvUg2gNhEjQfE
         d4ta8BJb62/Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91C48C43140;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <04e413ed5db93479848f1127a1a664a03df3bd2b.camel@linux.ibm.com>
References: <04e413ed5db93479848f1127a1a664a03df3bd2b.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <04e413ed5db93479848f1127a1a664a03df3bd2b.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.0
X-PR-Tracked-Commit-Id: 88b61b130334212f8f05175e291c04adeb2bf30b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 043402495deb5ccc3b3479dc69a03f990c41ea8d
Message-Id: <165947936458.5634.12443628938670762783.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:24 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 02 Aug 2022 17:55:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/043402495deb5ccc3b3479dc69a03f990c41ea8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
