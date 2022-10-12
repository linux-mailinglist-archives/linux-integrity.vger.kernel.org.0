Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A75FC278
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJLIzh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 04:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJLIzO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 04:55:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78BDFA;
        Wed, 12 Oct 2022 01:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF611CE1B48;
        Wed, 12 Oct 2022 08:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8148FC433C1;
        Wed, 12 Oct 2022 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564821;
        bh=gtoItcPGfyZKLxXvw4iJ2D84Gny/uKXcQVuRYmSNaLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRENFGiB3gIe8FqXclcfZTAv/VwA/B8keHOqetejQn/fyfec9G9BeyI0m8MC3eBif
         TySjyg36JIJafWuDv6KXmb3JiEu4rMZXES0lg2/i2UzEWsTsQB2fTz+Oc6n8iSzlQw
         QX9zCkTTXSpRz1Cp07L3A5/W2XZxdAod7IrFOWQYD67ucnRNkrhe8ljPVDFn0y737M
         e584mW+W1sLqdPQYhzkTzUvxlkeA5ZVSHgh02tPMFFmEUDdH/erQMhlGZzS7N4DkQL
         V7dR712auLBtfIP2MGQ3dG8V4wTJG1Pbfc6t0wYRQeFfB1ZTvTHep/dkM/JlAtnMdB
         vENl3t8GwcYSg==
Date:   Wed, 12 Oct 2022 11:53:37 +0300
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
Message-ID: <Y0aAkQBDN0Pn0sKX@kernel.org>
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
> +#define set_hbk_info(hbk_info, hw_flags, key_len) do {\
> +	hbk_info->flags = hw_flags;\
> +	hbk_info->key_sz = key_len;\
> +} while (0)

Also this:

1. Undocumented.
2. No idea why you want to use a macro instead of inline function.

BR, Jarkko
