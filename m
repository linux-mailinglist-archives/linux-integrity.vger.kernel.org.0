Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F148F374D86
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 04:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhEFCaA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 22:30:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56564 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEFC37 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 22:29:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EDF8D72C8B5;
        Thu,  6 May 2021 05:29:00 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D562C4A46E8;
        Thu,  6 May 2021 05:29:00 +0300 (MSK)
Date:   Thu, 6 May 2021 05:29:00 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
Message-ID: <20210506022900.cxvvlszet45r2scq@altlinux.org>
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-3-vt@altlinux.org>
 <ed882d26-47a8-9b45-6c96-83d2f64982f2@linux.ibm.com>
 <20210506005453.6czsllqawzye4pzb@altlinux.org>
 <20210506010753.eqbrr42ltk2eh6hs@altlinux.org>
 <db89901d-cb0a-60ff-f6e6-d5719186dfba@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <db89901d-cb0a-60ff-f6e6-d5719186dfba@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Wed, May 05, 2021 at 10:24:48PM -0400, Stefan Berger wrote:
> On 5/5/21 9:07 PM, Vitaly Chikunov wrote:
> > On Thu, May 06, 2021 at 03:54:53AM +0300, Vitaly Chikunov wrote:
> > > On Wed, May 05, 2021 at 07:13:39PM -0400, Stefan Berger wrote:
> > > > On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
> > > > > Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
> > > > > SKID of the certificate file. PEM or DER format is auto-detected.
> > > > > 
> > > > > `--keyid' option is reused instead of adding a new option (like possible
> > > > > `--cert') to signify to the user it's only keyid extraction and nothing
> > > > > more.
> > > > > 
> > > > > This commit creates ABI change for libimaevm, due to adding new function
> > > > > ima_read_keyid(). Newer clients cannot work with older libimaevm.
> > > > > Together with previous commit it creates backward-incompatible ABI
> > > > > change, thus soname should be incremented on release.
> > > > > 
> > > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > > > ---
> > > > >    README                 |  1 +
> > > > >    src/evmctl.c           | 22 ++++++++++---
> > > > >    src/imaevm.h           |  1 +
> > > > >    src/libimaevm.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    tests/sign_verify.test |  1 +
> > > > >    5 files changed, 105 insertions(+), 5 deletions(-)
> > > > > 
> > > > > +/**
> > > > > + * ima_read_keyid() - Read 32-bit keyid from the cert file.
> > > > > + * @certfile:	File possibly containing certificate in DER/PEM format.
> > > > > + * @keyid:	Output keyid in network order.
> > > > > + *
> > > > > + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
> > > > > + * Autodetect if cert is in PEM or DER encoding.
> > > > > + *
> > > > > + * Return: -1 (ULONG_MAX) on error;
> > > > > + *         32-bit keyid as unsigned integer in host order.
> > > > That's confusing, two times the same result, one time in host order, on time
> > > > in network order. Why not just one return value in host order?
> > > Pointer API is similar to calc_keyid_v2().
> > > 
> > > Do you sugegst to change calc_keyid_v2() API too?
> > > 
> > > To introduce non-confusing API that contradict other parts of API would
> > > be more confusing than it already is.
> > Maybe we could change this libimaevm API:
> > 
> >    void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
> > 
> > to
> > 
> >    void calc_keyid_v2(uint8_t *keyid, char *str, EVP_PKEY *pkey);
> 
> 
> I think it's better to leave it... :-(

OK.

> 
> > 
> > To signal to the user that there it's not just uint32_t, but some byte
> > array (possible in network order). This would not even break ABI, only
> > API. (But, we breaking ABI with this patch set anyway.)
> 
> You mean we are breaking it by introducing this extensions here?

As described in commit messages - adding new API function breaks
compatibility of new clients with old lib, and adding keyid into
libimaevm_params breaks compatibility of new lib with old clients.
Thus, major ABI change.

> 
> @ -196,6 +196,7 @@ struct libimaevm_params {
>  	const char *hash_algo;
>  	const char *keyfile;
>  	const char *keypass;
> +	uint32_t keyid;		/* keyid overriding value, unless 0. */
>  };
> 
> > 
> > Thanks,
> > 
