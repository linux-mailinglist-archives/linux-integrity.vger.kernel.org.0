Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7468158B793
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Aug 2022 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiHFSTq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Aug 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiHFSTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EAE0C7;
        Sat,  6 Aug 2022 11:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 391D0CE090A;
        Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75E7EC433C1;
        Sat,  6 Aug 2022 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809977;
        bh=23hV1FvTFoQPJG82yincXoFnJtqM68n3qlr/PH7oADY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ILANQsuLLMucXnRB/iHWGiNaBVoLWXbAkknVcD2cGJLIYlriMmpWFtqhay/j6XAwm
         755/K0yQhh1B34uySCHuMiVnDXP+AOhAe+TrGSj+e1pnkdsajuKBsbe35fg9Kp6xv4
         wwLuXNE/7SlgerUnXenEDiJDFvPDKXBfjOvrf5lG6BHHL4xZrpricm9hDGh49UhYWG
         oqxY8UiocFUG1LZi0Zxvv2oQ/qetgEsGg9rPAet7tbrODXGb2r3+BwKBvuts4mqA+h
         pXmFjny/BwAkUvNVC48xE9yUNNEHzCv4YcyCPMdOyLwsOPG9BWfgDa44Agaztw4Zcl
         3peTp+KosojjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 630E3C43140;
        Sat,  6 Aug 2022 18:19:37 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803210228.158993-1-jarkko@kernel.org>
References: <20220803210228.158993-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803210228.158993-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.20
X-PR-Tracked-Commit-Id: 863ed94c589fcd1984f4e3080f069d30508044bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20c95b46b8fa3ad34b3ea2e134337f88591468b
Message-Id: <165980997740.27284.17376485647055486721.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:37 +0000
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu,  4 Aug 2022 00:02:28 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20c95b46b8fa3ad34b3ea2e134337f88591468b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
