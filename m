Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382D12DE1FA
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLRL2c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 06:28:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:33128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLRL2b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 06:28:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D1D7AC7B;
        Fri, 18 Dec 2020 11:27:50 +0000 (UTC)
Date:   Fri, 18 Dec 2020 12:27:48 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
Message-ID: <X9ySNMlhYIMKd+SY@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-2-pvorel@suse.cz>
 <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> Thank you!

> On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > To be reusable by more tests (preparation for next commit).

> > Call set_digest_index() inside get_algorithm_digest() if needed
> > instead of expecting get_algorithm_digest() caller to call
> > set_digest_index() before.

> For the existing builtin templates, the algorithm/digest field is
> consistent.  With support for per policy rule template formats, there
> isn't necessarily a single template format for the entire list.

> In the future "set_digest_index" might need to be renamed to
> "get_digest_index" and the lookup done for each line.
Thanks for info, noted as TODO. Policy example would speedup fixing.


Kind regards,
Petr

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

