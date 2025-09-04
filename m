Return-Path: <linux-integrity+bounces-7016-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309FB437BD
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9633A73C4
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A162F2F83CD;
	Thu,  4 Sep 2025 09:59:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DC2D12E3;
	Thu,  4 Sep 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979969; cv=none; b=QGLnr8MmdcSmC8ZjhluOtQHWl3MC/FKiwEb/0nO3VAf4Lvr9T1GdSHutIRh9p86y+WcGCx394+ZooFAHVTWRWvmlgZpVICvAQNLItRqh69FICIln8dqdelhZJJMiAyXskuUpWaKyjx5unhwXiv7wlOWOKYcHYw0+B/PJJj+hd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979969; c=relaxed/simple;
	bh=r+uBilJr/vxSmXMH/1DtvnIISLAsJ6rpYpq0ZuqxWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVCdAGm1JpZplcCF6v0P7e9CLdtxkRuldev2xfthw+f30HUoaiqTllcU9CUVWXjeLGgZlq5uAkxfJaL2YA9L/NzScfNPDme1h75MP850ZVFwOEAdmlP5asz5YyYaEZ2V6T0d3wjEi5jQWvABfErR5f9HeTPqoInkPu3/chXWxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5849qZi2091419;
	Thu, 4 Sep 2025 18:52:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5849qZxs091415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 4 Sep 2025 18:52:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
Date: Thu, 4 Sep 2025 18:52:34 +0900
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar
 <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/04 5:32, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 6:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/tomoyo/common.h        | 2 ++
>>  security/tomoyo/securityfs_if.c | 4 +---
>>  security/tomoyo/tomoyo.c        | 1 +
>>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> Tetsuo, does this look okay to you?
> 

Yes.


