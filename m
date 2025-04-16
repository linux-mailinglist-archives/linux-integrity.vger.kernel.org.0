Return-Path: <linux-integrity+bounces-5913-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFEA8B4CE
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 11:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C983AAACC
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2B23497B;
	Wed, 16 Apr 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEp7HlI4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547C236440
	for <linux-integrity@vger.kernel.org>; Wed, 16 Apr 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794539; cv=none; b=UZE0f3RqHj2IzhKMjx1sBtesbPTqR4XDZbe1nCRokekLqtjuTn3ix1ffqS4dBBtGteH1lNxu31oIkgWjFqoFBdR2ltwacLIzqytyeQzb2V2xL66CnG49IYZQROXTay0uwayuhgyZg5W6IcQ9b+e1+NETICjlJnaVB9p6danvTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794539; c=relaxed/simple;
	bh=g8jueIBgcTn+FYC4lrbEtVTxxGmm6Nd0Tmk/DQVTIpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8iG/C4hSIgQh+7NN6QyC/fMsxngcTaG5j4o1Wmd/fdaR7mSZp/Z2q4UcC+pLxpGZ87WQ+f4acUezt65UQlH7PkM5lMl0298S+B1Lv/d2N+lXpOrjnLqefQyz2KxdFGvwlyiuwSk74zZ/+DcM1eQh6yXKK3RMMTPOGo2iwgxCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEp7HlI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIOfu8RrFqeGGuM6flhzjgQUceI7NT+dd2DxCzt2hy4=;
	b=OEp7HlI4KBenJAUPQvTqQdIwe/+H9O+xJY8dY6pTM5ssma1YCtXgLAYJhVHqLwl0ZQx3tS
	glbWILkgGZEkvZD0DF1/q8AJM24I0JfDvWEYRPeGYgNdHXE3N0KA0DDooXzNBet2qzuJ14
	Sj66yJRs3KdS3fdihKuI+HWEObtCmM4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-E5B81TLINSiYZNB2J7og9g-1; Wed, 16 Apr 2025 05:08:55 -0400
X-MC-Unique: E5B81TLINSiYZNB2J7og9g-1
X-Mimecast-MFC-AGG-ID: E5B81TLINSiYZNB2J7og9g_1744794534
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2a113c5d8so486965366b.1
        for <linux-integrity@vger.kernel.org>; Wed, 16 Apr 2025 02:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794534; x=1745399334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIOfu8RrFqeGGuM6flhzjgQUceI7NT+dd2DxCzt2hy4=;
        b=SU4rOx8nGVmWrP25DA7USaFegvLZ/6467zGKc6h0VGj3QD+ePJkPpF4QHBd3K9U3YU
         g2v3PqJQR6apQOIOnLVOChpzw/7QGD+mEAdEmXqWNp8fRH/2qMg2krfeapN8ZqOT12da
         +d+FFJvhGIBCIcyYMPDqvEcDDnZnyfy/Si7xLu1RtUhtHu+N0KgwD6gRYyFf9qI0QsFU
         pQn9tqM6EQ1gJ+kNbxl/geEQSt2N2tG97joH8Yh4C+Ck+IhJXpoHEVUTbwWG2eMtAWxC
         81WuhuCBloz8Vk6aIIAZK5aAESrGQbZSiJaSKLT993S3eumR5k84NClu9w4UC0ibFb/T
         glmA==
X-Forwarded-Encrypted: i=1; AJvYcCUUR0+YpgcfZ4PXBAwYe4K/DFFOBoqk3P9vx9s7ka+w1ousKGCGU6eoNnhxFLZM5xkv6eFeg35Vhl0mXHiC63U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPI6xMZbbRuCpprXqLIiBNKb/5YN6qqc2EyL2456Bjv2Q3VUR
	6OHNw4uxIfXe7o8C6kOxpXfsg1m7xkObuE+P297/Av6/D+P1ZPObUCmxnfVuOxRsMWQpaIMnrS4
	/ug/KofZIIbUAJOwadKbICO3lU238dUlT+VQd+AObEhuubwBEaaOlEX9c3manRTed//BcMgh6Jw
	==
X-Gm-Gg: ASbGncujiS2qO0pd35k8rGt0c6w/22JoG5+IuW9MbUMjX588Hq7g2NdiDB7m69D42J2
	UsTqxwJlSy2lOVqs6C48qxHwopr2f/rQ2N+9YIydJQouSIK1VBO9UpZfnSBo8PB3DBVlaYhsWW+
	ofTRIfFcJAyDl5ku0veT1OnDcPfUJb3g46HGBPUf9tldCLG2PaZygQvlkIS6w9SzG8USRjhqsy4
	B/8kognZ5soq/4jwt9zjSiPs0g/pdqIGAiL1UCNNRZSVQzaaFS5DxwIDSRyyLM+AyHk3xpVGJfO
	MAV+Ckr2wpngCDVqXA==
X-Received: by 2002:a17:907:3fa6:b0:ab7:6606:a8b9 with SMTP id a640c23a62f3a-acb42b5717dmr80245766b.42.1744794534140;
        Wed, 16 Apr 2025 02:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBsN4+oh5QxQ8vbKn116QSLShSvGFPIX2Be2WSdAd0ELx306bEqsJC2ErLqnEdyZGudqNVhw==
X-Received: by 2002:a5d:5f90:0:b0:38f:3e1c:211d with SMTP id ffacd0b85a97d-39ee5b18357mr957262f8f.14.1744794523366;
        Wed, 16 Apr 2025 02:08:43 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43d38fsm16568008f8f.71.2025.04.16.02.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:08:42 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:08:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@arm.com, stuart.yoder@arm.com, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Message-ID: <ss6mjfgbiq4z324uaamqfn7idcvv3hjjsictqqzfjvhftduexz@rvwrb6xsuy4j>
References: <20250415185013.2387369-1-yeoreum.yun@arm.com>
 <20250415185013.2387369-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250415185013.2387369-3-yeoreum.yun@arm.com>

On Tue, Apr 15, 2025 at 07:50:13PM +0100, Yeoreum Yun wrote:
>Instead of pr_xxx() macro, use dev_xxx() to print log.
>This patch changes some error log level to warn log level when
>the tpm_crb_ffa secure partition doesn't support properly but
>system can run without it.
>(i.e) unsupport of direct message ABI or unsupported ABI version
>
>Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>---
> drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>index fed775cf53ab..66b38b2cbdd5 100644
>--- a/drivers/char/tpm/tpm_crb_ffa.c
>+++ b/drivers/char/tpm/tpm_crb_ffa.c
>@@ -303,7 +303,7 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
>
> 	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> 	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
>-		pr_err("TPM partition doesn't support direct message receive.\n");
>+		dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");
> 		return -EINVAL;
> 	}
>
>@@ -324,17 +324,17 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> 	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
> 					       &tpm_crb_ffa->minor_version);
> 	if (rc) {
>-		pr_err("failed to get crb interface version. rc:%d", rc);
>+		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d\n", rc);
> 		goto out;
> 	}
>
>-	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
>+	dev_info(&ffa_dev->dev, "ABI version %u.%u\n", tpm_crb_ffa->major_version,
> 		tpm_crb_ffa->minor_version);
>
> 	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
> 	    (tpm_crb_ffa->minor_version > 0 &&
> 	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
>-		pr_err("Incompatible ABI version");
>+		dev_warn(&ffa_dev->dev, "Incompatible ABI version\n");
> 		goto out;
> 	}
>
>-- 
>LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


