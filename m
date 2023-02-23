Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A46A0F76
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 19:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBWSbG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 13:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWSbG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 13:31:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE324E5E8;
        Thu, 23 Feb 2023 10:31:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E690061762;
        Thu, 23 Feb 2023 18:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D9AC433D2;
        Thu, 23 Feb 2023 18:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677177064;
        bh=kf0a0BZaCUgBeMk+3XfM7CjeeDXLjWFdQPm4EbhE260=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dnt7dHbjQqToTbGnl4s7xSeDG/DqAAJE+P1WN09ulWljZ3IdmhPbTquRVwKZrIW6T
         EqeUiMRNvF/VKsuPaozzyZoZstuw0T26d9IN5XwHEHtl2gyV3jKhGJPVVCfp2PVpqE
         PJwtMGujTUIrACNREhFRstgoczfZzR86BYaBCCQF4Ck+o+/VIXx2fxtTpQS+YdutzK
         fH9IXvWY9feo8XwDj2cezkPlXWSg/hfo/DM2EkZC0iiGURKimo8sTbTajdAd5egh3g
         JhTupFBZy5JxTVkf+QP7ROJRwhgjqX64oqI1PO8cI4Pc6jZQwXUECSqErNc6FvB+w0
         ddtIVgJhOA0xw==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <20230223162635.19747-1-kyarlagadda@nvidia.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
Subject: Re: (subset) [Patch V3 0/3] Tegra TPM driver with HW flow control
Message-Id: <167717706126.292016.17503726127804100255.b4-ty@kernel.org>
Date:   Thu, 23 Feb 2023 18:31:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 23 Feb 2023 21:56:32 +0530, Krishna Yarlagadda wrote:
> TPM interface spec defines flow control where TPM device would drive
> MISO at same cycle as last address bit sent by controller on MOSI. This
> state of wait can be detected by software reading the MISO line or
> by controller hardware. Support sending transfers to controller in
> single message and handle flow control in hardware. Half duplex
> controllers have to support flow control in hardware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: tegra210-quad: set half duplex flag
      commit: f7482d8285b638be87a594a30edaaf1341135c1a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

