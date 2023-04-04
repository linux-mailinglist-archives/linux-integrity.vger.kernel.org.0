Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA36D6D59
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjDDTm6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjDDTm4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 15:42:56 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9B46A8;
        Tue,  4 Apr 2023 12:42:54 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id g9so24031771uam.9;
        Tue, 04 Apr 2023 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVy6vz18rTb7Udm0p5xModZ8Xqg9DGiiW3nsPVJcvq8=;
        b=fIdx3PKfuhKalicD/aVY6jVCnFSPNeNOC7UP9JQhBYksfnZcvsIi09uaXE+w6A0oVM
         sn2Ajcbwfhh4GRCJRaqUWh5GeRyg6u4XlrLGEa2tMjgFFEMK4nyBuWJHVXX7K+IWjpOz
         fXxMlXc4LbfJb/9aedkd4DYykvdhWq1mfbM1mSFLvE3AS5dN5MlCYsTZNpQwWHYqNQIH
         6MQWwYDKZ+jB6JjkGBe2Z7w2cfF4EUevALTyz+vhAyBR4gNpRuM3/ILsKSRpVVs5+Lbm
         jlv2kVh9Prol7OvX4SGK+1aalVWG/KvcALKqrxeDAZ3p+1Wuz443BnRwYcKBrUb6AIHj
         Y8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVy6vz18rTb7Udm0p5xModZ8Xqg9DGiiW3nsPVJcvq8=;
        b=NpUATjMLCBgG/8MtyhE0jNOX47bdl0ILqq9Whq1TWm0AO4KXkAliLc5cgRM8oKN1kA
         c5tYZkQTPtoHu4bhAY9+JHEASIgUgBalUIUBcWeqh1VTKH5iEJn08AwF3lZpD893LT+o
         SR6YPiTuZ6EFpWXkkSauKA18ekPO2uuuRcMmxbT3RI+8S7PLz+1zr/SBQ82iqlWq1U27
         YPF32PI0dkvGIA+hXA4AneY7IbdX/UUrdiizAozw/SFBu1Vwb0jZhMiI6ZJlnKASFIi5
         tNb2lj9dXA1AlgsGeLzvNawfbZNBCdgepbeEu4XCrfaSis+ThXlGUdML2nXyL74z7mH3
         q+bw==
X-Gm-Message-State: AAQBX9etaCorlZxhyDtQ+wO5ltlNFeJ1oCUrqHcnIS+xAQxMZG5dzESZ
        huFxbRCE+eVWaWnq3cscvIPEqb/vyeYlIQCEglDGTOK9
X-Google-Smtp-Source: AKy350aEqusm8LtYIomYlNMFMq2mAhrin6pG1ORNq/IcOEA7pc/UXMfRULE5XItrJ+ZzbbXu0+wBF3nR8gAg43njFKs=
X-Received: by 2002:a1f:21d8:0:b0:436:998e:a71e with SMTP id
 h207-20020a1f21d8000000b00436998ea71emr3153331vkh.3.1680637373217; Tue, 04
 Apr 2023 12:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com> <414fd2f5e49f9772dd1de4bd281a63e27e60e934.camel@HansenPartnership.com>
In-Reply-To: <414fd2f5e49f9772dd1de4bd281a63e27e60e934.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 4 Apr 2023 14:42:41 -0500
Message-ID: <CAFftDdqeaRWvfvZfGwdXYaFcGBNirDV75JsuRR88FSdCrYmKpg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 4, 2023 at 2:18=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2023-04-04 at 13:43 -0500, William Roberts wrote:
> [...]
> > > The final part of the puzzle is that the machine owner must have a
> > > fixed idea of the EK of their TPM and should have certified this
> > > with the TPM manufacturer.  On every boot, the certified EK public
> > > key should be used to do a make credential/activate credential
> > > attestation key insertion and then the null key certified with the
> > > attestation key.  We can follow a trust on first use model where an
> > > OS installation will extract and verify a public EK and save it to
> > > a read only file.
> >
> > Ahh I was wondering how you were going to bootstrap trust using the
> > NULL hierarchy.
>
> Well, actually, I changed my mind on the details of this one: the make
> credential/activate credential round trip is a huge faff given that
> there's no privacy issue.  I think what we should do is simply store
> the name of a known signing EK on first install (using the standard P-
> 256 derivation of the EK template but with TPMA_OBJECT_SIGN
> additionally set).  Then you can use the signing EK to certify the NULL
> key directly and merely check the signing EK name against the stored
> value to prove everything is correct.
>

Yeah that model is much simpler. My guess is that on install it would
persist this
"Signing EK" to a specific address that is different from the typical
EK Address?
Any particular reason for using the Endorsement Hierarchy outside of
the lifespan of the seed only changing on revocation of the Manufacturers C=
ert?
Ie why not Owner Hierarchy?

> James
>
