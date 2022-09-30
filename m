Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0F5F13CC
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 22:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiI3UjO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI3UjN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 16:39:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6A1A88E6;
        Fri, 30 Sep 2022 13:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF3FB82963;
        Fri, 30 Sep 2022 20:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73039C433C1;
        Fri, 30 Sep 2022 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570349;
        bh=EpUP/qbhlc6lK72+8vKV5oTpsI2G3aecCfJLJc2JTxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+7HWejQzP92VOW9zyOwfw/A/3PLGzITW2ncVDLWc/QqwBPNeFy9+2uPWgKXpnq6l
         ElPvtZzqOgCutLKV9WK1ubn9/5K9F25Xa0G93sMj3wityeHNd2RoprEcLJNVJsW+RC
         iytHCZ0lpYdu+csoY1HX+zz2yB+aYQZx5NXZT7RL+gln26BCwW5rbJztdyzcSP//sn
         nbYdTkCJrgOhYLzuNhmap5WeeV7c6ClD2tDnlb1Be7+vH1FWptBGfuKjj1Nka/yjkZ
         focLPMkRtkUu9EbTnoosjOoBrec3/kYsguz+SPU3XSsu6Oq2s8arz9hs6Jdb6/rsbx
         I3yBV44Y30TUQ==
Date:   Fri, 30 Sep 2022 23:39:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tpm: st33zp24: drop support for platform data
Message-ID: <YzdT6kkPXSXZ9hdB@kernel.org>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 25, 2022 at 10:39:56PM -0700, Dmitry Torokhov wrote:
> There are no users of st33zp24_platform_data in mainline, and new boards
> should be using device tree or ACPI to describe resources, so let's drop
> support for platform data from the driver.

Nit: drop instead of let's drop (needs also different sentence structure
obviously).

Also, please leave predictions out, or back them up with data. It's good
enough reason to remove code, if it is not used for anything. I really
don't care about "should" part. It is is out-of-scope for a kernel
patch.

BR, Jarkko
