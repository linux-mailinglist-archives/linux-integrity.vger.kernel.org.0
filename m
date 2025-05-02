Return-Path: <linux-integrity+bounces-6112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FDAA7731
	for <lists+linux-integrity@lfdr.de>; Fri,  2 May 2025 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6174B1709CD
	for <lists+linux-integrity@lfdr.de>; Fri,  2 May 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7F25D1E1;
	Fri,  2 May 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ID4wW6ak"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4263C465;
	Fri,  2 May 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203124; cv=none; b=NAGcNYJAigMyjnh9Rg5BMNomYARoZDKD3cx2i/6BvK/qW3pVH2BIynANdYijeBUK4vN2EbxIVHEFmJpHcokSe5AbJPadoiQ50PlGQFAX/+kLiBvMJulZdg11dz9uxBt8yjA2nHQi9PtBay6UJ60MPbGxL6w4hsEr+HJN+4XHJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203124; c=relaxed/simple;
	bh=pnwaqwu0PJ8lDlRXI3vBmxd2cJ+yKzMffA10mq51NRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKtGycXReXFOflcVSsMOKSGFVe3uP80w9XwL24PAo3Vi52YIkReQCzKF2OZRBwqmaqQl2504FSaB1IfHvxcSg8h6RcIH7vx+QyTo8oTkFS06ZJdaVJtr1vfbu0TNX9irFBHyrHUFLlo91a+VI2L/PlArysdV0RhiOJ8faqb01jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ID4wW6ak; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.194.49] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F15E2038A5C;
	Fri,  2 May 2025 09:25:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F15E2038A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746203122;
	bh=QKq6LqM0pEX95ODNBXEkqdtsxLl41A0R2DmDPU6S99M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ID4wW6akUmsu1eI4m/k7RRlTytYoBIZShSAOY+6ZSHApFoZsG3WsqP0+cO4iAaqDL
	 3CvJWrgfBs1ABDVOR854Wx0UJmDlMoHWgeXaaQpU3zY5ERO2PyZLiIdVNbfHtq/Hkb
	 gaKrfZMN+AGUkSa7QmtuFlqh9t/L4H00IJhDRqBQ=
Message-ID: <7337e27f-cc54-4c51-91d8-11d875baee49@linux.microsoft.com>
Date: Fri, 2 May 2025 09:25:19 -0700
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
>
Hi Baoquan,

I tested the kernel with above change. Normal soft reboot works fine.

I will post the patch for review.

Please make sure to test KDump scenario.

Thanks,

Steven


