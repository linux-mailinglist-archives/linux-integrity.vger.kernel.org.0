Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAF6A512E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 03:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjB1C2Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 21:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjB1C2O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 21:28:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2EC66F;
        Mon, 27 Feb 2023 18:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C920B60F21;
        Tue, 28 Feb 2023 02:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED0C433D2;
        Tue, 28 Feb 2023 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677551290;
        bh=z12K60BiOqqYNSlh0VQ0mkOy6DWR6l2dvzQwf+Fx43A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwsOO0QGU2YgpNQHcnVbn9b0wxmB4TiH9LZurY7XYL6IpclqesY3DDxXZwlWyiySr
         OVuC9SP2vwUTam2IqPZeFujBeWSCdoK9lXAB/R1oSjkm1XVAwBcleLlTYFTLT4myWL
         HHxzDF3ZBZiawmUl5z1ZGkjC8Zo+1/pTkwkC2ysbhBfqJbydgDeVpU98yJEoRDX/VL
         zypBfigGaiqzlpxXw4RlWuuGqzBN/P/ZAvdS5dE/sbeNRzTeZgby0GbgJqpFheYqy2
         skThCtOZxdTnnAKN7ndUMBJr7lnGQimkVrDHqyMenPS3OPJOle0wO2ISrnuO+5RSNi
         KzC/MN/0A1UZg==
Date:   Tue, 28 Feb 2023 04:28:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V5 0/3] Tegra TPM driver with HW flow control
Message-ID: <Y/1mtnSAg0TrVH2H@kernel.org>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227120702.13180-1-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 27, 2023 at 05:36:59PM +0530, Krishna Yarlagadda wrote:
> TPM interface spec defines flow control where TPM device would drive
> MISO at same cycle as last address bit sent by controller on MOSI. This
> state of wait can be detected by software reading the MISO line or
> by controller hardware. Support sending transfers to controller in
> single message and handle flow control in hardware. Half duplex
> controllers have to support flow control in hardware.
> 
> Tegra234 and Tegra241 chips have QSPI controller that supports TPM
> Interface Specification (TIS) flow control.
> Since the controller only supports half duplex, SW wait polling
> (flow control using full duplex transfers) method implemented in
> tpm_tis_spi_main.c will not work and have to us HW flow control.
> 
> Updates in this patchset 
>  - Tegra QSPI identifies itself as half duplex.
>  - TPM TIS SPI driver skips flow control for half duplex and send
>    transfers in single message for controller to handle it.
>  - TPM device identifies as TPM device for controller to detect and
>    enable HW TPM wait poll feature.
> 
> Verified with a TPM device on Tegra241 ref board using TPM2 tools.
> 
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
>   tpm_tis-spi: Support hardware wait polling
>   spi: tegra210-quad: Enable TPM wait polling
> 
>  drivers/char/tpm/tpm_tis_spi_main.c | 92 ++++++++++++++++++++++++++++-
>  drivers/spi/spi-tegra210-quad.c     | 21 +++++++
>  include/linux/spi/spi.h             |  7 ++-
>  3 files changed, 115 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

Funny that this is already in v5, I'm seeing this for the very first time.

BR, Jarkko
