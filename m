Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09751E970
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382368AbiEGT2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGT2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 15:28:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B7193F8;
        Sat,  7 May 2022 12:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 494D4CE0B8E;
        Sat,  7 May 2022 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012C8C385A5;
        Sat,  7 May 2022 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651951482;
        bh=MyfTcFDU6ZdDemzDXz07p3GqM6JlaSU35muvBx+cqsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWa5DFGSnHM+5qK1Nz9q8zyDg/AOASCQqnvJ0DnomLwFqMBGsfWD4eNeKL/rCg1nQ
         EAxoVoCdfC5PO27eZDd65kbixnFzkbauOLmcNodfPZbmJODG5WHub4CKwjK72WqsK6
         wu2DiGRWmhYqAMz+waY7xpBzGk3I3x4sGM+T53TxtWKzcSy4Wbzy+xOXyCmlDjVg4k
         bZI69rB9yME650ZZYxdYz3DehxpM+Xoobjwd7Fw7V9a/vuwOyop0cB780iDUKRWfiv
         rsiJirftMUIYfEmAHlpFPiAqeQq/rRWKpGFhKGgBgL5DlNytyK3XrX19/ROQKmvX94
         TfZCxf1m/Qo/g==
Date:   Sat, 7 May 2022 22:26:16 +0300
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
        Michael Walle <michael@walle.cc>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 7/7] MAINTAINERS: add KEYS-TRUSTED-CAAM
Message-ID: <YnbH2Fgn/JFOU3Rf@iki.fi>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-8-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506062553.1068296-8-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 06, 2022 at 08:25:53AM +0200, Ahmad Fatoum wrote:
> Create a maintainer entry for CAAM trusted keys in the Linux keyring.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v8 -> v9:
>   - rewrite commit message (Jarkko)
> v7 -> v8:
>   - add Pankaj's Reviewed-by
> v6 -> v7:
>   - split off as separate patch (Jarkko)
> 
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e8c2f611766..e58e6fc3016d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10855,6 +10855,15 @@ S:	Supported
>  F:	include/keys/trusted_tee.h
>  F:	security/keys/trusted-keys/trusted_tee.c
>  
> +KEYS-TRUSTED-CAAM
> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Maintained
> +F:	include/keys/trusted_caam.h
> +F:	security/keys/trusted-keys/trusted_caam.c
> +
>  KEYS/KEYRINGS
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> -- 
> 2.30.2
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
