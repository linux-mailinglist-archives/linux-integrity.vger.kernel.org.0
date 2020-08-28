Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C1255434
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 08:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgH1GF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 02:05:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1GF6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 02:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB44BAD6F;
        Fri, 28 Aug 2020 06:06:28 +0000 (UTC)
Date:   Fri, 28 Aug 2020 08:05:54 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200828060554.GB15251@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510>
 <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
 <20200827225417.GA29921@dell5510>
 <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Thanks, Petr.  This works properly.  To remove the "hack", would
> require running the test from "ima", not "ima/tests", but that would
> require fixing how ima_setup.sh is called.   It also would still
> require setting TST_DATAROOT to TST_DATAROOT/$TST_ID.
Let's keep it and suppose people run tests from ima/tests.
This needs to be fixed on LTP side, I have it on my TODO list.

Anything else?
After that I'll work on ima_tpm.sh and after on policy automatic loading.
BTW there are also plans for reboot support [1] [2], that could be used as
workaround for configuration without CONFIG_IMA_READ_POLICY=y and
CONFIG_IMA_WRITE_POLICY=y.

[1] http://lists.linux.it/pipermail/ltp/2020-August/018636.html
[2] http://lists.linux.it/pipermail/ltp/2020-August/018658.html

> Mimi

Kind regards,
Petr
