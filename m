Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4952A976
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351534AbiEQRkY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351515AbiEQRkW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 13:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F63A18E;
        Tue, 17 May 2022 10:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B42FB81AF5;
        Tue, 17 May 2022 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881EC385B8;
        Tue, 17 May 2022 17:40:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QoGWHJxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652809215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxDxL5i0Upqgmpm52ds4asiv1ztGNF3KbavIIqo1G5c=;
        b=QoGWHJxL/A0rfUC7fW+gJ8TZOgUVSkXIvQjcj65Y9AaTARQQLkkd3a+YKDU9aOmiS1dG4v
        ZncG5NncPOcQedl7Z/jHTnKAgk11jfLMgf/9GxihLuwfGAvx5yRnsbG93TkRoIgOotDmbM
        j7Ld5cdV+R7yEcACHB9s+sBJvfbWQ2w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df76288f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 17:40:14 +0000 (UTC)
Date:   Tue, 17 May 2022 19:40:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Message-ID: <YoPd9qbkzT97IuCd@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
 <6da32ccf-1735-c47f-02c3-f7a8c736dbe3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6da32ccf-1735-c47f-02c3-f7a8c736dbe3@pengutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

On Tue, May 17, 2022 at 06:25:08PM +0200, Ahmad Fatoum wrote:
> Hello Mimi,
> 
> [Cc'ing RNG maintainers in case they want to chime in]

Thanks for adding me to this thread.

> On 17.05.22 17:52, Mimi Zohar wrote:
> > On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
> >>  static int __init init_trusted(void)
> >>  {
> >> +       int (*get_random)(unsigned char *key, size_t key_len);
> >>         int i, ret = 0;
> >>  
> >>         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> >> @@ -322,6 +333,28 @@ static int __init init_trusted(void)
> >>                             strlen(trusted_key_sources[i].name)))
> >>                         continue;
> >>  
> >> +               /*
> >> +                * We always support trusted.rng="kernel" and "default" as
> >> +                * well as trusted.rng=$trusted.source if the trust source
> >> +                * defines its own get_random callback.
> >> +                */
> >  
> > While TEE trusted keys support was upstreamed, there was a lot of
> > discussion about using kernel RNG.  One of the concerns was lack of or
> > insuffiencent entropy during early boot on embedded devices.  This
> > concern needs to be clearly documented in both Documentation/admin-
> > guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> > encrypted.rst.
> 
> If a user decides to use kernel RNG for trusted keys, wait_for_random_bytes()
> called first thing in the used get_random_bytes_wait() will (quoting
> documentation) "wait for the input pool to be seeded and thus [is] guaranteed
> to supply cryptographically secure random numbers."
> 
> Does this address your concerns about Kernel RNG use?

Indeed if get_random_bytes_wait() or wait_for_random_bytes() is called,
then the RNG will just block until it's accumulated 256 bits of
estimated entropy. The RNG will also make use of whatever hwrng or
cpu rng capabilities are available, and mix those in to augment its own
output.

Jason
