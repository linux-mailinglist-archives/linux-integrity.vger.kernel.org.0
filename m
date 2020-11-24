Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBCF2C1C37
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 04:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgKXDqu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 22:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgKXDqu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 22:46:50 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E36220857;
        Tue, 24 Nov 2020 03:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606189609;
        bh=EcGFcmnYI8V4Iu6RvWWsS3VaqzXHZFadxgW5irsjkDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wl2oJiOeH+FPELpTU7tIs3jiKdKiRf5ezWDqRNbFBZa4IbjWKQqLQY1pD2Sxy6gVw
         euuh/yw27IrPNY4Pic3rokqz57hLnyn/dk11+IQlwytMU3y3TGGX6biMZfaHRfMHbl
         GqkNMxAAOMtRGW3OQ1ayjYPgNX8WHWiojJVJqsLg=
Date:   Tue, 24 Nov 2020 05:46:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 4/4] MAINTAINERS: Add myself as Trusted Keys
 co-maintainer
Message-ID: <20201124034641.GC40379@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604419306-26105-5-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:46PM +0530, Sumit Garg wrote:
> Add a Trusted Keys co-maintainer entry in order to support TEE based
> Trusted Keys framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b..52687bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9732,11 +9732,13 @@ KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
>  M:	Mimi Zohar <zohar@linux.ibm.com>
> +M:	Sumit Garg <sumit.garg@linaro.org>
>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
>  S:	Supported
>  F:	Documentation/security/keys/trusted-encrypted.rst
>  F:	include/keys/trusted-type.h
> +F:	include/keys/trusted_tee.h
>  F:	include/keys/trusted_tpm.h
>  F:	security/keys/trusted-keys/
>  
> -- 
> 2.7.4
> 
> 

/Jarkko
