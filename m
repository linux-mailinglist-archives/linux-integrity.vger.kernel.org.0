Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8224751E977
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 21:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446858AbiEGTb0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGTbZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 15:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092A1F60C;
        Sat,  7 May 2022 12:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8476091C;
        Sat,  7 May 2022 19:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF49C385A6;
        Sat,  7 May 2022 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651951657;
        bh=tCbjNWh33TN9ZWuP1GI7G43uFLsaZ6EsYzzFhSYLP/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvoOio3aGVWCzgmEJRP6dVi9rtgboB9UsetZ5WGs7wiWmmOW2kSdNKBYvbVvDrF4Z
         ODh/f2zbCEdRdTsmFhw1JHjz8bjaZW4/UBau0oOE7znx3EK9cA/4MdEF0XA+3Lq4Zc
         Unkzzgo+/HTfrXB0d7J6zELPxTbdCBV/9ZN860i6L18jIOgz3TqUFvo23D9fhh7dd4
         1uA2v/PWIjNgfww163WsmcZkXOpECZ3f01vSAo+ve19J9BvYuOnwnP6gZkUrB90887
         u8ZvUzkTTTYx/NDRt0keQa5kF8vqw2hog4iIAM/fEw6CU/0SkniDfyy5XQdES8srEm
         8V3TumBAt5UHQ==
Date:   Sat, 7 May 2022 22:29:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle <michael@walle.cc>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 7/7] MAINTAINERS: add KEYS-TRUSTED-CAAM
Message-ID: <YnbIiJynQq/tcFa2@iki.fi>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-8-a.fatoum@pengutronix.de>
 <YnbH2Fgn/JFOU3Rf@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnbH2Fgn/JFOU3Rf@iki.fi>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 07, 2022 at 10:26:21PM +0300, Jarkko Sakkinen wrote:
> On Fri, May 06, 2022 at 08:25:53AM +0200, Ahmad Fatoum wrote:
> > Create a maintainer entry for CAAM trusted keys in the Linux keyring.
> > 
> > Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
> > v8 -> v9:
> >   - rewrite commit message (Jarkko)
> > v7 -> v8:
> >   - add Pankaj's Reviewed-by
> > v6 -> v7:
> >   - split off as separate patch (Jarkko)
> > 
> > To: Jarkko Sakkinen <jarkko@kernel.org>
> > To: James Bottomley <jejb@linux.ibm.com>
> > To: Mimi Zohar <zohar@linux.ibm.com>
> > To: David Howells <dhowells@redhat.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: "Horia Geantă" <horia.geanta@nxp.com>
> > Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> > Cc: David Gstir <david@sigma-star.at>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> > Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5e8c2f611766..e58e6fc3016d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10855,6 +10855,15 @@ S:	Supported
> >  F:	include/keys/trusted_tee.h
> >  F:	security/keys/trusted-keys/trusted_tee.c
> >  
> > +KEYS-TRUSTED-CAAM
> > +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> > +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> > +L:	linux-integrity@vger.kernel.org
> > +L:	keyrings@vger.kernel.org
> > +S:	Maintained
> > +F:	include/keys/trusted_caam.h
> > +F:	security/keys/trusted-keys/trusted_caam.c
> > +
> >  KEYS/KEYRINGS
> >  M:	David Howells <dhowells@redhat.com>
> >  M:	Jarkko Sakkinen <jarkko@kernel.org>
> > -- 
> > 2.30.2
> > 
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

3/7 would probably need tested-by. Other than that this starts to look
good...

BR, Jarkko
