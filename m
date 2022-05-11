Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631D5236D4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiEKPNv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiEKPNt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E6FEAD09;
        Wed, 11 May 2022 08:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 397FFB824C8;
        Wed, 11 May 2022 15:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB0C340EE;
        Wed, 11 May 2022 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652282026;
        bh=oiXSRKcpIah/AZEY44g3Ce/a9M9OgnM/n6q6sy4F74U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfkhT8nFe6Dg5o5l2Z9GuasTRw14JfXpoxQtWwOeFqHgNZ+2HU02T5ifnJwRbaLQD
         CSBSRXAC0+Riv2C0WO4gVMtr8cpS0GceuUZJkYAznQrqe3ZWtCse4KYWKEi8l0vyAc
         M3bfRXuqVdGRcsFBf2Tej4jGOa5LbMzYG+FVmdXk57q1LUVVpUpzyqSrBEB7jfdj9E
         OZYxSMS0VS9Y/gjVqOo8PdIAUBpcF9Ge5FkLu6DEWe1Si3kCQRj6RRXPnhsDPcIO2F
         0wLiRU1UkaJuFmDIvVBd66NgpCkOMfsQQzG/vfQ+sp8vobDBmZ7j+G/MiYjA7o/VCW
         f3s76IuCTOaew==
Date:   Wed, 11 May 2022 18:12:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     Marten.Lindahl@axis.com, jgg@ziepe.ca,
        johannes.holland@infineon.com, jsnitsel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        martenli@axis.com, nayna@linux.vnet.ibm.com, peterhuewe@gmx.de
Subject: Re: [PATCH 2/2] tpm: Add Field Upgrade mode support for Infineon
 TPM2 modules
Message-ID: <YnvSULFUC9gADu0z@kernel.org>
References: <YnbL9LwDkY+MHdkK@iki.fi>
 <20220509125018.246093-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509125018.246093-1-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 02:50:18PM +0200, Stefan Mahnke-Hartmann wrote:
> On 07.05.22 21:43, Jarkko Sakkinen wrote:
> > On Fri, May 06, 2022 at 02:31:48PM +0200, Stefan Mahnke-Hartmann wrote:
> >> TPM2_GetCapability with a capability that has the property type value
> >> of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
> >> TPM2 is in Field Upgrade mode.
> >> Since an Infineon TPM2.0 in Field Upgrade mode returns RC_SUCCESS on
> >> TPM2_Startup, the Field Upgrade mode has to be detected by
> >> TPM2_GetCapability.
> >>
> >> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> >> ---
> >>  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> >> index e62a644ce26b..659130e2936e 100644
> >> --- a/drivers/char/tpm/tpm2-cmd.c
> >> +++ b/drivers/char/tpm/tpm2-cmd.c
> >> @@ -746,6 +746,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >>  	}
> >>  
> >>  	rc = tpm2_get_cc_attrs_tbl(chip);
> >> +	/*
> >> +	 * Infineon TPM in Field Upgrade mode will return no data for the number
> >> +	 * of supported commands.
> >> +	 */
> >> +	if (rc == -ENODATA)
> >> +		rc = TPM2_RC_UPGRADE;
> >
> > Injecting hardware error codes like this is not considered a great idea.
> 
> Resetting the error code was to avoid code duplication, while following the
> same rationale as Mårten's patch. I can also add the -ENODATA to the if clause
> below or duplicate the code block (similar to Mårten's). Do you have a better
> suggestion?

I'd do that instead. It documents better the conditions.

BR, Jarkko
