Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF93732B0
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 01:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhEDXTD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 19:19:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38202 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEDXTC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 19:19:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7466772C8B5;
        Wed,  5 May 2021 02:18:04 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 561804A46E8;
        Wed,  5 May 2021 02:18:04 +0300 (MSK)
Date:   Wed, 5 May 2021 02:18:04 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
Message-ID: <20210504231804.wxewx6wvc5rezxm7@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-2-vt@altlinux.org>
 <3caf1395-78ef-936f-4c8a-dbd56d0b6fea@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3caf1395-78ef-936f-4c8a-dbd56d0b6fea@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Tue, May 04, 2021 at 08:51:03AM -0400, Stefan Berger wrote:
> > @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >   		return -1;
> >   	}
> > -	calc_keyid_v2(&keyid, name, pkey);
> > -	hdr->keyid = keyid;
> > +	if (imaevm_params.keyid)
> > +		hdr->keyid = htonl(imaevm_params.keyid);
> 
> 
> Nit: Since existing code uses __be32_to_cpup I would use __cpu_to_be32 here.

That __be32_to_cpup usage is highly dubious. Perhaps, it should be
converted to some user-space and standard functions like be32toh(3).

Even in the kernel you should use be32_to_cpup, not __be32_to_cpup.
The "__" prefix is for a reason.

Thanks,

> 
> 
> > +	else
> > +		calc_keyid_v2(&hdr->keyid, name, pkey);
> >   	st = "EVP_PKEY_CTX_new";
> >   	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> > diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> > index 288e133..2c21812 100755
> > --- a/tests/sign_verify.test
> > +++ b/tests/sign_verify.test
> > @@ -359,6 +359,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
> >   sign_verify  rsa1024  md5     0x030201:K:0080
> >   sign_verify  rsa1024  sha1    0x030202:K:0080
> >   sign_verify  rsa1024  sha224  0x030207:K:0080
> > +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
> >   sign_verify  rsa1024  sha256  0x030204:K:0080
> >     try_different_keys
> >     try_different_sigs
> 
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
