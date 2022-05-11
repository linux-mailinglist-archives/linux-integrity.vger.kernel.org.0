Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410C5236FF
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245748AbiEKPUI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbiEKPUF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023620EE07;
        Wed, 11 May 2022 08:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3047C61913;
        Wed, 11 May 2022 15:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167A1C340EE;
        Wed, 11 May 2022 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652282403;
        bh=GMvnWYvbccZQktGrME0uBhLf6d3GEhAgIRMMt6zfpKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0GgXQ3dUxlFBEyRNuKUVqUYG6uMd2yFDSWva9G/T2PZlVOT9WDgfIg5Aw4gRrLVH
         LKx4I4DRmD5X5d+ukbDh0BUbefKRNEti9au2j7vah7qjirqIJJYTFesBfLg9ey8LIl
         i7GZuYMCbttNcxJZGkYMctx8CWaFGzRT8u26sCF6y9yXLHftCHCvYfVjWw8zO5bCUC
         PtDhOpduD0WUaYXj4wSRTRODtFpy2Ic11C7NZgkYUnvmJZ7V3mxQa9v2DHPNg6LwE/
         yuZlQfJm9mh7R4hmn1ZQzCY0rgJ0AUOUcS0UT+2rmHoSfTNSm18QcSvhdLLKWFYDSv
         vtpwU9Do0HeIw==
Date:   Wed, 11 May 2022 18:18:33 +0300
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
Message-ID: <YnvTyd8s4T+s/uAL@kernel.org>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-8-a.fatoum@pengutronix.de>
 <YnbH2Fgn/JFOU3Rf@iki.fi>
 <YnbIiJynQq/tcFa2@iki.fi>
 <e49920e6-0852-ad3d-5758-604655591671@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49920e6-0852-ad3d-5758-604655591671@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 11, 2022 at 12:48:53PM +0200, Ahmad Fatoum wrote:
> On 07.05.22 21:29, Jarkko Sakkinen wrote:
> >>> +KEYS-TRUSTED-CAAM
> >>> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> >>> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> >>> +L:	linux-integrity@vger.kernel.org
> >>> +L:	keyrings@vger.kernel.org
> >>> +S:	Maintained
> >>> +F:	include/keys/trusted_caam.h
> >>> +F:	security/keys/trusted-keys/trusted_caam.c
> >>> +
> >>>  KEYS/KEYRINGS
> >>>  M:	David Howells <dhowells@redhat.com>
> >>>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> >>> -- 
> >>> 2.30.2
> >>>
> >>
> >> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > 3/7 would probably need tested-by. Other than that this starts to look
> > good...
> 
> It has been tested by me on an i.MX6 (era < 10 with blobbing support)
> and by Michael on a LS1028A (era >= 10, both with and without blobbing
> support).
> 
> Cheers,
> Ahmad

Michael, can you give a tested-by for the corresponding patch?

BR, Jarkko
