Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0022D1B327E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 00:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDUWIU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 18:08:20 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46824 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgDUWIT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 18:08:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D99898EE10C;
        Tue, 21 Apr 2020 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587506898;
        bh=KeR9OV9DKucmm3r+dQBw0tarvnG83QLHN+v6m8c5b4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=htrmKcd/1+/VKrsKpIeL2x5tv82deIj0YghrSANKsXW3m0jdGkQEDwTgvTo9uRq+z
         P+81Z3mK5+tNPDUEjhYzww6NNSxEggT3TPNiqKdZkoH5k8DBRlz+vC6R9YcmGug9vp
         tSdblf02kMP9W2F0ybiM6KWpk+m+91vDcXnAJ8ZI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r70Sufnmynz1; Tue, 21 Apr 2020 15:08:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7E4438EE105;
        Tue, 21 Apr 2020 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587506897;
        bh=KeR9OV9DKucmm3r+dQBw0tarvnG83QLHN+v6m8c5b4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bessrf/d2KUd2+mQ/e4DGDrNtOx7YDRbK4UwQCKmH1mjKVz1R1uGShquyM2RBG26u
         gfJOwwec4rGBjYgG4L5wLhoguGbcg8I6Xnk4/ps2WuZau09KV96T33lWxYlCPt/gAD
         JY4pQXIJH3dlagjbmzEwSAQENzp+FY9oBlooHxes=
Message-ID: <1587506895.3873.11.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     zohar@linux.ibm.com, Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Tue, 21 Apr 2020 15:08:15 -0700
In-Reply-To: <20200421202355.GC46589@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
         <1586994699.3931.18.camel@HansenPartnership.com>
         <20200416001605.GA673482@vader> <20200416002442.GB673482@vader>
         <1587060171.15329.7.camel@HansenPartnership.com>
         <20200417235527.GB85230@linux.intel.com>
         <1587168748.5867.2.camel@HansenPartnership.com>
         <20200420204641.GA14637@linux.intel.com>
         <1587421686.3493.2.camel@HansenPartnership.com>
         <20200421202355.GC46589@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-21 at 23:23 +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 20, 2020 at 03:28:06PM -0700, James Bottomley wrote:
> > On Mon, 2020-04-20 at 23:46 +0300, Jarkko Sakkinen wrote:
[...]
> > > Does it matter?
> > 
> > Not if you're the one telling Mimi ... and I'm at least 1 mile from
> > the blast radius.
> > 
> > But more seriously: Nayna Jain did a series of patches improving
> > the time it takes to poll the TPM for operations precisely because
> > the TPM PCR extend was going so slowly:
> > 
> > https://lore.kernel.org/linux-integrity/20180516055125.5685-1-nayna
> > @linux.vnet.ibm.com/
> > 
> > I also reported the issue shortly after that patch was integrated,
> > but everyone seemed to think it was just a problem with my TPM chip
> > (it's an early Nuvoton field upgraded to 2.0):
> > 
> > https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@Han
> > senPartnership.com/
> 
> What if we make it dynamic? I.e. if the init code gets -ETIME, then
> increase the timeouts?

The problem is detecting that you need the updated timeouts.  My tpm
doesn't fail in init.  In fact it manages quite a healthy amount of key
operations before going offline.  I'm a heavy TPM key user: I use RSA
keys for two VPNs, all my ssh keys and so on I got tired of the time
RSA takes, so my gpg keys are elliptic curve, but they're the only
ones.  By the time my TPM fails, I've usually at least booted my
desktop, which means several tens of RSA operations have already
happened in the TPM.

James

