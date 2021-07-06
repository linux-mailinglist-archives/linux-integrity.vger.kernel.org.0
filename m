Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDC3BDEC9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFVQE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 17:16:04 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33278 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFVQD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 17:16:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1BC9872C8B4;
        Wed,  7 Jul 2021 00:13:23 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 09BFC4A46ED;
        Wed,  7 Jul 2021 00:13:23 +0300 (MSK)
Date:   Wed, 7 Jul 2021 00:13:22 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 0/3] ima-evm-utils: Add --keyid option
Message-ID: <20210706211322.wmw5w3loysyvbryl@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
 <7d201d4724e7399f87c0cc2f7291cfd13351d156.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <7d201d4724e7399f87c0cc2f7291cfd13351d156.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 06, 2021 at 12:23:26PM -0400, Mimi Zohar wrote:
> On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:
> > Allow user to set signature's keyid using `--keyid' option. Keyid should
> > correspond to SKID in certificate. When keyid is calculated using SHA-1
> > in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> > certificate (the way public key is presented to the kernel), thus making
> > signatures not verifiable. This may happen when certificate is using non
> > SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> > As a last resort user may specify arbitrary keyid using the new option.
> > Certificate filename could be used instead of the hex number with
> > `--keyid-from-cert' option. And, third option is to read keyid from the
> > cert appended to the key file.
> > 
> > These commits create backward incompatible ABI change for libimaevm,
> > thus soname should be incremented on release.
> 
> I haven't started using Github actions.

Will you create repo there?

> Here are some new Travis complaints:
> 
> Alpine:
> libimaevm.c: In function 'sign_hash_v2':
> libimaevm.c:996:47: warning: taking address of packed member of 'struct
> signature_v2_hdr' may result in an unaligned pointer value [-Waddress-
> of-packed-member]
>   996 |   int keyid_read_failed = read_keyid_from_key(&hdr->keyid,
> keyfile);
>       |                                               ^~~~~~~~~~~
> libimaevm.c:999:18: warning: taking address of packed member of 'struct
> signature_v2_hdr' may result in an unaligned pointer value [-Waddress-
> of-packed-member]
>   999 |    calc_keyid_v2(&hdr->keyid, name, pkey);
>       |                  ^~~~~~~~~~~
> 
> centos:
> ./.libs/libimaevm.so: undefined reference to `X509_get0_subject_key_id'
> ./.libs/libimaevm.so: undefined reference to `ASN1_STRING_get0_data'
> 
> xenial:
> libimaevm.c: In function 'extract_keyid':
> libimaevm.c:695:2: warning: implicit declaration of function
> 'X509_get0_subject_key_id' [-Wimplicit-function-declaration]
>   if (!(skid = X509_get0_subject_key_id(x))) {
>   ^
> libimaevm.c:695:13: warning: assignment makes pointer from integer
> without a cast [enabled by default]
>   if (!(skid = X509_get0_subject_key_id(x))) {

Thanks!

> 
> thanks,
> 
> Mimi
