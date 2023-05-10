Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91FB6FE757
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEJWmQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWmP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2564270D;
        Wed, 10 May 2023 15:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F3D6150C;
        Wed, 10 May 2023 22:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237EC433EF;
        Wed, 10 May 2023 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683758533;
        bh=OiwLhQKzpZvZvKvLZRl67jdxCOPPpaWtbveL4cX81eI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=OOQPElEIN+BFxDFLJpbN9NI2XBIIYn7h6wl+j5JjLn6AGaHMoO428fWtFFC2aEtvU
         PE5cRJqNUh04xyzx984bUJGSuvQmxgW1UF50SGBbLh42RKHydO9yizIaxaGClkW/P5
         0MO3ISisER/5mXCTfgkCuDwUpY45deeV2OgC4Nj1RUgsvrhb0oURpjEkXhh7Spg3f4
         Wf5wwLzrfGifGBC1e38wroAfd9H0O8hDO0JzP2Iw7tOgL8AoU+6k0RFkklXVJNSCYl
         gmVC8z75RNuQQw+IL7CXN0pMmUA7wZF2C5V/toxmwOUgn4csZdHx0/H7z2m48zARX1
         TZuVbbe5eRrMg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:42:08 +0300
Message-Id: <CSIYL1HLJ1RX.3J5079H7TBTT8@suppilovahvero>
Cc:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <jlee@suse.com>,
        <kanth.ghatraju@oracle.com>, <konrad.wilk@oracle.com>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/3] integrity: Remove EXPERIMENTAL from Kconfig
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Snowberg" <eric.snowberg@oracle.com>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
 <20230508220708.2888510-4-eric.snowberg@oracle.com>
In-Reply-To: <20230508220708.2888510-4-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 9, 2023 at 1:07 AM EEST, Eric Snowberg wrote:
> Remove the EXPERIMENTAL from the
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig
> now that digitalSignature usage enforcement is set.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  security/integrity/ima/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 684425936c53..225c92052a4d 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -261,7 +261,7 @@ config IMA_TRUSTED_KEYRING
>  	   This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
> =20
>  config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> -	bool "Permit keys validly signed by a built-in or secondary CA cert (EX=
PERIMENTAL)"
> +	bool "Permit keys validly signed by a built-in or secondary CA cert"
>  	depends on SYSTEM_TRUSTED_KEYRING
>  	depends on SECONDARY_TRUSTED_KEYRING
>  	depends on INTEGRITY_ASYMMETRIC_KEYS
> --=20
> 2.27.0

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
