Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730AA2F58C1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhANC4U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:56:20 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:58418 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbhANC4T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:56:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CAF7A12806CB;
        Wed, 13 Jan 2021 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610592938;
        bh=/Utd+gnwerCye7uCKqqxDj780oiA3dxjew+vCI8nNlQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ESSUmWiCS0RVnB1flSzD0lhD6JbpWNzqmGkSaBsgEDNqum/7CRvLmCaSylmaiJeOz
         uCTIrxIO1JNdqNr3g3VndnIqZwPnBri2RA8VFMUqDVOhrS23T+dOjNbE21p7kXCmyN
         4zfSQHEKMT211WjP5C1eHW9Adi9FwbzDgHQSsLq8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1uezo24jHUMq; Wed, 13 Jan 2021 18:55:38 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 570A712806BD;
        Wed, 13 Jan 2021 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610592938;
        bh=/Utd+gnwerCye7uCKqqxDj780oiA3dxjew+vCI8nNlQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ESSUmWiCS0RVnB1flSzD0lhD6JbpWNzqmGkSaBsgEDNqum/7CRvLmCaSylmaiJeOz
         uCTIrxIO1JNdqNr3g3VndnIqZwPnBri2RA8VFMUqDVOhrS23T+dOjNbE21p7kXCmyN
         4zfSQHEKMT211WjP5C1eHW9Adi9FwbzDgHQSsLq8=
Message-ID: <7bb26e6550ec35b3aa4bdb2e1dbfec04c3f4c871.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Greg KH <greg@kroah.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Wed, 13 Jan 2021 18:55:37 -0800
In-Reply-To: <X/9wwEr477zSttED@kernel.org>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
         <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
         <X/6lyuhqQ8TSXOSa@kroah.com>
         <a6bdeef73f9271cca99585d3e855681cf6b6f589.camel@HansenPartnership.com>
         <X/9wwEr477zSttED@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-14 at 00:14 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 13, 2021 at 09:31:44AM -0800, James Bottomley wrote:
> > On Wed, 2021-01-13 at 08:48 +0100, Greg KH wrote:
> > > On Tue, Jan 12, 2021 at 05:59:58PM -0800, James Bottomley wrote:
> > > > Create sysfs per hash groups with 24 PCR files in them one
> > > > group,
> > > > named pcr-<hash>, for each agile hash of the TPM.  The files
> > > > are
> > > > plugged in to a PCR read function which is TPM version
> > > > agnostic, so
> > > > this works also for TPM 1.2 but the hash is only sha1 in that
> > > > case.
> > > > 
> > > > Note: the macros used to create the hashes emit spurious
> > > > checkpatch
> > > > warnings.  Do not try to "fix" them as checkpatch recommends,
> > > > otherwise
> > > > they'll break.
> > > > 
> > > > Signed-off-by: James Bottomley <
> > > > James.Bottomley@HansenPartnership.com>
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > 
> > > > ---
> > > > 
> > > > v2: fix TPM 1.2 legacy links failure
> > > > v3: fix warn on and add note to tpm_algorithms
> > > > v4: reword commit and add tested-by
> > > > v5: algorithm spelling fix WARN->dev_err
> > > > ---
> > > >  drivers/char/tpm/tpm-sysfs.c | 179
> > > > +++++++++++++++++++++++++++++++++++
> > > >  include/linux/tpm.h          |   9 +-
> > > >  2 files changed, 187 insertions(+), 1 deletion(-)
> > > 
> > > You add new sysfs files, but do not add Documentation/ABI/
> > > entries
> > > showing how they are used and what they contain :(
> > > 
> > > Please do that for the next version of this patch.
> > 
> > It's a bit of a chicken and egg problem since I've no idea when
> > this
> > will go upstream and the entries require that information making
> > the
> > ABI more of a post accept type thing.  I can make a guess about the
> > values if Jarkko is going to but this in for the next merge window.
> > 
> > James
> 
> I agree with the ABI side, so you can safely include this to the
> patch set. 
> And yes, this looks like something I can include to the 5.12 PR.
> 
> Did you address Greg's remarks about warns?

You mean Rob Elliott's?  Yes, it was in the change log

> Other than that, please send a version with ABI entries  so that
> we can move forward with this.

It's already sent ... although vger is being a bit slow at the moment.

James


