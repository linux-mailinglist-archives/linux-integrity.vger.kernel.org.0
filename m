Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3F492D69
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbiARSff (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 13:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244660AbiARSff (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 13:35:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CA0C06161C
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 10:35:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so20042026plh.13
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 10:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FaIaORNSz7XiJbleCuK1NUmRfZPUdajgr0r/v10ft40=;
        b=JKRND+wPYLCcyAzDO1KAQCZh/sZV8jXN5P7KsXPAiUvMkrJdqmkKMe21LGgmkC60wJ
         RBaUkPkRsMDEQPNJAxSCN6maYxQ8Vkiom1FrmmeS4dc5tDUwAlMdzqDLsbeE/ltJ2MK8
         HgD09inP/PWgqeDZEosczAFdnFtx83z2pb8LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FaIaORNSz7XiJbleCuK1NUmRfZPUdajgr0r/v10ft40=;
        b=UGo/JbnHRb3vUstjo4ievjzMzPhNofMj05Lsk/nOFH9XPKarpc3IoTD4h6LbwTePhk
         BXYi5dqHt/YnnqLudE4UgWjMjeXUAqjm+9mbRrm3Fp5MBtpbGVXJt/GX4vNS8QZG0M5z
         EFA9zgH8t7xfWnrVUjJmg1hz4wzJK+rNshFB5jR6KeAmfngHVKkFdRpwfkYGhHOLof/l
         pXPk2Lhvspga7uzYf72QGk3g2DjZ6tyoq/BjkisBCa2FPmnrYWlQPi4s3P0MTBhp3fg7
         04mcTGU5oqZfUi5QORXuwxDUQXEKpYM/Dv3bvNXDC1b2PadtltXOS0BbADV/knP3PyrZ
         v+yA==
X-Gm-Message-State: AOAM531ZkeuRTi7ax93oPAWdNqzklXfgOeo6j4aacBW7qZCe4W7krtxs
        rgVog2I8GVb8+G0R2R8rp74AZQ==
X-Google-Smtp-Source: ABdhPJzWj0MC3WxjUBAs9H6h5KZ3dTfa1s9aGT3n//kJgRttbimCUDBIt/amV11vg462BRCfp/QQWw==
X-Received: by 2002:a17:902:bd05:b0:148:a2f7:9d87 with SMTP id p5-20020a170902bd0500b00148a2f79d87mr29276085pls.166.1642530934336;
        Tue, 18 Jan 2022 10:35:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w70sm13371180pfd.186.2022.01.18.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:35:34 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:35:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tpm: vtpm_proxy: Avoid device-originated buffer overflow
Message-ID: <202201181035.2CF27A0262@keescook>
References: <20220113002727.3709495-1-keescook@chromium.org>
 <4b59d305-6858-1514-751a-37853ad777be@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b59d305-6858-1514-751a-37853ad777be@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 13, 2022 at 04:19:32PM -0500, Stefan Berger wrote:
> I just want to clarify this. In vtpm_proxy_tpm_op_send() we have the only
> place that sets req_len to a value larger than 0:
> 
> static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t
> count)
> {
>     struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
> 
>     if (count > sizeof(proxy_dev->buffer)) {
>         dev_err(&chip->dev,
>             "Invalid size in send: count=%zd, buffer size=%zd\n",
>             count, sizeof(proxy_dev->buffer));
>         return -EIO;
>     }
> 
> [...]
> 
>     proxy_dev->req_len = count;
>     memcpy(proxy_dev->buffer, buf, count);
> 
> [...]
> 
> }
> 
> 
> The above makes sure that we cannot copy more bytes into the
> proxy_dev->buffer than the what the buffer has bytes for.
> 
> It then sets req_len to a valid value that is less or equal to the buffer
> size.
> 
> Considering this your check above seems to only be there to make the
> compiler happy but otherwise I don't see that this is a real problem with a
> buffer overflow?!
> 
> Nevertheless, let all those compilers be happy:
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Ah yes, thanks! I'll reword the commit log for v2. :)

-- 
Kees Cook
