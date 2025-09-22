Return-Path: <linux-integrity+bounces-7218-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB3B8FA3C
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ADE3BDF62
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74743280A58;
	Mon, 22 Sep 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erg93yRl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5B27EFE1
	for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530811; cv=none; b=cfQlu46kWtGvgqnqiRdQMIQZBlHJN/GzRb3ye2ZSwhDk9yrecY5riQC73xDpDZoabPa6ZjiEWZ2YtXZ15uQCA1PjSQxVWdkpdGJOp8Cor0SF7fNm73LPl8vkWWKivwAiSpI0s4d45zwqBkYJDLjJwoB8hlmAKJPV84KlhPTRue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530811; c=relaxed/simple;
	bh=rux0nTQ+9Ps75XEuL7CDS6cf7zTXqlLDg+FoU++9teE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ94OF4PTwj8/tAUnx0fi3Iz1sfgcRIzsicTtQUSLmmCUAJUoLYWU6ONGk9Rq88VbdsT5z9qcX4PYOZT7Qbu0JunYLeKF95JqBpXh3GkPsLDdV29xcA49VTTGSk3WR4FFJQfUnR/hkZmmsRTNkPvtVVUA/2SdwKY8eDiOP4RWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erg93yRl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
	b=erg93yRlVbtuZw+s77oia3XtXtTtdbZk/zPQBrYu4qMoXcz5e/m8dVCxONm8uiQXgacDaO
	u8sYiEZ7GdPIXUwleHwlIF5ANpLJWsKyWbiuCXTSAnPW3PNsdNpGISmzHJzjriEwaSQ0nj
	20CX0h6F8ipqCPf3/B3Ib4wLX/dUpYw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-7j7fWzOUOSeVZAG8oldmIA-1; Mon, 22 Sep 2025 04:46:45 -0400
X-MC-Unique: 7j7fWzOUOSeVZAG8oldmIA-1
X-Mimecast-MFC-AGG-ID: 7j7fWzOUOSeVZAG8oldmIA_1758530805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so717333f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 01:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530804; x=1759135604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
        b=dCOk2EdEdTpAK3yWB+SGncHjs+cth436NYphTdlKmDvJq6KrUFRsWcT9605BKxhr9+
         NamgUwCvBQ6nf84cBfduvStxT3s2inN00KYUyB/K3XFubAdwA4akr0c9iZ2XvA8GoJ83
         IBXoi9LrnIJ1a8QlSzkY+rTlpWEvGPHzBP9nGVTk/ldvZ/WpaDeT6KMEDwoiIojo4SbS
         7g1f9nlVnxdZpsxaQwaqWFYhLa6iUJMGEZDGzLhMzy4jEmhtozwLWgSwsoGTDXdoRMH9
         Q6nW55pwrb5zb0kJa+DxxliJg0ToEmh6awsiEhB9SXvv11LQAArz+5g8j555M3G3fkRl
         lcPw==
X-Gm-Message-State: AOJu0Yy4zFVYSqSE/qD/ZdI4leHjhR2zjxUzO425wxBRU/9HUYje7VgP
	hR/i7ZEEu5+obBMNEKAHnsDvXq4ZdxocUYWBImHaHXHL7+whsJNtoz9fymrf0v/fKQgLTtcNgUV
	lEIK5b41gtITx70Im1FYzv+Yes0IQJYxh8/4VY2NoQZdMTLpVQvUs+MGMLVg/av+AnBqS5g==
X-Gm-Gg: ASbGncux9E+Tk/I/b2vz2Je1xkl+uzNBXvvhCSL6vtWQINoOCyz7k3bg7d1Zw7Ny2Dn
	+7rIzeFpYGoBy4Syhqivkhxz4QqWzFViKZh8gKG1Y++OI/se/OimGVCpVSgzUhS+WcxhDVYTVZK
	oa8moaTKnAL9KH6Agy8DCWYiyNU8hq8H9Sslf+F+TR4KfeF71nxQhUmj85x0UF84vtWSESZ/CqR
	2lpEFBjGv+uu8jbCnija90S/ZUwhzKM6bJ31Bc10SB7obyd0blKrrPsk9NoCKXyGrIVw3RefiYa
	yfPXJkzrvRrWDr+d2xRIapj5OPOGpSwtAf5jAuP34g==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512226f8f.38.1758530804592;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFIdF26ri8nPLU1h2hF0oUN4DiGv6MueO1DVBaFqmOzwLifco/ttVWeCoGXOHOK8CouN8qOA==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512199f8f.38.1758530804128;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm7668492f8f.57.2025.09.22.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:46:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:46:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 4/4] tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
Message-ID: <swkdunznhlk5atrdfsiud57uzcvkmknnarzfh6esq3xzy74tmk@2qqsv6tvdtlw>
References: <20250921020804.1088824-1-jarkko@kernel.org>
 <20250921020804.1088824-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250921020804.1088824-5-jarkko@kernel.org>

On Sun, Sep 21, 2025 at 05:08:04AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use stack allocation for TPM_CC_SET_LOCALITY, as it has known fixed size.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> drivers/char/tpm/tpm1-cmd.c       |  2 +-
> drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++++-------
> 2 files changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>index 11c16ad9b2a7..433908cfb4a9 100644
>--- a/drivers/char/tpm/tpm1-cmd.c
>+++ b/drivers/char/tpm/tpm1-cmd.c
>@@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
> 	int rc;
>
> 	dev_info(&chip->dev, "TPM_Startup\n");
>-	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);

This change should be squashed in patch 2, right?

Thanks,
Stefano

> 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
> 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
> 	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>index e5de14379eb2..0f1b1b67ed4e 100644
>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>@@ -395,15 +395,13 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
>
> static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
> {
>-	int rc;
>-	const struct tpm_header *header;
> 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
>+	u8 buf_data[TPM_BUF_MIN_SIZE];
>+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>+	const struct tpm_header *header;
>+	int rc;
>
>-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>-	if (!buf)
>-		return -ENOMEM;
>-
>-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
> 	else
>-- 
>2.39.5
>


