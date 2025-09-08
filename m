Return-Path: <linux-integrity+bounces-7032-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B58B48F08
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 15:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7317E3AFFAF
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D430ACE5;
	Mon,  8 Sep 2025 13:12:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A9E30ACFF;
	Mon,  8 Sep 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337161; cv=none; b=sg9PGKsCucCuoxrhwuoge7nZlboSXPf2uGkitgRZ6l7l1mCmtukI0Z9iUqgwGaOgjVYLsYK1jyzFiXOM2eIZjcu2/dVKXQJ9FU4vUt3P+pJtgf0hiIukKrJDFMKgD5nniC3L2FydXLtfujg36WqByM22qn/4lmQo49gsducR2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337161; c=relaxed/simple;
	bh=BppaAQ4jD6WEzrdgKqVOPdodNLx/+Zk2oqkAZPgmM2Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b0dL7jdH5RXgZKx/7uKNmQmwuG2tJZm8LJwSFVSTNMF1WHvW87tK+w35wr579sn6o6q+QWZTEbirbOBoIPvmRuzkEsDfgn5mQATIaONOrxA2nWV1cJy7AfVrykzR+XQo11177Sk4wkjSjC8D5UumC8NNtgREXLtW3HbL8nxrvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 588D5kOL069269;
	Mon, 8 Sep 2025 22:05:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 588D5kwe069266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 8 Sep 2025 22:05:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
Date: Mon, 8 Sep 2025 22:05:43 +0900
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
 <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
 <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
 <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/07 16:35, Tetsuo Handa wrote:
> On 2025/09/05 2:52, Paul Moore wrote:
>> +               if (!str) {
>> +                       str = str_tmp;
>> +                       len = len_tmp - 1;
> 
> This needs to be
> 
> 			len = len_tmp - 1;
> 			mb();
> 			str = str_tmp;
> 
> , or concurrent access might reach simple_read_from_buffer()
> with str != 0 and len == 0. (If you don't want mb(), you can use
> 
> -	if (unlikely(!str)) {
> +	if (unlikely(!str || !len)) {
> 
> instead).

Well, memory barrier is more complicated; it will be

	len = len_tmp - 1;
	wmb();
	str = str_tmp;

and

	}
	rmb();
	return simple_read_from_buffer(buf, count, ppos, str, len);

pair.

Just splitting the whole { } block that follows "if (unlikely(!str))"
out as an initcall function is much simpler; no need to use spinlock
(because the userspace threads has not started yet), no need to worry
about kmalloc() failure (because the allocation failure will panic()
because the userspace threads has not started yet), and the memory size
saved by use of __init function will be larger than the memory size
wasted by /sys/kernel/security/lsm being never accessed...


