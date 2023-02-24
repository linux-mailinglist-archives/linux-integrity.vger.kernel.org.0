Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3909E6A1FC4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBXQhn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 11:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBXQhn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 11:37:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE62E0E2;
        Fri, 24 Feb 2023 08:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11031B81CAE;
        Fri, 24 Feb 2023 16:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E612EC433EF;
        Fri, 24 Feb 2023 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677256657;
        bh=LZJ0OulRokQhXMJX9Jm7ETApiJEUZc6SbN49M2hORUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqbUZDgNdQGy9MPznzCY6Pzy2pFfZctat8hAJ9tYqct10rSpQE0j9MS/AW2nyVRII
         ZjNIvJjhB6seaxypyACIJF2WXCSLrX2ebcmTJ9gSeDSSOSctUQSf5vU7XU8uCD0lgg
         Uryw4ugeL+TBStl8tzZZH/AelLSTavPhsLGWbWylvCuXlM7EYh3BU8Vt+wD38q7hji
         AlBKjo2pW1V1PsAQJJIYpAUegYQ+FW6Dcvkgoso8zlldUSOa6hP6cxzVWQXTdaU/Ax
         Fo/1V+OWrTcaF+Ip8qhYcwnJRjF8xuaTeK8Gt8lu15CfXBmwoWF59Kusk8icxZZQF+
         legzEufqoAdGA==
Date:   Fri, 24 Feb 2023 16:37:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V4 3/3] spi: tegra210-quad: set half duplex flag
Message-ID: <Y/jny4dDix7txf0y@sirena.org.uk>
References: <20230224154941.68587-1-kyarlagadda@nvidia.com>
 <20230224154941.68587-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zQhtFjXUlSiwkV7P"
Content-Disposition: inline
In-Reply-To: <20230224154941.68587-4-kyarlagadda@nvidia.com>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--zQhtFjXUlSiwkV7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2023 at 09:19:41PM +0530, Krishna Yarlagadda wrote:
> Tegra QSPI controller only supports half duplex transfers.
> Set half duplex constrain flag.

This was already applied I think?  If any changes are required to what
was applied please send an incremental patch.

--zQhtFjXUlSiwkV7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP458oACgkQJNaLcl1U
h9Bwvgf/Tw+7+BnCGNSrksbU5IJ/pBu4DcP0k5ARs3cROJJTHIgsbYU4YoTYdUn5
lXkOUNv/Ry9wTZOf+LMy3OouyU4VfJXYzQmi52t2hcEkZTIqZ09xZbuMdBzu8i+A
sjZE77cNDg85bzkgZrjmI7NTabijsNYzdFQd+zlCIescL9uO7+kdSszI01ydYAvH
H9Ed/AZY4aTakycuUBkliV+SEmVxCPzmfH1KC3rRbVzwAbFfestbvWIsHle9mnk3
QWJGuU8lI0KStvsW9RHxa5EVWD2Xbl0asK+r2icrlY0nONbInMs3FftRCVeVivqe
OpAkE2oOx00a0upjUrqbgchiSB7iuQ==
=7jYH
-----END PGP SIGNATURE-----

--zQhtFjXUlSiwkV7P--
