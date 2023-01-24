Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9182678FCB
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 06:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAXFYk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 00:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXFYj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 00:24:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757542DE60;
        Mon, 23 Jan 2023 21:24:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so13658621plr.10;
        Mon, 23 Jan 2023 21:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPflxlzn7J3IhwXMqkbeD44ht96unETWIQ75Qp5FCss=;
        b=ZfxguGrgsLcY0Sq2+g0kbtCLDOQn3UY9YpncBNNH3WXAXs6UuShB7ggTMjxNLWBRjS
         4S2X4T6qfadLoMDptTXfGxpyzDxNWD0Mvm6hXftn2Lo1du7fO/Wgelose8ln1gXxxAnV
         1ufbzEVQ1fiSBbzhMDfUDsZRajZhptf2gdv4k5wJZ3zuhE/qJ94/PW6HVgFQwyCBJkih
         J2w2im5PbQOYqqfvagGdJqgoYAIFOzd3c57/LwIlI/igZvZSBJZVoxo5fvn/y9QHxZXS
         6RgHH6s63RFqcET7pCffXuuFWsoLNKYoKi47uZwKzlT5UZMJkVSxosnChe+QDzKFoFtL
         rpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EPflxlzn7J3IhwXMqkbeD44ht96unETWIQ75Qp5FCss=;
        b=1QTVPrzgpp7VYXqWBvN/8xusGEaXwAA5IA1Pl8nPkNrM+8ptx6pc0s2n2mZd/50Fkx
         2cA2RCoKriFbHd3NCXRS2U8UVoxOakdlN56wNO7JnAYuODtKPVeXDsT4he8ZcbxNiuIF
         65JYzrV5l260RHZp7K1SGOM6rPE7x1PLUuQOf7njJKpaZOb3fCf/Q1tkqI1muHUMzeCa
         hKuliaJYCU5KVYUuXDAQo+bulpFu10Nrlnvt3QSUjdF93pU9TTfJv5NHucYtFnzBelgN
         PiQjwi8Sn5vGS1CNBybIl8XaY4cH6GpQLW9B+l0BYW5LUUY32FTwTpzefUWp4/lAHCK7
         opnQ==
X-Gm-Message-State: AFqh2kqKnHJbbpKTYEVadRPjYbyUcRUPtd4UvUnURbdfzs4Gk5oTGekG
        cInCBwceIlchWBFl1VwQKj4=
X-Google-Smtp-Source: AMrXdXsxQsqTnL+GRVS6OYc23i7BV4V8GyCJ1wcsXO8yFBZz0e4RWJrhVbXXTmgGKft8W5rGH5tVOg==
X-Received: by 2002:a05:6a20:3d0f:b0:af:9539:a2c0 with SMTP id y15-20020a056a203d0f00b000af9539a2c0mr35468533pzi.26.1674537877942;
        Mon, 23 Jan 2023 21:24:37 -0800 (PST)
Received: from localhost (121-44-64-35.tpgi.com.au. [121.44.64.35])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b00196047fc25dsm657743plg.42.2023.01.23.21.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 21:24:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 15:24:25 +1000
Message-Id: <CQ064REW0ZEO.1LUHVNN78TBRJ@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>, <ruscur@russell.cc>,
        <gcwilson@linux.ibm.com>, <joel@jms.id.au>
Subject: Re: [PATCH v4 24/24] integrity/powerpc: Support loading keys from
 pseries secvar
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-25-ajd@linux.ibm.com>
In-Reply-To: <20230120074306.1326298-25-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 20, 2023 at 5:43 PM AEST, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
>
> The secvar object format is only in the device tree under powernv.
> We now have an API call to retrieve it in a generic way, so we should
> use that instead of having to handle the DT here.
>
> Add support for pseries secvar, with the "ibm,plpks-sb-v1" format.
> The object format is expected to be the same, so there shouldn't be any
> functional differences between objects retrieved from powernv and
> pseries.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> ---
>
> v3: New patch
>
> v4: Pass format buffer size (stefanb, npiggin)
> ---
>  .../integrity/platform_certs/load_powerpc.c     | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index dee51606d5f4..d4ce91bf3fec 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -10,7 +10,6 @@
>  #include <linux/cred.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
>  #include <asm/secure_boot.h>
>  #include <asm/secvar.h>
>  #include "keyring_handler.h"
> @@ -59,16 +58,22 @@ static int __init load_powerpc_certs(void)
>  	void *db =3D NULL, *dbx =3D NULL;
>  	u64 dbsize =3D 0, dbxsize =3D 0;
>  	int rc =3D 0;
> -	struct device_node *node;
> +	ssize_t len;
> +	char buf[32];
> =20
>  	if (!secvar_ops)
>  		return -ENODEV;
> =20
> -	/* The following only applies for the edk2-compat backend. */
> -	node =3D of_find_compatible_node(NULL, NULL, "ibm,edk2-compat-v1");
> -	if (!node)
> +	len =3D secvar_ops->format(buf, 32);

sizeof(buf)?

Thanks,
Nick

