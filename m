Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED05FC270
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 10:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJLIyX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJLIyB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 04:54:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B730B97B4;
        Wed, 12 Oct 2022 01:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E793B819D0;
        Wed, 12 Oct 2022 08:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CCDC433D6;
        Wed, 12 Oct 2022 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564739;
        bh=jlyAJtmCR8ZWkVcxBk7C7KpvDq/ZundskWWe+5hPx2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8lXhZfRVcF2qxnlvxyWO+zxwhfmjU/pQncOgsTi5A1I+TIRYhdy4akxBXJEUU1/r
         IAYRYhZwaqMZBg1aB1xgyuiOHK4/x3i03PqsDDWRuAHTjB8sI56bWKhMUdP260NQse
         BuwF5BdNuMpOL++ePlqTfnVOsarxs0KesGqkJ1XFZS56yLlzCH3p0kKNuvPq4wb6w6
         zkFkgALlemphkOzByRYpQufQGJ5/UsP6xIQBcNCxYce6HFKfpMrvk1g5Xzd8gaHWN6
         0W/vknHyWKPoyT5Bp69M0HtRf945En1K9xEUYumDmIQu3Ml7R9Eb15ZhoVbnrdXRbH
         R61NmqugEO+DA==
Date:   Wed, 12 Oct 2022 11:52:15 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     a.fatoum@pengutronix.de, gilad@benyossef.com, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v0 1/8] hw-bound-key: introducing the generic structure
Message-ID: <Y0aAP/NvH9mgAi8n@kernel.org>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-2-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-2-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 06, 2022 at 06:38:30PM +0530, Pankaj Gupta wrote:
> Hardware bound keys buffer has additional information,
> that will be accessed using this new structure.

I don't really understand what I should get from this.

It lacks motivation and function of this structure, even
the name of the structure.

Hardware bound key does not mean anything at all without
a context. I don't know what it is.

> 
> structure members are:
> - flags, flags for hardware specific information.
> - key_sz, size of the plain key.

Who cares listing member names?

> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  include/linux/hw_bound_key.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/linux/hw_bound_key.h
> 
> diff --git a/include/linux/hw_bound_key.h b/include/linux/hw_bound_key.h
> new file mode 100644
> index 000000000000..e7f152410438
> --- /dev/null
> +++ b/include/linux/hw_bound_key.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright 2022 NXP
> + * Author: Pankaj Gupta <pankaj.gupta@nxp.com>

Formatting here is incorrect and there is no such license in
existence as "GPL-2.0-only".

Should probably be:

/* SPDX-License-Identifier: GPL-2.0+ */
/*
 * Copyright (C) 2022 NXP Semiconductors N.V.
 */

Author-field is redundant as it is part of the git metadata.
Also it is inaccurate description of authorship, as a file
can have multiple contributors over time.

This all is documented in 

https://www.kernel.org/doc/html/latest/process/license-rules.html

> + */
> +
> +#ifndef _HW_BOUND_KEY_H
> +#define _HW_BOUND_KEY_H
> +
> +#include "types.h"
> +
> +struct hw_bound_key_info {
> +	/* Key types specific to the hw. [Implementation Defined]
> +	 */
> +	uint8_t flags;
> +	uint8_t reserved;
> +	/* Plain key size.
> +	 */
> +	uint16_t key_sz;
> +};
> +
> +#define set_hbk_info(hbk_info, hw_flags, key_len) do {\
> +	hbk_info->flags = hw_flags;\
> +	hbk_info->key_sz = key_len;\
> +} while (0)
> +
> +#endif /* _HW_BOUND_KEY_H */
> -- 
> 2.17.1
> 

BR, Jarkko
