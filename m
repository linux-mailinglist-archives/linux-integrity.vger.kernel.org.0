Return-Path: <linux-integrity+bounces-7314-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BDBACC8D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B534732183C
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F82F9C2A;
	Tue, 30 Sep 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+BwZwui"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA72F83B8
	for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234297; cv=none; b=GCuPpACyLQ8JTSjbgbQ5gNha2TQWSIhqTKxD1XxXiuBGjUm7bU/exjU9K1aYLsqPa8dOqkx+xttr9Mfso7PhUcS4qZLHUV0XnYAaUWU5hEi3LfJ4nxBfzohJIJQeqcmgLxKi6s03lP/1BKfKZ2lkNXMOKDtDzlYuFkOw0Acneoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234297; c=relaxed/simple;
	bh=KD8kMWmVHWif/IAatoSGDNampJhPM/CNfGdxYnMKEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnV0v0sqBjMY0xcOIaQCk8dGjU58NW6h9Ze/9ROSBcim1cUtk0w8CZbLxjXzV+xxW7+7Zhgviuz1j/TDgrEHSHMU50qdHqblzH3HVoMdCBGROJTEt1AqhKNQJA8Onk0klJKAWWQI9CZb6wQN+l4a6AgtTJkkxuSiDXa9Ifkp6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+BwZwui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
	b=T+BwZwuiV2Pru8tXb9LrYzjnIlVWWvosEUz0SLLPGnpWZZ4C3Zn3U09fOM1PkJ2Tc6VMYz
	tlYVSQqFkkiX37neMvoY5k0c0Hz/SRFAe5E0siTHM4zmmpOMOg5nCWSSGUbYB7S7yzPTNe
	z7j/anwpJnT0D51aTlq0tzizZXeWKcU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-MWpmLqScNAG5jH_WXcQrHQ-1; Tue, 30 Sep 2025 08:11:33 -0400
X-MC-Unique: MWpmLqScNAG5jH_WXcQrHQ-1
X-Mimecast-MFC-AGG-ID: MWpmLqScNAG5jH_WXcQrHQ_1759234293
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-632d1317f48so6957232a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 05:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234292; x=1759839092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
        b=oTcZo5KvmoNQu6AL8DD9DNifhgqIBWjHG8PGwWfYwD58WQSZ68jE/yEgtzbSRyzW7o
         PS0S+j0/xakXpVk2GoOn1wpfM+5MyKEq5I2FlpZ9mv5OORnVysFxvAdhpKiQ7hIjIVb3
         bONa4f0CDn81ZxWY5nar8nx3h9/G13zE+13DEVQYSmO/RF9+NNiHSniZP/D709UXATVt
         8rY0U9VswpSc6tJLWG7qfpRvt0R4Z3fT5NN0aqugA6Uz4BZSX+mH0x7+SvB5FVDruo1K
         bj18go0M4TGrs6JZlL9NNVBXZC+tMmWyutvZk06kKn3gM9ylTioKAoTHcf6N+azozgck
         pKGA==
X-Gm-Message-State: AOJu0Yz62h7i8qDkxiKAZ56GmN4/QEj2Ipj8c8vWi0m9hFzOChOfzmDJ
	mVgZgDNO7F/BuqguKgStvRzD5y0XOlXiLsA7GEwLgv7OrM2krr0S2q32X36MJCs0kabDtq5Y4QB
	/l1qy8ahCmJYIXFHodfwkLMkgcBF7nQTp31HpPwB7mHGoyaqO+tAeeGp+or09/Vn+g7FxEQmCcD
	z5HA==
X-Gm-Gg: ASbGncsj2FK8nhSEw7CI7dBtxiGTxkNeOSXBiHCKTB7k3FbtD8n4hbLPszoPxZfxYqq
	uPrtKCG/1A0wimJEacwimc5bb2hP+n/Ak+CyCob60xQMWgnmIP8gBk25wekFpTbcKcO0WtbB0GO
	zh1PByDQxa+jCa9zT9qhVdnnZ4iz9wUl+7so74VYWlO3kBZS0pU0gB8RoElzMOpW4CVuU67ByGT
	SbJiTLlOSRmRs57psQD+qHk/4rC7przeZwuwD5t+8rN0HBqru3XYA1oBQfKbBeMe8fsP1JnBWQd
	JSK05NsubT6YX0XQC3kQxXNFfbeXzJLqNz1oshR4wxsYcRS3bmgxC2LAIRwGbZJtRlmVMAYAgF6
	pZ4+BW2lKp5TW3obX3vt9/A==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899897a12.26.1759234291453;
        Tue, 30 Sep 2025 05:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpBFHlpi6h26vswLogB4lR1OKDkES+l20vuTxXnbWfysRnTRsji62rg1W2cZYzxCghNaMmAA==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899850a12.26.1759234290960;
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b02ccbsm9498953a12.45.2025.09.30.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:11:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <hjay4b2lomj6k63tbnuk55q6mm4sdj2d7yycw64ybhu372l6bd@uqetr6ipbtg4>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-3-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:24PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT as the tpm_ret_to_err() fallback error code causes makes it
>incompatible on how trusted keys transmute TPM return codes.
>
>Change the fallback as -EPERM in order to gain compatibility with trusted
>keys. In addition, map TPM_RC_HASH to -EINVAL in order to be compatible
>with tpm2_seal_trusted() return values.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- Removed fixes tag as it hardly categorizes as a bug fix.
>v2:
>- Split trusted_tpm2 change to a separate patch.
>---
> include/linux/tpm.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

LGTM now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index fc7df87dfb9a..51846317d662 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -453,8 +453,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 		return 0;
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
>
>-- 
>2.39.5
>
>


