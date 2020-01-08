Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B417C134AEB
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgAHSuE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 13:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgAHSuD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 13:50:03 -0500
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.5-rc6 part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578509403;
        bh=aZiHTAWDu+0Z7nFRTnzftyuWlCCH+UV9UHx7AK92jWQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xIyrqEG1IvBi7PZUUpHYxONz4+nloH+qI8khv3v2T4y1PrFJCdRpQRA2NRFVTd7q7
         h5Y1hvv3NbkD53f+ghgJALGziqvlZm11w0ogyT57tmWbtYHHMNl5bzjSLH73PNm5ml
         eDhrO7maCJtqT0OGHHls5NA8ej6XwitN/+jcFL+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200108161625.GA16812@linux.intel.com>
References: <20200108161625.GA16812@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200108161625.GA16812@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200108
X-PR-Tracked-Commit-Id: a430e67d9a2c62a8c7b315b99e74de02018d0a96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07f636fca1c8fbba124b0082487c0b3890a0e0c
Message-Id: <157850940314.5663.4983243977664010162.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Jan 2020 18:50:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Laura Abbott <labbott@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 8 Jan 2020 18:16:25 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200108

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07f636fca1c8fbba124b0082487c0b3890a0e0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
