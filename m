Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909EA6F19D3
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Apr 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbjD1NlQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Apr 2023 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjD1NlP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Apr 2023 09:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218F1BFA;
        Fri, 28 Apr 2023 06:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8939643D4;
        Fri, 28 Apr 2023 13:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7739C433EF;
        Fri, 28 Apr 2023 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682689273;
        bh=lZrzjuU571vLyc9/UjAKgebSxuWsIZ/ivbq2LRelGTU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=pzN0c0ykfHzqcSKtUI6U7TW7FhVklucewaOXW5CtlF+Jx+AeRxE3gA3IQ7BHwYoeI
         9lxQbJczQDIKTmaQh0gYHXzmx7AI4HDb9BfjMJEn9KmpxZeqD4ts6R7qXBTeqjC+hC
         g9cuZ+kTkgsT6qfbR4LyC6LnqQATfyi3dP2SMDkpN+UZqgB4XmuOJ3kU0tjTHOG88x
         4+z6afRtJu36k8jQ1+QERRyr1gYzW+U8ORli/W5tG6vrxyvtH+kYXPwbkUuklMx0ps
         RCriX1ZVAOBG++uTKadV2ZpnuRqeDcThysQ+/HdTN7Yasml5XpeD7MArHFnUm7YD37
         hCN6cxqGJIeaw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Apr 2023 16:41:04 +0300
Message-Id: <CS8FK8E483XC.37N5N3KH1ZJEX@wks-101042-mac.ad.tuni.fi>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] tpm: Prevent hwrng from activating during resume
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230426172928.3963287-1-jarkko@kernel.org>
 <20230426172928.3963287-3-jarkko@kernel.org>
 <3r4dorqzh7nrcsqmsedmt47iimqrh52dfzgrmkjduqglhwufkt@3svji6cfdsug>
In-Reply-To: <3r4dorqzh7nrcsqmsedmt47iimqrh52dfzgrmkjduqglhwufkt@3svji6cfdsug>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Apr 27, 2023 at 9:27 PM EEST, Jerry Snitselaar wrote:
> On Wed, Apr 26, 2023 at 08:29:28PM +0300, Jarkko Sakkinen wrote:
> > Set TPM_CHIP_FLAG_SUSPENDED in tpm_pm_suspend() and reset in
> > tpm_pm_resume(). While the flag is set, tpm_hwrng() gives back zero byt=
es.
> > This prevents hwrng from racing during resume.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 6e592a065d51 ("tpm: Move Linux RNG connection to hwrng")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

Thanks Jerry! I'm planning to schedule these patches to rc2. So any
tested-by's are welcome before that (I'll send it the following week
of rc1 release).

BR, Jarkko
