Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2F3B8905
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhF3TN0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:13:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49510 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhF3TN0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:13:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 985E072C8B4;
        Wed, 30 Jun 2021 22:10:55 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7CA714A46ED;
        Wed, 30 Jun 2021 22:10:55 +0300 (MSK)
Date:   Wed, 30 Jun 2021 22:10:55 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210630191055.xpjsooduv7dfo6vc@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-4-vt@altlinux.org>
 <9e3eff6a1aecbf609bf3759addf32848177a08d9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <9e3eff6a1aecbf609bf3759addf32848177a08d9.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jun 30, 2021 at 01:38:02PM -0400, Mimi Zohar wrote:
> On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 1c03768..bfce7ef 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -1021,10 +1021,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >  		return -1;
> >  	}
> > 
> > -	if (imaevm_params.keyid)
> > +	if (imaevm_params.keyid) {
> >  		hdr->keyid = htonl(imaevm_params.keyid);
> > -	else
> > -		calc_keyid_v2(&hdr->keyid, name, pkey);
> > +	} else {
> > +		if (__read_keyid(&hdr->keyid, keyfile, KEYID_FILE_PEM_KEY))
> > +			calc_keyid_v2(&hdr->keyid, name, pkey);
> > +	}
> 
> If the call to  __read_keyid() was independent of the test and call to
> calc_keyid_v2(), it would make reading code the easier to understand.
> 
> result = __read_keyid(...);
> if (result  < 0)
>     calc_keyid_v2(...);

No problem to add additional variable and check __read_keyid indirectly.
But, how is this independent? Call to calc_keyid_v2 is dependent to
__read_keyid result.

Thanks,

> 
> thanks,
> 
> Mimi
> 
> > 
> >  	st = "EVP_PKEY_CTX_new";
> >  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> 
