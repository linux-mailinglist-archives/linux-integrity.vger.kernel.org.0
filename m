Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB867D32D
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAZRbL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjAZRbK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD535B8;
        Thu, 26 Jan 2023 09:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BBEB81EC6;
        Thu, 26 Jan 2023 17:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F6C433EF;
        Thu, 26 Jan 2023 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674754267;
        bh=9Vz8fsXf+lHADl26EgvxVXAxd89VK+kOoYuLdZ04b8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+ZaJ1JwbBRLypCEQqsJZmWtlCPbI5wt169vH7JxK9Apz5CcunVhrHEvK2lsSkiOK
         Ih3ji3HAp7SeZAT6S24knFOp4Ci2fTFwTDnb2//ifYpYquodw/i1cU3/5VOC5YrqUU
         OZsz5Sems8kakccPgt5R8N90+ZxJJ5p+loABXvXXqMdSzvJWywyxeivwxx3PNBsQCW
         B5OQHXC9NTX9vxPxOoX7F7P12pEdjiTFFQxN5e/ia7nSMloqKuufQrvBh0B0Pu14AJ
         rTV9h/YPJ5U8ypKzyjJX6v3f0kQE6rvow5ppua1nXfq2SFvW83cp95j2UrDz5uN+K7
         NPDEUglJ2HwkA==
Date:   Thu, 26 Jan 2023 17:31:04 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH v2 1/2] tpm: Use managed allocation for bios event log
Message-ID: <Y9K42OYk3WX7VH4E@kernel.org>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-2-eajames@linux.ibm.com>
 <Y8stxF+2XfSFN9wt@kernel.org>
 <ea8e873f-c052-832f-b4a5-0164f5cd6947@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8e873f-c052-832f-b4a5-0164f5cd6947@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 25, 2023 at 01:06:31PM -0600, Eddie James wrote:
> 
> On 1/20/23 18:11, Jarkko Sakkinen wrote:
> > On Fri, Jan 13, 2023 at 10:10:16AM -0600, Eddie James wrote:
> > > Since the bios event log is freed in the device release function,
> > > let devres handle the deallocation. This will allow other memory
> > > allocation/mapping functions to be used for the bios event log.
> > > 
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > ---
> > >   drivers/char/tpm/eventlog/acpi.c |  5 +++--
> > >   drivers/char/tpm/eventlog/efi.c  | 13 +++++++------
> > >   drivers/char/tpm/eventlog/of.c   |  3 ++-
> > >   drivers/char/tpm/tpm-chip.c      |  1 -
> > >   4 files changed, 12 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> > > index 0913d3eb8d51..40360e599bc3 100644
> > > --- a/drivers/char/tpm/eventlog/acpi.c
> > > +++ b/drivers/char/tpm/eventlog/acpi.c
> > > @@ -14,6 +14,7 @@
> > >    * Access to the event log extended by the TCG BIOS of PC platform
> > >    */
> > > +#include <linux/device.h>
> > >   #include <linux/seq_file.h>
> > >   #include <linux/fs.h>
> > >   #include <linux/security.h>
> > > @@ -135,7 +136,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> > >   	}
> > >   	/* malloc EventLog space */
> > > -	log->bios_event_log = kmalloc(len, GFP_KERNEL);
> > > +	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> > >   	if (!log->bios_event_log)
> > >   		return -ENOMEM;
> > > @@ -160,7 +161,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> > >   	return format;
> > >   err:
> > > -	kfree(log->bios_event_log);
> > > +	devm_kfree(&chip->dev, log->bios_event_log);
> > I wonder do we want to do devm_kfree's at all as the memory is freed during
> > detach, i.e. taken care by devres.
> 
> 
> I think we should since the chip/tpm driver will continue to probe without
> the bios event log. Therefore that memory will be wasted if there is some
> error during bios log setup.

OK, I buy this!

For this patch:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

If you could refine the description for the 2nd, then these would be ready
to be picked.

> Thanks,
> 
> Eddie

BR, Jarkko
