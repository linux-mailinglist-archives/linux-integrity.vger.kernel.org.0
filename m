Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2884C0F68
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2019 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfI1DAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Sep 2019 23:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI1DAF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Sep 2019 23:00:05 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569639604;
        bh=jtFKP3EkySB41LzARpvXmneUuAPeP7ujI6kguXSjZzE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0nknJWqkBgHRjXDoGIYHILxyIfnpb/zEJhc0IL679rjklLpWB8ii3m+z1U9195eYH
         9heY5cspuIbb9r+XVvSBcUY1dnYGy6DCRyuRLhlPmfE0WrPwCYktpfXjseSizGRTP4
         QhK6+DkHw8XGDNXlVgR6XjxEbp8k1hJNqHk9yVik=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1568237365.5783.39.camel@linux.ibm.com>
References: <1568237365.5783.39.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1568237365.5783.39.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-integrity
X-PR-Tracked-Commit-Id: 2a7f0e53daf29ca6dc9fbe2a27158f13474ec1b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f2f614d535564992f32e720739cb53cf03489f
Message-Id: <156963960435.16958.10604183293405631549.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 03:00:04 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Wed, 11 Sep 2019 17:29:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f2f614d535564992f32e720739cb53cf03489f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
