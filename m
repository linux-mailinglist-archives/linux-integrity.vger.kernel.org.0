Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB6AEE30
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfIJPLZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 11:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfIJPLZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 11:11:25 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09B0981F0F
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2019 15:11:25 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id h14so21110479qkl.17
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2019 08:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mjlmQ8q4ebSGeqcCwGl4CP2ghV+MJ2RVpTWgq9fAfiY=;
        b=MWfHBKpTE5FAIA8BGs+4Z4vqhQbjj4gbC/Xz6wVb4/Z6XVTzdEUZtFGqgGFNlPu+P4
         s9IevLXK10dnmog2wDfz0IX7HTeblK1W41FR9kBRrFcZSOvoYcxNn0ivspS3T86Nq+Ak
         8EbQUB1ylaYDTSX7KuCq9t9xL8LRADhabLsIbSeJOXsrPDbgDNw2DPwH74BEK/qORy6A
         Yikw6PA7Z5gVD5/j9CvNdkLTUW/nj26TldWU35wPbgMFniNtdyNXPWrq69QTEAWr1TNO
         CiuTvqWN6E/donsEbBi6V1Ytx/dXcPxlWDTq0Xw4/QdWRfE3StiUmfPVXur/kXvKEegg
         E4HA==
X-Gm-Message-State: APjAAAV185sY8xjKoa2f5G0nZ/7my3E4+dDR7Jr+cSicYMBBnxCgpgmx
        kCgSZ5ixsqhonjFHPk8tu/q65qSFz2TWaK5srTmwjMo4ZFmckKLXkzkwRblQpIq9/KEfyK4Bqux
        /8MmwJcqKj6RS6731w/S5AqwDQfmY
X-Received: by 2002:ad4:4246:: with SMTP id l6mr17975788qvq.140.1568128284315;
        Tue, 10 Sep 2019 08:11:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpuL3859rR0LE2rl/dgBb2h5pYNfUuwtFD0PdhTLyboBw9QPffFa+4gWJicHD8zJTrvwDs6A==
X-Received: by 2002:ad4:4246:: with SMTP id l6mr17975751qvq.140.1568128283949;
        Tue, 10 Sep 2019 08:11:23 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z72sm10001318qka.115.2019.09.10.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:11:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:11:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Call tpm_put_ops() when the validation for @digests
 fails
Message-ID: <20190910151121.3tgzwuhrroog5dvb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190910142437.20889-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190910142437.20889-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Sep 10 19, Jarkko Sakkinen wrote:
>The chip is not released when the validation for @digests fails. Add
>tpm_put_ops() to the failure path.
>
>Cc: stable@vger.kernel.org
>Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm-interface.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index 208e5ba40e6e..c7eeb40feac8 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -320,18 +320,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 	if (!chip)
> 		return -ENODEV;
>
>-	for (i = 0; i < chip->nr_allocated_banks; i++)
>-		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
>-			return -EINVAL;
>+	for (i = 0; i < chip->nr_allocated_banks; i++) {
>+		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
>+			rc = EINVAL;
>+			goto out;
>+		}
>+	}
>
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> 		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
>-		tpm_put_ops(chip);
>-		return rc;
>+		goto out;
> 	}
>
> 	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
> 			     "attempting extend a PCR value");
>+
>+out:
> 	tpm_put_ops(chip);
> 	return rc;
> }
>-- 
>2.20.1
>
