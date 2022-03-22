Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA04E3A5B
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 09:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiCVISG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCVISC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 04:18:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620D517CA;
        Tue, 22 Mar 2022 01:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D719CE1D27;
        Tue, 22 Mar 2022 08:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DBC340EC;
        Tue, 22 Mar 2022 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647936991;
        bh=wViT03VO9WUj9KY0s8wKyKJNf+YcAvGEWXKoZ9AleN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9Ue5cxIv8a2d8N6iYN533cFeIPEjXCJoeK1SMOj1yKL9jlMLWv2hpUePy4W2OOeI
         2/GfhIzr7iKeyu13vGPOdlUE4Z88QOXfK1iofqjHcHKQUqJbLDOFDEoWrSR0Vccevd
         E7UD3u4Bv81VODfXeTDk0Ds+1OhZhuStj8PSh5pKPwxW4FsS3KVOi587EFHNq0BCZl
         B+9VLpFoX5r9+g54AGfK7b4fAKZWMTh61sVM1H9x+u2Q8NTHuf98ZioWtJZcyNudLN
         qdYgiuy5fyanXQWqbfWw5tp05xwrO+/jqwNZ9dwMqIWlFOZo8oukfq1L3pqLSkNTdn
         JSOt8GXcFgUzA==
Date:   Tue, 22 Mar 2022 10:17:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 4/4] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YjmGHRK5TzteGwNu@iki.fi>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-5-a.fatoum@pengutronix.de>
 <YjeWSx84ev7u/YAi@iki.fi>
 <c946cce8-674a-43d2-1000-b57eba4bc45c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c946cce8-674a-43d2-1000-b57eba4bc45c@pengutronix.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 22, 2022 at 08:33:34AM +0100, Ahmad Fatoum wrote:
> Hello Jarkko,
> 
> On 20.03.22 22:02, Jarkko Sakkinen wrote:
> > On Wed, Mar 16, 2022 at 05:43:35PM +0100, Ahmad Fatoum wrote:
> >> @@ -192,6 +217,19 @@ Usage::
> >>  specific to TEE device implementation.  The key length for new keys is always
> >>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> >>  
> >> +Trusted Keys usage: CAAM
> >> +------------------------
> >> +
> >> +Usage::
> >> +
> >> +    keyctl add trusted name "new keylen" ring
> >> +    keyctl add trusted name "load hex_blob" ring
> >> +    keyctl print keyid
> >> +
> >> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
> >> +specific to CAAM device implementation.  The key length for new keys is always
> >> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> >> +
> >>  Encrypted Keys usage
> >>  --------------------
> >>  
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 05fd080b82f3..f13382a14967 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -10647,6 +10647,15 @@ S:	Supported
> >>  F:	include/keys/trusted_tee.h
> >>  F:	security/keys/trusted-keys/trusted_tee.c
> >>  
> >> +KEYS-TRUSTED-CAAM
> >> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> >> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> >> +L:	linux-integrity@vger.kernel.org
> >> +L:	keyrings@vger.kernel.org
> >> +S:	Maintained
> >> +F:	include/keys/trusted_caam.h
> >> +F:	security/keys/trusted-keys/trusted_caam.c
> >> +
> >>  KEYS/KEYRINGS
> >>  M:	David Howells <dhowells@redhat.com>
> >>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Documentation and MAINTAINERS updates must be separate patches.
> 
> I will do so for v7. Does this patch look otherwise ok to you?
> 
> Thanks,
> Ahmad

I don't give heads ups. It's improperly constructed patch, i.e. I won't
review it in this from.

BR, Jarkko
