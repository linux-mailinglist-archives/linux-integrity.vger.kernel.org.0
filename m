Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7179F251C5A
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHYPdp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 11:33:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53696 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHYPdo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 11:33:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 526438EE183;
        Tue, 25 Aug 2020 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1598369623;
        bh=blQewRuHVmDb5lLHvG9qC+OHsEvEMsp4ojlP8RkU+pM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QyfCuX172MVXXSYfioMaq059936J30BjdoVMK7BVN3Vqaip2a5jVU49cT38PfMTFY
         pOHsz8+wjGyMySA53PURjwZpUorf0rkw11+2c9Niuw0TBWqM7VRsSbAAINRxfyZw1h
         v5hi+40+hOwcLdvzI65Bkr9y6uqKAPDfxpoUxsEM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 32_gaP3JyP3I; Tue, 25 Aug 2020 08:33:43 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DD00F8EE17F;
        Tue, 25 Aug 2020 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1598369623;
        bh=blQewRuHVmDb5lLHvG9qC+OHsEvEMsp4ojlP8RkU+pM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QyfCuX172MVXXSYfioMaq059936J30BjdoVMK7BVN3Vqaip2a5jVU49cT38PfMTFY
         pOHsz8+wjGyMySA53PURjwZpUorf0rkw11+2c9Niuw0TBWqM7VRsSbAAINRxfyZw1h
         v5hi+40+hOwcLdvzI65Bkr9y6uqKAPDfxpoUxsEM=
Message-ID: <1598369621.7939.22.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 25 Aug 2020 08:33:41 -0700
In-Reply-To: <20200825152739.GA8518@linux.intel.com>
References: <1597850231.3875.13.camel@HansenPartnership.com>
         <20200819161845.GK1152540@nvidia.com>
         <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
         <20200819171709.GN1152540@nvidia.com>
         <1597867756.3875.39.camel@HansenPartnership.com>
         <20200819232132.GT1152540@nvidia.com>
         <1597940084.3864.35.camel@HansenPartnership.com>
         <20200821193847.GA2811093@nvidia.com>
         <20200824194457.GA7391@linux.intel.com>
         <1598300446.4034.5.camel@HansenPartnership.com>
         <20200825152739.GA8518@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-25 at 18:27 +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 24, 2020 at 01:20:46PM -0700, James Bottomley wrote:
> > On Mon, 2020-08-24 at 22:44 +0300, Jarkko Sakkinen wrote:
> > > On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley
> > > > wrote:
> > > > 
> > > > > > eg we can't do it because we can't access /dev/tpm for
> > > > > > permissions or something.
> > > > > 
> > > > > I already said that: we can't it's root.root 0600
> > > > > currently.  All the TSSs seem to change at least /dev/tpmrm
> > > > > to tpm.tpm 0660 but we can't do that in the kernel because
> > > > > there's no fixed tpm uid/gid.
> > > > 
> > > > Permissions is a pretty good reason to add a sysfs file.
> > > > 
> > > > Jason
> > > 
> > > I'm not sure why suid/sgid utility to read pcrs would be worse.
> > 
> > We don't do root running or suid/sgid binaries any more because
> > they're exceptional security risks.  That's why both TSSs for TPM
> > 2.0 change the device ownership.  For Trousers and TPM 1.2 we used
> > to run the daemon as root until we started getting CVEs about it.
> > 
> > James
> 
> OK, then a binary blob for pcrs would be sufficient.

From a sysfs perspective we only do one value per file and we don't
export binary if a valid and useful ascii representation exists.  On
both of those kernel principles, the current proposal is canonical.

James

