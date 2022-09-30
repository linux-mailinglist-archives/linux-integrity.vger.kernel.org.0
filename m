Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8A5F13E7
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 22:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiI3Uo1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3UoZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 16:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D991F44D7;
        Fri, 30 Sep 2022 13:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DB9624E1;
        Fri, 30 Sep 2022 20:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423ABC433D7;
        Fri, 30 Sep 2022 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570663;
        bh=lc2jy/ARQK6H8XqERFtcJ4MlYmpDmbHzUwDa9LqMQbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQqZR+qJCgmLawIXUz3YOw6zYW1uUaFuND3aFIOpRxsCfiZVyz1XsdfaNBZLMdzt2
         1InS/vBL/EsNCcsEq35vvfCoQcCtzg/5O1DtH11kCA8QTvEDO6+5/8bCUsgSNdf2Hq
         rTg2OQCYasda2yzUM+Hg1EP+Kcx9zhAmBys1iQKRmPmkEJQ9QC4p4BdwkMKH/0imRE
         6XhDISe2jy1m2qbSIfqLBqGKtto6RDAE3NbovB4Ddr4FVGCrQ8DQmfGE7iypZOT5EN
         27+zdcIjsm5IE2/KsD32fFjYUfCTyAFh0JKViTwfD3bkQGNuenLq27uW965axxZeI5
         bIW1ATvH/mcnA==
Date:   Fri, 30 Sep 2022 23:44:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: st33zp24: remove pointless checks on probe
Message-ID: <YzdVJYuzYzBTELI0@kernel.org>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
 <20220926053958.1541912-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926053958.1541912-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 25, 2022 at 10:39:58PM -0700, Dmitry Torokhov wrote:
> Driver core will never call driver's probe method without appropriate
> device structure, so testing them for NULL is pointless.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Missing a description what the patch does.

Also instead of "driver's probe method" you could just use
"st33zp24_i2c_probe()". It's even shorter.

BR, Jarkko
