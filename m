Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41C68C17B
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHMTZD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 15:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfHMTZD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 15:25:03 -0400
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565724302;
        bh=fb2E7hMTl5oWcFdEaa4sMK8QMX9lAJItlPoq+IiyALM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O6rq4RK60H6DBsgeA+oQhuH0ohtAmMB5LnDgvDetZb5hJWJ2pHMx+v4nGa6r60MIh
         pu1EPmhPUyTTecFiEmbsfdkjVIXMedZ3qD/ZZCWNdBDsxxtPQI7Qd8YzSnj5NqZMNn
         Iq8TA33aEwCCHKCp8JC/JnF1eCZ8PiF1cHIuWCZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190813170528.6w6s5d6ka4lzpzq5@linux.intel.com>
References: <20190813170528.6w6s5d6ka4lzpzq5@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190813170528.6w6s5d6ka4lzpzq5@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190813
X-PR-Tracked-Commit-Id: 2d6c25215ab26bb009de3575faab7b685f138e92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee1c7bd33e66376067fd6306b730789ee2ae53e4
Message-Id: <156572430212.27765.4569887924973984077.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Aug 2019 19:25:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        roberto.sassu@huawei.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pull request you sent on Tue, 13 Aug 2019 20:05:28 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190813

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee1c7bd33e66376067fd6306b730789ee2ae53e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
