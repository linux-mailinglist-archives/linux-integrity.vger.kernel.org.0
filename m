Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1C62EA3
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 05:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGIDPY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 23:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfGIDPE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 23:15:04 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562642103;
        bh=qAIXHIQXCwN4ZY9FkQ6TQ4y9mrlyzDm/W9EdCYOL7cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PP/R6lKRJcJNwHSUvQRE5AIzAKuEJpH/97s45voVnql/I2NM9VBslcsttUE7/Y0k4
         RsbxT+tSeSUd8i5W2aJl6UCej+Q8Yzb2iFsipT/q10l/NiD22aeI8qoOSYHGZ0McHs
         ANfFs8v8fV5wswTfZBT7r4tLVVni558TSjn2WNH0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
References: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190625
X-PR-Tracked-Commit-Id: 166a2809d65b282272c474835ec22c882a39ca1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 884922591e2b58fd7f1018701f957446d1ffac4d
Message-Id: <156264210349.2709.1195958711800929519.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 03:15:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        mjg59@google.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 01:50:47 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190625

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/884922591e2b58fd7f1018701f957446d1ffac4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
