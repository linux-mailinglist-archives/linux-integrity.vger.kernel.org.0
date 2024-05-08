Return-Path: <linux-integrity+bounces-2346-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9C8BF457
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 04:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8EAB22101
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31263944E;
	Wed,  8 May 2024 02:06:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E71A2C2A;
	Wed,  8 May 2024 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133976; cv=none; b=JTLnArgIXg0FCGl+Ge132gZRlxRCdQtyLKW5tjExBNhHbkepPqHm+powZ7gi9AHFGYiddNE28s2OvIG3/KIow0fkpq5caFSVoVYUZV/z2c15EHH23TIFzUs1+6YgNHWX8Kfbxgf6mfFlzJiZ/5Idq/mJq9CQLyOW/asekTR0I0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133976; c=relaxed/simple;
	bh=LWh+Ql9WBOZdrwbmzXuSsBh5Ua7/PlFQqSGwkjor1ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ahNBGuXzxbH5dRJRNZmHxOgDhMY+GXb2ZcbTSmq4rKeHzBPPupijW0dmUhvy7J8TI86HgJ/rWjabu6KAGnx3CA54eQqhsy9zJWehfmNf/2cSzg00/OWLd9fVcGxXNOFQdUBn575y/+7H0NQE6JnW1doS5HKr5/iEQ3Y2l3nMibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VYz4565Mzz1HBjw;
	Wed,  8 May 2024 10:04:53 +0800 (CST)
Received: from dggpemm500024.china.huawei.com (unknown [7.185.36.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C1071A016C;
	Wed,  8 May 2024 10:06:10 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 10:06:09 +0800
Message-ID: <3a155ac1-b97a-9ee3-a609-469502653f28@huawei.com>
Date: Wed, 8 May 2024 10:06:09 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
To: Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
	<jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240507093714.1031820-1-guozihua@huawei.com>
 <baff6527d8d1e1f7287e33d6a8570bd242d5cadf.camel@linux.ibm.com>
Content-Language: en-US
From: "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <baff6527d8d1e1f7287e33d6a8570bd242d5cadf.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)

On 2024/5/7 19:54, Mimi Zohar wrote:
> On Tue, 2024-05-07 at 09:37 +0000, GUO Zihua wrote:
>> From: liqiong <liqiong@nfschina.com>
>>
>> [ Upstream commit eb0782bbdfd0d7c4786216659277c3fd585afc0e ]
>>
>> The current IMA ruleset is identified by the variable "ima_rules"
>> that default to "&ima_default_rules". When loading a custom policy
>> for the first time, the variable is updated to "&ima_policy_rules"
>> instead. That update isn't RCU-safe, and deadlocks are possible.
>> Indeed, some functions like ima_match_policy() may loop indefinitely
>> when traversing "ima_default_rules" with list_for_each_entry_rcu().
>>
>> When iterating over the default ruleset back to head, if the list
>> head is "ima_default_rules", and "ima_rules" have been updated to
>> "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
>> stays always true, traversing won't terminate, causing a soft lockup
>> and RCU stalls.
>>
>> Introduce a temporary value for "ima_rules" when iterating over
>> the ruleset to avoid the deadlocks.
>>
>> Addition:
>>
>> A rcu_read_lock pair is added within ima_update_policy_flag to avoid
>> suspicious RCU usage warning. This pair of RCU lock was added with
>> commit 4f2946aa0c45 ("IMA: introduce a new policy option
>> func=SETXATTR_CHECK") on mainstream.
>>
>> Signed-off-by: liqiong <liqiong@nfschina.com>
>> Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>
>> Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
>> Reported-by: kernel test robot <lkp@intel.com> (Fix sparse: incompatible types in comparison expression.)
>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>> Sig=ned-off-by: GUO Zihua <guozihua@huawei.com>
> 
> Hi Scott,
> 
> I'm confused by this patch.  Is it meant for upstream?
> 
> thanks,
> 
> Mimi
> 
It's a backport from upstream.

-- 
Best
GUO Zihua


