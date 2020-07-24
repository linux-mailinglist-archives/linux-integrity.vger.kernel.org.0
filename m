Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4906322CF4C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXUPq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 16:15:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXUPp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 16:15:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21988AD0B;
        Fri, 24 Jul 2020 20:15:53 +0000 (UTC)
Date:   Fri, 24 Jul 2020 22:15:42 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
Message-ID: <20200724201542.GA85567@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com>
 <20200724131845.GB24626@dell5510>
 <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lachlan,

...
Thanks both for ack of the changes, I'll merge it on Monday.

> Hi Petr, these changes look good to me. I'm not exactly sure the convention
> here,
> since I originally wrote the patch, but feel free to mark me as
> Signed-off-by.
Of course I'll merge with you as the author of the patch :).

> Thank you for working on this!
> Lachlan

Kind regards,
Petr
