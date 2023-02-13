Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00683693F3D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBMH6H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 02:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBMH6G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 02:58:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DAB4EE8;
        Sun, 12 Feb 2023 23:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 285CCB80E17;
        Mon, 13 Feb 2023 07:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60769C433EF;
        Mon, 13 Feb 2023 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676275069;
        bh=O3NlGEShjdz2hVyiGv6jX8/UEwZ/gQWDwfZ2qFIHjbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhwO/xICyTpZpDnewCt0RTlSwWYyR1irvklP+qQi2CvOyHG6EfZxFJ7NLfLwZx4yb
         O8G+YjYkRTvIj/2zT+4JxI9zLW8sHb7duUHcxTr6LVPpe8gPUW5wqezTRrTZnU1G7+
         8EO6TQW8ApB9ka1ptHKITXTaqnljM93VA5CZ4PpHN2KBbgyh8pN8h7VNJ35PoFhdBW
         Py4EGIffFhZMLmwNPN/rAWsC8bq1YB9W2Y9ATrSC6Ul2EEKZsUkzCB7K6skAlZN05r
         Bw7+Uu8plMCBqzwoFPzKcuC1FJSocvyu43NpNABrJkwTEA3ZVoB099ZuIG7n+/9WSt
         sIyrDJ0pcCp1A==
Date:   Mon, 13 Feb 2023 09:57:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Julien Gomes <julien@arista.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH] tpm: add vendor flag to command code validation
Message-ID: <Y+ntemw98SY1Pjw6@kernel.org>
References: <20230208195836.30175-1-julien@arista.com>
 <Y+WUqcNTc8t0KIyD@kernel.org>
 <865dfe9e-ee3d-1067-625e-2d93bf96da4b@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865dfe9e-ee3d-1067-625e-2d93bf96da4b@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 10, 2023 at 10:07:02AM -0800, Julien Gomes wrote:
> On 2023-02-09 4:49 p.m., Jarkko Sakkinen wrote:
> > On Wed, Feb 08, 2023 at 11:58:36AM -0800, Julien Gomes wrote:
> > > Some TPM 2.0 devices have support for additional commands which are not
> > > part of the TPM 2.0 specifications.
> > > These commands are identified with bit 29 of the 32 bits command codes.
> > > Contrarily to other fields of the TPMA_CC spec structure used to list
> > > available commands, the Vendor flag also has to be present in the
> > > command code itself (TPM_CC) when called.
> > > 
> > > Add this flag to tpm_find_cc() mask to prevent blocking vendor command
> > > codes that can actually be supported by the underlying TPM device.
> > > 
> > > Signed-off-by: Julien Gomes <julien@arista.com>
> > > ---
> > >   drivers/char/tpm/tpm2-cmd.c | 4 +++-
> > >   include/linux/tpm.h         | 1 +
> > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > > index 65d03867e114..93545be190a5 100644
> > > --- a/drivers/char/tpm/tpm2-cmd.c
> > > +++ b/drivers/char/tpm/tpm2-cmd.c
> > > @@ -777,10 +777,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> > >   int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
> > >   {
> > > +	u32 cc_mask;
> > >   	int i;
> > > +	cc_mask = 1 << TPM2_CC_ATTR_VENDOR | GENMASK(15, 0);
> > >   	for (i = 0; i < chip->nr_commands; i++)
> > > -		if (cc == (chip->cc_attrs_tbl[i] & GENMASK(15, 0)))
> > > +		if (cc == (chip->cc_attrs_tbl[i] & cc_mask))
> > >   			return i;
> > >   	return -1;
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index dfeb25a0362d..4dc97b9f65fb 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -265,6 +265,7 @@ enum tpm2_startup_types {
> > >   enum tpm2_cc_attrs {
> > >   	TPM2_CC_ATTR_CHANDLES	= 25,
> > >   	TPM2_CC_ATTR_RHANDLE	= 28,
> > > +	TPM2_CC_ATTR_VENDOR	= 29,
> > >   };
> > >   #define TPM_VID_INTEL    0x8086
> > > -- 
> > > 2.39.1
> > > 
> > 
> > Just checking: did you run testing/selftests/tpm2?
> > 
> > BR, Jarkko
> 
> I didn't know about these, good call.
> Just ran the three test suites on a vm with a swtpm, as I don't have a
> physical box with TPM 2.0 able to run latest kernels handy, all passed.

Neither broke on my side, thanks.

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
