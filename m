Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507155F1533
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiI3Vtt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI3Vts (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 17:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06FF5A4;
        Fri, 30 Sep 2022 14:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86EF162523;
        Fri, 30 Sep 2022 21:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E5C433D6;
        Fri, 30 Sep 2022 21:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574584;
        bh=B7rHmkcOb/r7UGom5v9umZRm+YQRsqQ8eeuZLeWJQUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTlpmjYmcVJ8TjvV/2JE4xS7G3BH4q14VoRQ+nbV3kSvwXu4uTVGlEyyi3JvATiJE
         RbL+X2ysoekpw3Az/3JwMkNM+6fYOVa3oy0nQIjjUpEg3bTpL/UMAYLocLoUN5OWIf
         ft79pHy8vvCqz/XAHaUFZ+o9XNHowUNnQYO5bWgMvKnomVUNSMU6KxeLDkA1qc50AK
         UkVMljuv5CqJ4pAjK01FkQIh5dmWjNQ8s7Qd+4tMNaTy/ofB260QNxtDQCRyy6nvfo
         Ui41X8vSlBrm5ct2/ahFqfqRERNzIk9t389hwbsnoeaCxGdnt4JnQw3gXYujRENnR/
         F9h/I4pC00nfQ==
Date:   Sat, 1 Oct 2022 00:49:42 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.or, jgg@ziepe.ca,
        Alexander.Steffen@infineon.com
Subject: Re: [PATCH] tpm: Add flag to use default cancellation policy
Message-ID: <Yzdkdj7Ma3/RnCCs@kernel.org>
References: <20220907164317.80617-1-eajames@linux.ibm.com>
 <Yxl8CJBZiROgqhd6@kernel.org>
 <1a20cd56-cc6f-d1c3-2e9d-c6b1fe278959@linux.ibm.com>
 <CACPK8XfRC==6CmFV3LoTW9oF_KLxMXH2KZQD0WFfnYpgnBERXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfRC==6CmFV3LoTW9oF_KLxMXH2KZQD0WFfnYpgnBERXQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 28, 2022 at 05:10:25AM +0000, Joel Stanley wrote:
> On Thu, 8 Sept 2022 at 13:53, Eddie James <eajames@linux.ibm.com> wrote:
> >
> >
> > On 9/8/22 00:22, Jarkko Sakkinen wrote:
> > > On Wed, Sep 07, 2022 at 11:43:17AM -0500, Eddie James wrote:
> > >> The check for cancelled request depends on the VID of the chip, but
> > >> some chips share VID which shouldn't share their cancellation
> > >> behavior. This is the case for the Nuvoton NPCT75X, which should use
> > >> the default cancellation check, not the Winbond one.
> > >> To avoid changing the existing behavior, add a new flag to indicate
> > >> that the chip should use the default cancellation check and set it
> > >> for the I2C TPM2 TIS driver.
> > >>
> > >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > >> ---
> > >>   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++--------
> > >>   drivers/char/tpm/tpm_tis_core.h |  1 +
> > >>   drivers/char/tpm/tpm_tis_i2c.c  |  1 +
> > >>   3 files changed, 12 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > >> index 757623bacfd5..175e75337395 100644
> > >> --- a/drivers/char/tpm/tpm_tis_core.c
> > >> +++ b/drivers/char/tpm/tpm_tis_core.c
> > >> @@ -682,15 +682,17 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
> > >>   {
> > >>      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > >>
> > >> -    switch (priv->manufacturer_id) {
> > >> -    case TPM_VID_WINBOND:
> > >> -            return ((status == TPM_STS_VALID) ||
> > >> -                    (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> > >> -    case TPM_VID_STM:
> > >> -            return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> > >> -    default:
> > >> -            return (status == TPM_STS_COMMAND_READY);
> > >> +    if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
> > >> +            switch (priv->manufacturer_id) {
> > >> +            case TPM_VID_WINBOND:
> > >> +                    return ((status == TPM_STS_VALID) ||
> > >> +                            (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> > >> +            case TPM_VID_STM:
> > >> +                    return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> > >> +            }
> > > Why there is no default: ?
> >
> >
> > Well I didn't want to duplicate the line "status ==
> > TPM_STS_COMMAND_READY" in the default case and for the flagged case. So
> > now the switch just falls through for default. I can add default: break
> > instead
> 
> This code was in the original patch series submitted by Nuvoton:
> 
> https://lore.kernel.org/r/20211104140211.6258-3-amirmizi6@gmail.com
> 
> Perhaps something like that would be better?

The current patch could have 

        default:
                /* fall-through */
                break;

BR, Jarkko
