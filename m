Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095B21984DC
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgC3TuC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 15:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgC3TuC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:02 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597801;
        bh=xwUUryMp5GTbHMDazkQKlMrY8HdcqWGbe/rL7TKG80U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ArnWHQ2DRpuNhX9jVTZe+6vZGog2NQfNPSJObHq0xU6JmZMcfZGslCTwNwKAaKPMZ
         QhJzRYcrL7yh4TVeWMd/mzUu64BiTjupg9a729kzpyibLxHaf5xRkIgPsn4ICX5cJ9
         BggEihIf78F28os7NynZV2fwK7eBY3Bow8jRbuNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200315225443.GA1413900@linux.intel.com>
References: <20200315225443.GA1413900@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200315225443.GA1413900@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200316
X-PR-Tracked-Commit-Id: 2e356101e72ab1361821b3af024d64877d9a798d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f751396346f5cfb6d02abe1985af53717b23c3d
Message-Id: <158559780173.12131.1497831289468164278.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 16 Mar 2020 00:54:43 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200316

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f751396346f5cfb6d02abe1985af53717b23c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
