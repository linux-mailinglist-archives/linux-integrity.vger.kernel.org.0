Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA82C91C3
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 00:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgK3W6W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 17:58:22 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:47148 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728648AbgK3W6S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 16A861280996;
        Mon, 30 Nov 2020 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606777058;
        bh=DpwBXc4nj/fAPjJW+kwpvG65yBZzJWqqTWjfSdPgo18=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HaANaHmgJWnrAqo+tI4sihhb/BUwu4+QnbpmZ+ivrYdM1a+TwtuaxN3uoVMm0SHfW
         qKia6HNncx7m4Em/mKkVBKruTvvE1mPceffnvD7KcGL49OyjWyCy3vLL8mfpTh3bdv
         Rm0gTjQCwYLaeyu+4JAcT6v2Ca77TK5a0qNoct2w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cuk1A96NYp1M; Mon, 30 Nov 2020 14:57:38 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9DCE2128099D;
        Mon, 30 Nov 2020 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606777057;
        bh=DpwBXc4nj/fAPjJW+kwpvG65yBZzJWqqTWjfSdPgo18=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ByFo7x0v0WlkfDyFvAKl6IjTGjXukYroS7aVcXSRW/NBYVFko34mJTKAunhE48cPN
         O4XI1MKcslk36l8jCVfZ+Uj0grKj1ZzFyDev1POQmV55e5z854IDelaFePI7halAAM
         qPfM4RcRAGP+t25sNNxfS9e59B0wnObzvVhLs0qs=
Message-ID: <295ac6a70554b8a4c930866e002a37c68a7dbdd3.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Date:   Mon, 30 Nov 2020 14:57:36 -0800
In-Reply-To: <TU4PR8401MB10556D3CE22216CC6B15B57EABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
         <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
         <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
         <d1775d709b3b88b494e95fff6dbdbda72e1e3b61.camel@HansenPartnership.com>
         <TU4PR8401MB10556D3CE22216CC6B15B57EABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-30 at 22:50 +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Sent: Monday, November 30, 2020 1:54 PM
> > To: Elliott, Robert (Servers) <elliott@hpe.com>; linux-
> > integrity@vger.kernel.org
> > Cc: Mimi Zohar <zohar@linux.ibm.com>; Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com>; linux-api@vger.kernel.org
> > Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all
> > banks of PCR registers
> > 
> > On Mon, 2020-11-30 at 19:00 +0000, Elliott, Robert (Servers) wrote:
> > > ...
> > > > + * The first argument is the TPM algorithm id and the second
> > > > is
> > > > the
> > > > + * hash used as both the suffix and the group name.  Note: the
> > > > group
> > > > + * name is a directory in the top level tpm class with the
> > > > name
> > > > + * pcr-<hash>, so it must not clash with any other names
> > > > already
> > > > + * in the sysfs directory.
> > > > + */
> > > > +PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
> > > > +PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
> > > > +PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
> > > > +PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
> > > > +PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);
> > > 
> > > The latest PC Client Platform TPM Profile and TPM 2.0 Part 2
> > > Structures specs also define codes for three SHA-3 hash
> > > algorithms:
> > >   TPM_ALG_SHA3_256
> > >   TPM_ALG_SHA3_384
> > >   TPM_ALG_SHA3_512
> > 
> > this is PTP 1.05 which was published this September?  The basic
> > reason
> > is it wasn't there when this patch was first published, but they
> > can
> > always be added ... the whole idea is to be extensible.
> 
> Yes, they are in
> * TCG PC Client Platform TPM Profile Specification for TPM 2.0
>   Version 1.05, Revision 14, 4 September 2020
> * Trusted Platform Module Library Part 2: Structures
>   Family 2.0, Level 00 Revision 1.59, 8 November 2019
> 
> I don't know if anyone has started implementing SHA-3 for PCRs.

We at least need the algorithms to get added to our tpm.h, which really
has to be a separate patch, so I'd rather not conflate it with this
one.  I'll make sure that they're added to this patch (provided it's
upstream) at the same time they get added to our tpm.h.

> > > ...
> > > > +
> > > > +	/* add one group for each bank hash */
> > > > +	for (i = 0; i < chip->nr_allocated_banks; i++) {
> > > > +		switch (chip->allocated_banks[i].alg_id) {
> > > > +		case TPM_ALG_SHA1:
> > > > +			chip->groups[chip->groups_cnt++] =
> > > > &pcr_group_sha1;
> > > > +			break;
> > > > +		case TPM_ALG_SHA256:
> > > > +			chip->groups[chip->groups_cnt++] =
> > > > &pcr_group_sha256;
> > > > +			break;
> > > > +		case TPM_ALG_SHA384:
> > > > +			chip->groups[chip->groups_cnt++] =
> > > > &pcr_group_sha384;
> > > > +			break;
> > > > +		case TPM_ALG_SHA512:
> > > > +			chip->groups[chip->groups_cnt++] =
> > > > &pcr_group_sha512;
> > > > +			break;
> > > > +		case TPM_ALG_SM3_256:
> > > > +			chip->groups[chip->groups_cnt++] =
> > > > &pcr_group_sm3;
> > > > +			break;
> > > > +		default:
> > > > +			/*
> > > > +			 * If this warning triggers, send a
> > > > patch to
> > > > +			 * add both a PCR_ATTR_BUILD() macro
> > > > above for
> > > > +			 * the missing algorithm as well as an
> > > > +			 * additional case in this switch
> > > > statement.
> > > > +			 */
> > > > +			WARN(1, "TPM with unsupported bank
> > > > algorthm
> > > > 0x%04x",
> > > > +			     chip->allocated_banks[i].alg_id);
> > > 
> > > algorithm is missing the letter i.
> > 
> > Yes, I'll fix that.
> > 
> > > It might help to print the bank id (variable i) as well.
> > 
> > I'm not sure how it helps the user.  We deliberately hide the bank
> > numbers because all banks in sysfs are referred to by hash ... how
> > would exposing the bank number here help?
> 
> I just noticed the WARN inside the for loop and worried about
> spewing a lot of similar messages, each with long stack traces.
> 
> nr_allocated_banks shouldn't be very large, though, so there's
> probably nothing to be concerned about.
> 
> Maybe consider dev_warn instead of WARN? That would indicate which
> TPM has the unsupported algorithm, which could be useful, but avoid
> the stack dump, which might not be useful (except that it is more
> likely to be reported back to kernel developers).

The reason for a WARN is that we want it to trip a big bad error for
the developer.  It means we came across a TPM whose algorithm is
unsupported, so it really needs adding ASAP.  People take reporting
back WARN stack traces much more seriously than a stray dev_warn()
which often gets ignored.

James


