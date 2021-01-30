Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF8309724
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhA3RNl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 12:13:41 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:56084 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhA3RNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 12:13:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A4AA71280525;
        Sat, 30 Jan 2021 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612026780;
        bh=zChqpcBI4qTTdWHMi+Ul5RcEBAxMVF5t/fleW4TFVvg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hmgDMLCxgSKRgkuVEcF68p3ElzYAvEqNJAtSdigLtTKwy8iS0sl9G0Kg45hU2AeaI
         a/6EFUyhm+E9wTb+OpUIdagGlJFtn/iFgFvVCEFQiCFINum9mrjwID9/Q6gajd1yZi
         u2J8vUQVLIt19PSALThSvACFE4LEQDgDejF+xoU0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id URQxOuQdTlZu; Sat, 30 Jan 2021 09:13:00 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2F5811280521;
        Sat, 30 Jan 2021 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612026780;
        bh=zChqpcBI4qTTdWHMi+Ul5RcEBAxMVF5t/fleW4TFVvg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hmgDMLCxgSKRgkuVEcF68p3ElzYAvEqNJAtSdigLtTKwy8iS0sl9G0Kg45hU2AeaI
         a/6EFUyhm+E9wTb+OpUIdagGlJFtn/iFgFvVCEFQiCFINum9mrjwID9/Q6gajd1yZi
         u2J8vUQVLIt19PSALThSvACFE4LEQDgDejF+xoU0=
Message-ID: <2ead01f03be0022e42cb94e83cfdf674d2046119.camel@HansenPartnership.com>
Subject: Re: [PATCH v15 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Sat, 30 Jan 2021 09:12:58 -0800
In-Reply-To: <YBWJVcM8/2tIlWHk@kernel.org>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
         <20210127190617.17564-5-James.Bottomley@HansenPartnership.com>
         <YBWJVcM8/2tIlWHk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 18:29 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 27, 2021 at 11:06:16AM -0800, James Bottomley wrote:
> > Modify the TPM2 key format blob output to export and import in the
> > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > prior
> > trusted keys, the importer will also accept two TPM2B quantities
> > representing the public and private parts of the key.  However, the
> > export via keyctl pipe will only output the ASN.1 format.
> > 
> > The benefit of the ASN.1 format is that it's a standard and thus
> > the
> > exported key can be used by userspace tools (openssl_tpm2_engine,
> > openconnect and tpm2-tss-engine).  The format includes policy
> > specifications, thus it gets us out of having to construct policy
> > handles in userspace and the format includes the parent meaning you
> > don't have to keep passing it in each time.
> > 
> > This patch only implements basic handling for the ASN.1 format, so
> > keys with passwords but no policy.
> > 
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> This one had some coding style errors:
> 
> WARNING: Possible repeated word: 'for'
> #147: FILE: security/keys/trusted-keys/tpm2key.asn1:2:
> +--- ASN.1 for for TPM 2.0 keys
> 
> ERROR: space required after that ',' (ctx:VxV)
> #198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
> +static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
>                                ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
> +static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
>                                   ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
> +static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
>                                       ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
> +static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
>                                          ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
> +static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };

THat's actually deliberate.  the OID representation is traditionally a
sequence of numbers separated by a full stop, so it should be

2.23.133.10.1.5

Since we use an array to represent each number, the closest seemed to
be replacing the '.' with ',' hence leaving no spaces.  I don't think
it hugely matters, but just saying there was a reason for the style
deviation.

> I fixed them by hand. I will apply these now to my master branch
> first, but can you just sanity check that your changes still work for
> you?
> 
> Cutting hairs, but better to be safe than sorry when doing even a
> single change to the source code.

OK, I'll rebase on your tree and see what happens.

James


