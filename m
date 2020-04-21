Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5E1B308B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDUTkE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 15:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDUTkD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 15:40:03 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587498002;
        bh=zb9v/Fqr11DxgoXJezyIZpMjt3y6eTScm921w29WpUM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vlKDDMvw3JVUKUhAbdagfpI3NEzoSO4Ih3K0e17FhzC97fymTULE6BI7/un5nfByB
         McJEY+LNQyCeJwdShB2p7nLQiB3+rQdpVYQl7kdp8oKI4l4A4ZM6XRMFn0Yn+F/lKH
         PWATA+u3zod1c+RKDOaQ5sKXHZJ7YyyDuYHk4iME=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200420214744.GA18862@linux.intel.com>
References: <20200420214744.GA18862@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200420214744.GA18862@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200421
X-PR-Tracked-Commit-Id: b160c94be5d2816b62c8ac338605668304242959
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b61f7ff0f64f37797d437dd1e859c879e0be06e7
Message-Id: <158749800290.25518.14946554649746602252.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Apr 2020 19:40:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 21 Apr 2020 00:48:07 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200421

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b61f7ff0f64f37797d437dd1e859c879e0be06e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
