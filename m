Return-Path: <linux-integrity+bounces-2051-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0FE8A2849
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45766B21169
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E91DFF7;
	Fri, 12 Apr 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J7XxuLR3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F81B5AA
	for <linux-integrity@vger.kernel.org>; Fri, 12 Apr 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907411; cv=none; b=XNYXNwm+1N6uzVzUOAuG9dULujVep7QXMGdAG01hic4y0FPo+88hMeDB58J5ZN5voDE6YE46uEYJB8ID1ZEQaklF/vxEO5bqLsWkgRVFc1ldV/Lerhph88KsVl2smvMHkwriviDQ/DUfsEx+lwMzYEczl0x6WCHmm2CxNeHQVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907411; c=relaxed/simple;
	bh=YcTsmwlItoE8fSGwYRqqnuk+Tw51HfaATz60J8yRVI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AgXCMLOJlxJkoFTf7dA+LZdDi1aaNdrYnonomnKvUXNsvJeEe4Aq5gr2RLRBZXSvBBTATAB6BKQ/c/CwbrViG2l8MOffq5o9XJGDrOT7jv9Kt5NLurvQk2IpdqM48aTxN794Jo/7/kzzUVEL9nJRZeierWt9FsxBTs7KWLu5cNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J7XxuLR3; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712907405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YcTsmwlItoE8fSGwYRqqnuk+Tw51HfaATz60J8yRVI4=;
	b=J7XxuLR3VJXoUYVgdvFwijuI6WvzFTy27Og0jITGq7GMT5mlARj+6iLKM2liUv2CUFoDgUJqcaPhw5I4HQCsjG7aYPj2aaFGei5RLLYVafoGrt6EVxsr/DkMfDPtLt41zuEReZUMyn5tIE48TiNM5KnHQn5W4AXcllauJjDk1z4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4NUGc5_1712907404;
Received: from 30.240.117.218(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0W4NUGc5_1712907404)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 15:36:45 +0800
Message-ID: <9fd40539-3741-4980-ab03-c537b26db281@linux.alibaba.com>
Date: Fri, 12 Apr 2024 15:36:43 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org, Alberto Mardegan <a.mardegan@omp.ru>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Eric Biggers <ebiggers@google.com>, Patrick Ohly <patrick.ohly@intel.com>,
 Patrick Uiterwijk <patrick@puiterwijk.org>,
 Matthew Garrett <mjg59@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
Content-Language: en-US
From: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/3/18 23:42, Dmitry Kasatkin wrote:
> On Mon, Mar 18, 2024 at 5:07 PM Dmitry Kasatkin
> <dmitry.kasatkin@gmail.com> wrote:
>> Currently libimaevm provided by this project is used by the tool evmctl,
>> which is also provided by this project.
>>
>> An issue was reported about using libimaevm with other software. Its
>> GPL2-only license makes it incompatible to use with other licenses, in
>> particular GPL3-only.
>>
>> To address this issue, change the project license to GPL-2.0-or-later
>> and libimaevm to LGPL 2.0 or later.
>>
>> This patch includes all acks received so far.
>>
>> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
>> Acked-by: Petr Vorel <pvorel@suse.cz>
>> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>> Acked-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Vitaly Chikunov <vt@altlinux.org>
>> Acked-by: Ken Goldman <kgold@linux.ibm.com>
>> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Acked-by: Bruno Meneguele <bmeneg@redhat.com>
>> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Acked-by: George Wilson <gcwilson@linux.ibm.com>
>> Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
>> Acked-by: André Draszik <git@andred.net>
>> Acked-by: Frank Sorenson <sorenson@redhat.com>
>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Acked-by: Vivek Goyal <vgoyal@redhat.com>
>> ---


Acked-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>


Thanks.


