Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5185A1FA7
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Aug 2022 06:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiHZELE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Aug 2022 00:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHZELE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Aug 2022 00:11:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9E77C1E2;
        Thu, 25 Aug 2022 21:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63FC1B80ABF;
        Fri, 26 Aug 2022 04:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C571EC433D6;
        Fri, 26 Aug 2022 04:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661487060;
        bh=9FtfZRg8d5/PrQ/D6oaioOqEEZ7sw5lB8CDSQZYEtRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmtvuIAgTtWn8izH0XCMTykm91F7YBO6bLH7g2KaPvo4IE6IFomOX3gtkG9L1clNZ
         /KZn6fo+DSJV+1/jLmD4OSFLtVuudCx0jMq6mTNIv8is/XTUwrcn/VcGG6TsU6Wbkh
         +MCsrNFXAozRxZxfHHzF1+/aTxSsdQVCI6rhvlMRyPmW12lVVg02KaS9VTAUEGPkpe
         ODf+xLEy/myfrNYXbbfR+irKgRN3dQNgUsPBPp/uFDV/FrqvMLMBKskdDcLwjUzPj4
         k/CyawtXbzRNEH/VOW0Hr0M8zA4XuQQe73Pq59u+32FCCElwhSEUCTrbsD9yPZfnFF
         c8bRBqpP/c/sQ==
Date:   Fri, 26 Aug 2022 07:10:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Steffen@infineon.com, jgg@ziepe.ca, peterhuewe@gmx.de,
        joel@jms.id.au
Subject: Re: [PATCH] tpm: tis_i2c: Fix sanity check interrupt enable mask
Message-ID: <YwhHzDL5agT3enUn@kernel.org>
References: <20220817200333.305264-1-eajames@linux.ibm.com>
 <YwhGLZX2+dggWHcI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwhGLZX2+dggWHcI@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 26, 2022 at 07:04:00AM +0300, Jarkko Sakkinen wrote:
> On Wed, Aug 17, 2022 at 03:03:33PM -0500, Eddie James wrote:
> > The sanity check mask for TPM_INT_ENABLE register was off by 8 bits,
> > resulting in failure to probe if the TPM_INT_ENABLE register was a
> > valid value.
> > 
> > Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm_tis_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> > index 0692510dfcab..635a69dfcbbd 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > @@ -49,7 +49,7 @@
> >  
> >  /* Masks with bits that must be read zero */
> >  #define TPM_ACCESS_READ_ZERO 0x48
> > -#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
> > +#define TPM_INT_ENABLE_ZERO 0x7FFFFF60
> >  #define TPM_STS_READ_ZERO 0x23
> >  #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
> >  #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
> > -- 
> > 2.31.1
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Thank you.

I used "6.3 Handling of Multi-Byte Registers" I2C specification
to check this. I do not posses I2C chip.

https://trustedcomputinggroup.org/wp-content/uploads/TCG-TPM-I2C-Interface-Specification-v1.00.pdf

BR, Jarkko
