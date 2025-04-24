Return-Path: <linux-integrity+bounces-6023-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F57A9B848
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 21:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03227B2803
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E427C156;
	Thu, 24 Apr 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iCwNa1Pw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD761E5B95;
	Thu, 24 Apr 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522823; cv=none; b=faExlepASy+Y7HzkBghPo+kQJnL0yvpWAwcc4ZocourKS+EVKmS16ao6GJu4dmE7h7c/L9nErezymF7/w/JCqYxOSJ7M4bntCC/vIzMBayZRxTzKxIboCCR3Jd8U3+6LwelVqis/RLd4e6rLNZp2yR0FGBlEMKS60e6qUf+z1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522823; c=relaxed/simple;
	bh=FbQNuNG+a+QwOTzKXpP9P0iAjBjElMqiAwdzMsfzOMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vonm3GWGNuyBM1wZ37kPbJNkTRIFvCsO1JUCovabuOpHI4RpYJbdl33W8RcKP7t/XZtGVm9Ovj/BEkpHAkME+8yGUtdp01MOevB0cIBpkdt6o6Yl9aBlRSggrL0DNXqQbeGHaS4LXO2zvguYGuggVcPnt8dOkRIMonrjSyAi3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iCwNa1Pw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.202.48] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9726211308C;
	Thu, 24 Apr 2025 12:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9726211308C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745522821;
	bh=74cZhWXIm6DNK3Mg2kUV74aTfyWRc7iRAWJvXq6yXtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCwNa1PwnNR0onB/ijUlvcweRa6CXTmWKW14JsO29ycskZ7nGodrZpYFyGzH9k9V4
	 Sdk8+5Ymip2FoMrWkmBxEIDODYBWY+4iSWanqiEWUPN4Atf0HypxCtZ5KUIiX4oTmi
	 88xcyWJpxjt5nND9W+FXauji5KZmGss+dee/xv9Y=
Message-ID: <8909e6a6-4f3a-49a7-a3fe-f6ab9d925aaf@linux.microsoft.com>
Date: Thu, 24 Apr 2025 12:26:57 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/9] ima: kexec: measure events between kexec load and
 execute
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <aApMnEl1Xzarmimn@fedora>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aApMnEl1Xzarmimn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 7:37 AM, Baoquan He wrote:
> Hi Steven,
>
> Could you test below code and post a formal patch to not copy
> measurement list buffer to kdump kernel? Below log is just for your
> reference, please feel free to modify or rephrase.
>
> ===
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.
>
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
> ===
>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 38cb2500f4c3..7362f68f2d8b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	void *kexec_buffer = NULL;
>   	int ret;
>   
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		return;
> +
>   	/*
>   	 * Reserve extra memory for measurements added during kexec.
>   	 */

Hi Baoquan,

I will work on it and I will post a patch after this patch set merged.

Thanks,

Steven


