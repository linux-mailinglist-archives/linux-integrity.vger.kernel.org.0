Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530E6EAAEB
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDUMvT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDUMvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 08:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192FC645
        for <linux-integrity@vger.kernel.org>; Fri, 21 Apr 2023 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682081418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efvIjEJR7OoLjdwxlft+BlSYZztvjk4NbwCMvuO6Nyc=;
        b=UiOCyzMQidYbOuwwwJBvGQICTopCZa99mtpzD0i91LQjjNd5jZgi9VONm6v1e/jTOES8FU
        GEvTMZ/adp7J7s/2QZXC9mKFo124ZWNuAjxzOuwOaJf9b04Ke2Uq9SrkN/RrvQn2G8APte
        GuZAidvyP95jb7so156EKIApzPxrbaE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-7ajA2x96Oh-vF6s7rn_akg-1; Fri, 21 Apr 2023 08:50:17 -0400
X-MC-Unique: 7ajA2x96Oh-vF6s7rn_akg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5f1697ce25bso10700126d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 21 Apr 2023 05:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682081416; x=1684673416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efvIjEJR7OoLjdwxlft+BlSYZztvjk4NbwCMvuO6Nyc=;
        b=Ho76AHDfEvTGDJogUUfhQ+fARzlU6gDs/5noou9UkEoZF8BnC4V+Koevm88cdPCz9k
         0bgWcJUvNbmpDGiHp61Upa6YlKGL+9yRF4oVUn3OYGWY3SXMXtwjA1vSFdv+LrIdtnYD
         bQNyDw8LVXcPABySL+Mkb6Q62F/+HWNbPWtJbiUjg7AT3AEp4mU/x2ckrvwc7fyKlasw
         NqyMCZti5m3v0UIzSBoThvFTcokLlmDWwpENzH/NAhwr8rpnlzd7TLzYEKFqcElhzo1N
         3nvxD/tewBDXDOktSN45Oew4223XYDAwy9U2d1MSPBh7XBTl28+ZCUyxyv+7lwcteOuf
         oGXA==
X-Gm-Message-State: AAQBX9d5TLdVBJm0+nFcvmasNvVD+y3rug3R76YyMuo2J+O7Q3MSXzza
        v8SS6ASCe1NQmtto+Ywhkmi+AP+sYNJFSP6rdmJOwn/zjGc/r78mfKQLn6Tl/0jsGSU5XTRueHy
        nFvvt8wXgCcP8Yaqj9U2JxF0eTqrCTjUk/0OEktw=
X-Received: by 2002:a05:6214:20af:b0:606:526:a828 with SMTP id 15-20020a05621420af00b006060526a828mr2230414qvd.21.1682081416170;
        Fri, 21 Apr 2023 05:50:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGU0FBC7yj/+VzlSA+dXJ/D9lCCv5dj+6IgY8JAYV2GumyboAfhoGjHhO3ECAo7x8aO972pQ==
X-Received: by 2002:a05:6214:20af:b0:606:526:a828 with SMTP id 15-20020a05621420af00b006060526a828mr2230385qvd.21.1682081415907;
        Fri, 21 Apr 2023 05:50:15 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c2-20020ae9ed02000000b007339c5114a9sm1295618qkg.103.2023.04.21.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:50:15 -0700 (PDT)
Date:   Fri, 21 Apr 2023 05:50:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V10 0/3] Tegra TPM driver with HW flow control
Message-ID: <ijhnvqkimqkpjfpiat22log3tf3eufi4aj3jscqcpwrxvfjzrz@52tl5bj2dguk>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421091309.2672-1-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 21, 2023 at 02:43:06PM +0530, Krishna Yarlagadda wrote:
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
> V10
>  - use spi_sync in place of spi_sync_locked
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

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

