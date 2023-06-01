Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F03C719A7B
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jun 2023 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFALFI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jun 2023 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jun 2023 07:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF4F2;
        Thu,  1 Jun 2023 04:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479EC63E7D;
        Thu,  1 Jun 2023 11:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF8C433EF;
        Thu,  1 Jun 2023 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685617505;
        bh=6ICHZuj6hAIAPZMijWweUahu445gncy1I/61jiUCcnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G964wP5YwTgFib8H2aeKMBgTbaXbq9ZrKUibvUuWYPHfxpR/wuy1dwTVgHbX9ZFuW
         TbKdKzj6d+JcaSZOM5KcICPhzBEYgUUedJ0kePwsktHqAhqBqb/ZhZW33f8bI/K1dg
         Jy+A+aQRiI9dK2JHjYM6sB5eZl+7larrUKxiZPfNLKFZsIs708oFbZNd7ioRBxQqGh
         61qC41wN0jNhy8nUO+DuGSFAjF0223eeQSX321g277smLyLEMvR/joB/iKSoCD8QvW
         sff74VJCTOtutSrkHtJI9xLteGYtnEAi53/0DmMRbg5PdH3zWz1Gxro1bMmHh5HZVM
         Ki4xXZiHL+/0A==
Date:   Thu, 1 Jun 2023 12:04:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
 <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
 <ZHhW_wFvRWInR_iM@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iD5QcbyXQ8ebAu4H"
Content-Disposition: inline
In-Reply-To: <ZHhW_wFvRWInR_iM@orome>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--iD5QcbyXQ8ebAu4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:

> any ideas on how we can best get this merged? I guess at this point it
> could go through either tree since the SPI dependency has been in Linus'
> tree since v6.4-rc1.

I would expect it to go via whatever path TPM patches usually take given
that it's a TPM patch.

--iD5QcbyXQ8ebAu4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR4e1oACgkQJNaLcl1U
h9AP+wf9GVc9ULNfksPHMKBakL0c2zPNxXCiQ6doxXtRFZvlyPMBECFlubmcjHsh
iJeBoi1TL64eSZZACGqtOY87DQIy7AEiCwJNiwDRcw6GO4O6L9+ouXnSwwiZyQjW
n6pQ3xn+idgizbovTlTRUj1gcysznDYOmTTsAJDejM1kXvVj6NbkXntpA8T8okPT
B9Sof6toDV5WVm0B/rhojzesL/mL1pQ+OQY1YyAYWNCn60pSWe2xFnxn57/lLzRc
UVk6C9dIagzyEwlGdaj33JZalfYT361LqzqyzfgSA6aflRNuGCCOuMBPIyZn/3OJ
ilzQVs7pq1OlP727XLbt5uscLtoRdA==
=2mt+
-----END PGP SIGNATURE-----

--iD5QcbyXQ8ebAu4H--
