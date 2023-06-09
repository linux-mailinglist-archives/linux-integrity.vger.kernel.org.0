Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410D729DF4
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFIPMp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFIPMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 11:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9631FEB;
        Fri,  9 Jun 2023 08:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3329A61D23;
        Fri,  9 Jun 2023 15:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C50AC433D2;
        Fri,  9 Jun 2023 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686323562;
        bh=AwRX4+sJnX8qUM0WeKWhJVpcwCyWlK+KKr0cZLcayF8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=DT0PrVsfRSLlzWtU1EEG7KoHFfGKklbjpeSTzBdizF7CSJq9X9qzzwBMIK86R16Ru
         E6VeoZtNcy6SCe8VBGU04XHaGInvs5UtAvbfKielI5nm+ovm/415DFAnc1SE7o5tgk
         kcnQP13ESoZokKgSns5qiaNRXjt0/izxFmdVKenuOaF0vpAOVtnKWU2BSIdxf6JwnF
         R/5eZZ5TFw+G9RYAtXoq9gEInFuxI+V7pkmm+mtI6jllQVDi7oKw1qUt6ZU3HpPU2G
         pDRsMs3x15qFCbFNn0LP1Kq5LTBJhJax3PMgowb8P7JHaLYATBNOt640aOs/BbHE3/
         VtZBXr6wO549A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 18:12:34 +0300
Message-Id: <CT87T6F22SG0.Z8OLLVN0IZMI@suppilovahvero>
Cc:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
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
To:     "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.14.0
References: <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com> <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com> <ZHhW_wFvRWInR_iM@orome> <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk> <ZHiQ44gAL3YEZPUh@orome> <c0cf893d-8bc5-4f4b-a326-bb10dd0c84de@sirena.org.uk> <CT86OCSDQS17.21FWH48JRKKI9@suppilovahvero> <3b5e149d-4d52-46f8-85f5-821aa7b99ae9@sirena.org.uk>
In-Reply-To: <3b5e149d-4d52-46f8-85f5-821aa7b99ae9@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 9, 2023 at 5:22 PM EEST, Mark Brown wrote:
> On Fri, Jun 09, 2023 at 05:19:15PM +0300, Jarkko Sakkinen wrote:
> > On Thu Jun 1, 2023 at 3:40 PM EEST, Mark Brown wrote:
> > > On Thu, Jun 01, 2023 at 02:36:51PM +0200, Thierry Reding wrote:
> > > > On Thu, Jun 01, 2023 at 12:04:59PM +0100, Mark Brown wrote:
> > > > > On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:
>
> > > > Jarkko, can you pick this up for v6.5?
>
> > > No, I said that I had applied the SPI parts for v6.4 so there would b=
e
> > > no blocker whenever people got round to reviewing the TPM side.
>
> > I'm totally cool with this: won't pick the patch then.
>
> I have no intention of applying the patch, I am expecting it to go via
> the TPM tree.

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3D8638bedb01ab6170d7dbd1ceaefa5e82639c432d

I'll mirror publish this in my next branch (mirrored to linux-next) soon.

BR, Jarkko
