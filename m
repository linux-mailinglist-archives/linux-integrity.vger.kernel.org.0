Return-Path: <linux-integrity+bounces-6057-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE40AA1386
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C01888841
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C224A067;
	Tue, 29 Apr 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F9TFKZbM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB701FE468;
	Tue, 29 Apr 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946122; cv=none; b=UjHEizojCOtkk6KHp3huHU4JPcsxmJtSIMjyaNxzsyU1cj65xvhG61V1AgvV/D2VdBf9FYBSt6njGW5/pPHkK2iy8vcmRds88WhtPhmTfodNh3OLty3979mzUic8aA0+0SQ6EfnBFeoLuhJbEfWIvMCmoeSSFoZzQKaRcjlfyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946122; c=relaxed/simple;
	bh=UEkt5WGSXYQvSrj/tJVMJ3ZmSGMiLlkeeePBbDmWQvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdadVAyIjktBgdNBwvnCINqvYCXsQLwLnVfuSN9iwspb4gBHAogstCTUs2riiZwkVvrZLORR1vx8EHrsZ/0eBe1NehpQ5VO40iWTwhzEghANBzwqcl+3cKFQIXyb7VlkyEIq3JnDQagAg/QFopyLmVXWoePU8JuBXyPtwjG5vTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F9TFKZbM; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 9oK5uzDoOb5lz9oK9uPjhr; Tue, 29 Apr 2025 19:00:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745946049;
	bh=F9SrGWAxJKe9RnpLjvmH/WwUmHGMElfgW78kguoJoKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F9TFKZbMcxhHo0HzvT5zzL6G89DZ3HvzchtLhCcsy7RSb6oPPBBhZGZMArXY0qa8q
	 joZupnhHBtF2nyRE1JUkzezyTSBtUOwOO4k7vhvGS4vUMedhxMmlcCVHLoPXvSeD9F
	 Gni0mQVm7T2vHiwvxDJ6ulvPJN9wXMJ4oXprw7IhLL8bj5amyOsS5dEukYP1p4yRSm
	 Q7GQ1v9XShL4CfLXhI7+HbkL30GhV/W9GXGgIHE/gnXlRicecNao5OAIUsQ9QZnh9E
	 LRiwFAh4riiFays8bFX93jLI+lVOoe/QkrTeR6CQpryXu04EGNVgEv01l4vAjGVcxv
	 q1sZla6MhWKpg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 29 Apr 2025 19:00:49 +0200
X-ME-IP: 90.11.132.44
Message-ID: <9ca8a48c-dc5f-4c4d-a829-c94107d852c2@wanadoo.fr>
Date: Tue, 29 Apr 2025 19:00:45 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tpm: remove extraneous space after newline \n
To: Colin Ian King <colin.i.king@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429163859.823531-1-colin.i.king@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250429163859.823531-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/04/2025 à 18:38, Colin Ian King a écrit :
> There is an extraneous space after a \n in a printk statement.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/char/tpm/eventlog/tpm1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 12ee42a31c71..566f4df58d48 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -258,7 +258,7 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>   
>   	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
>   	if (!eventname) {
> -		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> +		printk(KERN_ERR "%s: ERROR - No Memory for event name\n",
>   		       __func__);
>   		return -EFAULT;
>   	}

Hi,,

kmalloc() is already verbose, so I think that the whole printk() could 
be removed.

CJ

