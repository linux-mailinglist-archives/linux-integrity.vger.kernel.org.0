Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14924E37BD
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiCVD6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Mar 2022 23:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiCVD57 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Mar 2022 23:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1111F62F;
        Mon, 21 Mar 2022 20:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D8E8B81ABE;
        Tue, 22 Mar 2022 03:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43002C340EC;
        Tue, 22 Mar 2022 03:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647921390;
        bh=cexSDATPBLDZbm2rXJiuw7AuaWdHp0Xtnd/v02cvhXc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SzU3Xux7c/EjCJ7JvxC/Dv7e8D1kiAAjGZ/2Fq3AZBRC02PyN5tATl/hUIDPL8LZS
         0ITDvYmmSV0rdzy078Ul5CunwbgyNQivDgC2bIqJAYxBymdZf6Rho9r8Trp+XEIVyd
         N9VMgrOe9JEp9zm909FuQVSbIMwKuNqJ9T4X4rxA5ECsl4do1ycTdmSHopOxC4JG/i
         If2QA09mqL21o18rdY/DkJRcJdmNAvlQEuZCQ2/7W2T1naH7g5yq81EqJ3yJC+oHCG
         Ba0e/uDzuKuGI3aNMu7V9JTxuvvnaoDPRVxQKHU5QUfoSFhz6uKK/GC7z/6TaKAbqt
         sq5Lwz5yfK9Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EBE1E6D406;
        Tue, 22 Mar 2022 03:56:30 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a47c4a2bdc27d1a66ae09b9a07a851d6b27e6a5c.camel@linux.ibm.com>
References: <a47c4a2bdc27d1a66ae09b9a07a851d6b27e6a5c.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <a47c4a2bdc27d1a66ae09b9a07a851d6b27e6a5c.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.18
X-PR-Tracked-Commit-Id: 4a48b4c428dc92b5e0b19de83e7eb8d530dddd48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f313ff0acdecf0926ab127533a2a93948a2f547
Message-Id: <164792139018.6005.4330983346570634834.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:56:30 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 14:37:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f313ff0acdecf0926ab127533a2a93948a2f547

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
