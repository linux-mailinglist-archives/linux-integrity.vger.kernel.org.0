Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86E550826
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jun 2022 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiFSDqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Jun 2022 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFSDqe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Jun 2022 23:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B549FFD18
        for <linux-integrity@vger.kernel.org>; Sat, 18 Jun 2022 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655610392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SupM77uoiaUlsLm8rRa8+v/8tKl0h9KOLP9hk1QSau0=;
        b=EHpgaOSGui/8WAMfOrhLgp3AE+biTiXpzHxY+tSueEnP4pIih0jQP/yWY0iOb3dOlwI0Jt
        XTSE8XLwxPmohdTfWyp1KTRkXVQB+QxavH2yXvW+M1WDg7AY2h76B0/bZHo2qUDYkJzuC5
        My4xm4RN6Wvvghtv/SL0Zh8ZLf3Obc4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-ikLfSl9JO760NCFA7V6-2Q-1; Sat, 18 Jun 2022 23:46:31 -0400
X-MC-Unique: ikLfSl9JO760NCFA7V6-2Q-1
Received: by mail-pg1-f198.google.com with SMTP id 196-20020a6300cd000000b0040c9c64e7e4so717898pga.9
        for <linux-integrity@vger.kernel.org>; Sat, 18 Jun 2022 20:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SupM77uoiaUlsLm8rRa8+v/8tKl0h9KOLP9hk1QSau0=;
        b=4G5bNEySOGzMv0dP8lKLoNUfhs6KgHeLR9tuk1WCoRhz5Rr8+SfdahN17wU4ZzmiHj
         Q4NQ+pXnAeZK5MelsCOOGigMcahNq62SQN+d+ZwLhJ1cK+NfMJVFBKPoPIQcIZOHGcUG
         EkQX5S5QhLzru4xiQg1AowPiMlJ7kSCe256T4NOZWQvaNeubOAHvkkRMg5Iu2jwlg/CX
         Yj4R5NoH1RLlpguMoqTwMYa0pescle2Fso4wCSDm98oLxUCBtyU93kAnYlEKm3gfIoaQ
         vdgKE+Z2aEQItKaMgt1xl4L2AqinzN+BQj8rxKwNbLDm5OyxjqkqRjC9Gw9UVdmFveha
         mU7g==
X-Gm-Message-State: AJIora9vnEi+0N8vGdUCx/lZYG/uIJvGtwCsSOR3hBFgosgxxErRIsWk
        bhyU6rF/fWNjwRJZahA9Io+abejW1A5z4/FTkgq3Q5Y1roVGwjyYFCRGq8kmPFT2eFERHLOIOwV
        ICv6/cycFt6oolZIxLtRQR4DkqEhS
X-Received: by 2002:a17:90b:33c4:b0:1e8:6e2f:97a2 with SMTP id lk4-20020a17090b33c400b001e86e2f97a2mr19431314pjb.165.1655610389922;
        Sat, 18 Jun 2022 20:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vVxWTpXRW4jW+5JJP6IOKW3ks0loWHHV7Ipk/+u1ZPR5zZH9VQ7LWo8roKg16k6n6OxCmMJw==
X-Received: by 2002:a17:90b:33c4:b0:1e8:6e2f:97a2 with SMTP id lk4-20020a17090b33c400b001e86e2f97a2mr19431300pjb.165.1655610389595;
        Sat, 18 Jun 2022 20:46:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b0050dc7628171sm6271169pff.75.2022.06.18.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:46:29 -0700 (PDT)
Date:   Sat, 18 Jun 2022 20:46:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: Re: CKI team seeing boot failures with 5.19 kernels on VMs with tpm
 device
Message-ID: <20220619034627.ldqdaqrnw5truaye@cantor>
References: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
 <Yqo4ot+mIW+LsrxB@iki.fi>
 <CALzcdduSg92P7nU3kXEugxq-xysvCPV2SUPRNtrvGMUb0rq6dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcdduSg92P7nU3kXEugxq-xysvCPV2SUPRNtrvGMUb0rq6dg@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 15, 2022 at 03:52:14PM -0700, Jerry Snitselaar wrote:
> On Wed, Jun 15, 2022 at 12:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 07:47:40AM -0700, Jerry Snitselaar wrote:
> > > This came to my attention this morning, and I was able to do a quick
> > > test and reproduce in a vm locally, using both the crb and tis
> > > emulation. 5.18 boots up fine.
> > >
> > > The only thing I see that could impact both crb and tis in the tpm
> > > changes would be:
> > >
> > > af402ee3c045 tpm: Add field upgrade mode support for Infineon TPM2
> > > modules | 2022-05-23 | (Stefan Mahnke-Hartmann)
> > > e57b2523bd37 tpm: Fix buffer access in tpm2_get_tpm_pt() | 2022-05-23
> > > | (Stefan Mahnke-Hartmann)
> > >
> > > I'm going to poke around some more and see if I can figure out what is
> > > going on, but wanted to give you a heads up.
> > >
> > > Regards,
> > > Jerry
> > >
> >
> > OK, thanks for spotting this.
> >
> > BR, Jarkko
> >
> 
> Whatever it was it wasn't the tpm code, and it looks like it has
> disappeared with v5.19-rc2.
> 
> Regards,
> Jerry
> 

It looks like the problem was fixed by:

228432551bd8 ("virtio-rng: make device ready before making request")

If I revert this on 5.19-rc2, I see the problem again. One of the
commits it lists as fixing is:

8b4ec69d7e09 ("virtio: harden vring IRQ")

If I go to a build prior to that it comes up fine. So looks like
it was introduced by 8b4ec69d7e09 and fixed with 228432551bd8.

Regards,
Jerry

