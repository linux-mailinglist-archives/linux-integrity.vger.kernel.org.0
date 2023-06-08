Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5926F728208
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjFHOAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjFHOAU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 10:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A9726AB;
        Thu,  8 Jun 2023 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E97564C79;
        Thu,  8 Jun 2023 14:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B75C433D2;
        Thu,  8 Jun 2023 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686232818;
        bh=9D5wCgWDsvqhe68Ss5JsgTkkHCuqZ4CotewKlUNqRh8=;
        h=Date:To:Subject:From:References:In-Reply-To:From;
        b=uRKfV27O7tVqQ0KiHeplwVmB9eb95iwq9BEBdoCrOTlDhELHYL4389US+pdKASaJe
         VuDh8fHKOcEGZ4Yn4sCq+3Tbsyhe2qYDN9djdvr/UcwEowTJ8GG/pwvGU7G5rOZhmq
         Ai/hFBNotrzUaz8si1BnUw1j5/QWSATivRlk96L23PB7nlU4GaYu2GhURNEiOV6+e4
         8U0c3EI62MfKTQSZMrfzlzykisBJzSTTi1qRnRu6nQyYzbqJ24zZYM6Vkb34j6zABW
         mlYwlzun/35gBzkx844cg2SlTPRUHyrEBSD8+s1vl+9yejYBcGqsCv0epIZTk6f4VV
         btJEMKdeuShIg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Jun 2023 17:00:15 +0300
Message-Id: <CT7BN97ICGN7.37I0H14NKKMYR@suppilovahvero>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-4-Alexander.Steffen@infineon.com>
 <CT5VOWDNIK5S.1549VUD23JWWB@suppilovahvero>
 <34f01f17-3091-0ce2-f0c3-b0cd25ea61ce@infineon.com>
In-Reply-To: <34f01f17-3091-0ce2-f0c3-b0cd25ea61ce@infineon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jun 7, 2023 at 8:14 PM EEST, Alexander Steffen wrote:
> >> -     if (status & TPM_STS_DATA_AVAIL) {      /* retry? */
> >> +     if (status & TPM_STS_DATA_AVAIL) {
> >=20
> > Please remove (no-op).
>
> You mean I shouldn't change the line and leave the comment in? To me it=
=20
> looked like a very brief TODO comment "should we retry here?", and since=
=20
> with this change it now actually does retry, I removed it.

Right, ok, point taken, you can keep it.

> >>                dev_err(&chip->dev, "Error left over data\n");
> >>                size =3D -EIO;
> >>                goto out;
> >> @@ -396,10 +391,39 @@ static int tpm_tis_recv(struct tpm_chip *chip, u=
8 *buf, size_t count)
> >>        }
> >>
> >>   out:
> >> -     tpm_tis_ready(chip);
> >>        return size;
> >>   }
> >>
> >> +static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, =
size_t count)
> >=20
> > This *substitutes* the curent tpm_tis_recv(), right?
> >=20
> > So it *is* tpm_tis_recv(), i.e. no renames thank you :-)
> >=20
> >> +{
> >> +     struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> >> +     unsigned int try;
> >> +     int rc =3D 0;
> >> +
> >> +     if (count < TPM_HEADER_SIZE) {
> >> +             rc =3D -EIO;
> >> +             goto out;
> >> +     }
> >> +
> >> +     for (try =3D 0; try < TPM_RETRY; try++) {
> >> +             rc =3D tpm_tis_recv(chip, buf, count);
> >=20
> > I would rename single shot tpm_tis_recv() as tpm_tis_try_recv().
> >=20
> >> +
> >> +             if (rc =3D=3D -EIO) {
> >> +                     /* Data transfer errors, indicated by EIO, can b=
e
> >> +                      * recovered by rereading the response.
> >> +                      */
> >> +                     tpm_tis_write8(priv, TPM_STS(priv->locality),
> >> +                                    TPM_STS_RESPONSE_RETRY);
> >> +             } else {
> >> +                     break;
> >> +             }
> >=20
> > And if this should really be managed inside tpm_tis_try_recv(), and
> > then return zero (as the code block consumes the return value).
>
> What exactly should be done in tpm_tis_try_recv()? It could set=20
> TPM_STS_RESPONSE_RETRY, but then it would still need to return an error=
=20
> code, so that this loop knows whether to call it again or not.

So my thinking was to:

- Rename tpm_tis_recv() as tpm_tis_try_recv()
- Rename this new function as tpm_tis_recv().

BR, Jarkko
