Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE094BD2B7
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiBTXbP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbiBTXbO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:31:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DCA496B2;
        Sun, 20 Feb 2022 15:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 507EC60F1E;
        Sun, 20 Feb 2022 23:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA8CC340E8;
        Sun, 20 Feb 2022 23:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645399851;
        bh=8ZXAn6mg4jBeLomGaLG3dqTfukjdq/S19p5z1d5eH3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdGSnTq509QYAi3y4ZlOmiocK1vftdaynPIr4uO9XawZKEFz5TjCddLLbmAPo6WeC
         35ZYpVNv/0Fda2sjat1FuKLo1A4ltJ0UPHUQh/1EgyIhJWh3HCDGJd4V/KVZsCSeam
         R4mdEBWQRQLkHqXfMhxYhq3On0L+tICnLuVVBNMwTawCkVcQVzwerx3/f6/Oi731+K
         9Mtw/FNGhtV9ivxh6J+ijucM/NqaUrr5MQgpnVrxheSDmK4B1xnk5eRd1E4Lq/1suK
         Qfxte1zCTT4kmPBsB4fVna8IBTkHczL7M1ogVoLhlkLKrHmfDtJDkRi+7dFyU92dMC
         nFxFPRknYpsYw==
Date:   Mon, 21 Feb 2022 00:31:30 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <YhLPUkmSIOQNcTd4@iki.fi>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 02, 2022 at 07:55:43AM -0500, Stefan Berger wrote:
> 
> On 2/2/22 01:59, Vitaly Chikunov wrote:
> > Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> > failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> > does not pass in/out sizes check in keyctl_pkey_params_get_2.
> > This in turn because these values cannot be distinguished by a single
> > `max_size' callback return value.
> > Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> > algorithms.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> How do you use pkey_query?
> 
> $ keyctl padd asymmetric testkey %keyring:test < cert.der
> 385037223
> $ keyctl pkey_query 385037223 ''
> Password passing is not yet supported
> $ keyctl pkey_query 385037223
> Format:
>   keyctl --version
>   keyctl add <type> <desc> <data> <keyring>
> [...]
> 
> $ keyctl unlink 385037223
> 1 links removed

A keyctl transcript of the failing case would be really educating addition
to the commit message (low-barrier to test this patch).

BR, Jarkko
