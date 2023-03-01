Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96A6A6D51
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCANpk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCANpj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:45:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D973B207;
        Wed,  1 Mar 2023 05:45:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC906121F;
        Wed,  1 Mar 2023 13:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E7DC433D2;
        Wed,  1 Mar 2023 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677678337;
        bh=1dD0pfFSToxyyHnOfvS1/MB1SaH40n0HvBzGm/xGYgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nP6fPks0nvwV8mXLCdjb4pNHMZDHId82gyBhyBiHJ3jK1Zli0+IT3ucPaSdF6cnQ4
         4GL0XhGSxttxixLQ8Fin5ohtn0ve2kqkEUSOV3kj35Rqco1v/FGDpxH1DjOA8uxU8j
         LinWi1/l2eQAokClHIdsAoikDUgopALAzA/UCgYE6kG/OGyPwQuyeXcJVknQwA9p/M
         KKPZiCMT5i1/4BKcyV5t7L3f0l1MYAxOC/3VVVjka7o2xaxqpsZxWNx+7ZFGyg8R0U
         QKqyS8TZw2I1FW/Lht912c910+pFSQ0LYkuYB0VoV5Fo7dswNjM2WSTroLTZYqsIfj
         5WZo4YfiHlSNg==
Date:   Wed, 1 Mar 2023 13:45:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/9W+7fiRRMqw5LB@sirena.org.uk>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/9EwTtmxcVBjiHz@nvidia.com>
 <Y/9HB/KF2Kjkihkg@sirena.org.uk>
 <Y/9VkGjCP48FHtyS@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlJqL3KQOXVxMEv/"
Content-Disposition: inline
In-Reply-To: <Y/9VkGjCP48FHtyS@nvidia.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--HlJqL3KQOXVxMEv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 01, 2023 at 09:39:28AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 12:37:27PM +0000, Mark Brown wrote:

> > It's not like these buses are hot pluggable - someone would have to
> > design and manufacture a board which doesn't work.  It's probably
> > reasonable for this to fail with the SPI subsystem saying it can't
> > support things when the operation is tried.

> If the spi subsystem fails this request with these flags that would be
> great, it would cause the TPM to fail probing reliably.

> But does this patch do that? It looks like non-supporting half duplex
> drivers will just ignore the new flag?

That's something we can fix up in SPI, we shouldn't worry about it for
the client drivers.

--HlJqL3KQOXVxMEv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/VvoACgkQJNaLcl1U
h9BVlgf/fs6E4wmKL5YMg67Xab5gvjFCS0c76pnr1vNsg7oz4yBQBqQnyEcgAuBl
tPyhDERF91NXkFa1bnJKd0aVFmq3cgUCp1bswLI2UfCXb+7T91yfHPR1zuJHXzX8
S9WBmw8wZJYHHzgxVuOKaRjsg/SYUKSMYuPiW34HDhMKBlf94IiqsrK78Li5Gj5W
9Z9DBv2CKGjP1JvcprBZQqhrgrDBWploLOh+5GqjKCDtoeSdntuUD+015K+EiajS
RQpThQz4OfCWLfuGVb4O/L5tNoI0QSIzAz2DAq8Ow3XLzdGLK+nzeOuC/j9JVXh6
wYcHaj8yHSm7/Esg05zt6MZzeMhK+g==
=YiAy
-----END PGP SIGNATURE-----

--HlJqL3KQOXVxMEv/--
