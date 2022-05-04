Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC8519685
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiEDE3x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiEDE3x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110326567;
        Tue,  3 May 2022 21:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A27F6B82280;
        Wed,  4 May 2022 04:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2C8C385A4;
        Wed,  4 May 2022 04:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651638375;
        bh=2grO925VY+hSkPAqlv6IbwcYz8VLaRjVf1Oso1qMAqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoCDcdKBjR87YVuMlGi+tTfF8Yy73r2asC5iEP0t8ihdkyU3gx8q5kC/4W0tplzmX
         6lrgXdW7Mp8r/uzdYEdlVK8mlPiS2ouF7g/Kd7CJsgTeNOOPEz6rJJBNk4qHpmtHZA
         hLUDP0SLBDO3sFPQXXjLUnE+f/QH7H7axRGU6YtjWSA5M46Z1rVlSsJkp5F33xHC7g
         BfCuZV9G5dG40HSQqWLROxiQzYQXEmI9zR4l2ybXsGJeQJbSmE1V0WqXKzgdXlF9kP
         vNoIzW7nptOq68EEoKt/7NnUbAe38hoQ6VkG78n+Ua+wmESgyE9N549sBaMWRBVnFd
         r+n1FrXYtqwaQ==
Date:   Wed, 4 May 2022 07:24:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 6/6] MAINTAINERS: add myself as CAAM trusted key
 maintainer
Message-ID: <YnIAEmUKfFxoGlwr@kernel.org>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
 <20220428140145.870527-7-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428140145.870527-7-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"MAINTAINERS: add KEYS-TRUSTED-CAAM"

On Thu, Apr 28, 2022 at 04:01:45PM +0200, Ahmad Fatoum wrote:
> Add myself as maintainer for the just added trusted key integration
> with the NXP Cryptographic Acceleration and Assurance Module.

Please, remove "just added". Also what the heck is this integration
in this context? It's afaik a process and not any sort of asset.

Maybe rephrase the whole paragraph simply:

"Create a maintainer entry for CAAM trusted keys in the Linux keyring."

BR, Jarkko
