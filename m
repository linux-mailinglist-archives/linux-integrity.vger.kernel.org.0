Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBE78426D
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Aug 2023 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjHVNvZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Aug 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjHVNvZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Aug 2023 09:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C41B9;
        Tue, 22 Aug 2023 06:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE4A630B5;
        Tue, 22 Aug 2023 13:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9FBC433C7;
        Tue, 22 Aug 2023 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712282;
        bh=wWgeV9cnYr35uF8vmB7XZowHeamqW2oUoudh7yeFjc0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=fLyb4xC3a6KmqdkzDYEtge66fwMiHgDZusGYkP2jEXXOF4kQ0wQyCEtRf2G4HoOA0
         gLaQAPe+AQJHW0toVSf/6WxcZCRkqth2RCzj9lkgPdStwuHhEdzBOX2mlzQlTIAm3y
         mgwBbK1RC9dN6rB9cReDCsQochGLs+0u1H7+9KRPwyTWVh6lvfoKUf0U2983PFZGnY
         Zg26XZZb7UW79fyge8VFqygxVEpfmc3fzNu9I0h0BwhUcq5QyLKTZ64Zy/sn3E3L+0
         hMMPO1NpM41Xq55FJuCRwn0at2ekAM0VgFHzWpB7h/qVmqfwXc5RtXLWuF1YP3LeX4
         xxRTBy5c6x/7Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 16:51:19 +0300
Message-Id: <CUZ4F9XVTLQC.2Y0E44H0PZ3P3@suppilovahvero>
Subject: Re: [PATCH v4 05/13] tpm: add cursor based buffer functions for
 response parsing
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
 <CUZ143E6EP2G.2V9A6YWYBSXJX@suppilovahvero>
In-Reply-To: <CUZ143E6EP2G.2V9A6YWYBSXJX@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 22, 2023 at 2:15 PM EEST, Jarkko Sakkinen wrote:
> On Tue Apr 4, 2023 at 12:39 AM EEST, James Bottomley wrote:
> > Extracting values from returned TPM buffers can be hard.  Add cursor
> > based (moving poiner) functions that make it easier to extract TPM
> > returned values from a buffer.
> >
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >
> > ---
> > v4: add kernel doc and reword commit
> > ---
> >  drivers/char/tpm/tpm-buf.c | 48 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h        |  3 +++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index b7e42fb6266c..da0f6e725c3f 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -6,6 +6,8 @@
> >  #include <linux/module.h>
> >  #include <linux/tpm.h>
> > =20
> > +#include <asm/unaligned.h>
> > +
> >  static int __tpm_buf_init(struct tpm_buf *buf)
> >  {
> >  	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
> > @@ -229,3 +231,49 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct=
 tpm_buf *tpm2b)
> >  	tpm_buf_reset_int(tpm2b);
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> > +
> > +/* functions for unmarshalling data and moving the cursor */
> > +
> > +/**
> > + * tpm_get_inc_u8 - read a u8 and move pointer beyond it
> > + * @ptr: pointer to pointer
> > + *
> > + * @return: value read
> > + */
> > +u8 tpm_get_inc_u8(const u8 **ptr)
> > +{
> > +	return *((*ptr)++);
> > +}
> > +EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
>
> No overflow check, and these should be static inlines.
>
> Please consider this:
>
> /**
>  * tpm_buf_read_u8() - Read a byte from a TPM buffer
>  * @buf:	&tpm_buf instance
>  * @offset:	offset within the consumed part of the buffer
>  */
> static inline int tpm_buf_read_u8(const struct tpm_buf *buf, offs_t *offs=
et)
> {
> 	if (*offset++ >=3D buf->length)

Oops, this increases pointer location, not value, sorry (should be (*offset=
)++).

> 		return -EINVAL;
> =09
> 	return buf->data[*offset - 1];	=09
> }

Actually probably best would be if you would add first (in order to
have all the logic in a single location):

/**
 * tpm_buf_read() - Read from a TPM buffer
 * @buf:	&tpm_buf instance
 * @count:	the number of bytes to read
 * @offset:	offset within the buffer
 * @output:	the output buffer
 */
int tpm_buf_read(const struct tpm_buf *buf, size_t count, offs_t *offset, v=
oid *output)
{
	if (*(offset + count) >=3D buf->length)
		return -EINVAL;

	memcpy(output, &buf->data[*offset], count);
	*offset +=3D count;

]	return 0;
}
EXPORT_SYMBOL_GPL(tpm_buf_read);

For instance:

static inline static int tpm_buf_read_u16(const struct tpm_buf *buf, offs_t=
 *offset)
{
	u16 value;
	int ret;

	ret =3D tpm_buf_read(buf, sizeof(u16), offset, &value);=09

	return ret ? ret : be16_to_cpu(value);
}
=20
BR, Jarkko
