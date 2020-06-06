Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97041F07FE
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jun 2020 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFFRPD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Jun 2020 13:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgFFRPD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Jun 2020 13:15:03 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591463703;
        bh=GqEP5bmTThIHhRu5/SZdYs+DKg1sHnOTn9uROokY4RI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JB6VvAWF+vijGJ8Q8XLGuFAazdXM5TO4CXXlZmeOTHNuCACBCNoHhYFrtCYOicIJl
         qJGMYNWouxO7gGxyz9xhYTCUqfh4C56VAGBt1cG4O8tKATuloMa6CT71T9CXN4VQdZ
         0ZSQcpiJ3PRmKmPWfIz5gR47tuG2fRfdYzsIn84o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1591376548.5816.14.camel@linux.ibm.com>
References: <1591376548.5816.14.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1591376548.5816.14.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 tags/integrity-v5.8
X-PR-Tracked-Commit-Id: 42413b49804b250ced70dac8815388af2d4ad872
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c0ad98c2eda5ff30d23777e30744be6f7b8f097
Message-Id: <159146370302.31751.5200907103809059275.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 17:15:03 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Fri, 05 Jun 2020 13:02:28 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c0ad98c2eda5ff30d23777e30744be6f7b8f097

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
