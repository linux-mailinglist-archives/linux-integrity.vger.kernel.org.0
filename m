Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387B1F1056
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFGXLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jun 2020 19:11:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56981 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727804AbgFGXLV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jun 2020 19:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591571479;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=KSlntCbluVS76b3g/z4HXEV6a3OnchHRiFcS+IdPIFA=;
        b=Jhdt8UIxqkUiOaRxrumbSpK928uwx3w/XU1AQd+xOSkimRFBEiuDsDRfW7ILNdSzYdOf6I
        5tiEMuilmuLsJ990C9RF1qoQQZrcUNN944wTCI+xiaoBpDllPl2UZFbNT0mfjO936lKRCk
        lf9AeX1gX6UgVYVtjKq7WdFV0HM2OuE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71--c84XtniPZ2zJNW4D26ITA-1; Sun, 07 Jun 2020 19:11:16 -0400
X-MC-Unique: -c84XtniPZ2zJNW4D26ITA-1
Received: by mail-qk1-f200.google.com with SMTP id x68so12917653qkd.1
        for <linux-integrity@vger.kernel.org>; Sun, 07 Jun 2020 16:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KSlntCbluVS76b3g/z4HXEV6a3OnchHRiFcS+IdPIFA=;
        b=BuVRdjG3osEGJiRsseCPXisDA7NswUNFS3fq6E3ChzYocjP/kuwYKradPjKZBYrF2l
         2uWkLZ6xdVB0mJ6CN8jVsRqi0ik/Ve+Pc75uon1jEXd3Wk8G42pAUrqNr1YHSbUUhD1h
         PHo4tYyBWDcWVUimrhXoWqB1QaeJkrVbFd/TMPq5VU5n8pazdU+ylKU48dApb1qR0m5e
         gvjPiY/jZsQBnvUzHW49WKavdIm9JYpi6eyjNxfKteNpPP/JPB4AJKeRArDdd2oBD1Y+
         dh7Q6BF8hzcJyBDbsF4djpvQDLkA6KDOYG+PEjzAxGh2A2mdokQ8/c86s5iRf6l/7bjp
         lalw==
X-Gm-Message-State: AOAM530qAVOFVofmWrH2t1be5QJjD4tmyTDQqMd+aShwi0ijpQ+OqiA6
        3RMhz33yQ9SHKGSr8wa5oCaBx6yzCaL1+X1VdtSq5MRH/ZFDoGj7a/93gvOdi2k+f9B0eq74Xx6
        ZWSwGTzdWVMQA4qhxu5vFub13lf8l
X-Received: by 2002:ac8:5648:: with SMTP id 8mr20542604qtt.280.1591571475456;
        Sun, 07 Jun 2020 16:11:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpekLdyoLa9wr0qytkS/wYSsoLBrj0PEk8/q8fKvEGGc7LPHx1/CyhX1FGA6tWiJ6toLo+tQ==
X-Received: by 2002:ac8:5648:: with SMTP id 8mr20542575qtt.280.1591571475209;
        Sun, 07 Jun 2020 16:11:15 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b4sm5249646qka.133.2020.06.07.16.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 16:11:14 -0700 (PDT)
Date:   Sun, 7 Jun 2020 16:11:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     torvalds@linux-foundation.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH] ima: Remove __init annotation from ima_pcrread()
Message-ID: <20200607231113.mocsa7wphkpleh7a@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Roberto Sassu <roberto.sassu@huawei.com>,
        torvalds@linux-foundation.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com, stable@vger.kernel.org
References: <20200607210029.30601-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200607210029.30601-1-roberto.sassu@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Jun 07 20, Roberto Sassu wrote:
>Commit 6cc7c266e5b4 ("ima: Call ima_calc_boot_aggregate() in
>ima_eventdigest_init()") added a call to ima_calc_boot_aggregate() so that
>the digest can be recalculated for the boot_aggregate measurement entry if
>the 'd' template field has been requested. For the 'd' field, only SHA1 and
>MD5 digests are accepted.
>
>Given that ima_eventdigest_init() does not have the __init annotation, all
>functions called should not have it. This patch removes __init from
>ima_pcrread().
>
>Cc: stable@vger.kernel.org
>Fixes:  6cc7c266e5b4 ("ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()")
>Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> security/integrity/ima/ima_crypto.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
>index ba5cc3264240..220b14920c37 100644
>--- a/security/integrity/ima/ima_crypto.c
>+++ b/security/integrity/ima/ima_crypto.c
>@@ -786,7 +786,7 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
> 	return calc_buffer_shash(buf, len, hash);
> }
>
>-static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
>+static void ima_pcrread(u32 idx, struct tpm_digest *d)
> {
> 	if (!ima_tpm_chip)
> 		return;
>-- 
>2.17.1
>

