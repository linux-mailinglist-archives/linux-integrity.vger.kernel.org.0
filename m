Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF6616FFF
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKBVmy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBVmw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 17:42:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041563D0
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 14:42:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h206so12700782iof.10
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIdmaqZeSNizmt6MMmspW44PQIHeaw+eQdTEyj8Is6o=;
        b=P9OBe1fpxXys3NgQvnjGd7oHgAEpNg32ivS5qFyIcKLfQml5BX0bCqWEGeOPNg4m/7
         AAmIM8iL1BXzL8WI6aY1JXpuRb33Nn06Lix+86LD08wQef1oEf0x+dgDFh2k6l2SgMKU
         UhClCHFo/bxgapDFaf9TW/vMI32RclXCuQsIirfBUp//rYdiTAp7iuN1cCbP1obai4n1
         TSx/In6U10ARA4uf/s+D9UfZymwMRNAMXW8uTpVRcokGixUWKJtLzyh8SXFUB+vTQe4e
         8A2PK0lwEpJ0FNjLbXF8xSZK26YcUs00yXfULI7jhzPI9T+gZ6l8T4gg1iwHJ5hg+Vhv
         IWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIdmaqZeSNizmt6MMmspW44PQIHeaw+eQdTEyj8Is6o=;
        b=mvBOZZcCZ4pd1cdlo7AIiZMspHkocdJ1QqH70AIa+O2txMuos1vNJy6Pe/bUn8mfcW
         97bBUPNcNwoqQ0idDPWl+Cac/T2RFme+3oXi9Gb+z3QZQ0lOS+3m41g7QAjNRW1AhzSn
         oj/vo1Wblt/nGQhOurL18BL3fZyWex+AA59QtoMgHJ2sSz2iF5smBVzsYgIgYcu1FZPv
         EmTgQBOyo8h/vrb4kjOOaxhADM74GTO0L7Jf0wlhrW8qh+ouHhGI853ZQXbcWWdCYJBf
         oF4SmQ45qK7pJAX3hCA6Wt2aHcH0i81ZvREpp2olQh9Booa9AFYYsZbifIl92BpBFsa/
         6iQg==
X-Gm-Message-State: ACrzQf2noHuqXOmbQlJBbtr/Z4/3ToK7npUvkBBtMMBwLKi/nXPlAZbb
        HSHw1d68vdR/FUHHbdtH+4IrZ3BBpeaK6EpcZH5fTA==
X-Google-Smtp-Source: AMsMyM772PXzRJ8S3Qzs5krirV4cUiywhBmYYiA8M2i7QN5tgG0CdB9/Xhijb+4KGBXw8O7PMGyfgsabZcYpoCLrUvs=
X-Received: by 2002:a02:7b10:0:b0:375:4b12:56c with SMTP id
 q16-20020a027b10000000b003754b12056cmr15012214jac.51.1667425371370; Wed, 02
 Nov 2022 14:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221101020352.939691-1-jsd@semihalf.com> <20221101020352.939691-3-jsd@semihalf.com>
 <CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
In-Reply-To: <CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Wed, 2 Nov 2022 22:42:40 +0100
Message-ID: <CAOtMz3P0aToZN8+VwQ2GjWQbn_=DOAZteyw0NxFgO4YAOPXxXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
To:     Tim Van Patten <timvp@google.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> >  /**
> > - * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
> > + * tpm_cr50_check_locality() - Verify if required TPM locality is active.
> >   * @chip: A TPM chip.
> > + * @loc: Locality to be verified
> >   *
> >   * Return:
> > - * - 0:                Success.
> > + * - loc:      Success.
> >   * - -errno:   A POSIX error code.
> >   */
> > -static int tpm_cr50_check_locality(struct tpm_chip *chip)
> > +static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
> >  {
> >         u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
> >         u8 buf;
> >         int rc;
> >
> > -       rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> > +       rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
> >         if (rc < 0)
> >                 return rc;
> >
> >         if ((buf & mask) == mask)
> > -               return 0;
> > +               return loc;
> >
> >         return -EIO;
> >  }
>
> Why is it useful to return the same `loc` value that was passed in,
> rather than just returning `0`? The caller already knows the value of
> `loc`, so they aren't being told anything new.
>
> I think this should continue to return `0` for success.

I agree, I should keep this as it was.

>
>
> > - * tpm_cr50_request_locality() - Request TPM locality 0.
> > + * tpm_cr50_request_locality() - Request TPM locality.
> >   * @chip: A TPM chip.
> > + * @loc: Locality to be requested.
> >   *
> >   * Return:
> > - * - 0:                Success.
> > + * - loc:      Success.
>
> Same as above. Return `0`.

The case here is that .request_locality callback should return active
locality. This value is assigned to chip->locality inside
tpm_request_locality() [drivers/char/tpm/tpm-chip.c].

>
> > @@ -374,7 +386,9 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
> >  {
> >         u8 buf[4];
> >
> > -       if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
> > +       WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");
>
> For each of these ` WARN_ONCE((chip->locality < 0), ...).`, can it
> return immediately rather than attempting to continue using an invalid
> locality value? Do the following commands have a chance of succeeding
> with the invalid value?

I agree - it makes more sense to return immediately instead of trying
to send invalid configuration over i2c.

Best Regards,
Jan
