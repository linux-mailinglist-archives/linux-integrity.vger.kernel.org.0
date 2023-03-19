Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA36C021E
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Mar 2023 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCSNmk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Mar 2023 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSNmj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Mar 2023 09:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BC1EBED;
        Sun, 19 Mar 2023 06:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05F63B80B93;
        Sun, 19 Mar 2023 13:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23062C433D2;
        Sun, 19 Mar 2023 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679233355;
        bh=XW28SiAdE1y4C0WY0yU92It1pSLjH0atea5xcEjiF5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9yWFTqLR2JGlBPFzFmDDRQcgN2yR1p/TpStQI6vefWn9mdWXLed/GGB/hV1JyZOL
         pqTq+DP1B7p1bztMIinDLte9cZKtiXuq1ZLV8SKkxHhROrnZIDZqMtmiX4SEIRS3si
         wuuaBUVfeWzOl1gvYVfRM082aYX0NT+sjRJLZfgLFX5MzB6FL/sMlA17IanM7mW6gu
         huZQKNrCTuTtOJ5o3vMsBUEILe7rqBuRTwqmTsLtTfmA7kb3/OMFkyckEhr8p6KHxr
         l34BhosglXUMcUSQb9MuvosUqtp/upweK8dt8parKWpuRhjFvteU63BPTdvBC8fncn
         ZtndsjZod/AzA==
Date:   Sun, 19 Mar 2023 15:42:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
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
Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <20230319134232.wzjvk4ddwqrbexil@kernel.org>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
 <20230302041804.24718-3-kyarlagadda@nvidia.com>
 <01959c869e01075705cd436afa822f2586d0509c.camel@kernel.org>
 <DM4PR12MB576911FA514FAFEBE6B3A39FC3BF9@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB576911FA514FAFEBE6B3A39FC3BF9@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 15, 2023 at 03:47:33PM +0000, Krishna Yarlagadda wrote:
> 
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: 12 March 2023 03:19
> > To: Krishna Yarlagadda <kyarlagadda@nvidia.com>; robh+dt@kernel.org;
> > broonie@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> > krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; linux-
> > tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> > Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> > <ldewangan@nvidia.com>
> > Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, 2023-03-02 at 09:48 +0530, Krishna Yarlagadda wrote:
> > > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16
> > > len,
> > > +                        u8 *in, const u8 *out)
> > > +{
> > > +       struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > > +       struct spi_controller *ctlr = phy->spi_device->controller;
> > > +
> > > +       /*
> > > +        * TPM flow control over SPI requires full duplex support.
> > > +        * Send entire message to a half duplex controller to handle
> > > +        * wait polling in controller.
> > > +        * Set TPM HW flow control flag..
> > > +        */
> > > +       if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > > +               return tpm_tis_spi_hw_flow_transfer(data, addr, len,
> > > in,
> > > +                                                   out);
> > > +       else
> > > +               return tpm_tis_spi_sw_flow_transfer(data, addr, len,
> > > in,
> > > +                                                   out);
> > > +}
> > > +
> > 
> > Based on the condition, better names would be
> Though condition is based on half duplex, functions are implementing
> HW or SW flow of the transfer.

Both are hardwaw flows in the sense that you are controlling a piece of hardware.

BR, Jarkko
