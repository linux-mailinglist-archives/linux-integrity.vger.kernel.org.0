Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F278DCD8
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbjH3Sqx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbjH3Qea (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF5F19A;
        Wed, 30 Aug 2023 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E80DF6228C;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BCDFC433C8;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413266;
        bh=n2/DRhb/Ihb3Ap1FioZFD3qXzwYxwyIv168OqchsSU0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oD+vRxHCgfD0Hw+lviSkFRc4ZAZ54jo2ezECLluKKmpgFLH3b2df1E7fB9YdV7vfk
         ZY819mqEsWYJK2XmWvWT9qaX2XiosliZlgxtlT++ChZ2R+SqJ0BQy2hUtw3NQEwxGw
         yb4sUhpysP9ZTqVXO6p7Y+S5PowgDbao3hb3ojciFEZLuvraBNF9ItIJP+2+z6X1HZ
         xqJzKTCI1GM++rxOU11Kzg78ZdZI+qK9777z692IoArGfhE63TCK29yk+RyZegO/BU
         Bd/AdiZSfnqHACQa0MApbCXeAbqUWQY+piDGq7JYOhRsIVvAF3q19K/w9BLWQbsW+t
         Fnd/C6vwA20cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A03DC64457;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbystem updates for v6.6 (take 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154c360fb6a21849e89ec003cf2be9ef96599393.camel@linux.ibm.com>
References: <154c360fb6a21849e89ec003cf2be9ef96599393.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154c360fb6a21849e89ec003cf2be9ef96599393.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6
X-PR-Tracked-Commit-Id: 55e2b69649be38f1788b38755070875b96111d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a35914f738c564060a14388f52a06669b09e0b3
Message-Id: <169341326629.28213.6888093003025624318.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:26 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 16:17:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a35914f738c564060a14388f52a06669b09e0b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
