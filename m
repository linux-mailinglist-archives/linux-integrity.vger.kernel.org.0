Return-Path: <linux-integrity+bounces-6549-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04113AEA18D
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A076173B42
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F262ED142;
	Thu, 26 Jun 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OoE0pHQk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532442F1FE2
	for <linux-integrity@vger.kernel.org>; Thu, 26 Jun 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949360; cv=none; b=jsWGhfoIZi1RE6t5Blqbn42uGTUwOiPQ0FqK9qzgsrUY7534EnvR+JTXPinVew9X/4tzvjYzCz/KfmZzCc65myFClau3kwa6biU9s0AV88Eq1UaWzroqko6WNbdMyznV9uhz6C4pgMXTR0PlR+ndOAE0olVf2IIfT0LdC+xS5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949360; c=relaxed/simple;
	bh=e+p1u3bjk72DZ4xXV4yRymVTRZjUSFmGtt4UT1KJy4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKsrV6r1dplV1+rDDkRo7BkZdeWlSObGWVs1JXdfO/ZDfM+mpxuiXCdGJgbnJ2gtmDlRNfGxyBrRVRQB5Yi53dNe15jhoeiI3zQZgCoxQ+gcibLd3UENLpV/rYK9lgB2SpWrgjSzL+iGUgRLZo1MDNxnX8BlAxlsBtMUk6sVSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OoE0pHQk; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-404e580bf09so260631b6e.1
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jun 2025 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750949357; x=1751554157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDTHGKJ7PRnQtifJssL8JUIIPtKYbrBYEt3PvsupNKg=;
        b=OoE0pHQkKhw4hvO00e7lyvZUJjgpBMreXb6Jk35+vlUH2IE5UYZqaqLSQHU/nibg6v
         ruXqxLbVMqM1vytrKhJtNrqEDD6h6rXPgBiryqmNYLC3IQnZIhuOS7TcPwGr5R7ygKs1
         lWTtvGDk6W0KewJgH+hGGwveddIggSzeYH22jvTTUIxPsmaKjGdaoU/MlO0VHJ95ibm8
         knVzbKenulkmq7F+9uZ5iBaho2oUTnB1Fx9YeiEBCInT5w6yq1OERaErbJt1TU1W9RXL
         JVbdr/2nbDQR2i1Zix/oN3aQ7XelMgfOCuorezM/K2rl/XlBSx5xdT0WppNl72JmrNT7
         FlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949357; x=1751554157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDTHGKJ7PRnQtifJssL8JUIIPtKYbrBYEt3PvsupNKg=;
        b=Ndq2Stu+3RoIgqzRTOynB7mGiMyQ6fro0PpXoT7Smr3zBGzmEkOP4eKy2h5Qp5LXlR
         fKqmUcFw4SPj57IuXLkPELFTqct/h22cix1+xb8XUg8fUlHKANr5W36HJQ9eir2ojkno
         PKpvMf2r9asvvG8s0CduakcP2x+QIUfDbDTauiMj/flCPbJTxRKkEtHjQZf+K9b5RHNe
         Ygd/WDMNTVst8UtzliNhAzqved7aavjtOZDVbRfp2DrjpeB+DBEc7+kP4yFTvOoIULjd
         rLsa4AbBhhbHgn8nFNR/6f0MW9oh+9JsuRDk1DPCVa683Yz+j9XYABuplvnl1mfzQxLQ
         vhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnPqsirYtzJlmZHSsHWlDykoTY1JJ8NxzazYxOQjOrGX4nuBbHHjuho9HQEluQZLYgIoaxsicG1pUPvJbsFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoqRqhGSSiEF8nQpnQnoU02GqyJjAwhc0UsnWT4CuhPK8q17P
	PpDGj4KURUDzjxZH4YukHnOgCnIYEFsIYQsLIa0rcTxI5KERxgySRrtZmtXZinJwYGVVHffSpZh
	Be2qC
X-Gm-Gg: ASbGncviT0mJTDis8Fbk5skaZ9X38D68/m/Jd9+jPBm84EXT3t5YGBgcOKSNUyP5iPV
	a0z7j/gw8KrG5l8UYVTDq1GdYr8w13R1jLMMMhJ7SRK9U/QgFB1E5FS/vMT4jyWUa9B82cBZqi7
	2rx2IVNVldM2uHinfqxMyDs4XT07om9jJBHbOqS1FrpHNKatMHOnnMta8foG5VfJrKXebTJo/c3
	TwKy1ZMIl8XV1FHwsqchLcuX27z8kg8V+IUNf7L0EAaT4WuQuaPZ27JvmkFYjbQagcG2v7tkpfS
	h3ne3pYVsLrp4geqRWENnWWAg1mYH96edMd7049EuwpAGBU=
X-Google-Smtp-Source: AGHT+IEk1fuPkxL2WLgf9P7Tgn7/Q5tUITHrfb7oE7/rJ7NBa+jsmVtdMJzdRWUlmWV91MQIQpsO/Q==
X-Received: by 2002:a05:6808:50ac:b0:406:7186:5114 with SMTP id 5614622812f47-40b05c73cf1mr5460261b6e.36.1750949357253;
        Thu, 26 Jun 2025 07:49:17 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6c136ecsm2593994b6e.6.2025.06.26.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:49:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uUnud-00000001WeQ-0wX2;
	Thu, 26 Jun 2025 11:49:15 -0300
Date: Thu, 26 Jun 2025 11:49:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Create cleanup class for tpm_buf
Message-ID: <20250626144915.GD213144@ziepe.ca>
References: <20250625213757.1236570-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625213757.1236570-1-jarkko@kernel.org>

On Thu, Jun 26, 2025 at 12:37:56AM +0300, Jarkko Sakkinen wrote:
> @@ -323,7 +323,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   */
>  static int tpm1_startup(struct tpm_chip *chip)
>  {
> -	struct tpm_buf buf;
> +	CLASS(tpm_buf, buf)();
>  	int rc;
>  
>  	dev_info(&chip->dev, "starting up the TPM manually\n");
> @@ -335,7 +335,6 @@ static int tpm1_startup(struct tpm_chip *chip)
>  	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
>  
>  	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
> -	tpm_buf_destroy(&buf);
>  	return rc;
>  }

So, Linus has spoken negatively about just converting existing code to
use cleanup.h, fearful it would introduce more bugs.

I would certainly split this into more patches, and it would be nice
if something mechanical like coccinelle could do the change.

At least I would add the class and drop the tpm_buf_destroy() as one
patch, and another would be to cleanup any empty gotos.

Also, I think the style guide for cleanup.h is to not use the
variable block, so it should be more like:

CLASS(tpm_buf, buf)();
if (!tpm_buf)
   return -ENOMEM;

AFAICT, but that seems to be some kind of tribal knowledge.

Jason

