Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840B628C73D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgJMCrX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 22:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgJMCrW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 22:47:22 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60396208B8;
        Tue, 13 Oct 2020 02:21:59 +0000 (UTC)
Date:   Tue, 13 Oct 2020 05:21:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com, dhowells@redhat.com,
        jens.wiklander@linaro.org, corbet@lwn.net, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-ID: <20201013022157.GA47751@linux.intel.com>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 07, 2020 at 03:37:48PM +0530, Sumit Garg wrote:
> Add MAINTAINERS entry for TEE based Trusted Keys framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48aff80..eb3d889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9663,6 +9663,14 @@ F:	include/keys/trusted-type.h
>  F:	include/keys/trusted_tpm.h
>  F:	security/keys/trusted-keys/
>  
> +KEYS-TRUSTED-TEE
> +M:	Sumit Garg <sumit.garg@linaro.org>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Supported
> +F:	include/keys/trusted_tee.h
> +F:	security/keys/trusted-keys/trusted_tee.c
> +
>  KEYS/KEYRINGS
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -- 
> 2.7.4

I'm sorry but I think I have changed my mind on this. This has been
spinning for a while and sometimes conclusions change over the time.

I don't think that we really need a separate subsystem tag. I'd be for a
new M-entry or R-entry to the existing subsystem tag. It's essential to
have ack from someone with ARM and TEE knowledge but this way too heavy
for the purpose.

I also see it the most manageable if the trusted keys PR's come from a
single source.

/Jarkko
