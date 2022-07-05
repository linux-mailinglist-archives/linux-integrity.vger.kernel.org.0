Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6473C566FC5
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jul 2022 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGENtD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jul 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGENsl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:41 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70E220C4
        for <linux-integrity@vger.kernel.org>; Tue,  5 Jul 2022 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1657027090;
  x=1688563090;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=vilXFeekisoFI4K0Xp1eWNr0+nsQS55sG23OQdnrqNc=;
  b=P3btqxv4JAALo4tb/oCS1IuwGN5ncDI+L4gOLOncIC8QybPwfltKfKyz
   QFdFOIO8ZJSBmOnjAMINKol+eUZgu+4Lxr4Hpfbfbl6eC1xwJsRtHZtty
   qlw7IgVjpuFSoTeavdgndiy9AQCajsQ/0OvBUARKQY/kKkC4GdvdNDWC0
   4erYBmT3yZIJ9CMJAcemJvKoMH+ozzEdQixZqY2ve11WAapkvkQQSOjus
   GcLwlRINr+eHoIjbh/8AA+l4bUKobus/UdDhcFCoLgkIpt3i2ozSgH3X6
   3DkFUh3p9pLeKi2BMLTIjsmCd/og1v2BbkGJgcLinHi79xR9jujnIL9/C
   w==;
Date:   Tue, 5 Jul 2022 15:18:08 +0200
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YsQ6EI6KQ47c9X4i@axis.com>
References: <20220620152129.551199-1-marten.lindahl@axis.com>
 <Yrf6z8ChB0XYOmuQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yrf6z8ChB0XYOmuQ@kernel.org>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 26, 2022 at 08:21:03AM +0200, Jarkko Sakkinen wrote:
> On Mon, Jun 20, 2022 at 05:21:29PM +0200, Mårten Lindahl wrote:
> > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > TPM2 modules") it was said that:
> > 
> > "If the TPM is in Failure mode, it will successfully respond to both
> > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > is in Failure mode."
> > 
> > But a check was never added in the commit when calling
> > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > This commit corrects this by adding a check.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> > 
> > v2:
> >  - Add missed check for TPM error code.
> > 
> >  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index c1eb5d223839..65d03867e114 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -752,6 +752,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >  	}
> >  
> >  	rc = tpm2_get_cc_attrs_tbl(chip);
> > +	if (rc == TPM2_RC_FAILURE || (rc < 0 && rc != -ENOMEM)) {
> > +		dev_info(&chip->dev,
> > +			 "TPM in field failure mode, requires firmware upgrade\n");
> > +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> > +		rc = 0;
> > +	}
> >  
> >  out:
> >  	/*
> > -- 
> > 2.30.2
> >

Hi Jarkko!

Yes, I will add the tags. Thanks!

Kind regards
Mårten
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Shouldn't this have:
> 
> Cc: stable@vger.kernel.org # v5.17
> Fixes: 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for TPM2 modules")
> 
> BR, Jarkko
