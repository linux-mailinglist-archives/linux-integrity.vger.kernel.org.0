Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2E2547A3
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Aug 2020 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgH0OwZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 10:52:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgH0NYJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 09:24:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C5B1AC48;
        Thu, 27 Aug 2020 13:24:28 +0000 (UTC)
Date:   Thu, 27 Aug 2020 15:23:54 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200827132354.GA20439@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > +	if ! tst_is_num $KEYRING_ID; then
> > +		tst_brk TBROK "unable to parse the new keyring id ('$KEYRING_ID')"
> > +	fi
> > +

> Instead of using TST_DATAROOT, which is defined as
> "$LTPROOT/datafiles", use LTPROOT directly to define the path to the
> cert.  Adding the following will allow the test to run from the build
> directory.

>       if [ ! -f $cert_file ]; then
>               cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
>       fi
Yes, this will work if you set LTPROOT to <ltp git>/testcases/kernel/security/integrity/ima/tests/:

$ cd <ltp git>/testcases/kernel/security/integrity/ima/tests/
$ LTPROOT=$PWD PATH="../../../../../lib/:.:$PATH" ./ima_keys.sh

But, according to doc [1] $LTPROOT is "Prefix for installed LTP, the default is
/opt/ltp.". Using it like this is confusing (if we want to misuse $LTPROOT, one
would expect it's a cloned git root directory). Running from git root it'd have
to be:

$ cd <ltp git>
$ LTPROOT=$PWD/testcases/kernel/security/integrity/ima/tests/ \
PATH="testcases/lib:testcases/kernel/security/integrity/ima/tests/:$PATH" ima_keys.sh

TL;DR: I'd really prefer people run IMA from installed LTP (make && make install
in both testcases/lib and testcases/kernel/security/integrity/ima/ is just enough),
but I'll add this hack to make your testing easier :). But fixing this in
tst_test.sh is really needed.

> Mimi

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/User-Guidelines
