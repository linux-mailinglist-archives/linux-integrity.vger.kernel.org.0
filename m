Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C92C18E2
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 23:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgKWWwg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 17:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbgKWWwb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 17:52:31 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC152206D8;
        Mon, 23 Nov 2020 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171951;
        bh=kuDyYfFAzKwYCzre6viwIkFybY6f6EhC4LYo07GXriI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZUQ1x+Y0l//U0HqEsAC9TuQjVO3tF2E+PYXIGJvtJ9WxDt6TgFZUsLqO99dSdk8F
         xtUvn+iVUSvsDf3FOxwzPVCP4BAeqHXDjp6LySP+7G/xJE231xl9OrLD4kTCZpZN4t
         zsf/b+R10BAenQQFXaxiZdbbMiIsVHfnosiBJ7HE=
Date:   Tue, 24 Nov 2020 00:52:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 131/141] tpm: Fix fall-through warnings for Clang
Message-ID: <20201123225226.GA17124@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <1804f48dac434541dc60ada5eefcb86f74905671.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1804f48dac434541dc60ada5eefcb86f74905671.1605896060.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 20, 2020 at 12:40:14PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 2c96977ad080..8aa9057601d6 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -210,6 +210,7 @@ static int get_event_name(char *dest, struct tcpa_event *event,
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
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

Who is picking these patches?

/Jarkko
