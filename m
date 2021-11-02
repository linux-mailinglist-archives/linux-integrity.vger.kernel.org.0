Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40734435B7
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKBSkH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 14:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235177AbhKBSkF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 14:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C8EA6103C;
        Tue,  2 Nov 2021 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635878250;
        bh=KW/6vlseMMQdU9ju+f0Im9d/jyi6hPkLygCy+5iFyYU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=scgivtIsiakuZmYSx7cNLPYdiqzlzWgsX2ECnUf+K1Tb7uObKU/k3AF3jWCmd1Kh5
         zHvbuea9BqXGS+5+5Y7fiOkOpk1AWrIwFaoV8WoCbHTDwRDIBtOJVZXAbfr4vPEp84
         IExj1IhGAwlmNxd4xRjQx28Q4Xei8TR3gM5Fc12309mbk1xg3bj7L5ZKxAdu/IfSzQ
         8jsbLPGAznRdqJ4LQiwsyUFive1bT6KmG0z36C+8A1O7oRRsw5BJucRrz0uRQOl4uw
         RmKn9+Gp9zoCt5Hj/hHSh5LUcUyXtCxhfOO3dHkwXPgCqQ21MqjNqyZ2xe7+g9e5Xx
         84DsaCaTGOrwA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66F4160A90;
        Tue,  2 Nov 2021 18:37:30 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3f066f52d4937414a9e01c7f46a714e988e6196a.camel@linux.ibm.com>
References: <3f066f52d4937414a9e01c7f46a714e988e6196a.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f066f52d4937414a9e01c7f46a714e988e6196a.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.16
X-PR-Tracked-Commit-Id: 32ba540f3c2a7ef61ed5a577ce25069a3d714fc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c150d66bd514b21a8d0c4da063d77fb7bf1ecc4b
Message-Id: <163587825041.14475.16002631597249011515.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 18:37:30 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 02 Nov 2021 06:41:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c150d66bd514b21a8d0c4da063d77fb7bf1ecc4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
