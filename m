Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364E28FB71
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgJOXIc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 19:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbgJOXIc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 19:08:32 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602803311;
        bh=J+PmgdVeecsvfEK2XgwFvm6RwuRRjsnKgd3J2HF/3aI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mU+tBPqCxpkf/YRvOqEFglKBjAhRYrTdpb9mpyGjNvGL+s9FJcN55qopU4GZS504l
         VcndejMGlx4NShLuFWz9SPRmrfas3hYH1Wy5tRUem81+oOPckBb6WbKExA2brgdkEp
         +Th0F7noXkVXk9wMGRpvlAysa+14qcNr1jXKWy88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1bd027b4212db6f3630b8344efde4678fcd90088.camel@linux.ibm.com>
References: <1bd027b4212db6f3630b8344efde4678fcd90088.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1bd027b4212db6f3630b8344efde4678fcd90088.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.10
X-PR-Tracked-Commit-Id: aa662fc04f5b290b3979332588bf8d812b189962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 840e5bb326bbcb16ce82dd2416d2769de4839aea
Message-Id: <160280331167.7173.2869073053314550676.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 23:08:31 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 13:19:31 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/840e5bb326bbcb16ce82dd2416d2769de4839aea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
