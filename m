Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2F6ED127
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDXPTE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjDXPTA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 11:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B08A50;
        Mon, 24 Apr 2023 08:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8E3625F5;
        Mon, 24 Apr 2023 15:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788DCC433EF;
        Mon, 24 Apr 2023 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349532;
        bh=WNhrzb+two7LSArpEYTM4KxCfhgBU/6AXoKRPek2FD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+0e9hekrRTYM0TjAunzdz9BezS0atWyS8DcUnKSaTQ5nSraFCAdjaltJtk6yN4nh
         FbHL1hd6RTSuRbEIOulZtHxybTcYq6v3XYKpF6IFs+IUPFAuEG4VZgRp9nB7rTjkPG
         Vyy7E52k158r121lPyvmfcrGZzrKrMi6GDyP21wjFxe6/sWy5k+662hJi6O4hhr8Lk
         6Ped7sexk5PwgjuvyCjfvlcue4MTsCn/wLqWug5u6EbhTDE8XfluyYtuc3ZTH68kzy
         sbK+Kn/vxP7sHoKmCZ4FBsTay4YhQARymw7i9ztT4Rb44YFYn6RQ/2PbXBhzDLQiPE
         AqRn5OnfTjuzA==
Date:   Mon, 24 Apr 2023 16:18:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        jsnitsel@redhat.com, robh+dt@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lPOdm6vGo8h/yZ6"
Content-Disposition: inline
In-Reply-To: <ZEaWQD_QTs2usVl8@orome>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--7lPOdm6vGo8h/yZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2023 at 04:46:24PM +0200, Thierry Reding wrote:

> Would it make sense for you to pick up patch 2/3 as well? As far as I
> can tell there's a build dependency on patch 1/3 because of the newly
> added SPI_TPM_HW_FLOW symbol.

I'll include it in my pull request for spi this time round so it should
end up in -rc1, my thinking was that I was happy with the SPI bits and
if it was in -rc1 then the TPM bits could be handled without cross tree
issues when the review was sorted (which it is now but wasn't at the
time).  If the SPI side doesn't make -rc1 for some reason I can pick up
the TPM bit as well, and/or do a signed tag.

--7lPOdm6vGo8h/yZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGndQACgkQJNaLcl1U
h9ADuAf+K3fSxfQBMYgj1jBglBFx5Ww6piOvrVw4uby6KKj9nDBve1456ikcc80Z
hOQx1cJ3Cw191WSRTtUPX/I1xzuSEDfeks6kqK0JuaohVmQ3sGrSuo4vg3x8xiCs
3UTACSsJ4WzHlup+63eWyToow5bigO+kXLz6k/tHUbqrtkiKbgRxjbPePVLzAcox
dVJzpSFURHMzow92183nneyk+8FCEHeNTGTdYEnSRrtByFoqaCKwn8J1t6OhP46a
S6whcV5g0AbnNM0eT4W44aLcQTyEnI9wxpq0uF8a4PF+0EWj/lVlayuRQItK/nqN
D1QAtXhaCHRoCFt473q6C9cjcezxtA==
=q1nE
-----END PGP SIGNATURE-----

--7lPOdm6vGo8h/yZ6--
