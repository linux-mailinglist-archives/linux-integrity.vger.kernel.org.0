Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F1349D03
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Mar 2021 00:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCYXuA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Mar 2021 19:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231309AbhCYXtR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Mar 2021 19:49:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EDEAC61A32;
        Thu, 25 Mar 2021 23:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616716157;
        bh=DlwVGUKvp/Zjp+HKHJeRTWneAHPtk8cqgn326jBbpYA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WO+3vct3y1IsQIamAe5elgOpC5+sGCoI0jRu0I6L+gYftb6lb053zya5SBibFWPlM
         kgmywyTnKqj7MvzNi/DQ/z+Ck3g0cQmCeVmMJD6hBvZLkXofnywtZ312CDs16jIyov
         8BSqgJleOcOcO8BR6bbMSHqpXOiw1gB2/yN5nu6wgnqzcHbZjLNn3HbALlzUQCR5M3
         JsjZ2Hfs18qYPFycycc5KntUK5oJng9N3nveixfK0OFCUcKo68pVj/Z896ZqeEO8nT
         LiL23ka4xRS1pIsqVihTrBQFhUKdsb3XIhGkEpCOfvDC7pZiuC2qjCxedblbB3uqmE
         r20mg2ORZPbuA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D4022609E8;
        Thu, 25 Mar 2021 23:49:16 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem fix for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <98cd4b74a0658c14acc0071349122b13e7238a53.camel@linux.ibm.com>
References: <98cd4b74a0658c14acc0071349122b13e7238a53.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <98cd4b74a0658c14acc0071349122b13e7238a53.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12-fix
X-PR-Tracked-Commit-Id: 92063f3ca73aab794bd5408d3361fd5b5ea33079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db24726bfefa68c606947a86132591568a06bfb4
Message-Id: <161671615680.12710.6635035561217735131.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Mar 2021 23:49:16 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 25 Mar 2021 19:01:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db24726bfefa68c606947a86132591568a06bfb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
