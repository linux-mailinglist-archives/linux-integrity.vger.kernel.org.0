Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B28168801
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBUUAE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 15:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUUAE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 15:00:04 -0500
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582315203;
        bh=KfvBv1/JbVdoHa/WKWybYiAZxwPNQC1F8Sb6p0ZnLs8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=krzm04Q746Mi+QBu9JO+pkHhFJTfw80U95/5lnPwQyoEeNOZFf1sZdukbDxj0A837
         KbOoBzrZk44zWu52uIzHWOHlADqPq9wJQshTLmODUc7zDukB/5KrjkJCZi+9g/zkd6
         Zlp2wR5bzcm3Pc/CitKJ3TYEXlFkKA1kFKLtXKgE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1582227963.19057.17.camel@kernel.org>
References: <1582227963.19057.17.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1582227963.19057.17.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 5780b9abd530982c2bb1018e2c52c05ab3c30b45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebe7acadf5a9c4b67475e766e0e80ae6a2a79c61
Message-Id: <158231520371.21762.1589719128492558301.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 20:00:03 +0000
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 20 Feb 2020 14:46:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebe7acadf5a9c4b67475e766e0e80ae6a2a79c61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
