Return-Path: <linux-integrity+bounces-6073-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30BAA4248
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 07:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED687188F340
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35AA1DFD8B;
	Wed, 30 Apr 2025 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZMCQJZ3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20211DF98B
	for <linux-integrity@vger.kernel.org>; Wed, 30 Apr 2025 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990462; cv=none; b=llCh845hovFw5/ciRe/m5JgIaF5kMJY0PCkfBA3pn8yGrzM+GtRkHVYHz32CX2GvOW+wVSJnHX6z7zhveaH9i9HneHCoHDPJKGmFj6l75AyNbVCQf1eOdDeqtkSQd89BUBuJOtIdl2Il2ceqzZ17u4h79+fgfgEb+A+sOzmThPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990462; c=relaxed/simple;
	bh=3LBZ8CNZY6y9TZGjfZGOceqANuDT2oBaOWkru0fxFQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT9pozjQxL0BSUUQANuZvisysUCMm0VZX8P6WQqbcqwyCSiws0iacIO7rRw7B2xLPjb+QwV0/2XddT4xUgEuIAAWsnfsVwvl8T0QbOWKkq5ALek2af+/AJfKarsaTUvhSCAq0HgtvGnHqkHa2JdM3w4UPP2aU5uf3W3iGGA8d9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZMCQJZ3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so7305322f8f.1
        for <linux-integrity@vger.kernel.org>; Tue, 29 Apr 2025 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745990459; x=1746595259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EObNhpS6QTdve6kAkH7lX8BP03yhDQRh6hSnvdBfWqw=;
        b=nZMCQJZ3YHEiKRq9xdUEFaoGqNt69hP3P0w1XYeo9Ti5qpMznMI/wn7CysKlxaKzKs
         juknxhYTukcAvaVnD0w+9ABsnHGoBw0cSeZQPMsa492Y19Oha7aPjjdNQm0uGwbmEopE
         /bWZWAJ/AWVypjcStPK2ScZO+PG5JdoamwlmfTJ2rbLtMkv/3g1iKhoGpao7h1uMvz0N
         bIST50dmml5umjyNLCf+Asec1o4CUYE6usUaqgVEVJT/Kg93FJY2HZMJJ0CVHMlCgckQ
         Y1i9JAxjiaLxc0wkC6JXNw59AdEbXfVOnWl8/OpmWLeE9iqAU+DPHMR79kkCtC+oGYGy
         LrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745990459; x=1746595259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EObNhpS6QTdve6kAkH7lX8BP03yhDQRh6hSnvdBfWqw=;
        b=Xb4+b8BRpMWQ7DOdVbUwNprst2PFqD9aW9iU2r2G4g71R4atG85HBMPNcMDFh3bK0N
         hhYP4bmt0kvr23vl7zJd0uluayaTna4sJsdU850eusv66ZcEgMgkBwC+qYlHrWxHmVm8
         Hxl3J9yLAXZXsy3Ke7NhdaNHbQX7zRzITXDLztyKtKAvMxu7HTtVjXiSUWIbSZqib/3L
         JLv6NWypkfVAS7RgjFyy8dgBhh0KPGEDNTtd+UnFQkbbmq6YB5FZ+7hxtLCg4wnCsBv9
         Q2djqknfhJkG8rfNnAtglV/fv8VIzfV2g0Z2cR4i37PxxXhiP1C0/9AzICCEONxB/f5q
         BOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVwhZ60bFa3foSgc8I+u4Ul3cLdUEXkHr3hhyZXwox6yNyRANeAlzDVIdnZGSdl/5Mqq4s0TJUr1QKRQCuxps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39OEYe3r4Tpl4CXGKikSpzsHE+uEqodMSEquoaHHl9ZoOTO55
	HlV0Y5WNVj4UaDHZuYOIhRWBG7toeuhDGa8gkBRBWKn1lZ5icYknWByuwAReL9M=
X-Gm-Gg: ASbGncupYWv4pWbRMTr7G7+w6DirUzM72bJX8LWNfDXuCQE8sAb5MfCD4EJdA1J85fm
	6M/32NypDFFBjopn37Q4bK09dgpw1oFsMO/GPiwI/6ROq3X6xvUYVqhJH5EQC7J7VerrxnXYnfs
	Znoq24VTNKX+rDX0g9cvtylD8EZemUM2A7b8VGbzUme57sgPwT2FQbmcEbe9Af3WUDN0NDqVqkm
	ZqqUTXuITVc4tA0WYgEYdWOQcLBZuydmrEt3Gd5RNxRk34dVJ5ovyQYJUqTQtVHnbA6uE+0dhUO
	DwsBl6upP1WhV+MNiIf8r5oBqr4fyw5GfcoLJp66mG1HBXCGs7OVV+oO
X-Google-Smtp-Source: AGHT+IG3i/sYdfjxVU/5DJKWsNnGTYm+BVMuqTqLUwyXPnfD53W2Wi3SUbcbcnKkL9uToGoA8/2P6Q==
X-Received: by 2002:a05:6000:2cb:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-3a08f7a04c9mr1444347f8f.45.1745990459186;
        Tue, 29 Apr 2025 22:20:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2bbf29dsm10403475e9.36.2025.04.29.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:20:58 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:20:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tpm: remove extraneous space after newline \n
Message-ID: <c4ee8e82-4021-418e-a822-34e56c7322c9@stanley.mountain>
References: <20250429163859.823531-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429163859.823531-1-colin.i.king@gmail.com>

On Tue, Apr 29, 2025 at 05:38:59PM +0100, Colin Ian King wrote:
> There is an extraneous space after a \n in a printk statement.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 12ee42a31c71..566f4df58d48 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -258,7 +258,7 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>  
>  	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
>  	if (!eventname) {
> -		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> +		printk(KERN_ERR "%s: ERROR - No Memory for event name\n",
>  		       __func__);
>  		return -EFAULT;

Let's change this to -ENOMEM as well.

regards,
dan carpenter


