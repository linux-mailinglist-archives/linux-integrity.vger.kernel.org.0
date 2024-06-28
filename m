Return-Path: <linux-integrity+bounces-2939-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D4B91C1F7
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF501F24CDD
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EB1C230A;
	Fri, 28 Jun 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WvSgKtJP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B11BE852;
	Fri, 28 Jun 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586816; cv=none; b=I7LScWzvwz54Qj4SvQ4lPNdGOkHgNkC4R+nCzv94nDbVIvKprGP5Q+khQbCuEwcugWV7RA2u0zlRCuqBHOfVUPPh6izrPVh3o3zmxnxsb+gqQmQbCWpvNqntH50b+62+/Xc6Bs/XE8nKNkkjiYA9l4vQ3XUifk11Jf7hoMfWZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586816; c=relaxed/simple;
	bh=c7Mw7OUBjwuJgW7MMo0ZIBNrqurcj/pKhW/s7eLGHTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9dqIh/xxKquAhkaRgExZHBgTMVcKbgVWUilH1ntu6XVOzSfHjdWWGLWvKYNEKJ87bAKCpTzVn5gxq7UrseslesIUA/PzAELLPfRsXxXI41sgeZpa+yVL4Mp6mBWMKa6bvhQyws9WQRYC8m1AGQOEZ2MgdVcSkwFZF/NftPN4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WvSgKtJP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=c7Mw7OUBjwuJgW7MMo0ZIBNrqurcj/pKhW/s7eLGHTw=;
	t=1719586814; x=1720018814; b=WvSgKtJPq+1+fzWGtdoF4WqKcSISLfgg0St5vpB79/1DDly
	SqPi66gKifzNWq5IsLaaAPhcJVwRW6jrAPhxWXNLNl9x7iSNzYBaSnx+aC1ISD1yAmgwWBSyGlvs9
	yqrlfkxwUS2oQ+13TpvXpEb0uXS1snYl7DWRHKZRar7pcOAg2CDVd7pKCERFpUouaErKCnnSZ4PSz
	mCYzHlb4ELE7jrtAQexIByPwjNORuMXJ8prRfL9QJte1lOJ6xWAIm2FONC06gRLHgpfQhxRhBgiBT
	Lk6zZD/DZTglK2aNFzXdLoJe/6+mLT24CldT5edS++4v6ygnGFhCxfNArHrIZ/BQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sND59-00082p-6W; Fri, 28 Jun 2024 17:00:11 +0200
Message-ID: <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
Date: Fri, 28 Jun 2024 17:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
To: jarkko@kernel.org
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719586814;d8f4184b;
X-HE-SMSGID: 1sND59-00082p-6W

[CCing the regression list]

On 20.06.24 00:34, Stefan Berger wrote:
> Jarkko,
>   are you ok with this patch?

Hmmm, hope I did not miss anythng, but looks like nothing happened for
about 10 days here. Hence:

Jarkko, looks like some feedback from your side really would help to
find a path to get this regression resolved before 6.10 is released.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> On 6/17/24 15:34, Stefan Berger wrote:
>> Fix the following type of error message caused by a missing call to
>> tpm2_sessions_init() in the IBM vTPM driver:
>>
>> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error
>> 0x01C4
>> [    2.987140] ima: Error Communicating to TPM chip, result: -14
>>
>> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
>> b/drivers/char/tpm/tpm_ibmvtpm.c
>> index d3989b257f42..1e5b107d1f3b 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
>> *vio_dev,
>>           rc = tpm2_get_cc_attrs_tbl(chip);
>>           if (rc)
>>               goto init_irq_cleanup;
>> +
>> +        rc = tpm2_sessions_init(chip);
>> +        if (rc)
>> +            goto init_irq_cleanup;
>>       }
>>         return tpm_chip_register(chip);

