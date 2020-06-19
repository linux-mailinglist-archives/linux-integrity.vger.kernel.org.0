Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8686D2000E8
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 05:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgFSDmr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 23:42:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57777 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgFSDmr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 23:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592538165;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=28QQhWqRGlKtVSPRIgoEL6SC7gfBRze3wXuD/kfRWpU=;
        b=FoA0KjGEjR0M9yDAP57y3hL/hldlee3AlTE97LtmsJix3ZAugUDR3U8DAQe3oxTarp3y8O
        DJss/P3TOuYQ0Cbgqy9oDaEy1A1tmNnbb7tMrbZ2OWE7lDJJJ+4RmQZaoBsnXkBYZdVaAZ
        ftSNnEH0BnjU6XmCVw9mgCxTha8udIY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-R7ADbhkGPyyOjUq3XklxEQ-1; Thu, 18 Jun 2020 23:42:43 -0400
X-MC-Unique: R7ADbhkGPyyOjUq3XklxEQ-1
Received: by mail-qt1-f197.google.com with SMTP id x21so6068029qtp.16
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=28QQhWqRGlKtVSPRIgoEL6SC7gfBRze3wXuD/kfRWpU=;
        b=l34w3kOG/xOSXKoVdztzlHqq5QGgq7ya/X1THrvNeXtg37XmCMvo8e15uVP2/6j3PD
         f1C0RABMN8Lr6py46We+n33IGx61Yu8Bc33QTDIsf8POdU85VANv+gDcMkevMAAHu/UG
         j2GDIQgD6H8abCOnwAohluNOaFrDT5nMrZzLMlPW3A9rZXWwLdyhhcimFl7GIZwZISgx
         BE3TE46tlubk12hh7m+t8HKmO7Gcw5aNsJ3dkqhnUtluxBbvQBmQW0mOxhiPyB6u8PAZ
         hLXXS7zZbbIVAkdBkNp9Xiy278cHR8BogwZLoeXLrqqqGMjkPpCzKKaZDx3C41XnT7so
         +aHw==
X-Gm-Message-State: AOAM530lil68Kj+wYInAk7w2Ljwkz8zx3MbCMMOCD85XrE5eKH6Q5tqF
        CZKrcsQmv1RfrpMN4VqSl9K2mdGpj1pTi3k6umDFHR3OOxu6on5sy/G2itqaAQNomr7D7aX/+Pr
        JbpvjYjddUjHPwblmA91G9RwMkuT0
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr1701667qkk.120.1592538163401;
        Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEdCt+tIxvWhB4ftv3tYaBoyyRuWID8OfhggBjQxCeKOfezWy9w7oOYhRS+zMVygilIx2xyg==
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr1701654qkk.120.1592538163097;
        Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id o144sm5112725qke.126.2020.06.18.20.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:42:42 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:42:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     jarkko.sakkinen@linux.intel.com, stefanb@linux.ibm.com,
        mpe@ellerman.id.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
Message-ID: <20200619034240.xcl56oboxurym4jm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        jarkko.sakkinen@linux.intel.com, stefanb@linux.ibm.com,
        mpe@ellerman.id.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200619033040.121412-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619033040.121412-1-david@gibson.dropbear.id.au>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 19 20, David Gibson wrote:
>The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
>which will need the use of the internal command/response buffer.  But,
>we're issuing this *before* we've waited to make sure that buffer is
>allocated.
>
>This can result in intermittent failures to probe if the hypervisor / TPM
>implementation doesn't respond quickly enough.  I find it fails almost
>every time with an 8 vcpu guest under KVM with software emulated TPM.
>
>To fix it, just move the tpm2_get_cc_attrs_tlb() call after the
>existing code to wait for initialization, which will ensure the buffer
>is allocated.
>
>Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
>Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>
>Changes from v1:
> * Fixed a formatting error in the commit message
> * Added some more detail to the commit message
>
>drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
>index 09fe45246b8cc..994385bf37c0c 100644
>--- a/drivers/char/tpm/tpm_ibmvtpm.c
>+++ b/drivers/char/tpm/tpm_ibmvtpm.c
>@@ -683,13 +683,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
> 	if (rc)
> 		goto init_irq_cleanup;
>
>-	if (!strcmp(id->compat, "IBM,vtpm20")) {
>-		chip->flags |= TPM_CHIP_FLAG_TPM2;
>-		rc = tpm2_get_cc_attrs_tbl(chip);
>-		if (rc)
>-			goto init_irq_cleanup;
>-	}
>-
> 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
> 				ibmvtpm->rtce_buf != NULL,
> 				HZ)) {
>@@ -697,6 +690,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
> 		goto init_irq_cleanup;
> 	}
>
>+	if (!strcmp(id->compat, "IBM,vtpm20")) {
>+		chip->flags |= TPM_CHIP_FLAG_TPM2;
>+		rc = tpm2_get_cc_attrs_tbl(chip);
>+		if (rc)
>+			goto init_irq_cleanup;
>+	}
>+
> 	return tpm_chip_register(chip);
> init_irq_cleanup:
> 	do {
>-- 
>2.26.2
>

