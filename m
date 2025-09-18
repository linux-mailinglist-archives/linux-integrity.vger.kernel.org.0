Return-Path: <linux-integrity+bounces-7149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2741B83A0A
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81F53A11EE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA330102A;
	Thu, 18 Sep 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LESX5cmq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAD3002A4
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185747; cv=none; b=SBDzHNUUYAJRy33yfM1XZBpweHYjdL1Po4oVFoAlfP/PeclEc1mj+z/15ciGDhnrz7pdmPhGggwXEF9Os+u9IdmEVpo+jDFY4+eb8LDegNDWK7P3LUW72he2Y7dY0phohvEQH3U/6h/naWorfXHB0Zv+MTVQpPmfh1OzTjY03Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185747; c=relaxed/simple;
	bh=1PqtqwA8HTxTGdbY6XU+KfBZ/5blcdrJ1NKOXPhyCXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+AZJSV78bUnfKk5Ms0a9ywEqNNrwHXRGRG7YBZRit4e2GbbxoJu5H1zEWmcisqbnnu02Qej8AB9zL/kfvBjFm9T7bgU5mkdtz8MjDNPsaN7ODH7G5uMgKHJDz8U6xdM1qFU8YmUpb3u/bd/rlxWWGNYWGahBPgGL3g6BrTZBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LESX5cmq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758185745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfSX/3glV+vNGGCchKq7p2eyLcNnzQWJh7iAfkK8WO0=;
	b=LESX5cmqiaDZVJYQyB89MQkDGLrJ7KgAKp3fUG2PxucUhGPDvUrxK9Y3A0JyBr9rXeYH0k
	Z5Tq+I3+AOJb4szTPYXsNJKZH/CRP/dAiXEleEeYfzSZDSv42ES1LYdhD4KHxAzXEluM84
	qLeGHwBM1PcpI3scMs1CNVXKtlAyEKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-AeJM_znfPBmacfum9BvtBg-1; Thu, 18 Sep 2025 04:55:43 -0400
X-MC-Unique: AeJM_znfPBmacfum9BvtBg-1
X-Mimecast-MFC-AGG-ID: AeJM_znfPBmacfum9BvtBg_1758185742
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so5274965e9.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185742; x=1758790542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfSX/3glV+vNGGCchKq7p2eyLcNnzQWJh7iAfkK8WO0=;
        b=cSz+TiR/ypoi1oIehdqKAetgNHlugte6lJrINFCKiau4/a2GS8opTAvrWh4c5jaJDj
         p7/cM8WrigxXU1o/ZMPIpi4QMp3gLKAwiytIRCdGTkArKS/73E77yE0gO10Pf7TdV1y2
         T0hdP1llGTuJ3DV3vZQWSpiVW1fpJwMuU2eAef+0uhZ8tEoB/MNo/U1SegamP3YzGwGq
         CaIxk3ldmA/IStDdmLYmC3Pgt800j8biQlUh8ZHJHHKhNjZA+0who34hBjw+wpVzZKot
         rH9VRv3t9yTPQHRSP+5COnCJQPP2UCElIeipULHvbIGmhucDxS13msm0rkta07KtVkh0
         xqxg==
X-Forwarded-Encrypted: i=1; AJvYcCUDsUu2Rbnzzt6b5bSRpCbFGiuauFhANkT+MqLlIxSHrBUS/bTU4yJPj0cFRbc0/m1b7S3nvf5WGO35FZGVXj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0t+2r4NeHn3p2ThjXHIrlfOf2dNfV/WMwCgYOw/+x4/tAqus
	+0fdO6tLW5YCbVgtRSzzvU+a1jDtTXL+CJ66z8Qsa+5K9bGxm7mmlOCI9zVBTYDNfCSN+0U37vX
	oYLpAxHBK+1UTc9dnlI/UW3lOARN3u0scQmBeX+plPyyajgpvMqH46RnjkqAtHsZpRW8MTQ==
X-Gm-Gg: ASbGncvU3ZSt75yOPS4YUwo371jCLobofkb8lWchMSO6j37Sku1yr/ae6UYo7w2jZzG
	KccSlItJW8bsw9SSh52qu+jZz+batxhCkYfsUopQ3BYYfETUp42g6x+1tuQPrIoJ/Vr2y4DXOzF
	oOxvrVTwLbwGSzlm9bRC3us49ShWxXJ6ZmJDKVNhRbC9BwYYLrYeh/7w7HXhOjELRlz0mIwXYf0
	3KvCxEaw/KDtPfx4ydBNXt10q2sHHy832XQ8xTIhTjoEYjl7fQXCVzYDFoy1dCHuuyWlgtS0MG3
	Hw5IkUepdH4PmmSSoG6JnVgR5QRXKh9xM9IVMvbPWeU=
X-Received: by 2002:a05:600c:1993:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-46206b1ffe5mr45269535e9.27.1758185741774;
        Thu, 18 Sep 2025 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDL6A/B1KiEn8NHf82/BX9qvSi3nK8XhtHIfdcuZ0mICv4WoJhO2X+6N2sP+jKTJkCiwT/9g==
X-Received: by 2002:a05:600c:1993:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-46206b1ffe5mr45269255e9.27.1758185741229;
        Thu, 18 Sep 2025 01:55:41 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.120.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm31225685e9.3.2025.09.18.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:55:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:55:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	kyarlagadda@nvidia.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm_tis: Fix undefined behavior in
 tpm_tis_spi_transfer_half()
Message-ID: <d24qnjxzidsbi6oidx7fk5i7txinsxj5rthnzx4n2ylbblejtx@26n4ecbdgyqc>
References: <20250917153022.18567-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250917153022.18567-1-gunnarku@amazon.com>

On Wed, Sep 17, 2025 at 03:29:56PM +0000, Gunnar Kudrjavets wrote:
>When len is 0, the while loop in tpm_tis_spi_transfer_half() never
>executes, leaving ret uninitialized. This will lead to undefined
>behavior when the function returns.
>
>The issue was introduced when tpm_tis_spi_transfer() was refactored
>to call tpm_tis_spi_transfer_half() or tpm_tis_spi_transfer_full().
>While ret is properly initialized in tpm_tis_spi_transfer_full(), it
>was missed in tpm_tis_spi_transfer_half().
>
>Initialize ret to 0 at the beginning of the function to ensure
>defined behavior in all code paths.
>
>Found by GCC 14.2.0 static analyzer with -fanalyzer.
>
>Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
>Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
>Reviewed-by: Justinien Bouron <jbouron@amazon.com>
>---
> drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>index 61b42c83ced8..1b6d79662ca1 100644
>--- a/drivers/char/tpm/tpm_tis_spi_main.c
>+++ b/drivers/char/tpm/tpm_tis_spi_main.c
>@@ -85,7 +85,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
> 	struct spi_transfer spi_xfer[3];
> 	struct spi_message m;
> 	u8 transfer_len;
>-	int ret;
>+	int ret = 0;
>
> 	while (len) {
> 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
>

As an alternative, we can move the declaration in the while block where 
`ret` is always initialized, and we can return 0 at the end of the 
function since all the errors have an early return, I mean something 
like this:

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 61b42c83ced8..c78c0a2d0541 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -85,9 +85,10 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,            u32 addr,
         struct spi_transfer spi_xfer[3];
         struct spi_message m;
         u8 transfer_len;
-       int ret;

         while (len) {
+               int ret;
+
                 transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);

                 spi_message_init(&m);
@@ -135,7 +136,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,           u32 addr,
                 len -= transfer_len;
         }

-       return ret;
+       return 0;
  }

  static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,

BTW, I don't have a strong opinion on that, your patch also LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


