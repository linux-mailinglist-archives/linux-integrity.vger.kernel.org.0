Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96A26A6C72
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCAMhh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 07:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCAMhh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 07:37:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC13C794;
        Wed,  1 Mar 2023 04:37:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1026B81029;
        Wed,  1 Mar 2023 12:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAE6C4339B;
        Wed,  1 Mar 2023 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677674253;
        bh=MBQdWxbSmZQ5JdSzxRhSfN/JHRqs463vKGEv9B/9RBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2EYmLCQISZ/1K8ZrVhLUPXg9ffoV5BTo/0cvYM7U6SeEV7e7ALoKxh4VzWqppiea
         eJvvZXCiAt74bgLP0hpqeyBbmegHzBlsc/Wo1/+RvB02N2TKy00mzryhHeLF2U92r9
         qeq22inFTafqJSUOexyeVy1abWF398L40sbBowUrXi3Mj1FYXFpy5MhFwvXlwoRBjZ
         kHVpvs0L7KPmh5Dyf0WKiF3be7Ibo7NjZXyXWaqoQ4GC6OjZGty+mjmPxb5xG9gtab
         FcdxWbYn9ben6BVCYGgkmTC+84tPWRGH3LbKUYQ5op1UeT2i8ezSLo+EIM+Albox0t
         FtxFuaPOaKTnw==
Date:   Wed, 1 Mar 2023 12:37:27 +0000
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
Message-ID: <Y/9HB/KF2Kjkihkg@sirena.org.uk>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/9EwTtmxcVBjiHz@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZNm/cRTLJKLEOJhn"
Content-Disposition: inline
In-Reply-To: <Y/9EwTtmxcVBjiHz@nvidia.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--ZNm/cRTLJKLEOJhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 01, 2023 at 08:27:45AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 11:56:53AM +0000, Krishna Yarlagadda wrote:

> > TPM device connected behind half duplex controller can only work
> > this way. So, no additional flag needed to check.

> Just because a DT hooks it up this way doesn't mean the kernel driver
> can support it, eg support hasn't been implemented in an older SPI
> driver or something.

> If the failure mode is anything other than the TPM doesn't probe we
> will need to check for support.

It's not like these buses are hot pluggable - someone would have to
design and manufacture a board which doesn't work.  It's probably
reasonable for this to fail with the SPI subsystem saying it can't
support things when the operation is tried.

--ZNm/cRTLJKLEOJhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/RwYACgkQJNaLcl1U
h9Awdgf9Gw5DpsYEJgXj8lUPLqMn95/TGZDmecFTQXKHdEen+ujsVZy31oCvd7ct
BhopZRYQF917zCDkIS8EkkSgvpuXkQrzimXFKj4aroFtw5C0V4K4T+csnz8FqCKg
37/nfu0481Gwf6vY+7wd4oOuOzNJDGp6lOBBFNlSxoxL7tnV0JHm2eqmu0ndhPe7
UmdHEH5q3pgmZScrSptALSoqQRxCABT2n4Tdv9yayeNhc+x+fB3lvkt9yivIRqdG
wzntZGHATWgBkAulA89yauPXvRFvD2HnLSxaDPJtdEYZOy9RqwIdXzt5tWU6yhNp
jLUK4sBw8hwflLWmguFloPaZXnAzew==
=ePN6
-----END PGP SIGNATURE-----

--ZNm/cRTLJKLEOJhn--
