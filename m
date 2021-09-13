Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA155409BBC
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbhIMSIn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 14:08:43 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60230 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhIMSIn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 14:08:43 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ECCAF72C8B1;
        Mon, 13 Sep 2021 21:07:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A82754A46EF;
        Mon, 13 Sep 2021 21:07:25 +0300 (MSK)
Date:   Mon, 13 Sep 2021 21:07:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private
 keys and passwords
Message-ID: <20210913180725.d4rngs22tqkgos77@altlinux.org>
References: <20210904105054.3388329-1-vt@altlinux.org>
 <413f31067da8a63ecd76228e86505a9f4e5599f8.camel@linux.ibm.com>
 <20210910181307.dmpx5463c3t2etax@altlinux.org>
 <a5fce02a7ed3758c2aa13e0700b071d4b8d8213b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a5fce02a7ed3758c2aa13e0700b071d4b8d8213b.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Sep 13, 2021 at 01:51:58PM -0400, Mimi Zohar wrote:
> > > Assuming we aren't guaranteed that the heap size is allocated, should
> > > we check (e.g. OPENSSL_secure_actual_size())?
> > 
> > We guaranteed that secure heap is allocated by return value of
> > CRYPTO_secure_malloc_init.
> > 
> > OPENSSL_secure_actual_size tell if OPENSSL_secure_malloc is actually
> > provided bigger memory fragment than we requested (to reduce
> > fragmentation). Why care about it?
> 
> We wouldn't care, assuming we're guaranteed the heap size requested was
> allocated and not the minimum heap size.  Hm, wondering what would be
> the purpose of the minimum heap size ...

Perhaps, just to control heap fragmentation.

> > > > +	if (!CRYPTO_secure_malloc_init(8192, 64))
> > > > +		log_err("CRYPTO_secure_malloc_init() failed\n");
> > > 
> > > Either change the test to "!= 1" or also log "and 2 if successful but
> > > the heap could not be protected by memory mapping."
> > 
> > Why should we care about implementation details of successful
> > allocation? If they don't think it's secure heap they should not return
> > success. And they say about its return value "and 2 if successful but",
> > so it's successful.
> 
> If you're correct, then there is no reason ever for returning 2. 
> Without documentation or digging into OpenSSL, this makes no sense to
> me.  Perhaps "secure heap" has some kernel dependency, requires HW, or
> something else entirely.  Not that there is much we could or would do,
> but simply ignoring it just seems wrong.

I looked at CRYPTO_secure_malloc_init and it seems they return 2 if
mlock/madvise is failed. I think it's major enough to report it, so I
will add it.

Thanks,

