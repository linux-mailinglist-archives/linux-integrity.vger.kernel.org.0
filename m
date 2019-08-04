Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60180F72
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 01:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHDXpC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Aug 2019 19:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfHDXpC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Aug 2019 19:45:02 -0400
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564962301;
        bh=8RlQdNAcpQtFvyZL9AJ9supFQk2ldzqSGYCUn2mebXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mj3zyrmXGdhmeuBviKobHbebb3qsldE/vNr0BWp8kQpLKXQmWefy8nEn9s2h/kdY5
         Fe5fJWNSuQEV8rhsVoZ1LFofY80i+nVRS0EdJrC1kT/2z2MH6+xhNW5Q9vqWSGfrPO
         l9lMkgymiF/6i3mOR6fiPQYPc+SfYNvxFDOeqsS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
References: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190805
X-PR-Tracked-Commit-Id: fa4f99c05320eb28bf6ba52a9adf64d888da1f9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6831a89bcaf351cf41b3a5922640c89beaaf9eb
Message-Id: <156496230136.14797.607405632963435837.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 23:45:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        gmazyland@gmail.com, nayna@linux.ibm.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 01:14:50 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190805

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6831a89bcaf351cf41b3a5922640c89beaaf9eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
