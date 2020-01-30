Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9E14D712
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA3HbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 02:31:25 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55202 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbgA3HbZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 02:31:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 035A68EE15F;
        Wed, 29 Jan 2020 23:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1580369485;
        bh=OFFq1n/xZIO0HDGayTN8AekIUkZsrlhOyuq6k/TQCFE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rGR2Z3rZ+ul0vF0fbPAbZos5sSLCAy++j/Bc79xF8b5AY1F/fwQ/8mB3UomuQpUPM
         4UcN+SWL3jBSQUvYmcYumEBVsLrLaTGTzA37TeS78LS4aztiHBFCGX41GMvX++LKlz
         e51HcvM23UPuchEd5cHjbA4fgagc8umjWnRBwRM4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a4p759NrPwda; Wed, 29 Jan 2020 23:31:24 -0800 (PST)
Received: from [10.22.222.128] (unknown [77.241.229.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9191C8EE0D4;
        Wed, 29 Jan 2020 23:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1580369484;
        bh=OFFq1n/xZIO0HDGayTN8AekIUkZsrlhOyuq6k/TQCFE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wkxvYvpbTT7evfC4t2MMCdjGb4CffzHV7zvPSoNSL8VUj+p5k04yIMOj6z6ffvRRW
         s4RLH4hnErBP6HuOT5j2WUlCoVXyHaMlz8ArBqOpzp44/SUwlPyEprVnWAcRU6oan/
         o/rRrdATvSbSIR51pEkEWqWFOza7LFvX4Cs3yqIg=
Message-ID: <1580369477.3688.8.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 30 Jan 2020 08:31:17 +0100
In-Reply-To: <1580340007.4790.31.camel@linux.ibm.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
         <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
         <1580226042.5088.90.camel@linux.ibm.com>
         <1580340007.4790.31.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-29 at 18:20 -0500, Mimi Zohar wrote:
> On Tue, 2020-01-28 at 10:40 -0500, Mimi Zohar wrote:
> > > This code assumes that the algorithm used to calculate
> > > boot_aggregate and the algorithm of the PCR bank can be
> > > different. I don't know if it is possible to communicate to the
> > > verifier which bank has been selected (it depends on the local
> > > configuration).
> > 
> > Agreed, but defaulting to the first bank would only happen if the
> > IMA default hash algorithm is not a configured TPM algorithm.
> > 
> > > 
> > > In my opinion the safest approach would be to use the same
> > > algorithm for the digest and the PCR bank. If you agree to this,
> > > then the code above must be moved to ima_calc_boot_aggregate() so
> > > that the algorithm of the selected PCR bank can be passed to
> > > ima_alloc_tfm().
> > 
> > Using the same hash algorithm, preferably the IMA hash default
> > algorithm, for reading the TPM PCR bank and calculating the
> > boot_aggregate makes sense.
> > 
> > > 
> > > The selected PCR bank might be not the first, if the algorithm is
> > > unknown to the crypto subsystem.
> > 
> > It sounds like you're suggesting finding a common configured hash
> > algorithm between the TPM and the kernel. 
> 
> I'd like to clarify the logic for the case when a common algorithm
> does not exist.

I'm not sure we need to twist ourselves in knots over this.  The TCG
client platform for 2.0 mandates sha256, so we should be able to count
on it being present.  I'd be happy to treat the failure to find sha256
on TPM 2.0 as a fatal error, and the same for the failure to find sha1
on TPM 1.2.

>   None of the TPM allocated banks are known by the kernel.  If the
> hash algorithm of the boot_aggregate represents not only that of the
> digest included in the measurement list, but also of the TPM PCR bank
> read, what should happen?  Should the boot aggregate be 0's, like in
> the case when there isn't a TPM?

For TPM 1.2 sha1 is required and for TPM2 sha256 is.  I'd just force
search for those, based on the TPM version, and fail to use the TPM if
they're not found.  There should be a boot time and config option for
weird hashes which might be the only ones on BRIC embedded devices,
like Streebog or ZM2, but the clear default should be the TCG mandates
and it should be up to anything weird to cope with their own induced
problems and not make it part of the standard setup.

James

