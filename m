Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311427E1DB
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 08:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgI3Gxv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 02:53:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3Gxv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 02:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45450ABAD;
        Wed, 30 Sep 2020 06:53:50 +0000 (UTC)
Date:   Wed, 30 Sep 2020 08:53:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/4] IMA: Rewrite ima_boot_aggregate.c to new API
Message-ID: <20200930065348.GB21664@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165021.11731-3-pvorel@suse.cz>
 <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> <snip>

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index c69f891f1..dc958eb5c 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -33,7 +33,7 @@ test1()
> >  			tst_res TFAIL "bios boot aggregate is not 0"
> >  		fi
> >  	else
> > -		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
> > +		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
> >  		if [ "$boot_hash" = "$boot_aggregate" ]; then
> >  			tst_res TPASS "bios aggregate matches IMA boot aggregate"
> >  		else

> The original "ima" template is just the hash digest, without the
> algorithm.
Yes, but this code is output of ima_boot_aggregate.c. And code detecting old
format is still working (verified on ima_measurements.sh with ima_tcb kernel
parameter on 3.10).

Kind regards,
Petr
