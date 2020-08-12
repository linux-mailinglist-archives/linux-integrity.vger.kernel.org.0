Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990BE242A74
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHLNg4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 09:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgHLNg4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 09:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DD75AB71;
        Wed, 12 Aug 2020 13:37:16 +0000 (UTC)
Date:   Wed, 12 Aug 2020 15:35:07 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/4] IMA: verify measurement of certificate imported
 into a keyring
Message-ID: <20200812133507.GE4994@gacrux.arch.suse.de>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200807204652.5928-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807204652.5928-1-pvorel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> sending enhanced Lachlan's version.
> I haven't tested this patchset, could please anybody test it?

@Mimi FYI, I'm waiting for your review to merge this patchset (when you have
time).

Kind regards,
Petr

> Lachlan Sneff (1):
>   IMA: Add a test to verify measurement of certificate imported into a
>     keyring
I guess I should shorten this message.

> Petr Vorel (3):
>   IMA/ima_keys.sh Fix policy content check usage
>   IMA: Refactor datafiles directory
>   IMA/ima_keys.sh: Enhance policy checks

Kind regards,
Petr
