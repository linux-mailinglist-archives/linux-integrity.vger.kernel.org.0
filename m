Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928A33FD5A
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Mar 2021 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCRCon (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 22:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCRCoQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 22:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1101364DE2;
        Thu, 18 Mar 2021 02:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616035455;
        bh=I941/3+SIUByqU++oi0JMy7YHTVWrKqHCyGLLHmdn+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVcVsIxFmgNT7LnDWw6V7BSXSSRwUpqy6zwcOx2csA+Png68lSSgZHsW+VsBlEF6Z
         j3R4vRJLTsVgaXN/1GY/bm+H06B7jszCudjrynJITOCubY0T5UgHfi2jgH3DWLnIKa
         croZaDs5mLB8xXFIzYFEvSa6stB89wYwV6lrqhATbGjHeKByYSUrcNY5KC4yfKZpnJ
         hoxQfeGtukp1hWcCxR5hciqxXlpSr89MP80FJSVqCI4dG1IQdSh27g4iWSTF3RanNx
         j/I22SnNg1W2smRiMEHk8uSA6Ce4ZyxuptHsmEbBnG+potHnzZYZg5Myir/cg8HgDM
         YluXc+vyIKtcw==
Date:   Thu, 18 Mar 2021 04:43:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
Message-ID: <YFK+ZLJCWcvqJ88+@kernel.org>
References: <1615971586-21039-1-git-send-email-tiantao6@hisilicon.com>
 <YFJtcUzj6SGRRgq9@kernel.org>
 <32fee14a-1b53-2833-b0b8-0532fc62620e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32fee14a-1b53-2833-b0b8-0532fc62620e@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 18, 2021 at 08:50:28AM +0800, tiantao (H) wrote:
> 
> 在 2021/3/18 4:58, Jarkko Sakkinen 写道:
> > On Wed, Mar 17, 2021 at 04:59:46PM +0800, Tian Tao wrote:
> > > disable_irq() after request_irq() still has a time gap in which
> > > interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > > disable IRQ auto-enable because of requesting.
> > > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > Is this a new feature?
> yes ，you can see cbe16f35bee6880becca6f20d2ebf6b457148552 genirq: Add
> IRQF_NO_AUTOEN for request_irq/nmi()


Can you refine the patch by adding a "Link: <lore>" to the patch?

> > What would be great is a "Link:" tag to the patch set if it is fairly
> > recent (i.e. lore.kernel.org link).
> > 
> > /Jarkko
> > 
> > > ---
> > >   drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > index ec9a65e..25299e5 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > @@ -705,14 +705,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
> > >   	if (client->irq > 0) {
> > >   		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
> > > -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> > > +				      IRQF_NO_AUTOEN,
> > >   				      dev->driver->name, chip);
> > >   		if (rc < 0) {
> > >   			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
> > >   			return rc;
> > >   		}
> > > -		disable_irq(client->irq);
> > >   		priv->irq = client->irq;
> > >   	} else {
> > >   		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > .
> > 
> 
> 
