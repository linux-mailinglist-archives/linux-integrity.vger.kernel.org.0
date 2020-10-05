Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0331283F38
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgJETA7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 15:00:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49968 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbgJETA7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 15:00:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 679128EE1CB;
        Mon,  5 Oct 2020 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601924458;
        bh=8m1l0vBnng+DIhzgcnyPcN0anwtH9OM88LwtUb7oHwI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g3Ay6oZq3leVTkPbuhs1sPSBhVnss44zHt+KjIivQA2piYmYlBWxsgjEPnBY5x8q1
         C0Adi8heozZ4GfFZEDklueEtgNhF2AO3s1AMFkXpEFrezQivjZzAkdZTgVSYFWchSH
         PijOoOvWBjf59N9ZnB8bP5l6sOSfFLRK12jEwYiY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HZdrgX4jiS5u; Mon,  5 Oct 2020 12:00:58 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D14388EE173;
        Mon,  5 Oct 2020 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601924458;
        bh=8m1l0vBnng+DIhzgcnyPcN0anwtH9OM88LwtUb7oHwI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g3Ay6oZq3leVTkPbuhs1sPSBhVnss44zHt+KjIivQA2piYmYlBWxsgjEPnBY5x8q1
         C0Adi8heozZ4GfFZEDklueEtgNhF2AO3s1AMFkXpEFrezQivjZzAkdZTgVSYFWchSH
         PijOoOvWBjf59N9ZnB8bP5l6sOSfFLRK12jEwYiY=
Message-ID: <14edea1f5092c2b8442165756b2ee32e56bed1eb.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality
 acquisition
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Mon, 05 Oct 2020 12:00:57 -0700
In-Reply-To: <20201005153418.GB6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
         <20201005153418.GB6232@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-05 at 18:34 +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 01, 2020 at 11:09:21AM -0700, James Bottomley wrote:
> > The TPM TIS specification says the TPM signals the acquisition of
> > locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
> > TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check
> > the
> 
> Put a reference to the section.
> 
> I'm *guessing* that the spec is
> 
> https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis
> 
> Please have this and also location in this spec.

I can, but the TCG reorganizes its website every few months, so no URLs
like that are permanent.

> > former not the latter, so check both.  Adding the check on
> > TPM_ACCESS_REQUEST_USE should fix the case where the locality is
> > re-requested before the TPM has released it.  In this case the
> > locality may get released briefly before it is reacquired, which
> > causes all sorts of problems. However, with the added check,
> > TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
> > the locality is granted.
> 
> The description is really good and understandable otherwise.
> 
> For me it is not obvious at all, why this is missing a fixes
> tag?

It's been there ever since the initial commit:

commit 27084efee0c3dc0eb15b5ed750aa9f1adb3983c3
Author: Leendert van Doorn <leendert@watson.ibm.com>
Date:   Sat Apr 22 02:38:03 2006 -0700

    [PATCH] tpm: driver for next generation TPM chips

> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > 
> > ---
> > 
> > v2: added this patch
> 
> Use the cover letter for the changelog. I'm afraid that I might
> miss these otherwise.

Submitting patches actually recommends doing this ... I think we want
to keep to standard kernel process, but I can gather them in the cover
letter as well.

James


