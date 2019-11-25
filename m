Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60CA10959D
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 23:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfKYWpD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 17:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfKYWpD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:03 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721902;
        bh=pt93TpD3bcRM2woCPlb5kjxWwt/2vu3TsxLgqWDZZ9w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ALUiLUDYFnYHGCpY7Qtp8e7lDTF1DAr1U9MKAGnJpYzItxJZy8MX1W/h6NKXQbM0e
         OFZuvNas3vXqXG+rRI/G34rNSmnIZOLBaMa5WMoHDlfJVhtIl2c6TkgRdzNQ43589m
         5OmXYC/I9Xjmg16ibUCLWbj18S8Xya+dW5U5fzD4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191112195542.GA10619@linux.intel.com>
References: <20191112195542.GA10619@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191112195542.GA10619@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20191112
X-PR-Tracked-Commit-Id: 0b40dbcbba923b5379bd1d601edd6d51e23fe72c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54f0e54011c9e83277e84ec2f60696285066dfa9
Message-Id: <157472190290.22729.17187770371067659051.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 12 Nov 2019 21:55:42 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20191112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54f0e54011c9e83277e84ec2f60696285066dfa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
