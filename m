Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED74ACA4C
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 21:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiBGUUk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbiBGUOp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 15:14:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A52C0401E1;
        Mon,  7 Feb 2022 12:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FA39B816D9;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C57FEC004E1;
        Mon,  7 Feb 2022 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644264882;
        bh=0M21RJ3h28C6tQN0sbw3p2LtChDpgeliRzFb0M/3rHI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=un7M4SnAusq+FMRtuRRunXBoqhUfiTHyFhg/xCwIRuT60gWsz/xX9eetnFuV9rh2c
         k6Mp16lwt6L0EW2U8DUR33w36oepYaRkbiuMhIFW1mSUBpOgdeA8s1AOCMhJj9Kyrm
         RBaIWlirkajN6MgnHwv4hZ/folUJfiLUNlWZCmWzZS5Jh/lNn4C+RqyA+OzD1SBZvl
         ZSboAlhlYEgo+iVWwdFqJf5EzQdhK1I32EbjPHoa8DE+Zixii26ztKuFayZ9Hvyv9h
         BZv2z9CLkAA4Mn3bWPuH7edREPzpVV2pC6VULMjvKs2nVqTPpDEXo87ClImni2gdB/
         pjxPLyvv/fSyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B504CE5CF96;
        Mon,  7 Feb 2022 20:14:42 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3a988ebfffe725e3172a6850c3b2b603d16c2330.camel@linux.ibm.com>
References: <3a988ebfffe725e3172a6850c3b2b603d16c2330.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <3a988ebfffe725e3172a6850c3b2b603d16c2330.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17-fix
X-PR-Tracked-Commit-Id: 89677197ae709eb1ab3646952c44f6a171c9e74c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8ba56b7e8f3ca4d86c556f5498e4faeb6d139ec
Message-Id: <164426488273.18191.13523485374769038925.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Feb 2022 20:14:42 +0000
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

The pull request you sent on Sun, 06 Feb 2022 18:32:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8ba56b7e8f3ca4d86c556f5498e4faeb6d139ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
