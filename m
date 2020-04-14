Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA21A8C73
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632797AbgDNU2X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 16:28:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50155 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633118AbgDNU2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 16:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586896081;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=p9TpLNBdviwoTPvCd6HwdAiAsgTDf+tnQwjKV/KP1bE=;
        b=ar1NkpXDnJGyEZF1rIS5P8of8w3AL7dsKMIZVq99gdDD/5ubZ9QJoJZTvLRjGPGS3o3YQt
        GZoXg+AcJ/qKX7JULG7kuFlthP6mChUzIggORLVwyueld+s8R7WAiOzrx6q5wa1gi0FTdR
        FQM/58WfAwrXucms6uzsBQVs5XtOJl0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-pRJiwp6MPVKic0-1UUFhTA-1; Tue, 14 Apr 2020 16:26:40 -0400
X-MC-Unique: pRJiwp6MPVKic0-1UUFhTA-1
Received: by mail-qv1-f69.google.com with SMTP id y18so982185qvx.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 13:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=p9TpLNBdviwoTPvCd6HwdAiAsgTDf+tnQwjKV/KP1bE=;
        b=m8JdxGN4oA16c+rMcZ3d1UJ1PcQjaU+XX9aFJ0IcXbcV9EzvUmwCPuS53PJVsg4ZOl
         CKXOUPNl13b+UHFSd2PcpedJQDwVnqgu5DjNflAgYI3nw3qwbj5KonZiWggJtzNJe+6c
         DafVqtcAMRMtml8XhcxJnVd8/GY5u9SNooeLo4QHZtjAefrgq17QHMD3/WZIxvUX4oru
         OjqU1kgiUYkIAhMe8nNHzEj4Hp8r9lyFSM37DbewhrPvswocUNmFf92N5/OshlaCSHBn
         t/X5qe/QITEYk2xVbsRfdJpPrJ1UcClDKlGCYF1RPY1OpyTISmxjLYuwr8k9Uw3L5bNk
         Xf0Q==
X-Gm-Message-State: AGi0PuZkqQlNjLLK90zh4ZRSm1/7I3d5S1T6zx5HCh20mKIOsLkNz/Xr
        JJHAOfI7wOu/jLldEyS6lZo3LDhR8DVGq4HQlt7QtJq65L8cfXna9eebceqaRt75LcAuEogUPem
        hve+bPUnkSy0rwtbMAcVBHLIvpQzt
X-Received: by 2002:a37:4d43:: with SMTP id a64mr21132515qkb.55.1586896000164;
        Tue, 14 Apr 2020 13:26:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdpcrABXmZxnkowDDGciffEPiMY56MFLXYSgsbGyO9CrWBD6FPOgLLxiNf1ltOhPEA3yvigQ==
X-Received: by 2002:a37:4d43:: with SMTP id a64mr21132489qkb.55.1586895999934;
        Tue, 14 Apr 2020 13:26:39 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p22sm1630458qte.2.2020.04.14.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:26:39 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:26:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        zhang.jia@linux.alibaba.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200414202637.bsr3yccjq6mpflmp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        zhang.jia@linux.alibaba.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Apr 14 20, Tianjia Zhang wrote:
>For the algorithm that does not match the bank, a positive
>value EINVAL is returned here. I think this is a typo error.
>It is necessary to return an error value.
>
>Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm-interface.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index a438b1206fcb..1621ce818705 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -323,7 +323,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>
> 	for (i = 0; i < chip->nr_allocated_banks; i++) {
> 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
>-			rc = EINVAL;
>+			rc = -EINVAL;
> 			goto out;
> 		}
> 	}
>-- 
>2.17.1
>

