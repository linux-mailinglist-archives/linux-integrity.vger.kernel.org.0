Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9CA63928A
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Nov 2022 01:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiKZAOH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Nov 2022 19:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiKZAOG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Nov 2022 19:14:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23434B749;
        Fri, 25 Nov 2022 16:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D12261013;
        Sat, 26 Nov 2022 00:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B6C433C1;
        Sat, 26 Nov 2022 00:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669421644;
        bh=6/HKHAcpcZnzmoIIifE6UUgv+eAUk8ch8uOJFlBZ1y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuSeiphuhTZ3KqQHiwz+3yy5ExZsgirWZQlIQO06Xmh/cZEgY7JlEVtj/pbi5+QZn
         DJ4VCD5YD2QJ4mkz4pI7tY6HUBirKvGRnlqMWsb4LSUHg9ZlCIi37NI+NTu++Uz2of
         P0n6DvR9eKv6nVtc4YR8d0FVKqwsBbvR/6np4rzqPA+Z+mpV/hRnf10QrZrpm2rdkW
         7g1C8MIZsmbbD0hNlo3CA5vpeqFPkoPxOxVa3MbrtFfbzM6F8OrpKtpoxg9CVcvoUV
         aMdqJr16e3xr7Q3EMFAsDKToGV3eskDboFj4lgID5Mrj+hisixWKLbcevGZEEZYThS
         KgoRFWw5eTLwA==
Date:   Sat, 26 Nov 2022 02:14:00 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Steffen@infineon.com, jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH] tpm: tis_i2c: Fix sanity check interrupt enable mask
Message-ID: <Y4FaSDxnImetrc75@kernel.org>
References: <20220817200333.305264-1-eajames@linux.ibm.com>
 <CACPK8XfyOCmr_mRmaGTG6oJUNwU23ZoWam0e-RrQxY38=OnVrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfyOCmr_mRmaGTG6oJUNwU23ZoWam0e-RrQxY38=OnVrQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 14, 2022 at 03:16:00AM +0000, Joel Stanley wrote:
> On Wed, 17 Aug 2022 at 20:03, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > The sanity check mask for TPM_INT_ENABLE register was off by 8 bits,
> > resulting in failure to probe if the TPM_INT_ENABLE register was a
> > valid value.
> >
> > Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> Tested-by: Joel Stanley <joel@jms.id.au>
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> 
> Jarkko, do you plan on sending this as a fix?

Thanks for reminding! I picked it.

BR, Jarkko
