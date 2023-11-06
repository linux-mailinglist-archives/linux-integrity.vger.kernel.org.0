Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20807E2D0C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Nov 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjKFTiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Nov 2023 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjKFTia (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2023 14:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4E1984
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2023 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=EYOBcFjY6OjVjGv6ihC1eycf8uY4S2lYKKRrSXZSXz1kMYo+IbhW3TrK0V2/4Xg815pXiZ
        TFMNBD5UF3UBF0rhnq0u2xJDTN9Wy/BM3HXE/H7Els91+HH/ObOBYlrYzue0Bgy3KF1Xbk
        u66RR3+RR9E14XTSpEsaAdZOhJPeWX8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-lStVJirSNhiyKzFr9ljlQg-1; Mon, 06 Nov 2023 14:36:32 -0500
X-MC-Unique: lStVJirSNhiyKzFr9ljlQg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778964b7c8bso530345185a.1
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2023 11:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299391; x=1699904191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7nXQhaGb4pY7ry3e+e6wtXTEqqn1g4LsKBGCFFbdOs=;
        b=V+oktx9Zq1k12iXPEZhCgWznbw+Wq/qxCk5b0IGz0SzEP4/Se5qKfCeEwkLoIwKp/2
         GOvkDJFr7lVvpArEQm6EMmpmcgcrWmt8eetQs1XV5GdiT4jDdJYMepe4fXl6DXZJWjS3
         3Ve7p+xua7phihZRe2ICDJbsZF/hUTS+JcbAfNlidiM/QT9iXUBGud8RSxJsQRhD7ciD
         SrDportS1TXf442bgIBkDo8jw8HzFCMTG0NofBlZJFVlaDstHw2xjbniSVqJEz2lPSlH
         +EM5jcgyATSg+0gjbzqK/N+M5E3vFIg8c0Tqm1VyM5A1mNYnHosS9X1Abf/YNqzX5Lts
         ovOw==
X-Gm-Message-State: AOJu0Yzy7sirLB3uThhZIkC4NnIkM11qat+6W+R+XRmH1/shp15zlAoE
        ZxjAJlfGJnbdjZkmjobj7pGoaCkq4pDe8WzBkIAssWAfrmOueegMAMHCe4Y+ztWG/9D+1ZEHnz/
        ASudzKVGit1OF7r7qpWKimcKTtmauBBi/dwwc
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927589qkk.39.1699299391180;
        Mon, 06 Nov 2023 11:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNkybdYX04EQtC/tz+Zpa+0fOVbb/hUPD57Vng3tHmEY+2ovmvEntRX3G/+cgNqoXu8DTZmg==
X-Received: by 2002:a05:620a:118e:b0:775:f1bd:f75e with SMTP id b14-20020a05620a118e00b00775f1bdf75emr29927560qkk.39.1699299390943;
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b00774133fb9a3sm3537442qkn.114.2023.11.06.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:36:30 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:36:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <4gyb46g6makecsv7mq67qdp5hilytpymvdbffz5q64tday5dva@wjg3achi5rrv>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 24, 2023 at 04:15:20AM +0300, Jarkko Sakkinen wrote:
> Both TPM commands and sized buffers (TPM2B) have a fixed size header, which
> is followed by the body. Store TPM buffer length to a new field in the
> struct tpm_buf.
> 
> The invariant here is that the length field must always contain the total
> length of the buffer, i.e. the sum header and body length. The value must
> then be mapped to the length representation of the buffer type, and this
> correspondence must be maintained.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c                | 36 ++++++++++++++++-------
>  drivers/char/tpm/tpm-interface.c          | 18 +++++++++---
>  include/linux/tpm.h                       | 10 +++----
>  security/keys/trusted-keys/trusted_tpm1.c |  8 ++---
>  4 files changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 88ce1a5402de..8dc6b9db006b 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -18,6 +18,12 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_init);
>  
> +/**
> + * tpm_buf_reset() - Initialize a TPM command
> + * @buf:	A @tpm_buf

One minor thing I meant to mention, did you intend this to be &tpm_buf like it
is for tpm_buf_append?

Regards,
Jerry

