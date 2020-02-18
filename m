Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241DD1636CF
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 00:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBRXFD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 18:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgBRXFD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 18:05:03 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582067102;
        bh=QmUnoPymKKoqwRvV6Lcu38T+58tkGng7qoSaChK5uZc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gSfrACUoqCeem7Ci0f4iknZV7VAVTLXsekPGxRSJY31rIAOEMV1L+mMuXEib1Q6/p
         rXnoQPMnjUPshomQhlgNM8aleSkLPs2QqCmkF+LkdD609MoJb6iQHuIEz1kt4R9mTq
         hf2JlVME99qVe0zRYC0BuEzBpWiyuWJqJoIw8xyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200217185044.GA7180@linux.intel.com>
References: <20200217185044.GA7180@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200217185044.GA7180@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200217
X-PR-Tracked-Commit-Id: dc10e4181c05a2315ddc375e963b7c763b5ee0df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b72104b8c12504176fb5fc1442d6e54e31e338b
Message-Id: <158206710266.5982.13455580152886456927.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Feb 2020 23:05:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 17 Feb 2020 20:50:44 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200217

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b72104b8c12504176fb5fc1442d6e54e31e338b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
