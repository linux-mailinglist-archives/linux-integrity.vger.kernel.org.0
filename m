Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8715740768
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jun 2023 03:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjF1BBh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jun 2023 21:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjF1BB1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A072975;
        Tue, 27 Jun 2023 18:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 334776123F;
        Wed, 28 Jun 2023 01:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97472C433C8;
        Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914085;
        bh=Ca2VNQ0Tv6RUBE6dfaDK+smRCTV5c893rp/AOtEarF4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MMMHwSkwGly94bz3DgsD2UReNJclQpc0nKTN4BQD5NSsMlYxN5quqRVmjEvhnqkgg
         LY3DnH6VvkVENU6TenJppM2/MW8p0O84JF8W1Nno5XePlo9vH24EK1Q+ocCdKpvWQ3
         L5VAhJ3WIeG0HMnakLUWS5Cq0QlHvzuAcLMk7wnqcc2eazXi+IZofdnNj4al+WbnQt
         MsO/mre/08XjnrZJdAviWwS+mxfZ+Daabn/MSiU64dic2p9kHILafdyU5YU+BuW/Yc
         S1xWJbfzWAz8wTiaaiu5CekGGv6Dmmts6xVG6xtNDCyI081ow5NXUl8Ck+kkdAWqwd
         tLkPy+pBali1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85259E53807;
        Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbystem updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bdea3a9112c28fd6c2c158a14b632f89dba53ac6.camel@linux.ibm.com>
References: <bdea3a9112c28fd6c2c158a14b632f89dba53ac6.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdea3a9112c28fd6c2c158a14b632f89dba53ac6.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.5
X-PR-Tracked-Commit-Id: 95526d13038c2bbddd567a4d8e39fac42484e182
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4c7f2e6ef40f545054a902e4708ed908d562318
Message-Id: <168791408554.14121.6436652613056866126.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:25 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 08:28:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4c7f2e6ef40f545054a902e4708ed908d562318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
