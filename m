Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D6729C9A
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbjFIOTk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjFIOTY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 10:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD19730E7;
        Fri,  9 Jun 2023 07:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1F46116E;
        Fri,  9 Jun 2023 14:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566D9C433EF;
        Fri,  9 Jun 2023 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320361;
        bh=K7lXT3opzeY5uB4rE9Ffi1Qh2lNzJNMMWwcGGwb9Ekw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=NVOCgdjf9E0dLNTt2I5kZ2nivw7RdQSz72xA/fSLWl7yCM9Pz35MzMUDIQpaKn3Om
         AkqNd+/kgytymA/UDpkoBJ57Q5+rYqYTJaTMTgdYzFfGJemP0fHo+I8mIrRHJOLYjN
         ZBVvBj0T7P0qzSU/eNTfuvUF5pLvqUxL50eJUNV/jPreFgFnDAoHE1aeadQRd2hm3X
         4oH5+YU19+A2/zjnaLrqn5K26QRmtTW90We6No/C19ExfoxvwJFrSDUJ80KdSlG3Pk
         aJWwxYlOO2ybDJFzjPOt3bg5cR4prthVX1vDRWwvViUWc5KQbdQAfEPJf+FalAOqHQ
         xpRl/nAqWdi3A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 17:19:15 +0300
Message-Id: <CT86OCSDQS17.21FWH48JRKKI9@suppilovahvero>
Cc:     "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
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
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mark Brown" <broonie@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.14.0
References: <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com> <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com> <ZHhW_wFvRWInR_iM@orome> <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk> <ZHiQ44gAL3YEZPUh@orome> <c0cf893d-8bc5-4f4b-a326-bb10dd0c84de@sirena.org.uk>
In-Reply-To: <c0cf893d-8bc5-4f4b-a326-bb10dd0c84de@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 1, 2023 at 3:40 PM EEST, Mark Brown wrote:
> On Thu, Jun 01, 2023 at 02:36:51PM +0200, Thierry Reding wrote:
> > On Thu, Jun 01, 2023 at 12:04:59PM +0100, Mark Brown wrote:
>
> > > On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:
>
> > > > any ideas on how we can best get this merged? I guess at this point=
 it
> > > > could go through either tree since the SPI dependency has been in L=
inus'
> > > > tree since v6.4-rc1.
>
> > > I would expect it to go via whatever path TPM patches usually take gi=
ven
> > > that it's a TPM patch.
>
> > There might have been a misunderstanding. My recollection was that you
> > had said a few weeks ago that you would pick this up. Going through the
> > thread again I realize that may not have been what you meant. Perhaps
> > Jarkko misinterpreted this in the same way.
>
> > Jarkko, can you pick this up for v6.5?
>
> No, I said that I had applied the SPI parts for v6.4 so there would be
> no blocker whenever people got round to reviewing the TPM side.

I'm totally cool with this: won't pick the patch then.

BR, Jarkko
