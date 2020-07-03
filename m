Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4D2133E5
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2020 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGCGKC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jul 2020 02:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGCGKB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jul 2020 02:10:01 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593756601;
        bh=GgcW1R25V5qO0KwYjA1ihH16TIdTMecUPzPOIVRWyrc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sh5hy5DeyoNUJ05qn5ZY22TYx9uvVvd3VJYdOD8/Dq2d2fulORCeG+zNdzvu418ae
         Vr+CB6ty1JbDwupRIfxW+eczEPNLKAeG6+6VC4ZnVyy3qAgHkLMCBEquKb88UUAcfx
         iMHC9863MrF3igGZiqu8b/PZlxBpy/te85F4F8x0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200702185813.GA25571@linux.intel.com>
References: <20200702185813.GA25571@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200702185813.GA25571@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-v5.8-rc4
X-PR-Tracked-Commit-Id: e918e570415ced9898a51109000a3f39a6e03be5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c7415c31ea9482c4377287af5f459778bf64d2a
Message-Id: <159375660136.4799.9936288428262230064.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 06:10:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 2 Jul 2020 21:58:13 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c7415c31ea9482c4377287af5f459778bf64d2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
