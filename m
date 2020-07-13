Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EFF21CD15
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2020 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgGMCSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jul 2020 22:18:03 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57214 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgGMCSD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jul 2020 22:18:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U2Uh7i._1594606675;
Received: from 30.25.206.74(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U2Uh7i._1594606675)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 10:17:56 +0800
Subject: Re: [PATCH v5 2/8] lib/mpi: Extend the MPI library
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, vt@altlinux.org, gilad@benyossef.com,
        pvanleeuwen@rambus.com, zhang.jia@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
 <20200709084015.21886-3-tianjia.zhang@linux.alibaba.com>
 <20200710131203.wyj33bq2hgkz6pv4@valinor>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <82c805c6-5614-2889-6e2d-840a2eb8373b@linux.alibaba.com>
Date:   Mon, 13 Jul 2020 10:17:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710131203.wyj33bq2hgkz6pv4@valinor>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020/7/10 21:12, Marcelo Henrique Cerri wrote:
> Hi, Tianjia.
> 
> On Thu, Jul 09, 2020 at 04:40:09PM +0800, Tianjia Zhang wrote:
>> Expand the mpi library based on libgcrypt, and the ECC algorithm of
>> mpi based on libgcrypt requires these functions.
>> Some other algorithms will be developed based on mpi ecc, such as SM2.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   include/linux/mpi.h    |  88 +++++++++++
>>   lib/mpi/Makefile       |   5 +
>>   lib/mpi/mpi-add.c      | 207 +++++++++++++++++++++++++
>>   lib/mpi/mpi-bit.c      | 251 ++++++++++++++++++++++++++++++
>>   lib/mpi/mpi-cmp.c      |  46 ++++--
>>   lib/mpi/mpi-div.c      | 238 +++++++++++++++++++++++++++++
>>   lib/mpi/mpi-internal.h |  53 +++++++
>>   lib/mpi/mpi-inv.c      | 143 ++++++++++++++++++
>>   lib/mpi/mpi-mod.c      | 155 +++++++++++++++++++
>>   lib/mpi/mpi-mul.c      |  94 ++++++++++++
>>   lib/mpi/mpicoder.c     | 336 +++++++++++++++++++++++++++++++++++++++++
>>   lib/mpi/mpih-div.c     | 294 ++++++++++++++++++++++++++++++++++++
>>   lib/mpi/mpih-mul.c     |  25 +++
>>   lib/mpi/mpiutil.c      | 204 +++++++++++++++++++++++++
>>   14 files changed, 2129 insertions(+), 10 deletions(-)
>>   create mode 100644 lib/mpi/mpi-add.c
>>   create mode 100644 lib/mpi/mpi-div.c
>>   create mode 100644 lib/mpi/mpi-inv.c
>>   create mode 100644 lib/mpi/mpi-mod.c
>>   create mode 100644 lib/mpi/mpi-mul.c
>>
>> diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
>> new file mode 100644
>> index 000000000000..9afad7832737
>> --- /dev/null
>> +++ b/lib/mpi/mpi-add.c
>> @@ -0,0 +1,207 @@
>> +/* mpi-add.c  -  MPI functions
>> + * Copyright (C) 1994, 1996, 1998, 2001, 2002,
>> + *               2003 Free Software Foundation, Inc.
>> + *
>> + * This file is part of Libgcrypt.
>> + *
>> + * Note: This code is heavily based on the GNU MP Library.
>> + *	 Actually it's the same code with only minor changes in the
>> + *	 way the data is stored; this is to support the abstraction
>> + *	 of an optional secure memory allocation which may be used
>> + *	 to avoid revealing of sensitive data due to paging etc.
>> + */
>> +
>> +#include "mpi-internal.h"
>> +
>> +/****************
>> + * Add the unsigned integer V to the mpi-integer U and store the
>> + * result in W. U and V may be the same.
>> + */
>> +void mpi_add_ui(MPI w, MPI u, unsigned long v)
>> +{
>> +	mpi_ptr_t wp, up;
>> +	mpi_size_t usize, wsize;
>> +	int usign, wsign;
>> +
>> +	usize = u->nlimbs;
>> +	usign = u->sign;
>> +	wsign = 0;
>> +
>> +	/* If not space for W (and possible carry), increase space.  */
>> +	wsize = usize + 1;
>> +	if (w->alloced < wsize)
>> +		mpi_resize(w, wsize);
> 
> You are ignoring the mpi_resize() return. I believe these new functions
> need to return an int to indicate errors as mpi_powm() does.
> 

Yes, of course.  Thanks for pointing it out.

Thanks,
Tianjia

> 
>> +
>> +	/* These must be after realloc (U may be the same as W).  */
>> +	up = u->d;
>> +	wp = w->d;
>> +
>> +	if (!usize) {  /* simple */
>> +		wp[0] = v;
>> +		wsize = v ? 1:0;
>> +	} else if (!usign) {  /* mpi is not negative */
>> +		mpi_limb_t cy;
>> +		cy = mpihelp_add_1(wp, up, usize, v);
>> +		wp[usize] = cy;
>> +		wsize = usize + cy;
>> +	} else {
>> +		/* The signs are different.  Need exact comparison to determine
>> +		 * which operand to subtract from which.
>> +		 */
>> +		if (usize == 1 && up[0] < v) {
>> +			wp[0] = v - up[0];
>> +			wsize = 1;
>> +		} else {
>> +			mpihelp_sub_1(wp, up, usize, v);
>> +			/* Size can decrease with at most one limb. */
>> +			wsize = usize - (wp[usize-1] == 0);
>> +			wsign = 1;
>> +		}
>> +	}
>> +
>> +	w->nlimbs = wsize;
>> +	w->sign   = wsign;
>> +}
>> +

