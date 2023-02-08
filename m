Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97368E560
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBHB1C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 20:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHB1B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 20:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D99A5C4
        for <linux-integrity@vger.kernel.org>; Tue,  7 Feb 2023 17:26:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4EF6146B
        for <linux-integrity@vger.kernel.org>; Wed,  8 Feb 2023 01:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E0C433EF;
        Wed,  8 Feb 2023 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675819610;
        bh=YC9ZClRBSfYKfUF73/ckYN9jJ26JtwJgDZJJkzPeYn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7sO4Adu9y1E6wu8luGSoD5A/bCmhx2W+hLw/dykySsbg6w/75InrN3RHmwAzp1cX
         WgSkGhe7lMcAuly+pZThK/QzpQDw2ffA0z/g7T/UMS72LW4IknIYCe5IaSoe2W+J4O
         VEGwPyKG4QPerDB/vx2rJzcoSNAh3xeYVoL0hkQceO16mXvyvcoh7BCQyhtdg22LcC
         bcQLLY6I731P0NkuQUh6U99P1HfRmLwkIT17Zy1wGABqoYF7gJIlhtvvQg68N1vDFi
         1TOdTaFW/54/KwemUYhwr/fa6GVIoQekDQvPHoBUB/7fMY/o+rTFfnjhofKCOZTJWB
         06BOVw6wHirnA==
Date:   Wed, 8 Feb 2023 03:26:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        eajames@linux.ibm.com
Subject: Re: [PATCH -next] tpm: of: fix return value check in
 tpm_read_log_memory_region()
Message-ID: <Y+L6VE9k7lYwbfU8@kernel.org>
References: <20230129072637.279576-1-yangyingliang@huawei.com>
 <Y+L4b2rLYUe8091O@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+L4b2rLYUe8091O@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 08, 2023 at 03:18:45AM +0200, Jarkko Sakkinen wrote:
> On Sun, Jan 29, 2023 at 03:26:37PM +0800, Yang Yingliang wrote:
> > devm_memremap() never returns NULL pointer, it will return
> > ERR_PTR() when it fails, so replace the check with IS_ERR().
> > 
> > Fixes: b0474a20b153 ("tpm: Add reserved memory event log")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/char/tpm/eventlog/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> > index c815cadf00a4..6a818a026c94 100644
> > --- a/drivers/char/tpm/eventlog/of.c
> > +++ b/drivers/char/tpm/eventlog/of.c
> > @@ -43,7 +43,7 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
> >  
> >  	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
> >  						 MEMREMAP_WB);
> > -	if (!chip->log.bios_event_log) {
> > +	if (IS_ERR(chip->log.bios_event_log)) {
> >  		dev_info(&chip->dev, "err memremap\n");
> >  		return -ENOMEM;
> >  	}
> > -- 
> > 2.25.1
> > 
> 
> Thanks. I will squash this with the patch and add your sob.

Ugh, in the review three dev_info()'s went out of my radar.

They make no sense so I'll drop them.

BR, Jarkko
