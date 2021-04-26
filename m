Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B736B64C
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhDZQAC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 12:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhDZQAC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 12:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B64B26044F;
        Mon, 26 Apr 2021 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619452760;
        bh=YL9R7TRvbhmsh0VNfkQcK3MuA43bNXHEO1UpnNnP3jM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fvtxvBy5syZozg9ebJlHhfYOr3n/wnkFqFYm+6c4gjSpsw67M/jjwU3CO03e5L4BZ
         zPwIgvQxsJTdTPPvXjPP5i08j3zgbUNvVC2Nq2eIBt3eA4rvIiZNylbcn1sbQ/ZMjz
         5hLLVZol0TIYOUMuOujv123g4BkV+DrfXU3PGx+438E4hgIcezW49QgHypi+6Tv/Su
         HqqKxmZcOsxRN8gQOeytZqsnstovLuyfQ89R8OiS0UK6MEYQf0Of/s7anhwFouHcYv
         gwZGuBeeSOeOIPcBmUqi3yMFCJUWaxO2sVURyvn7bxfL5ywPpN3BtcLwLbTcL0s4+h
         EoPKEmOS4Gkqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A9AE8609AE;
        Mon, 26 Apr 2021 15:59:20 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHb06P4IOGV7eoiJ@kernel.org>
References: <YHb06P4IOGV7eoiJ@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHb06P4IOGV7eoiJ@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13
X-PR-Tracked-Commit-Id: aec00aa04b1131e17e6744681b380779f89d77b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60dc5f1bcfaa9cae9f99637e347d068cad7f8c9f
Message-Id: <161945276063.5751.837280008931872407.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 15:59:20 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 14 Apr 2021 16:58:00 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60dc5f1bcfaa9cae9f99637e347d068cad7f8c9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
