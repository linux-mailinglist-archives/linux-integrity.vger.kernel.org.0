Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2C14C4C2
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2020 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgA2DAD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jan 2020 22:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgA2DAD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jan 2020 22:00:03 -0500
Subject: Re: [GIT PULL] integrity subsystem updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580266802;
        bh=AUh8a9mOT7BJyvvKE0IiWg8bKKn10fEYsuyhEsDQ2VQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GRt4tKgLKUN2BmO+tkyjemi/sS/nm2T1AxawCsV1uMZTB2cBYHUq42eJGFMyXlYyo
         llvViRx9fF9ZAdh5ySS9jMtyOqUAMbmzXBDwXm+a03FDGZmyNWFj3UPordiTKz8mkS
         agyQxuGE6Rbw1MgR9aJIraXXqKHD3Kxx3b3LxrO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1580242186.5088.96.camel@linux.ibm.com>
References: <1580242186.5088.96.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1580242186.5088.96.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: d54e17b4066612d88c4ef3e5fb3115f12733763d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73a0bff2058f2403c604371c325fec737ac2ac61
Message-Id: <158026680251.3354.3412098348797129123.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 03:00:02 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 15:09:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73a0bff2058f2403c604371c325fec737ac2ac61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
