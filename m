Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EF672DC7
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 01:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjASA7W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 19:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASA7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 19:59:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC961683D1;
        Wed, 18 Jan 2023 16:59:20 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g205so313821pfb.6;
        Wed, 18 Jan 2023 16:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU+eYoCUYw7OUrQ34xBj/dGRvIDzcpEGZXWLrE7d4zs=;
        b=gz85+iNW2Y3eSbshAzxzfhFFiBk15RBYYo/Ta22Cx4vNnkGWBnv61NxZF0xrGZP/fd
         LaA+Uf5VWLMzLkiJwEDaP+bh/zwItSGvisR/Thh89Far9EXZssVWqeAuRqKLyJDhEbsS
         0hKFQw82MizFDTA6gDKiyiDOV8HssxWG11Fpukyy+wzf1SYfVnThV1z0P09wr6ipx1ay
         Npfy77cwwQ0eVt3CVdE5V+dLlYjXpFFF2wZE6VS6drERmj0Q0+PTz2kCBZww/gkVSAdQ
         Q+zi/+JSxaCsY/rnBk+T4KC9GpATG5f/5XlGEWFkk6KWqlwFAxPAWCAVAONGF2ADFCJc
         tRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JU+eYoCUYw7OUrQ34xBj/dGRvIDzcpEGZXWLrE7d4zs=;
        b=khGClFdjHYmHE3BDt/0hFUCsSNrrRDSOtn7eLVnwtahM317YSQl0pRYxWnL5hM23tt
         cUHJ6Y8LHjWDZ3yKnRAqadcy9Kfs+HO1Qer4a5Xdr9B81QsJlHQOAW3i2+A7zQrAkEy8
         aotK8ebNeVVv3DbKRz+URlq5peOTjtEpLJo5WODg3rZTb+TfJHx0feKUkZPHnZTLhjj7
         6oo2+9PYiggtcoEv55LCFtFRVHGUJIa1F5MnLFstaURdG4P4YsFFtjgCVoKPaMSen1bW
         SDkYn17S4kWHnYUWur4vtFbkicgwYmfUuTw0/qEw2RSsirz8es7VKhlB1NyT3DD3qf4E
         4muQ==
X-Gm-Message-State: AFqh2krk9vx2ehVvR0XlPLsUmYFGFATcMwMgBSHeUR27oemuwvha22bd
        4xGy7ssd2w45WKrfAUfCwHE=
X-Google-Smtp-Source: AMrXdXucjHz8FZFT/NIriPu9GE/0b4TrRV4+MCEE7H0qbs59fRDHyGXP1sClacAUrp2o7QCsUMenpg==
X-Received: by 2002:a05:6a00:4207:b0:580:eeae:e4ba with SMTP id cd7-20020a056a00420700b00580eeaee4bamr10242724pfb.4.1674089960161;
        Wed, 18 Jan 2023 16:59:20 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id 134-20020a62148c000000b0056bc30e618dsm22728931pfu.38.2023.01.18.16.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 16:59:19 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 10:59:12 +1000
Message-Id: <CPVRCZ8Z84K4.337F5K1N7RCRS@bobo>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>,
        <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 02/24] powerpc/secvar: WARN_ON_ONCE() if multiple
 secvar ops are set
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-3-ajd@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-3-ajd@linux.ibm.com>
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
> The secvar code only supports one consumer at a time.
>
> Multiple consumers aren't possible at this point in time, but we'd want
> it to be obvious if it ever could happen.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/kernel/secvar-ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secva=
r-ops.c
> index 6a29777d6a2d..aa1b2adc2710 100644
> --- a/arch/powerpc/kernel/secvar-ops.c
> +++ b/arch/powerpc/kernel/secvar-ops.c
> @@ -8,10 +8,12 @@
> =20
>  #include <linux/cache.h>
>  #include <asm/secvar.h>
> +#include <asm/bug.h>
> =20
> -const struct secvar_operations *secvar_ops __ro_after_init;
> +const struct secvar_operations *secvar_ops __ro_after_init =3D NULL;
> =20
>  void set_secvar_ops(const struct secvar_operations *ops)
>  {
> +	WARN_ON_ONCE(secvar_ops);
>  	secvar_ops =3D ops;

You could make it return error here and two line patch in the caller to
handle the error and then things wouldn't get corrupted.

Thanks,
Nick
