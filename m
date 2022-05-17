Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6F52A96E
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351523AbiEQRi2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351501AbiEQRiZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 13:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188621FA5D;
        Tue, 17 May 2022 10:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A104C60FB7;
        Tue, 17 May 2022 17:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A778BC34116;
        Tue, 17 May 2022 17:38:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cgcWXJhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652809099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9RelKVWAEnn3zSQJJyz2hD3K3LfCnfuPRMvd0iw8j4=;
        b=cgcWXJhzp6k4CpAT0sgta14Ad3/9TfxFO4GYxtzSbrFce3PfybC1TERVN9ui0EudA5Eyu8
        AseI4vF6EvqI9sB+MGBVV/xYkhTeH/Wnb8wKwS1ItrJE+HsHEzpPhOzWnjY7KHTMQuZRpi
        V7R7qWfHAarzbsJvXD0L2VwcCFGpVoA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d74eb289 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 17:38:18 +0000 (UTC)
Date:   Tue, 17 May 2022 19:38:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Message-ID: <YoPdfjswwA2wKinr@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 17, 2022 at 11:52:55AM -0400, Mimi Zohar wrote:
> On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
> >  static int __init init_trusted(void)
> >  {
> > +       int (*get_random)(unsigned char *key, size_t key_len);
> >         int i, ret = 0;
> >  
> >         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > @@ -322,6 +333,28 @@ static int __init init_trusted(void)
> >                             strlen(trusted_key_sources[i].name)))
> >                         continue;
> >  
> > +               /*
> > +                * We always support trusted.rng="kernel" and "default" as
> > +                * well as trusted.rng=$trusted.source if the trust source
> > +                * defines its own get_random callback.
> > +                */
>  
> While TEE trusted keys support was upstreamed, there was a lot of
> discussion about using kernel RNG.  One of the concerns was lack of or
> insuffiencent entropy during early boot on embedded devices.  This
> concern needs to be clearly documented in both Documentation/admin-
> guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> encrypted.rst.

Sounds like FUD. Use `get_random_bytes_wait()`, and you'll be fine.

Jason
