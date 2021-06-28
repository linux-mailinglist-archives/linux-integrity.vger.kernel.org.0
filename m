Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E123B6B64
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhF1XjL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 19:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233942AbhF1XjD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 19:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 571CB61D00;
        Mon, 28 Jun 2021 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624923392;
        bh=/hO/oZb2mVuBmkscgzTpx+bEkYMl6dXUAjL3aylUMAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FpnDsQkXrZ9AkdNeYnbTNfGlMaTBXcuABDHG3z6UGtOjh9KK1kkRoW9QJLss9hMJE
         7eI/t0Uk48dr6u/J1pio/AHVLOWeZwWxO5WWsl2LGnskweXOpRTZJcgXbqF9LzepfD
         Izy1kDDZoTzR6ljr5v/aSxgXP4cH22GzvUxtVdkcl0RLmwGK1lxIxmkMk9DEybdQ1B
         Cxy5fxqZq1CPgfDkk825mM08JLhbr+33e3ow/q0ysvxAzAB1360SrC3wNBSyW7VimX
         zZG2U/7HHkkG6RzJ4Hvw6vPnEOkDtDHrRUvg67qvzcLLjJXjqnFf3ZlXfvk3G7wMuz
         xrg+hOa+AzDfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 52A0260A3A;
        Mon, 28 Jun 2021 23:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <12f950a86631e83e9af52faa843cd335ac867af8.camel@linux.ibm.com>
References: <12f950a86631e83e9af52faa843cd335ac867af8.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <12f950a86631e83e9af52faa843cd335ac867af8.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.14
X-PR-Tracked-Commit-Id: 907a399de7b0566236c480d0c01ff52220532fb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a60c538ed2ff9d084544a894219eed9c5ab980e5
Message-Id: <162492339233.13806.2146751465335123896.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 23:36:32 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 14:10:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a60c538ed2ff9d084544a894219eed9c5ab980e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
