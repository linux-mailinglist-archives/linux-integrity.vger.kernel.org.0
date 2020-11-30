Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A112C8E7E
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgK3TyR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 14:54:17 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:51248 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388205AbgK3TyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 14:54:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0AEB81280932;
        Mon, 30 Nov 2020 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606766017;
        bh=2GjomwJHfvE5/JDVfBSgwjqOaGFKey4KToh8zDNbi0w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=M7cosVmVm5uFtOEJc/LzlVaxgY4NuoWXyG1Ax4tppatNKsEI1jAmiwdtUI2bXLKx5
         00elnjPIyS7ZXUabA0sMmnIJT8NZTNwrEaccZwOb8ITwddbB+bU6VV6LLHQ+InUI0I
         vU6xkRu8GQZcskaJRw4uAuGglRALnkfXmSwJ1Q84=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7rldPXPTytN8; Mon, 30 Nov 2020 11:53:37 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 984FE12808F8;
        Mon, 30 Nov 2020 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606766016;
        bh=2GjomwJHfvE5/JDVfBSgwjqOaGFKey4KToh8zDNbi0w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=byj7jyCMucTt/DmVeTZa/mCyPedBrhUACSzBjuB9okpxQL8wAwP0++nVegkh5iuJW
         0IQCtHWDoOpzs+ZaqAFqCs1uCKZcPCaTEalfSrFG4X/pLBmVnCwupOgaD71jzPhL9q
         aTZOdzihVcLAw7KxU6qNiA1HPeSLbT083btgegsw=
Message-ID: <d1775d709b3b88b494e95fff6dbdbda72e1e3b61.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Date:   Mon, 30 Nov 2020 11:53:35 -0800
In-Reply-To: <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
         <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
         <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-30 at 19:00 +0000, Elliott, Robert (Servers) wrote:
> ...
> > + * The first argument is the TPM algorithm id and the second is
> > the
> > + * hash used as both the suffix and the group name.  Note: the
> > group
> > + * name is a directory in the top level tpm class with the name
> > + * pcr-<hash>, so it must not clash with any other names already
> > + * in the sysfs directory.
> > + */
> > +PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
> > +PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
> > +PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
> > +PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
> > +PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);
> 
> The latest PC Client Platform TPM Profile and TPM 2.0 Part 2
> Structures specs also define codes for three SHA-3 hash algorithms:
>   TPM_ALG_SHA3_256
>   TPM_ALG_SHA3_384
>   TPM_ALG_SHA3_512

this is PTP 1.05 which was published this September?  The basic reason
is it wasn't there when this patch was first published, but they can
always be added ... the whole idea is to be extensible.

> ...
> > +
> > +	/* add one group for each bank hash */
> > +	for (i = 0; i < chip->nr_allocated_banks; i++) {
> > +		switch (chip->allocated_banks[i].alg_id) {
> > +		case TPM_ALG_SHA1:
> > +			chip->groups[chip->groups_cnt++] =
> > &pcr_group_sha1;
> > +			break;
> > +		case TPM_ALG_SHA256:
> > +			chip->groups[chip->groups_cnt++] =
> > &pcr_group_sha256;
> > +			break;
> > +		case TPM_ALG_SHA384:
> > +			chip->groups[chip->groups_cnt++] =
> > &pcr_group_sha384;
> > +			break;
> > +		case TPM_ALG_SHA512:
> > +			chip->groups[chip->groups_cnt++] =
> > &pcr_group_sha512;
> > +			break;
> > +		case TPM_ALG_SM3_256:
> > +			chip->groups[chip->groups_cnt++] =
> > &pcr_group_sm3;
> > +			break;
> > +		default:
> > +			/*
> > +			 * If this warning triggers, send a patch to
> > +			 * add both a PCR_ATTR_BUILD() macro above for
> > +			 * the missing algorithm as well as an
> > +			 * additional case in this switch statement.
> > +			 */
> > +			WARN(1, "TPM with unsupported bank algorthm
> > 0x%04x",
> > +			     chip->allocated_banks[i].alg_id);
> 
> algorithm is missing the letter i.

Yes, I'll fix that.

> It might help to print the bank id (variable i) as well.

I'm not sure how it helps the user.  We deliberately hide the bank
numbers because all banks in sysfs are referred to by hash ... how
would exposing the bank number here help?

James


