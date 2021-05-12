Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA437EFD8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhELXda (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 19:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349876AbhELWtq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 18:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 079E6613D6;
        Wed, 12 May 2021 22:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620859718;
        bh=SDBULz4jCvnH5Z4Ja5vns5dF7gyGVPBY5srIj3LeNLg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lwaWVzA0cyVppM8TSEVVhJY4FR4uj5/eQC1ZM1hYJ1ob2G0B83s6ycOXJ0re8fS/u
         StBcNhn+sARlZdlVykcRVHu/Y80iF4yxoJ+7sESKTMKmi/yMk/lMbnhmeSFakOh/Eb
         TL0siYwRnVvgmpG5tvk3G2E2ungiCcDatQNblXQ2TwQIe0D8i2boV2HYOulY34Z/mK
         hF0KkTUYpWj9HSQKYXl54bjF8YaWvXXZjSRo3EI8bIUybyjvmilCJszTIVbbvq/Eam
         mmmYRjRdVxBgrEN5f4qcrCM5FYuNVNpwqAyxf3stY36iEdvNmidoJ/hGBK5mpZ9wFH
         UkZJbWaIiY+Kw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E6FB3609D2;
        Wed, 12 May 2021 22:48:37 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJw8J1icU49X/Wo9@kernel.org>
References: <YJw8J1icU49X/Wo9@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJw8J1icU49X/Wo9@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13-rc2
X-PR-Tracked-Commit-Id: 1df83992d977355177810c2b711afc30546c81ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d02490ccdde9aef1ca57d5c87f8c20c2d6b1f5e
Message-Id: <162085971788.12307.13441010475019966764.pr-tracker-bot@kernel.org>
Date:   Wed, 12 May 2021 22:48:37 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de,
        zohar@linux.ibm.com, jejb@linux.ibm.com
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 12 May 2021 23:35:51 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d02490ccdde9aef1ca57d5c87f8c20c2d6b1f5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
