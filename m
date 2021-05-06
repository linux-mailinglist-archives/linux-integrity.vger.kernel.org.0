Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D40374CCA
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhEFBQH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 21:16:07 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40758 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFBQH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 21:16:07 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DD7AE72C8B5;
        Thu,  6 May 2021 04:15:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C41CF4A46E8;
        Thu,  6 May 2021 04:15:08 +0300 (MSK)
Date:   Thu, 6 May 2021 04:15:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
Message-ID: <20210506011508.yavlih5tkdcta5wq@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-2-vt@altlinux.org>
 <3caf1395-78ef-936f-4c8a-dbd56d0b6fea@linux.ibm.com>
 <20210504231804.wxewx6wvc5rezxm7@altlinux.org>
 <20210504234318.GC10037@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210504234318.GC10037@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dmitry,

On Wed, May 05, 2021 at 02:43:18AM +0300, Dmitry V. Levin wrote:
> On Wed, May 05, 2021 at 02:18:04AM +0300, Vitaly Chikunov wrote:
> > Stefan,
> > 
> > On Tue, May 04, 2021 at 08:51:03AM -0400, Stefan Berger wrote:
> > > > @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> > > >   		return -1;
> > > >   	}
> > > > -	calc_keyid_v2(&keyid, name, pkey);
> > > > -	hdr->keyid = keyid;
> > > > +	if (imaevm_params.keyid)
> > > > +		hdr->keyid = htonl(imaevm_params.keyid);
> > > 
> > > 
> > > Nit: Since existing code uses __be32_to_cpup I would use __cpu_to_be32 here.
> > 
> > That __be32_to_cpup usage is highly dubious. Perhaps, it should be
> > converted to some user-space and standard functions like be32toh(3).
> 
> By the way, be32toh() is identical to ntohl().
> 
> I wonder what was the reason for the existing code to use these obscure
> linux-specific functions instead of posix interface described in
> byteorder(3)?

Perhaps, it's to simplify work with unaligned data, since __be32_to_cpup
accepts the pointer (without assumption of alignment), where you cannot
just call ntohl(*ptr) without possible sigbus on some platforms.

linux/byteorder/generic.h:

 * The "... p" macros, like le64_to_cpup, can be used with pointers
 * to unaligned data, but there will be a performance penalty on
 * some architectures.  Use get_unaligned for unaligned data.

Thanks,

> 
> 
> -- 
> ldv
