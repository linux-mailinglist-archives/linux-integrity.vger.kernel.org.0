Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6F5FC297
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJLJBh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 05:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLJBg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62A73308;
        Wed, 12 Oct 2022 02:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38EEE61481;
        Wed, 12 Oct 2022 09:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D14C433D6;
        Wed, 12 Oct 2022 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665565294;
        bh=816bi159mluWyxxugxMZ1DY/Wdh/2OzhkEWZst20zPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNdp9zi8P1evlXgp30Ien7vP53++/M/OltYIFxva9TF1EeCZjU/OqeM9P0UYNeD2k
         yMn4lEceWgcjeRYZYXmlwy2OKwPFHmFO9ZbdjZszK8ofnHMgID+IKEWvZBW1oi6J2S
         Vw/ICJjvF09aXKHS+h2ZDR/q+M2gbFqM+rvja5x2y1W/4wBeFmhEMc838YLMcUEGMD
         /PsEbu86L1l7cRysGheRCnBZV48dRhetsSa0GKTq22XE+NSeLXSecRXbw7p+kpGn5o
         d+vZLachiRQRyoa8aD804h6GDTEs8TmN5GhErkt8Do9NhDmF5fn/HSUY5PCKUe6rSz
         4FuDdd0ETIkAg==
Date:   Wed, 12 Oct 2022 12:01:31 +0300
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
Subject: Re: [PATCH v0 7/8] caam alg: symmetric key ciphers are updated
Message-ID: <Y0aCa1K/JXENYPrZ@kernel.org>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-8-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-8-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 06, 2022 at 06:38:36PM +0530, Pankaj Gupta wrote:
> Changes to enable:
> - To work both with black key and plain key.
> - It is supported in context of trusted key only.
>   - as meta-data is added as part of trusted key generation.
>   - otherwise, work as previously.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

These commit messages look more like a personal backlog
copy-pasted than a reasonable summary of what is the
movation with the change and how the change achieves
the goals.

BR, Jarkko
