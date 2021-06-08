Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4739FD04
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFHREq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhFHREp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 13:04:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E9C06178B
        for <linux-integrity@vger.kernel.org>; Tue,  8 Jun 2021 10:02:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so2669710pjq.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jun 2021 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=JlUf729Lw0qh8gpM+lacYrwI/BZHfR8iaIh6HWob68cqLRbEOcHJt9U9t2YgpQU93j
         5p+//oTnvpy2Z43uQrbn65F8sQfCvpsHOcdByFr2F9G3lB39uVlA7OfOv5iL0bwRwVfq
         YTTgYWPVApdUTu3XoW2nGATAhWdVzSTq61Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=S2CS4lZ29pIzdch1B6Fp8MacVG3hkBCPNhJ9JoWjS4z0fdMO6qlGBICAmY5IpfHiPr
         t55Vi44uIq9yKI/20q3AIMYaXxikEsaE1Ju+0B273JVn6S/BUSdDQiTqX/SmuLENstzc
         nMVnAE7a8IDkIbqmjFe0JzS3JjQheeA9ENb1MmNys/CiZnOnjCsP0BRPKxYM6N33EOVa
         hgW/hfyIeVG7mMI3pl4+uzpzJ3P5ptSPq5TyG6/B+7p/k68KeE9TSl7Hcm7maSHhojTa
         NrG6Ll0mTP2q4KcPn1HAB/lqx7RuMdLs9m0BGuqpvJVQge9mx77QA7WV0nX0FEYQ3ePv
         qrTQ==
X-Gm-Message-State: AOAM530V4qgg9sn+XcVMrYJKqw6MjoP7u/Vrp27flAj7LGkLpu6KiqjA
        +tKh0X4pv2RxI5hXotgoXNj3nw==
X-Google-Smtp-Source: ABdhPJxaSatIHX/sZrfjfZA+xFPKOXe2WFUxGqcRbH4r+NdC1vX/iNz1cah9e+xIGvpANxz9gqGpmQ==
X-Received: by 2002:a17:90a:b28d:: with SMTP id c13mr5823656pjr.80.1623171757403;
        Tue, 08 Jun 2021 10:02:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm11476540pfc.126.2021.06.08.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:02:36 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:02:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ima: Fix fall-through warning for Clang
Message-ID: <202106081002.252C11321F@keescook>
References: <20210607204934.GA63263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607204934.GA63263@embeddedor>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 07, 2021 at 03:49:34PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a break statement instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 13 in linux-next(20210607). This is one of those last
>       remaining warnings. :)

Looks right to me; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
>  security/integrity/ima/ima_template_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 518fd50ea48a..8f96247b4a5c 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -119,6 +119,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
