Return-Path: <linux-integrity+bounces-5994-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AFFA965BD
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DD01762A9
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D12144A6;
	Tue, 22 Apr 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdyNwAU7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52E204689
	for <linux-integrity@vger.kernel.org>; Tue, 22 Apr 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317247; cv=none; b=c4t5zAJc24tPcbWzahpCePs2l9y1WBd4Pp64TSTC1QsmpNVxTv6nUfj0Wg/Uj8RJd6CxQXO/bdlLGJx319gCh9M9faUHPv/xnAJFt3tA/vSddAR2TnebmN9fax589cpiUccus7uL9Hf4XGw1a5joJHOyzVJO6GqZ2wX6cJSiemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317247; c=relaxed/simple;
	bh=yg+c2UCJeuy5r4oHtXQrwXmPqBpaiKr61unzuNIJWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEv9WutLimx4awIpz6CI7jSKRNTfj6CVPdD4LQ6lBkHhpb+bWR9cTCrwOy5cknZhMVtzaO10W3ZlxSW/NaWXpj6ornE8ciJU5g/qIysYBRzoHPRz0noXnxtt2++/X6crz5CCiLgp4awZKFHEC7Y3FXm3jDtAiLQ8Nt/9C/hHIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdyNwAU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745317244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDzjuAw8gyec0UtcHaMK8ay4lrVZAz455CrMeb1zHOU=;
	b=PdyNwAU7GNY0a3T9PcLqJFPXuN99Gq6SU9qaY0JDQUPddvs23iiZSHTQGe9XsbffM6uKgW
	fQTWskQiLoBIzzkTamRWoAZwd0CiKSLznf/9AfDAKxZzE0/QJraRrYnA4oOOwUtXiuXMAi
	Y1Py2BgLMJlrHL5bXBO5APDdbtZzQBg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-bD7n946INEeHDvhGm-rOCg-1; Tue, 22 Apr 2025 06:20:41 -0400
X-MC-Unique: bD7n946INEeHDvhGm-rOCg-1
X-Mimecast-MFC-AGG-ID: bD7n946INEeHDvhGm-rOCg_1745317240
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso345416066b.0
        for <linux-integrity@vger.kernel.org>; Tue, 22 Apr 2025 03:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317240; x=1745922040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDzjuAw8gyec0UtcHaMK8ay4lrVZAz455CrMeb1zHOU=;
        b=MdH0L8VeJiEqXTb25829RkFWjrYo/qbdXk2OI9NyBCNANKO7zTa3bj+zPPXZVXWdYS
         Nod76p89QMviWoAIlEz/6bIrMPUHOZROCuvq8J4upEp6/zF9ylxx1yUTSR2XZifF/LVU
         EQ4bO4b2toEgW+96qeyevzqfr1rH05HZN90sVvHLmHMTaMcrDQ7Ld+hM7NNk1hQbOXmv
         vQZipASBAg6/tTVCLaps8qMCsSLpJrGj1xmmPNehSJLFnMhyomdZBcmtVb6HQZp90qLn
         PNbCChRm7gVfnN96wuerhjYPvVC4hWksq1p5LS0dbyQJCkwC3GH1zXraSY3QpNujA2dz
         RZgw==
X-Forwarded-Encrypted: i=1; AJvYcCXYgrUWJgGu3a2YusZ0YFil9dwNkDOAoKyCc498ns6dRaCis1m/vcQJJEzdupeArG6gjhJj6R4IHTM9e8fi28A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXY7uzCpSJHWHFPC60XYYZm6O/hOdDZAsB3tafbm1j9OgvdOM
	zbC9fT5wpu89OiGJBGkGkoIMuDtUuWFEs098I4YgIPrX1WOtAlN7cmeDvGRQ4e1WzfiUhHqjwPj
	q4rU7mcaK8yxr6r8OkTZoK44i3aUS9+imKA4ERsV4WDaYGU13NdK+6IZaD3I0efPCKw==
X-Gm-Gg: ASbGncsPKIZOqYEXlZnFZ/UdUGTDEPdRCrk6wbgHhENLqMi/x1zMmUYI/7L+oyF8lhS
	0SCtbSRSpQcrTZvWSsl1YqOHlMr9KvSfNUTIsJ52kN6wlv7qyNANkcIhqyEPIEdqPOpgtC9iDme
	8jbzuPyl8O0ZQYA0OBDE/bRUX07gJn3zhgBY5BzpSr5Gq7yKvttiLokjJTL9ayKCWAVnYnWxoTM
	yxxexKa4HiIIZl0copYRGY8YizjwrAfIlyBVRGKyiFueIlHYTWPVvSecPgX17aAK4wkyLo9CqrS
	DGjhWrD30MEJ/LFu9g==
X-Received: by 2002:a17:907:72ce:b0:ac6:fec7:34dd with SMTP id a640c23a62f3a-acb74e09f3fmr1184070366b.52.1745317240077;
        Tue, 22 Apr 2025 03:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS+uMA1StUCAyrk69fQ00I3GurylSo4xmtvYwqLxjQJ/N/RmIisq+dh9LxGK6QS38KW2+XjA==
X-Received: by 2002:a17:907:72ce:b0:ac6:fec7:34dd with SMTP id a640c23a62f3a-acb74e09f3fmr1184065566b.52.1745317239418;
        Tue, 22 Apr 2025 03:20:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.201.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb8f2019dbsm473147666b.158.2025.04.22.03.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:20:38 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:20:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v14 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
Message-ID: <4w5oshnh6opkrhngzy74cagd7vio45wz6cv3ltmowfbcipdjvs@rijgzlucl6jd>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-17-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250421162712.77452-17-ross.philipson@oracle.com>

On Mon, Apr 21, 2025 at 09:27:09AM -0700, Ross Philipson wrote:
>DRTM needs to be able to set the locality used by kernel. Provide
>a one-shot function tpm_chip_set_locality() for the purpose.
>
>Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> drivers/char/tpm/tpm-chip.c     | 34 ++++++++++++++++++++++++++++++++-
> drivers/char/tpm/tpm_tis_core.c |  2 ++
> include/linux/tpm.h             |  4 ++++
> 3 files changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>index e25daf2396d3..a603f0dadd43 100644
>--- a/drivers/char/tpm/tpm-chip.c
>+++ b/drivers/char/tpm/tpm-chip.c
>@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
> 	if (!chip->ops->request_locality)
> 		return 0;
>
>-	rc = chip->ops->request_locality(chip, 0);
>+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
> 	if (rc < 0)
> 		return rc;
>
>@@ -380,6 +380,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> 	}
>
> 	chip->locality = -1;
>+	chip->kernel_locality = 0;
> 	return chip;
>
> out:
>@@ -695,3 +696,34 @@ void tpm_chip_unregister(struct tpm_chip *chip)
> 	tpm_del_char_device(chip);
> }
> EXPORT_SYMBOL_GPL(tpm_chip_unregister);
>+
>+/**
>+ * tpm_chip_set_locality() - Set the TPM locality kernel uses
>+ * @chip:	&tpm_chip instance
>+ * @locality:   new locality
>+ *
>+ * This a one-shot function. Returns zero or POSIX error on failure.
>+ */
>+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
>+{
>+	int ret;
>+
>+	if (locality < 0 || locality >= TPM_MAX_LOCALITY)

Since `locality` is unsigned, we can skip the `locality < 0` check.

>+		return -EINVAL;
>+
>+	ret = tpm_try_get_ops(chip);
>+	if (ret)
>+		return ret;
>+
>+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
>+		tpm_put_ops(chip);
>+		return -EINVAL;

IIUC this operation is allowed only one time.
So, this case seems more like an operation that's not allowed because 
it's already been done, so what about returning "-EPERM".

Thanks,
Stefano

>+	}
>+
>+	chip->kernel_locality = locality;
>+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>+	tpm_put_ops(chip);
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index 222081e5c7f7..2bc0cf46adbf 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -1124,6 +1124,8 @@ int tpm_tis_core_init(struct device *dev, struct 
>tpm_tis_data *priv, int irq,
> 	if (IS_ERR(chip))
> 		return PTR_ERR(chip);
>
>+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>+
> #ifdef CONFIG_ACPI
> 	chip->acpi_dev_handle = acpi_dev_handle;
> #endif
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 86fe8f6a2d52..884791acba2e 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -207,6 +207,8 @@ struct tpm_chip {
>
> 	/* active locality */
> 	int locality;
>+	/* the locality used by kernel */
>+	u8 kernel_locality;
>
> #ifdef CONFIG_TCG_TPM2_HMAC
> 	/* details for communication security via sessions */
>@@ -355,6 +357,7 @@ enum tpm_chip_flags {
> 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
> 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
> 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
>+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
> };
>
> #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>@@ -448,6 +451,7 @@ static inline u32 tpm2_rc_value(u32 rc)
> extern int tpm_is_tpm2(struct tpm_chip *chip);
> extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
> extern void tpm_put_ops(struct tpm_chip *chip);
>+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
> extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> 				size_t min_rsp_body_length, const char *desc);
> extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>-- 
>2.39.3
>
>


