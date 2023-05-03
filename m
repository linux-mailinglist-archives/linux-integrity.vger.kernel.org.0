Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD266F572E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 May 2023 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjECLbo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 May 2023 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECLbn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 May 2023 07:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1846AC;
        Wed,  3 May 2023 04:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 456D4629F0;
        Wed,  3 May 2023 11:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95071C433EF;
        Wed,  3 May 2023 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683113501;
        bh=hVkxxzmR/MIPMkMSri1hUC8sUGB/8pTVJfJIw2Jacy8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=o69abGVzEiVUacq5Aro4hDmNcIadhyapwj/N2y/54tSqtaKXpnjo2TYQ8c9z9oM2x
         Nv7RBahFdupq8S8HmXbV6kRb/aqkuETytEYfz8//i7BIE6pJ75z/IT7Dwjr0qoug33
         iAk6AtwqjG1x/j9LeTd73d+y9+SR/sPPMNqQ1EbHzcJMY/J5TKfVFEGmjL4SdOsvLC
         ujsXKKkt7neNrs2MRIy6dtZjf2YVUTj0NvuI6yVpeUv2TvmkWTLXfRgezZbQFVMmPZ
         szFt23UxiOEbV8rzzYpbak3+NgtS5/NEFwI5V8b+quoZN3rROPEwY+JsHU8254SM5s
         FZqQEGAteDocQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 03 May 2023 14:31:38 +0300
Message-Id: <CSCLXUWIMPCG.D6K372YA1HMK@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 06/13] tpm: add buffer function to point to returned
 parameters
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
 <d5c86f6f-6854-c649-d2a9-8090cc7d74cd@linux.ibm.com>
In-Reply-To: <d5c86f6f-6854-c649-d2a9-8090cc7d74cd@linux.ibm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 2, 2023 at 5:09 PM EEST, Stefan Berger wrote:
>
>
> On 4/3/23 17:39, James Bottomley wrote:
> > Introducing encryption sessions changes where the return parameters

s/Introducing/Introduce/

Commit messages should always be in the imperative form.

> > are located in the buffer because if a return session is present
> > they're 4 bytes beyond the header with those 4 bytes showing the
> > parameter length.  If there is no return session, then they're in the
> > usual place immediately after the header.  The tpm_buf_parameters()
> > encapsulates this calculation and should be used everywhere
> > &buf.data[TPM_HEADER_SIZE] is used now.
> >=20
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >=20
> > ---
> > v4: add kdoc
> > ---
> >   drivers/char/tpm/tpm-buf.c | 27 +++++++++++++++++++++++++++
> >   include/linux/tpm.h        |  2 ++
> >   2 files changed, 29 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index da0f6e725c3f..d107321bcdff 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -277,3 +277,30 @@ u32 tpm_get_inc_u32(const u8 **ptr)
> >   	return val;
> >   }
> >   EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> > +
> > +static u16 tpm_buf_tag(struct tpm_buf *buf)
> > +{
> > +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> > +
> > +	return be16_to_cpu(head->tag);
> > +}
> > +
> > +/**
> > + * tpm_buf_parameters - return the parameters area of the tpm_buf
>
> in a TPM response
>
>
> > + * @buf: tpm_buf to use
> > + *
> > + * Where the parameters are located depends on the tag of a TPM
> > + * command. Evaluate this and return a pointer to the first byte of
> > + * the parameters area.
>
> I would also describe here what the non-obvious 4 bytes are that you are =
skipping over in case of TPM2_ST_SESSIONS.
>
> With this:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> > + *
> > + * @return: pointer to parameters area
> > + */
> > +u8 *tpm_buf_parameters(struct tpm_buf *buf)
> > +{
> > +	int offset =3D TPM_HEADER_SIZE;
> > +
> > +	if (tpm_buf_tag(buf) =3D=3D TPM2_ST_SESSIONS)
> > +		offset +=3D 4;
> > +
> > +	return &buf->data[offset];
> > +}
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 845eadfed715..d2fea2afd37c 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -340,6 +340,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
> >   u16 tpm_get_inc_u16(const u8 **ptr);
> >   u32 tpm_get_inc_u32(const u8 **ptr);
> >  =20
> > +u8 *tpm_buf_parameters(struct tpm_buf *buf);
> > +
> >   /*
> >    * Check if TPM device is in the firmware upgrade mode.
> >    */

BR, Jarkko
