Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F88672DCB
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjASBCq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 20:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASBCp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 20:02:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B44C59552;
        Wed, 18 Jan 2023 17:02:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so4285720pjg.4;
        Wed, 18 Jan 2023 17:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzC0sU/N12ncEGDzD9fPcibOi5DmMLZMi0fdgF9XEqw=;
        b=AYtPSQ8/l89DagqqXtQI6yiVXSzsTcUBaQiMk2f1jiZyJ5ELiIGB0pZLTJnp8amdI2
         E9USP8ckmgFNAtbnEoOYYEmnUi5knwgQiQIsu+XBK87SrVt3G4Z7NEK00vhQjdlc4uAe
         cUWuQ9+EIWNEUEecO15jMDjh7K8C3W/p/vLOToGoVZwCyALXyYsxihbAnAW9nkojB1jD
         W4PyN1pMYXFeHmI2ySiO/3SOQnFtrWf3y7kddaOhygH3d8MNWuA//hY+i/Lb0SZ6YloL
         AS9FQBWer3V6rNXX0e0CrLQATvoZgKgHf3OyQiHAf0umnVjJScE+CMG+PuftHWcDfxSI
         KSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bzC0sU/N12ncEGDzD9fPcibOi5DmMLZMi0fdgF9XEqw=;
        b=DhtYQrVP7/6ydcAhzZh4GzL046UxGqzzP7Nx9dgmIEmU3b1dUS+sJIqoG+PKwylhxL
         ha1pxTBqFPFYQzwT7dvEF7goVqYWfXGHuBwLyRs2zxO01KxyCKqCFvWKqil16GJBdihy
         XvTsS+dXrMYsSa1SYpRR9ffR55HM3wMe0+xK9oczOL2qNfDC/IEC3nrOya5wK6mmQvGd
         1m/dbiEa8xcV1WTDvCBqdXPpTmYENnkKaZTYN7z4wpOti8H3W//XgqHvB9cFxEoyg56L
         o3Ox74GpxSYOlMCpc62rlmwKtEMB7ucy3bur3lcwgQXIap9f3gMjKDPeN6PYXjaaE2GB
         XrnQ==
X-Gm-Message-State: AFqh2krBdcYV4CugroocLyjefY8pTsdwM8YMR71qVwgzdLv0/pgheZ9o
        XRMo9vGZALst+b+BAiyZwpU=
X-Google-Smtp-Source: AMrXdXt4gseTnAfOPrChP9m2wVf26VWcohagyq74svl8eO9K6vlv12wRtzJHCZkfmem+ShkJYon6sA==
X-Received: by 2002:a05:6a20:ba87:b0:af:8e92:3eeb with SMTP id fb7-20020a056a20ba8700b000af8e923eebmr9175136pzb.9.1674090163920;
        Wed, 18 Jan 2023 17:02:43 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id e3-20020a63f543000000b004cd2eebc551sm5414418pgk.62.2023.01.18.17.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:02:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 11:02:36 +1000
Message-Id: <CPVRFKZUFEFE.3IPS9CFR9KPD6@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>,
        <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 04/24] powerpc/secvar: Handle format string in the
 consumer
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-5-ajd@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-5-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jan 18, 2023 at 4:10 PM AEST, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
>
> The code that handles the format string in secvar-sysfs.c is entirely
> OPAL specific, so create a new "format" op in secvar_operations to make
> the secvar code more generic.  No functional change.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> ---
>
> v2: Use sysfs_emit() instead of sprintf() (gregkh)
>
> v3: Enforce format string size limit (ruscur)
> ---
>  arch/powerpc/include/asm/secvar.h            |  3 +++
>  arch/powerpc/kernel/secvar-sysfs.c           | 23 ++++--------------
>  arch/powerpc/platforms/powernv/opal-secvar.c | 25 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm=
/secvar.h
> index 07ba36f868a7..8b6475589120 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -11,12 +11,15 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
> =20
> +#define SECVAR_MAX_FORMAT_LEN	30 // max length of string returned by ->f=
ormat()
> +
>  extern const struct secvar_operations *secvar_ops;
> =20
>  struct secvar_operations {
>  	int (*get)(const char *key, u64 key_len, u8 *data, u64 *data_size);
>  	int (*get_next)(const char *key, u64 *key_len, u64 keybufsize);
>  	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
> +	ssize_t (*format)(char *buf);

Maybe pass the buf size as an argument here? Which is a bit less error
prone and more flexible than finding the right #define for it.

Thanks,
Nick
