Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC5722B3C
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjFEPgc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjFEPgb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 11:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C641F7;
        Mon,  5 Jun 2023 08:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B0462720;
        Mon,  5 Jun 2023 15:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68998C4339B;
        Mon,  5 Jun 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685979384;
        bh=YdamecFINNCEd7qN4wE3PtBR9T5k9xrbpuFxPFkqLHI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RMPY3LwpOCY/mrT9wYDvGsqbAzDaHm7CJni6fiO+keKHR+t1lU3wddmZo3zJE88N0
         f37FVWCFdUAd4d6YyVWvelhsHEuCKBgwwh+LN8Ypu1rB8MTWfwX8Ow5IMA+NqcvmXR
         4NqzTgdu2D8lS7AJ1cywCNZ+0CEbicumUnHhniMgThBlyKTgf0FiymizXeHS4co4GU
         5emHEBNnyZSSDHiBISOAo3iKJ7PvcqNxFjiKO55Fu1Ku94gWzDgoNvg3PHqTio8DY4
         V2486cTNYseo3PYmVQVDD/8ku/Pg4TzLoYqlEq/xnGGKAR95ALxt/+hgm1H+/LS1sg
         JBlJnorf5jHeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C461E87231;
        Mon,  5 Jun 2023 15:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
X-PR-Tracked-Remote: https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-v6.4-rc5
X-PR-Tracked-Commit-Id: c3d03e8e35e005e1a614e51bb59053eeb5857f76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8dba31b0a826e691949cd4fdfa5c30defaac8c5
Message-Id: <168597938430.2179.8103170042142681716.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jun 2023 15:36:24 +0000
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Fri, 02 Jun 2023 16:41:04 +0200:

> https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-v6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8dba31b0a826e691949cd4fdfa5c30defaac8c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
