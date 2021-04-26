Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DD36B64D
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhDZQAD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 12:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhDZQAC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 12:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7C6D61154;
        Mon, 26 Apr 2021 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619452760;
        bh=nsge/2WCcBDOBHtrrteKlWs94a5NVYG/zAvOd4PPY4g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dNOnZi6/EeIZEkqycuhagbnVJwI6nVVJbGq1eSq5xzzrgApIn/PtMvALs4Mvnd4OD
         oFJDAF2zNAGkLDhPYbTnxDRnMo/TIqXYEUXDhfcZxw2Sh4gsnc2UCfBNwNM915tegW
         xfTqQATyo8R9qCU3lQ9fChKXzZT7wuMs5fLWXW71MS8o7e3zVjW1UOifmcnyHli0Y3
         5iMmwdzrsRAWgrbIOzRiZUilKLkVzHNfAI6h5dg8i/j0jMkJ1BIKAgepMj/xMTQWJD
         qPr96sPqq0OXX5f0ZiFV769rdN/3YnS+GZwNwylSGydin6wx0xn+ucMgD3pd3SgQpO
         3Uv+iUCQOB+zA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BD6E9609B0;
        Mon, 26 Apr 2021 15:59:20 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.13 (updated)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <52f4810fbcdb3a118b7126e2497ae384016c9004.camel@HansenPartnership.com>
References: <52f4810fbcdb3a118b7126e2497ae384016c9004.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <52f4810fbcdb3a118b7126e2497ae384016c9004.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git queue
X-PR-Tracked-Commit-Id: 60dc5f1bcfaa9cae9f99637e347d068cad7f8c9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87f27e7b189f54a9e928efb4ea98bf375708ff1f
Message-Id: <161945276076.5751.10749914749968096050.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 15:59:20 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Fri, 23 Apr 2021 16:04:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git queue

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87f27e7b189f54a9e928efb4ea98bf375708ff1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
