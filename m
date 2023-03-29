Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736EC6CF63C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2WQo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 18:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2WQn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 18:16:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8A4C2B;
        Wed, 29 Mar 2023 15:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7872FCE1AD9;
        Wed, 29 Mar 2023 22:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F01C433EF;
        Wed, 29 Mar 2023 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680128198;
        bh=qEzWWxe3urV5mH4fniwtoC5mrsTPABA1ybxLsxhpVxI=;
        h=Date:From:To:Cc:From;
        b=KybuRhACBdxfmbi2RI38GbS1qwi8My813WI8etEamc0jo12a0GgEDZAi+BWHBHu5h
         h792VHG0xfwoLqcrofdMjZUf7P89K5JwQNYjyNPDyfO/F3XnGBWKDEdS3b0ZsHw/fh
         uPBSRYYfbP1uFqhF8/JlUTUXK3JYUwHXNdS2F22Pk1ZQxY1fzzmtcwDk3CNAwskqQF
         XfmDzgmv8OZV4BxUyJRzycCuIyd+8jhatqs7ZllSqw9jLb0z7HlJU8u6KN8LJyKK9P
         7NdjHP9RCv+C2lj/3dB/T88+iiIaMxqEF26TSz/b+Ea4kLb8NhfQoLr1bFDJvCdjr1
         TnIgNaaUaSKmA==
Date:   Thu, 30 Mar 2023 01:16:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <20230329221635.eh4x764ec5iiu3q7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bcc:
Subject: Re: [PATCH 03/12] tpm: add buffer handling for TPM2B types
Reply-To:
In-Reply-To: <981c339a6f09cd16a1d677e0fc2df1bdf1a5baec.camel@HansenPartnership.com>

On Tue, Mar 28, 2023 at 03:42:09PM -0400, James Bottomley wrote:
> On Mon, 2023-02-27 at 10:31 +0200, Jarkko Sakkinen wrote:
> > On Thu, Feb 16, 2023 at 03:14:01PM -0500, James Bottomley wrote:
> > > Most complex TPM commands require appending TPM2B buffers to the
> > > command body.  Since TPM2B types are essentially variable size
> > > arrays, it makes it impossible to represent these complex command
> > > arguments as structures and we simply have to build them up using
> > > append primitives like these.
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > > ---
> > >  drivers/char/tpm/tpm-buf.c | 71
> > > +++++++++++++++++++++++++++++++++++---
> > >  include/linux/tpm.h        |  3 ++
> > >  2 files changed, 69 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-
> > > buf.c
> > > index ca59b92e0f95..292c6f14f72c 100644
> > > --- a/drivers/char/tpm/tpm-buf.c
> > > +++ b/drivers/char/tpm/tpm-buf.c
> > > @@ -7,17 +7,16 @@
> > >  #include <linux/module.h>
> > >  #include <linux/tpm.h>
> > >  
> > > -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > > +static int __tpm_buf_init(struct tpm_buf *buf)
> > >  {
> > >         buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> > >         if (!buf->data)
> > >                 return -ENOMEM;
> > >  
> > >         buf->flags = 0;
> > > -       tpm_buf_reset(buf, tag, ordinal);
> > > +
> > >         return 0;
> > >  }
> > > -EXPORT_SYMBOL_GPL(tpm_buf_init);
> > >  
> > >  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > >  {
> > > @@ -29,17 +28,60 @@ void tpm_buf_reset(struct tpm_buf *buf, u16
> > > tag, u32 ordinal)
> > >  }
> > >  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> > >  
> > > +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > > +{
> > > +       int rc;
> > > +
> > > +       rc = __tpm_buf_init(buf);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       tpm_buf_reset(buf, tag, ordinal);
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(tpm_buf_init);
> > > +
> > > +int tpm_buf_init_2b(struct tpm_buf *buf)
> > 
> > kdoc
> 
> I'm currently working on adding kdoc to everything.  However:
> 
> > > +{
> > > +       struct tpm_header *head;
> > > +       int rc;
> > > +
> > > +       rc = __tpm_buf_init(buf);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       head = (struct tpm_header *) buf->data;
> > > +
> > > +       head->length = cpu_to_be32(sizeof(*head));
> > > +
> > > +       buf->flags = TPM_BUF_2B;
> > 
> > Please make tpm_buf_init() and tpm_buf_reset() to work for both
> > cases.
> 
> That's not a good idea: tpm_buf_init() and tpm_buf_reset() are used to
> initialize *command* buffers.  tpm_buf_init_2b() is used for parameters
> within commands and can't encompass whole commands, so the arguments
> are different (that's why tpm_buf_init_2b() has no tag or ordinal).

Hmm... OK, I get this. I think this would a really good documentation
for this function to make it dead obvious.

> > This explodes the whole thing into an unmaintainable mess. It is
> > better to have a type as a parameter for tpm_buf_init() and have only
> > single flow instead of open coded and patched variation.
> > 
> > I'd simply just put it as:
> > 
> > struct tpm_buf *tpm_buf_init(u16 tag, u32 ordinal, bool tpm2b)
> 
> The convention in Linux is that it's better to have named initializers
> if we can rather than use less obvious booleans or flags ... think the
> conversion from printk(KERN_ERR, ...) to pr_err(...)
> 
> Additionally tag and ordinal have no meaning for a tpm2b, so you're
> really gluing two incompatible initializations into one which is bound
> to cause confusion.
> 
> I've no objection in principle to doing a reset of a tpm2b (except,
> again, it has no use for tag or ordinal) but I've just not got any code
> that would use it, so I was leaving it out until someone had an actual
> use case.
> 
> [...]
> > > index 150b39b6190e..f2d4dab6d832 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -300,6 +300,7 @@ struct tpm_header {
> > >  
> > >  enum tpm_buf_flags {
> > >         TPM_BUF_OVERFLOW        = BIT(0),
> > > +       TPM_BUF_2B              = BIT(1),
> > >  };
> > 
> > 
> > This is IMHO unnecessary complex.
> > 
> > I think we could just have two bools:
> > 
> >         bool overflow;
> >         bool tpm2b;
> 
> The advice (in the coding-style.rst bool section) is not to do this but
> go the other way (so use flags instead of a string of bools).  The
> reason is that even though bool represents a true/false value, it
> usually takes one machine word (32 bits or sometimes more) to do it, so
> bools tend to bloat structures over single bit fields.

I'm in process getting this tested ASAP. For past two weeks I've been putting
together a better QA environment for TPM so that I can run same tests with
NUC, Rapsberry PI3B, QEMU (for 1.2, I do not possess hardware chip anymore,
would be good to get one though), and possibly later Vision Quest 2
RISC-V board.

I was planning to get this, Lino's patch set, and reproduce bug reported
by Jason over the weekend but unfortunately got sick on Friday, and was
back at work on Tue. Anyway, please have some patience and I'll get over
these :-)

I think this new QA will over time pay itself back.

BR, Jarkko
