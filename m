Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2471F1C989E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgEGSCV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728256AbgEGSCU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 14:02:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295BC05BD09
        for <linux-integrity@vger.kernel.org>; Thu,  7 May 2020 11:02:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so2968769pjd.1
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RcV9lFh0IW1N+XHaoImBLGRzG64WEmrZADnXXHQ+xEw=;
        b=FaGuhBOb8Z469hrDfs6vsVsvoQgKcxtPvTN256HuPR18U0yw2VUUtU8/pjPfcRCDEN
         sGQZ3k0HLtLtMtSGbBqPZQ2KN6pC/7KLzY/BJ+HtHbvlLLMOHudRKh1zoCjaJb2WE3lV
         GtqAPDel/iGBpnVwe8/QLWFa8wVii5Y+bFp60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RcV9lFh0IW1N+XHaoImBLGRzG64WEmrZADnXXHQ+xEw=;
        b=RHR4ALUFOXl2nldxGYYfNKKcSG9wqH2ZiBf81g7+5PgZYXXcD/wzBoxPAXg8Ualiwc
         nOnPTO2yB58BuAoKA5FRRdgVa9C3cL6bWaBk+cASJq/H49Cv9G3Q4G7531FX3lpfI9JL
         J5CdKb6AhT5C3QPjuyk92oy67MuDS6Gaa5XlwOst1wNHuCd+qEzZuMveO8F/Zi7dIzNx
         CWas2QR1ysrXmnMFx4OdA8iPhFNXdd/Fd8wcDaKfY/Z1WtxGUbdr7gGlDKTCYSI1/etX
         XCsCcTIYIJJmEBR1U+m34N5+OfG2LLVdsfLYnuin8bFaWBjfPFSBlqg4Pr2IzDjUO/9J
         GXBQ==
X-Gm-Message-State: AGi0PubJthLH6V7jguM/nYrlxcloIY3jV9z3RCwLZZl4yjDbSh7q8t+9
        hhKgnfhFInVFNlWnRIWONrlDMw==
X-Google-Smtp-Source: APiQypJKk+TbElDSjc9LxL9Q/oaEJix7niFewv4zimIZp6EwRkySvviGZeAu9Fq+9oA2ikbs9CHxWw==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr1327983pje.93.1588874540257;
        Thu, 07 May 2020 11:02:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b75sm421141pjc.23.2020.05.07.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:02:19 -0700 (PDT)
Date:   Thu, 7 May 2020 11:02:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <202005071058.A2234694ED@keescook>
References: <20200507040912.GA31382@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507040912.GA31382@embeddedor>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 06, 2020 at 11:09:12PM -0500, Gustavo A. R. Silva wrote:
> As mentioned above: "Flexible array members have incomplete type, and
> so the sizeof operator may not be applied. As a quirk of the original
> implementation of zero-length arrays, sizeof evaluates to zero."[1] So,
> the sizeof(flexible-array) can be safely removed to fix the error above.

As in "sizeof(event_header->event) always evaluated to 0, so removing it
has no effect".

> [...]
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index e741b1157525..351a2989b3c6 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -51,8 +51,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  	int i;
>  
>  	event_header = addr;
> -	size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
> -		+ event_header->event_size;
> +	size = sizeof(*event_header) + event_header->event_size;

That said, I think it would be better to stick to the struct_size()
idiom for dealing with flexible arrays here:

	size = struct_size(event_header, event, event_size);

-- 
Kees Cook
