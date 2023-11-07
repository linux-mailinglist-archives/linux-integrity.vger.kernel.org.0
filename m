Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA97E46AC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Nov 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjKGRU6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Nov 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRU5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2023 12:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EBDDF
        for <linux-integrity@vger.kernel.org>; Tue,  7 Nov 2023 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699377608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BzU3dDdSH7oEfLk2Y642FIj/xbly1n4FfWSInGGOWQ=;
        b=Z/Djiz2zfR+XjEXvucrJwHpuQxi4tjChDjSZdYAHiQuf5bDnf6pT6Et5J6eYW0FHNlIaIf
        5vQzWm0FH2TubqKZ3k3xwxb6FbUaJf7HOAigZw0iTEJbU55n1q3mo61WCIQyQ3n4biI9d4
        wYfijnx97XDkEOW6MGpe0+vWaCrRb0U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-b8sjUMr8NFCwYcuSGz5hjg-1; Tue, 07 Nov 2023 12:20:06 -0500
X-MC-Unique: b8sjUMr8NFCwYcuSGz5hjg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cd433742dso73118101cf.2
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2023 09:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377605; x=1699982405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BzU3dDdSH7oEfLk2Y642FIj/xbly1n4FfWSInGGOWQ=;
        b=SeBIiP/6pXLt2wfX7H8opW0RePnH/LVER4hT59cMYj6YlsLZfxss5c+YxVt9aZNN+l
         6p4rdMaBuioPyB+OzPfh9T3/7rIs5rwjrnY+4awuMkfhjqAp/7bNz4idQAdlqszI4nG3
         tbHlDMySV95mMeJ6Dq7025zVsfa0tLjv6Bzdo0zNwJsKKmQxBFnXg7M2sDS3ziu1euYU
         WQurbWKYQ73SPF9xec1VF4j5dW9m2MZmtO+Hwo/0FGclU2ZqGrXz5scBXWnbixy15wsH
         7TnrYTAqWklnOjnGF6U3DtXloge4QNaA/5KFFHKSHdyVtwS+AfHyP8CJen+mrXBQjCni
         MklQ==
X-Gm-Message-State: AOJu0YypF4anLF8htybENdkgCQMCbY68ZSCjyFAn2W9cQ4oSDLdqMd30
        38kDCm7xWElhWlLuDvfK/nVek5OqX24TIUqFgnG0J3lQCv5Qcvm/4bUvR14IoIWpyLga0Pma/Uw
        7jGo+QhyQHNVqTzASELHfjoVfgnPl
X-Received: by 2002:ac8:7f0a:0:b0:419:4c21:d706 with SMTP id f10-20020ac87f0a000000b004194c21d706mr41838467qtk.23.1699377605715;
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmk5NphBaKNBHbqE52Hw8MNilCJ0v2xrcEj47TC7u8ivcNr/mb5kCdrz4mKADOyy+M6i9epw==
X-Received: by 2002:ac8:7f0a:0:b0:419:4c21:d706 with SMTP id f10-20020ac87f0a000000b004194c21d706mr41838445qtk.23.1699377605471;
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p25-20020ac84619000000b0041cbb7139a9sm81308qtn.65.2023.11.07.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:20:05 -0800 (PST)
Date:   Tue, 7 Nov 2023 10:20:03 -0700
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] tpm: Support TPM2 sized buffers (TPM2B)
Message-ID: <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-5-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-5-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 24, 2023 at 04:15:22AM +0300, Jarkko Sakkinen wrote:
> Add boolean parameters @alloc and @sized to tpm_buf_init():
> 
> * If @alloc is set to false, buf->data is assumed to be pre-feeded and
>   owned by the caller.
> * If @sized is set to true, the buffer represents a sized buffer
>   (TPM2B).
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c                | 32 ++++++++++++++++-------
>  drivers/char/tpm/tpm-sysfs.c              |  2 +-
>  drivers/char/tpm/tpm1-cmd.c               | 14 +++++-----
>  drivers/char/tpm/tpm2-cmd.c               | 22 ++++++++--------
>  drivers/char/tpm/tpm2-space.c             |  4 +--
>  drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
>  include/linux/tpm.h                       |  3 ++-
>  security/keys/trusted-keys/trusted_tpm1.c |  4 +--
>  security/keys/trusted-keys/trusted_tpm2.c |  6 ++---
>  9 files changed, 51 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index fa9a4c51157a..f1d92d7e758d 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,22 +7,32 @@
>  #include <linux/tpm.h>
>  
>  /**
> - * tpm_buf_init() - Initialize from the heap
> + * tpm_buf_init() - Initialize a TPM buffer
>   * @buf:	A @tpm_buf
> + * @sized:	Represent a sized buffer (TPM2B)
> + * @alloc:	Allocate from the heap
>   *
>   * Initialize all structure fields to zero, allocate a page from the heap, and

Depending on what the decision ends up being on the bools, flags,
separate functions, or wrappers possibly an "if needed" should be
tacked on to the end of "allocate a page from the heap" here.


Flags would be better when coming across calls to the routine in the
code than the bools, but I think switching to wrappers around
a __tpm_buf_init for the different types would be good.


>   * zero the bytes that the buffer headers will consume.
>   *

