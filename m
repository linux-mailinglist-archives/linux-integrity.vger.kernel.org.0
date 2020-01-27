Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8B14A90F
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0RfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgA0RfC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:02 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146502;
        bh=1xliGvsBOcWpopxp1jdAXo5BLBHgmV8GPJ+RFhbyJZM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uWFj8Pg0+yXIbKokxkxV64Rlwp3c8PHB5A3akAOh6Mrcp6CJSSJJWooeaQsn/zNHD
         +HFr99Q7jheOLdlqmGUoGu5kaWFakId5uG9c2mcf0JyqywlBw/AmnsWJ36FMxXS4gU
         MZXaeP2KGSwFMKjx5pGRkF77L8ysw3X8RCwVdt1s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200122085335.GA9383@linux.intel.com>
References: <20200122085335.GA9383@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200122085335.GA9383@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200122
X-PR-Tracked-Commit-Id: 7084eddf6be94e73f8298c1a28078b91536f2975
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 189fc98efe59b9b0a49a4f29ee3d91eeded4e4d4
Message-Id: <158014650223.9177.123216930003214309.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        jsnitsel@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 22 Jan 2020 10:53:35 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/189fc98efe59b9b0a49a4f29ee3d91eeded4e4d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
