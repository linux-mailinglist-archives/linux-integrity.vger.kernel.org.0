Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91C4A82B1
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiBCKtc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Feb 2022 05:49:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40092 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBCKtb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Feb 2022 05:49:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 831C61F399;
        Thu,  3 Feb 2022 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643885369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6gXtaxF4sUpqNbpvqW3e+eeQ67Q3V181j1MpX5xCXw=;
        b=HaY3A8a7CHu+p6SkQfzXFxoRVgaixyso1zTY8l10onfr+4M1WM6Keh9Ypvjdw1ey18+Cq8
        Pz48XGKgBpP8Ki2zWHuhHY1Gy46s/PE0MAZ4LbmxhJWmPuIQIKdMYbozDUo4+Q7MCpXRpB
        UgCTlfrM191QhW6/Am1jz3JKp4une/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643885369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6gXtaxF4sUpqNbpvqW3e+eeQ67Q3V181j1MpX5xCXw=;
        b=4EJKGBft4bAsvWMXkRCyg9VCRvMq2sAKI0INSYlhae42A7n/QFT0juKBfObRurO+3478Iw
        wdlekzqTUvDT8pBQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AACFA3B85;
        Thu,  3 Feb 2022 10:49:27 +0000 (UTC)
Date:   Thu, 3 Feb 2022 11:49:26 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 3/6] kexec_file: Don't opencode appended signature
 verification.
Message-ID: <20220203104926.GA3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
 <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
 <YfBafIXgnLzf0QMb@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBafIXgnLzf0QMb@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

thanks for the review.

On Tue, Jan 25, 2022 at 12:15:56PM -0800, Luis Chamberlain wrote:
> On Tue, Jan 11, 2022 at 12:37:45PM +0100, Michal Suchanek wrote:
> > diff --git a/include/linux/verification.h b/include/linux/verification.h
> > index a655923335ae..32db9287a7b0 100644
> > --- a/include/linux/verification.h
> > +++ b/include/linux/verification.h
> > @@ -60,5 +60,8 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
> >  				   enum key_being_used_for usage);
> >  #endif
> >  
> > +int verify_appended_signature(const void *data, unsigned long *len,
> > +			      struct key *trusted_keys, const char *what);
> > +
> 
> Looks very non-module specific.

Which it is now that the same signature format is used for kernels.

> 
> > diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> > index 8723ae70ea1f..30149969f21f 100644
> > --- a/kernel/module_signing.c
> > +++ b/kernel/module_signing.c
> > @@ -14,32 +14,38 @@
> >  #include <crypto/public_key.h>
> >  #include "module-internal.h"
> >  
> > -/*
> > - * Verify the signature on a module.
> > +/**
> > + * verify_appended_signature - Verify the signature on a module with the
> > + * signature marker stripped.
> > + * @data: The data to be verified
> > + * @len: Size of @data.
> > + * @trusted_keys: Keyring to use for verification
> > + * @what: Informational string for log messages
> >   */
> > -int mod_verify_sig(const void *mod, struct load_info *info)
> > +int verify_appended_signature(const void *data, unsigned long *len,
> > +			      struct key *trusted_keys, const char *what)
> >  {
> > -	struct module_signature ms;
> > -	size_t sig_len, modlen = info->len;
> > +	struct module_signature *ms;
> 
> There goes the abstraction, so why not make this clear where we re-use
> the struct module_signature for various things and call it as it is,
> verify_mod_appended_signature() or some such?

It sounds like the abstraction is actually improved by callers no longer
dealing with struct module_signature when verifying signature on a
kernel. That is the structure is misnamed but it is now hidden behind
an abstraction.

Or am I missing something?

Thanks

Michal
