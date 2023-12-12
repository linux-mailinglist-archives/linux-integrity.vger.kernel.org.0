Return-Path: <linux-integrity+bounces-394-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAAB80E45E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 07:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB6F1C21AC2
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645D156DE;
	Tue, 12 Dec 2023 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzRniBVT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7DC7;
	Mon, 11 Dec 2023 22:40:45 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-589d4033e84so3087907eaf.1;
        Mon, 11 Dec 2023 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702363245; x=1702968045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ3uJeujcSHCX4Yuy40El599+rKbJemClUH5Ymogx/A=;
        b=UzRniBVTjkr5tGpREb+y0JI5HdTuHlEdywQlMvei3lXSW8x4S+uQSyurVwv9HW/KiL
         Gl3fyLphZ9S4ReqKeZdtHcp322Ow6eACX9nFkLg4XyJMqV6te4fWzPuNjAXedRo0onhg
         5XUSgq/ncuXhXLd2q67k+gjOB4ApVHGWS+R6wr/JomYn/y64n+gQwPw0vsRPCKBloIk+
         pngq1X3aTyoVRj5aTLzv9h6Vw0fI1RkDJVNtZFEqQkDoWT7zfzeZrP8k3FDnuzsehSiA
         FqIHgZDMFwLQu6Gk8v6aWYOLfLCxNmTxJ+RzRtnAhYvK7Ww9tYDu1XUiiMUZsAw75APz
         K8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702363245; x=1702968045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ3uJeujcSHCX4Yuy40El599+rKbJemClUH5Ymogx/A=;
        b=DvsKmk9o5eC9gQauZhqaZ2UWFfwOpENz9uOF16vrggTR/MgYqN16YFtdhVct3otcqr
         dVSMj240zGx1X3uMXbvj08p3m5S2MBf/Tfq1VctK4nuh1xDGZl3iATbNzXBlGRwViJVM
         yX0DKueBMKzNcDk22s79ghGswU/pMUcXVYGzM+C5UK43XYrnMsvUjtkrHS+EnFi5Pdf2
         py63ZnYFyceauJeV8delbkKtB5BglbhMbMIZcgjVctYqccwJTbijtVs+Dj8UDwnvpOLD
         tPyGIAm5aUZFWXlTF4qhJbBR+K7yuRuVKEquz92Pe9hEv9ns8ofaFIS8ctVIQF9J+2SH
         Ob7g==
X-Gm-Message-State: AOJu0YxWv5qXpNE3PybbQb9wvMTIjgNmFn+8LuolSDWqfAq6tCMqLcBc
	IhLkBK9b7Ryy6Mrqe9gKpbP5B5ySLWU=
X-Google-Smtp-Source: AGHT+IGO7oCpn2HiGO4Pa3WCaKh+37j9sxmkHe2lf3t5n5MLgxDWCRwUG4qwYd8hUEXSTnJKBHq1DQ==
X-Received: by 2002:a05:6359:3103:b0:170:8db:96a with SMTP id rh3-20020a056359310300b0017008db096amr4229908rwb.16.1702363244726;
        Mon, 11 Dec 2023 22:40:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id du12-20020a056a002b4c00b006cef5c025d2sm5326604pfb.95.2023.12.11.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:40:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Dec 2023 22:40:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Johannes Holland <johannes.holland@infineon.com>,
	eajames@linux.ibm.com
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
Message-ID: <bd63a97e-d27a-495d-aaf5-138507c10e07@roeck-us.net>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-4-joel@jms.id.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928043957.2636877-4-joel@jms.id.au>

On Wed, Sep 28, 2022 at 02:09:57PM +0930, Joel Stanley wrote:
> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> 
> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> 
> Add a compatible string for it, and the generic compatible.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Does anyone happen to know why this patch never made it upstream ?

Thanks,
Guenter

> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 0692510dfcab..4af27b7ec5b1 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] = {
>  	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "nuvoton,npct75x", },
> +	{ .compatible = "tcg,tpm-tis-i2c", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> -- 
> 2.35.1
> 

