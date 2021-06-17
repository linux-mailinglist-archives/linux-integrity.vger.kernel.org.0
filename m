Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012043AAB25
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Jun 2021 07:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhFQFkR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Jun 2021 01:40:17 -0400
Received: from smtp2.axis.com ([195.60.68.18]:39023 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQFkR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jun 2021 01:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1623908290;
  x=1655444290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xk5lY+DviIEB+UeE2RSKHxcpgc9FMKqbw8HU2SouMqc=;
  b=QRiK5c56ooSAML0WkPR1ASFyoIY30BwI0yr+wHN9fSycdMQYhx9k9CdO
   wAOuIE/Qd74yNTnqsX5tdnbAVCATMVutTSL/QjTqjuW56rUvlxW8r7lb7
   qBLJQvOPOiJ4cSHFP2AtrJhqPEqse+NazT61juHurRrASe7Oe1XFiiecH
   DLThqArLkyT3RKTl2su1PTT0HdciFc6E1G1U1/n5N6haQ5Le9xQx0BXJA
   YZFl8ZgaCvJZL76saslEtX99REeBYtArAF1X6FT1bNiF8IqK5DYBy3COQ
   u+u0DRfkvy5VAbokF1k+hrp1RiCiljieGtYH6Sm38iiaEJ/Uxzui9AORX
   w==;
Date:   Thu, 17 Jun 2021 07:38:09 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 1/2] tpm: Fix tpmrm reference counting
Message-ID: <20210617053809.GA4049@axis.com>
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
 <20210616185301.GV1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210616185301.GV1096940@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 16, 2021 at 08:53:01PM +0200, Jason Gunthorpe wrote:
> On Tue, Jun 15, 2021 at 11:14:08AM +0200, Vincent Whitchurch wrote:
> > The code added by commit 8979b02aaf1d6de8 ("tpm: Fix reference count to
> > main device") tries to take an extra reference to the main device only
> > for TPM2 by looking at the flags, but the flags are actually not set
> > at the time when tpm_chip_alloc() is called, so no extra reference is
> > ever taken, leading to a use-after-free if the TPM modules are removed
> > when the tpmrm device is in use.
> 
> Please read this
> 
> https://lore.kernel.org/linux-integrity/20210205172528.GP4718@ziepe.ca/

Thank you for the pointer.  I see that Lino already posted your proposal
as a real patch as you requested so I will drop this.

 https://lore.kernel.org/linux-integrity/1613949567-1181-2-git-send-email-LinoSanfilippo@gmx.de/
