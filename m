Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB1233EB4
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 07:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgGaFeq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 01:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbgGaFeq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 01:34:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73C8BAC82;
        Fri, 31 Jul 2020 05:34:57 +0000 (UTC)
Date:   Fri, 31 Jul 2020 07:34:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@kernel.org>,
        Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
Message-ID: <20200731053443.GB3900@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200728001301.31121-1-pvorel@suse.cz>
 <1596139131.25003.14.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596139131.25003.14.camel@kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lachlan,

> On Tue, 2020-07-28 at 02:13 +0200, Petr Vorel wrote:
> > From: Lachlan Sneff <t-josne@linux.microsoft.com>

> > IMA policy can be set to measure the command line passed in the kexec
> > system call. Add a testcase that verifies that the IMA subsystem
> > correctly measure the cmdline specified during a kexec.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> > [ pvorel: improved setup, various LTP API cleanup ]
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, really nice.

> Missing is a short comment explaining the reason for the multiple
> tests.

Just to reduce duplicity with checks.

Anyway, finally merged, thanks a lot both!

Kind regards,
Petr
