Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5606CCAD8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Mar 2023 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC1TmR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Mar 2023 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1TmQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Mar 2023 15:42:16 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653539F;
        Tue, 28 Mar 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680032532;
        bh=EnCIZR9L3TlBlrVGMnuA5qvZ9gv41Av4SPp4vWEd8Zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CGDvjj2hkMeFEVn2JyDmbuRZktoKUo6bBE48kp2fncOJceVjg7bJbYfvDyYWhpEKP
         oqIcHgIaA/kjXyeCJ+EEdCJzfDCwmuSm5Z2ME0jZXpuPISt6NDtc64EiT9EB2e+C5A
         /fKQI279uzVCyopu4wbpH3cZmj7Cgaawu0c7v+7c=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B238E12807C5;
        Tue, 28 Mar 2023 15:42:12 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Hn-nqg_EzYuD; Tue, 28 Mar 2023 15:42:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680032532;
        bh=EnCIZR9L3TlBlrVGMnuA5qvZ9gv41Av4SPp4vWEd8Zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CGDvjj2hkMeFEVn2JyDmbuRZktoKUo6bBE48kp2fncOJceVjg7bJbYfvDyYWhpEKP
         oqIcHgIaA/kjXyeCJ+EEdCJzfDCwmuSm5Z2ME0jZXpuPISt6NDtc64EiT9EB2e+C5A
         /fKQI279uzVCyopu4wbpH3cZmj7Cgaawu0c7v+7c=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0ABE012806FC;
        Tue, 28 Mar 2023 15:42:11 -0400 (EDT)
Message-ID: <981c339a6f09cd16a1d677e0fc2df1bdf1a5baec.camel@HansenPartnership.com>
Subject: Re: [PATCH 03/12] tpm: add buffer handling for TPM2B types
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Mar 2023 15:42:09 -0400
In-Reply-To: <Y/xqbCwh+VBmJ1ZL@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
         <20230216201410.15010-4-James.Bottomley@HansenPartnership.com>
         <Y/xqbCwh+VBmJ1ZL@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-27 at 10:31 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 16, 2023 at 03:14:01PM -0500, James Bottomley wrote:
> > Most complex TPM commands require appending TPM2B buffers to the
> > command body.  Since TPM2B types are essentially variable size
> > arrays, it makes it impossible to represent these complex command
> > arguments as structures and we simply have to build them up using
> > append primitives like these.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/char/tpm/tpm-buf.c | 71
> > +++++++++++++++++++++++++++++++++++---
> >  include/linux/tpm.h        |  3 ++
> >  2 files changed, 69 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-
> > buf.c
> > index ca59b92e0f95..292c6f14f72c 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -7,17 +7,16 @@
> >  #include <linux/module.h>
> >  #include <linux/tpm.h>
> >  
> > -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +static int __tpm_buf_init(struct tpm_buf *buf)
> >  {
> >         buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> >         if (!buf->data)
> >                 return -ENOMEM;
> >  
> >         buf->flags = 0;
> > -       tpm_buf_reset(buf, tag, ordinal);
> > +
> >         return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(tpm_buf_init);
> >  
> >  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> >  {
> > @@ -29,17 +28,60 @@ void tpm_buf_reset(struct tpm_buf *buf, u16
> > tag, u32 ordinal)
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> >  
> > +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +{
> > +       int rc;
> > +
> > +       rc = __tpm_buf_init(buf);
> > +       if (rc)
> > +               return rc;
> > +
> > +       tpm_buf_reset(buf, tag, ordinal);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tpm_buf_init);
> > +
> > +int tpm_buf_init_2b(struct tpm_buf *buf)
> 
> kdoc

I'm currently working on adding kdoc to everything.  However:

> > +{
> > +       struct tpm_header *head;
> > +       int rc;
> > +
> > +       rc = __tpm_buf_init(buf);
> > +       if (rc)
> > +               return rc;
> > +
> > +       head = (struct tpm_header *) buf->data;
> > +
> > +       head->length = cpu_to_be32(sizeof(*head));
> > +
> > +       buf->flags = TPM_BUF_2B;
> 
> Please make tpm_buf_init() and tpm_buf_reset() to work for both
> cases.

That's not a good idea: tpm_buf_init() and tpm_buf_reset() are used to
initialize *command* buffers.  tpm_buf_init_2b() is used for parameters
within commands and can't encompass whole commands, so the arguments
are different (that's why tpm_buf_init_2b() has no tag or ordinal).

> This explodes the whole thing into an unmaintainable mess. It is
> better to have a type as a parameter for tpm_buf_init() and have only
> single flow instead of open coded and patched variation.
> 
> I'd simply just put it as:
> 
> struct tpm_buf *tpm_buf_init(u16 tag, u32 ordinal, bool tpm2b)

The convention in Linux is that it's better to have named initializers
if we can rather than use less obvious booleans or flags ... think the
conversion from printk(KERN_ERR, ...) to pr_err(...)

Additionally tag and ordinal have no meaning for a tpm2b, so you're
really gluing two incompatible initializations into one which is bound
to cause confusion.

I've no objection in principle to doing a reset of a tpm2b (except,
again, it has no use for tag or ordinal) but I've just not got any code
that would use it, so I was leaving it out until someone had an actual
use case.

[...]
> > index 150b39b6190e..f2d4dab6d832 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -300,6 +300,7 @@ struct tpm_header {
> >  
> >  enum tpm_buf_flags {
> >         TPM_BUF_OVERFLOW        = BIT(0),
> > +       TPM_BUF_2B              = BIT(1),
> >  };
> 
> 
> This is IMHO unnecessary complex.
> 
> I think we could just have two bools:
> 
>         bool overflow;
>         bool tpm2b;

The advice (in the coding-style.rst bool section) is not to do this but
go the other way (so use flags instead of a string of bools).  The
reason is that even though bool represents a true/false value, it
usually takes one machine word (32 bits or sometimes more) to do it, so
bools tend to bloat structures over single bit fields.

James

