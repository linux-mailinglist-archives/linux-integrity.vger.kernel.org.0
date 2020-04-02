Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27719CCFC
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Apr 2020 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbgDBWpE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 18:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390316AbgDBWpD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 18:45:03 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867503;
        bh=c9ETl+9+WA3T/vW2Fwgn72DysCMVBso1ewme4KBGaIg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rhheg33LUVg31zIEQdmJEuufZrQ87JAiMIm6wSIE1dRZ7RsiaJMHm0FYlONwSd2tS
         46J0saAD6t4wbeyaVXQYbhBSacqthMNV4wTs4y9kwpj+A8Uxx1yDdvZQfV5x/ckELW
         z3qV//G/jYKhEaR3aArhpHcigxqqH6GnDvMpohjo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1585778597.5188.665.camel@linux.ibm.com>
References: <1585778597.5188.665.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1585778597.5188.665.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 9e2b4be377f0d715d9d910507890f9620cc22a9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f218319caaaf6f2a43b22d8c82b898f32b4ec70
Message-Id: <158586750335.2810.1251219729592050514.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 22:45:03 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 01 Apr 2020 18:03:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f218319caaaf6f2a43b22d8c82b898f32b4ec70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
