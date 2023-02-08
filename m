Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3168E5F8
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBHCQd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHCQc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:16:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA03ABF;
        Tue,  7 Feb 2023 18:16:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA2561480;
        Wed,  8 Feb 2023 02:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECCC433EF;
        Wed,  8 Feb 2023 02:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675822590;
        bh=j7aKbY2JrEEZOdlDK4VVZgF73aOeL4L9cMCE/NEpNHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=En88/cYtQJhSQa4Lf5PRtfg53dkL950rcKZIKGBMLP2NZ5/5ZorBPSwjE4ewK1zsX
         YSQDFLFBK/gnYBESUE2ylU8vxOmZvEYzlGiG13NIimPqhFfMvxmZovo2Ua1AvHo51L
         d8UzlvwEzilwVpyvXY8nojXgsj/q9yneFqIwyG/G+xEd3gMeffmq27IS33Fs5qvYX9
         IMdB0hbrqkwWfe3VUzvbzmMdTkZbtDixZ7q4SvXD4r1mZAZNCj/0JVJ21bnvA+yXJw
         Iw6RSEh3sobe4WzR7zdfFfZdQ0iuEs9DD5hxyJBLmX0qi3jhbYGAO58P/Mp7PBen0Z
         dg2WQkufjyp2Q==
Date:   Wed, 8 Feb 2023 04:16:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [PATCH 0/4] Tegra TPM driver with hw flow control
Message-ID: <Y+MF+SdrE99YCuQB@kernel.org>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 02, 2023 at 09:47:46PM +0530, Krishna Yarlagadda wrote:
> Tegra234 and Tegra241 chips have QSPI controller that supports TCG
> PC Client Specific TPM Interface Specification (TIS) flow control.
> Since the controller only supports half duplex, sw wait polling
> (flow control using full duplex transfers) method implemented in
> tpm_tis_spi_main.c does not suffice.
> Added extended driver to disable sw flow control and send

s/Added/Add/

What is "extended driver"?

> all transfers in single message. Flow control is handled by hardware.
> 
> Krishna Yarlagadda (4):
>   dt-bindings: tpm: Add compatible for Tegra TPM
>   tpm: tegra: Support SPI tpm wait state detect
>   spi: dt-bindings: Add Tegra TPM wait polling flag
>   spi: tegra210-quad: Enable TPM wait polling
> 
>  .../security/tpm/nvidia,tegra-tpm-spi.txt     |  14 ++
>  ...nvidia,tegra210-quad-peripheral-props.yaml |   6 +
>  drivers/char/tpm/Makefile                     |   1 +
>  drivers/char/tpm/tpm_tis_spi.h                |   1 +
>  drivers/char/tpm/tpm_tis_spi_main.c           |   4 +-
>  drivers/char/tpm/tpm_tis_spi_tegra.c          | 123 ++++++++++++++++++
>  drivers/spi/spi-tegra210-quad.c               |  16 +++
>  7 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt
>  create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c
> 
> -- 
> 2.17.1
> 

BR, Jarkko
