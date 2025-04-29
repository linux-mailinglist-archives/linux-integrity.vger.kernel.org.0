Return-Path: <linux-integrity+bounces-6062-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E36AA1AD2
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D290E4A848E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88B2522AA;
	Tue, 29 Apr 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CgzuBq/n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD22459E1;
	Tue, 29 Apr 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952226; cv=none; b=tnlvBfmBtju60APpIGLt19HPA+fP3Z3wm6p6YbdpZDbksGhn434uC8XhUYwCJmvzLVJpDWHwGtUPJ9nFPv6Qko3AGxMFnFqzefGu6OIRN2z/Zvjo9IMa0mwtx9RQEKXX1oUsjPsj9KuAmszA/8SLotCzBf9yW1jybRIFJWXVCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952226; c=relaxed/simple;
	bh=Z6mkwjng3lmvVlSacVSrnsXJZ8Ei6AdhSYHxjE5y7dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSOsHQjmsYTVzD+sq09B6+00EOLJtoxxRGzL+DK0k0mr5ogc2qcjAQdig6i5SXTS7RclDMRrvNY3jgVXJ8i0sBUs5p0cPwlM0jTguVQXokgfXKyo4vZJLXdCQuo/WrukdslkwVkc4TnLWC9I4aXXcrHiF71ThOzk2vdimnB0GH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CgzuBq/n; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 9pu4uBT2Jo24u9pu7u4D40; Tue, 29 Apr 2025 20:42:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745952124;
	bh=CJfmyDLx95cl/rb5U922mRDjqr6hA8J5X+u9yZBBAeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CgzuBq/nmkWps0gTHn2AcWgwonPp6PPhhuouN4u2i99q71QzTJuNnNgATt4c2SdoN
	 K8LLf80TPbF5HXwVdWDc0KuvAXlguqhfXq4jG2Is4rtNOdxPbTjYqhmct8mlZgg25G
	 qplJbHA3m23BCOGbOYSswlx0AXUUXSbl/0IbBhsJz+ChGQQGLKfyOxSZQZngMoi6Bh
	 rst00Vm/PTCAIxHPlCSlccvBlBtSDkp0JKlezR77iK1MMFs2vXmUk0QJ4PlkiBDMv1
	 lgHd5VgZ84Va9jnRiewNlp6//V3p28Yjr2LeRlye36pYHBQC5uOFhoKeRMI6zWoeTi
	 dOCa+5WIp4ipw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 29 Apr 2025 20:42:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a07bec9d-26db-4270-bb75-49c9d3b6b91b@wanadoo.fr>
Date: Tue, 29 Apr 2025 20:42:26 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tpm: remove kmalloc failure error message
To: Colin Ian King <colin.i.king@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429171454.828003-1-colin.i.king@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250429171454.828003-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/04/2025 à 19:14, Colin Ian King a écrit :
> The kmalloc failure message is just noise. Remove it.
> 
> ---
> 
> V2: remove entire message, originally just removed a trailing space
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hi,

The S-o-b tag is not correctly placed.

CJ

> ---
>   drivers/char/tpm/eventlog/tpm1.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 12ee42a31c71..773e9e537991 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -257,11 +257,8 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>   	    (unsigned char *)(v + sizeof(struct tcpa_event));
>   
>   	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
> -	if (!eventname) {
> -		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> -		       __func__);
> +	if (!eventname)
>   		return -EFAULT;
> -	}
>   
>   	/* 1st: PCR */
>   	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));


