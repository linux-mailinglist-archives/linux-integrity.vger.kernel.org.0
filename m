Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633E5AE397
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiIFI6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiIFI6X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 04:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A97124BC1;
        Tue,  6 Sep 2022 01:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B6461470;
        Tue,  6 Sep 2022 08:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA1C433D6;
        Tue,  6 Sep 2022 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662454701;
        bh=GKNX2gt6lOvmJQO/ERaU3bZz9S3yTumOoy5DxUyuK/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk6sYDdRlp77tXXTE5MtkGgok1ah8PYhtmwTHLFuIOnWdHmTmxq24rK1JGxKeIPe8
         91ThLSb7kYrRZNIG6SUHXlBkirhoFS+TArF2VEdHCHsC3o3XM6QzdX5+MW1w0Lo4rN
         QV3nAsXPbJz9KKxGOXCeiqtqQxZ3p+mEIbTeRJ37ocggO8NqCrDlxXZ7aP62GoQbDJ
         gL1RybP4uxC6lpack7j0r7vM7m+wtgh6qyJ0dQl96yB5O1BgxLMssBJ/5gdT5xbA8l
         w9LbnvS0G4HAQ4hR/i6D8JSTnx/xlVt7Fqe96m1IjUWovJT2Gry9wyveZGS+H13nc0
         nt5bmsJOfW5dQ==
Date:   Tue, 6 Sep 2022 11:58:17 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     a.fatoum@pengutronix.de, Jason@zx2c4.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dhowells@redhat.com, sumit.garg@linaro.org,
        david@sigma-star.at, michael@walle.cc, john.ernberg@actia.se,
        jmorris@namei.org, serge@hallyn.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, j.luebbe@pengutronix.de, ebiggers@kernel.org,
        richard@nod.at, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Message-ID: <YxcLqepquOuOOjvq@kernel.org>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 06, 2022 at 12:21:49PM +0530, Pankaj Gupta wrote:
> Hardware Bound key(HBK), is never acessible as plain key outside of the
                                    ~~~~~~~~~
                                    accesible.

> hardware boundary. Thus, it is un-usable, even if somehow fetched
> from kernel memory. It ensures run-time security.

Why is it called "HBK" here and "hw" in the context of keyctl?

> This patchset adds generic support for classing the Hardware Bound Key,
> based on:
> 
> - Newly added flag-'is_hbk', added to the tfm.
> 
>   Consumer of the kernel crypto api, after allocating
>   the transformation, sets this flag based on the basis
>   of the type of key consumer has.
> 
> - This helps to influence the core processing logic
>   for the encapsulated algorithm.
> 
> - This flag is set by the consumer after allocating
>   the tfm and before calling the function crypto_xxx_setkey().
> 
> First implementation is based on CAAM.

CAAM is implementation of what exactly?

I'm sorry but I don't know your definition of unusable.

BR, Jarkko
