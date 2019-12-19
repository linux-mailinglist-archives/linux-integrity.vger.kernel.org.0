Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF212593D
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 02:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSBaD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 20:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSBaD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 20:30:03 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576719002;
        bh=s8shV4w2igNDmjITc4x6DKnVvwncODzNRqpehLZ7QT8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjvEWmmGMzoNaOBvfT8+M5nnweh8c1zJ8KRQEfiDEVt48p94veuhHN13ylUb45a8f
         zl9PnFAqWKZqmabzVv/sXlN0LrrY8x9JMNDAX2VduiIIrYsZtUqevLdASlkgSue3mk
         pmvkj7NDxuqxlE582cg5dEw0vU3fX0BhQ/RF9gWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191219010317.GA3086@linux.intel.com>
References: <20191219010317.GA3086@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191219010317.GA3086@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tpmdd-next-20191219
X-PR-Tracked-Commit-Id: 1760eb689ed68c6746744aff2092bff57c78d907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a94c43323342f1522034d6566c5129a7386a0ab
Message-Id: <157671900258.19837.15533650713180573474.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Dec 2019 01:30:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 19 Dec 2019 03:03:17 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tpmdd-next-20191219

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a94c43323342f1522034d6566c5129a7386a0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
