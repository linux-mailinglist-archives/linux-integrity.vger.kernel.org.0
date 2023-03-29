Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C76CF644
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2WSr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjC2WSr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 18:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C55251;
        Wed, 29 Mar 2023 15:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F9F0B820FC;
        Wed, 29 Mar 2023 22:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5989C433EF;
        Wed, 29 Mar 2023 22:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680128323;
        bh=LPKXNP+sV6Paa9ixM06V+mjOA1SRzRyMcJDWgx2RNSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFcQapHIc9bvQSPY97pmEtiVTYOa1MVH04gcgBdbcelaXnuBIl0j4XUVgp4h33ZV4
         pBHKyHjvzZZu5AaPK521AUZqzmenrPBxkLlGFCa+BGQK8b1L+FUOeOniMlK3zCsMja
         RQIzQI5TtlYYhXBXwHY1Q9A4Ipm9x8K3aIfDG7IlS4xdCX73YHzeZOeUOf79AxDu1u
         0F4o58j/FYrqYHyRONLQWSTSEpJ4WUY6FM4v2xD8BGeetRgft8igyUEH5D3NS5TVSl
         JkUOmUJnWgr0+tbpu74OfvfNQwNXCX3uTSwtmmVVTrtzoEQlalhmisNMsq3txJy8jK
         RySSu6RSeXj1g==
Date:   Thu, 30 Mar 2023 01:18:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V9 0/3] Tegra TPM driver with HW flow control
Message-ID: <20230329221840.dijkt2jnww6e45rg@kernel.org>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325183409.7695-1-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 26, 2023 at 12:04:06AM +0530, Krishna Yarlagadda wrote:
> TPM devices may insert wait state on last clock cycle of ADDR phase.
> For SPI controllers that support full-duplex transfers, this can be
> detected using software by reading the MISO line. For SPI controllers
> that only support half-duplex transfers, such as the Tegra QSPI, it is
> not possible to detect the wait signal from software. The QSPI
> controller in Tegra234 and Tegra241 implement hardware detection of the
> wait signal which can be enabled in the controller for TPM devices.
> 
> Add HW flow control in TIS driver and a flag in SPI data to indicate
> wait detection is required in HW. SPI controller driver determines if
> this is supported. Add HW detection in Tegra QSPI controller.
> 
> Updates in this patch set 
>  - Tegra QSPI identifies itself as half duplex.
>  - TPM TIS SPI driver skips flow control for half duplex and send
>    transfers in single message for controller to handle it.
>  - TPM device identifies as TPM device for controller to detect and
>    enable HW TPM wait poll feature.
> 
> Verified with a TPM device on Tegra241 ref board using TPM2 tools.
> 
> V9
>  - renamed tpm spi transfer functions
> V8:
>  - fix compile warning.
> V7:
>  - updated patch description.
>  - TPM flag set in probe.
>  - minor comments.
> V6:
>  - Fix typo in chip name Tegra234.
>  - Debug logs change skipped to be sent later.
>  - Consistent usage of soc flag.
> V5:
>  - No SPI bus locking.
> V4:
>  - Split api change to different patch.
>  - Describe TPM HW flow control.
> V3:
>  - Use SPI device mode flag and SPI controller flags.
>  - Drop usage of device tree flags.
>  - Generic TPM half duplex controller handling.
>  - HW & SW flow control for TPM. Drop additional driver.
> V2:
>  - Fix dt schema errors.
> 
> Krishna Yarlagadda (3):
>   spi: Add TPM HW flow flag
>   tpm_tis-spi: Add hardware wait polling
>   spi: tegra210-quad: Enable TPM wait polling
> 
>  drivers/char/tpm/tpm_tis_spi_main.c | 91 ++++++++++++++++++++++++++++-
>  drivers/spi/spi-tegra210-quad.c     | 14 +++++
>  include/linux/spi/spi.h             | 16 ++++-
>  3 files changed, 116 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

Looks quite sane to me. Can anyone peer test these (i.e. provide
tested-by)?

BR, Jarkko
