Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1236624A782
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHSUJT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 16:09:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46048 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgHSUJT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 16:09:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 472348EE1F3;
        Wed, 19 Aug 2020 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597867758;
        bh=1mRi1aW/FI3TIVe600lFM8mtVRkaSLyOgF6/Rp8g1Yo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wdk8akQ+ov21+5VmYYoaY22LFx7Ws2AmiOZwFJtK8LfX9WKURHz2ogKaE6w44jyeN
         o5/kvfu96O+glcraH7fxQgwo5H6fbE0Ftlvc1xKlmoxrpK61DSyMCmUKMK48PXDA7S
         Xgb3UXdzjMmawYVe7gDUcMQDDUOJxAbzXUeO6Ja8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4eKjEAt_BrC2; Wed, 19 Aug 2020 13:09:18 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9C6BD8EE0E9;
        Wed, 19 Aug 2020 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597867757;
        bh=1mRi1aW/FI3TIVe600lFM8mtVRkaSLyOgF6/Rp8g1Yo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p2pwf+HhfSZhBwIf7XcKhsQ5o6ki8Kh6pF6YHZkthUAAjcVN9Nl6ROTxb2B++D5y2
         MMZ+eK5pDk6+2utt5cjhyVwoDmlQf3va4ptb9iX5wxLNJjvmh6xUovUkaxcyRwyrHs
         sbe+KF4OVL5tk148EHe67CqagoDHFzTMaJSEzLnY=
Message-ID: <1597867756.3875.39.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 13:09:16 -0700
In-Reply-To: <20200819171709.GN1152540@nvidia.com>
References: <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
         <1597850231.3875.13.camel@HansenPartnership.com>
         <20200819161845.GK1152540@nvidia.com>
         <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
         <20200819171709.GN1152540@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 14:17 -0300, Jason Gunthorpe wrote:
> On Wed, Aug 19, 2020 at 12:57:42PM -0400, Mimi Zohar wrote:
> > On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> > > Yes - it was dropped because TPM 2 was a *complete ABI break* for
> > > everything. The kernel was reset to a uABI that matches current
> > > uABI standards starting TPM 2.
> > > 
> > > The whole userspace needed to be redone anyhow, and certainly
> > > nobody objected at the time.
> > > 
> > > At least my expecation was that a sensible userspace for TPM (for
> > > administrator user) would be built, like we see in other
> > > subsystems eg 'ip' for netdev.
> > 
> > "Because TPM 2 was a complete ABI break for everything" could be
> > reason for upstreaming a minimal subset of functionality initially,
> > which could be expanded over time.  I don't recall a discussion
> > about limting features in the future.
> 
> All new uAPI additions need to pass the usual uAPI hurdles.
> 
> As James outlined, justify why the kernel must present a duplicated
> uAPI between sysfs and /dev/tpm. 
> 
> There have been good reasons in the past, eg SCSI inquiry.

First, can we please agree /dev/tpm does not substitute as a "duplicate
API".  I can now clarify the objection into "it's a binary marshalled
interface and Linus doesn't think we should force users to use them":

https://lore.kernel.org/linux-api/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/

So the question boils down to whether we're providing a simple
interface that allows preboot and other use cases or should we require
the complexity of a TSS installation to get the necessary tools. 
Perhaps we should also simply copy linux-api and accept the judgment of
the experts on whether we should expose PCRs via sysfs.

> But there are also bad reasons like "our userpsace is dysfunctional
> and can't make a library or tool".

The reason we provide a kernel interface instead of a library or tool
is that libraries and tools tend to be domain specific and the
information needs to be provided across domains.  So: both the current
TPM 2.0 TSSs are written in C.  This means they can just about be
plugged into python but not easily into Go because of its abhorrence of
ffis.  Providing the PCRs from sysfs allows Go attestation easy access
that the TSS tools don't because of the language domain problem.

James


