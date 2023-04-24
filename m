Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F246ED4CC
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjDXSuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjDXSt7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 14:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B46AF3B;
        Mon, 24 Apr 2023 11:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2BB628B5;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDC73C4339C;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362055;
        bh=KaHYegHHp3knLTn/TKI/WpmSFLx7FKHDx6t6gg0A67E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mqZgGA28tYlZDtC8unkIzVH2GX/rVck2tvpl3g7RdBl/Koa6pA6nPikeSA3hbXZIU
         a+GW73jChh0swjnYZBPHfyOM7kvJ7X6NSh9SGa9EzYZdLtyShF1IAfMUDPVfaYPHoy
         z5iVQhgzZzSgG0POMpZEH/HaYexIKvMFqSjgEopu03xzW0dbTqe/JtYUKqqCUdt9fy
         i7pr/HWxZbBP6KG2OSwo917YSnVeSuYzkmckUnv9YOUIubO2ZWeaCyNUh5rUh5onjn
         ehFiMZOFaOUFqcT9baSDHdIQXgLfZJvFBYK1Y50mfWUIIopouazmOECzce65NO7S9h
         li1K2yrN5fCMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD361E5FFC7;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd: changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424144130.1084795-1-jarkko@kernel.org>
References: <20230424144130.1084795-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424144130.1084795-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1
X-PR-Tracked-Commit-Id: bd8621ca1510e6e802df9855bdc35a04a3cfa932
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a0beef98b582b69a2ba44e468f7dfecbcfab48e
Message-Id: <168236205577.5635.12268604346004084504.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:35 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Martin Dimov <martin@dmarto.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 17:41:30 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a0beef98b582b69a2ba44e468f7dfecbcfab48e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
