Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC2228327
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGUPG6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 11:06:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34868 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbgGUPG6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 11:06:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 964D18EE269;
        Tue, 21 Jul 2020 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595344017;
        bh=9i8rDc+sv5FkL2ev9ga4Igb7ZIAT0ypLIZLSmzvUelI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aHzU9ZHVATjwpQXWIGGwZSZAATb2wynlen9kEp1Ttct9oUu+lwQlWCtiGIlacsO7S
         b9kzzB7xYrPXCQP/AywKP/2E6PjmunrbDA7SuFoyGuNj1BZ2f+PK/brqB04Rl7tOhr
         h6qWFtDZJu1OBKwOuKPo+jRQ22HDtVs/LARSqkBM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fj1ej5wo7MTP; Tue, 21 Jul 2020 08:06:57 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 37D128EE207;
        Tue, 21 Jul 2020 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595344017;
        bh=9i8rDc+sv5FkL2ev9ga4Igb7ZIAT0ypLIZLSmzvUelI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aHzU9ZHVATjwpQXWIGGwZSZAATb2wynlen9kEp1Ttct9oUu+lwQlWCtiGIlacsO7S
         b9kzzB7xYrPXCQP/AywKP/2E6PjmunrbDA7SuFoyGuNj1BZ2f+PK/brqB04Rl7tOhr
         h6qWFtDZJu1OBKwOuKPo+jRQ22HDtVs/LARSqkBM=
Message-ID: <1595344015.4494.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 21 Jul 2020 08:06:55 -0700
In-Reply-To: <1595334627.5109.23.camel@linux.ibm.com>
References: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
         <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
         <1595334627.5109.23.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-21 at 08:30 -0400, Mimi Zohar wrote:
> Hi James,
> 
> On Mon, 2020-07-20 at 08:00 -0700, James Bottomley wrote:
> > use macro magic to create sysfs per hash groups with 24 PCR files
> > in them one for each possible agile hash of the TPM.  The files are
> > plugged in to a read function which is TPM version agnostic, so
> > this works also for TPM 1.2 although the hash is only sha1 in that
> > case. For every hash the TPM supports, a group named pcr-<hash> is
> > created and each of the PCR read files placed under it.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> Nice!  Being able to read the TPM 2.0 PCRs, without requiring a TSS,
> will really simplify regression testing - re-calculating the IMA
> "boot_aggregate" and verifying the IMA measurement list.
> 
> With the following code snippet all of the PCRs for all the exported
> TPM banks are displayed, but unfortunately the digests are not
> ordered or prefixed with the PCR.
> 
> banks=$(echo -n $(ls -d /sys/class/tpm/tpm0/pcr-*))
> 
> for bank in ${banks[@]}; do
>         echo "$bank:"
>         find "${bank}/" -type f -exec cat {} \;
>         echo " "
> done
> 
> Either this code snippet needs to be fixed or, perhaps, instead of
> returning just the digest, the digest could be prefixed with the PCR
> number (eg. PCR-00:<digest>).

I think the sysfs output should be a pure hash to save having to
massage it.  However, if you want the 1.2 format, this is the script I
use:

a=0; while [ $a -lt 24 ]; do printf "PCR-%02d: " $a; cat
/sys/class/tpm/tpm0/pcr-sha1/$a; a=$[$a+1]; done

> FYI, with this patch on a system with TPM 1.2, IMA goes into TPM-
> bypass mode.

Hm, got to say I ran this in a virtual environment with the emulator
and I don't have a TPM 1.2.  I'm sure I have a physical system with TPM
1.2 somewhere I can dig out.

> From dmesg (with some extra debugging):
> tpm_chip_register: tpm_add_legacy_sysfs failed
> tpm_tis: probe of 00:05 failed with error -2

Oh, it's assuming chip->groups[0] is the unnamed group.  I can put that
back.  I only added the pcr groups first so they could be counted to
make sure a warning triggered if we had too many.

James

