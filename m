Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D656718762
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEaQcW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEaQcV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 12:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070798;
        Wed, 31 May 2023 09:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3747B62EB8;
        Wed, 31 May 2023 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3EAC433D2;
        Wed, 31 May 2023 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685550739;
        bh=96xh+pvt4FZ9RhX8I2cOmSjN4jqPa3fgUfHTq9AIyb8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b6d++uiC4FkX4fn9HjVahUZGbWLbXNGIKTw1siZgHLu2Fv2ar+hsKPLoSAmL9y2AF
         ScvOM0e0scjJrCaPjuO9N+e0NnUnAhb9JblxdJnsxMOKpvaDUCvEK4tNE5ZtAgBTvA
         OduuPTy9n7F4d/QWrXfZwOiLPrm+KG1nTXCE30jpIEJNZXXHv25x3l9J6RsytZ4OkF
         pDjjbde2WOB6OFnpBBKrc/PWi64F+0be2fpDsx22a4OITLffOSRee4he5tt+6hKM1H
         pW3hObKDCs0NBYM4gvu/QjAHTU4YjjWE1oeJbYrimoNz7o4jeMXbndt7ogxpdYAH0q
         +iBWHtMJ3aTdA==
Message-ID: <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 May 2023 19:32:16 +0300
In-Reply-To: <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
References: <20230530205001.1302975-1-jarkko@kernel.org>
         <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-05-31 at 11:20 -0400, Stefan Berger wrote:
>=20
> On 5/30/23 16:50, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> >=20
> > vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
> > copy_from_user() and copy_to_user().
>=20
> And what is the problem with that? Is it not working?

It is API contract and also clearly documented in the kernel documentation.

This should be obvious even if you have've consulted that documentation bec=
ause
both functions have 'user' suffix, and also the pointer is __user tagged.

To make things worse it is architecture specific. I'm worried that it will
break in one of the 23 microarchitectures. Have you actually ever checked i=
t
does not?

I'm not also an expert of how all the possible CPUs in the world empower
Linux to further restrict the move between different memory spaces. I'm
quite sure that this does conflict neither with SMAP or SMEP on x86
(because I know x86 pretty well), but who knows what they add in the
future to the microarchitecture.

> > Factor out the crippled code away with help of an internal API for
> > managing struct proxy_dev instances.
>=20
> What is crippled code?

Code that behaves badly, i.e. does not meat the expectations. Illegit use o=
f
in-kernel functions easily fits to the definition of crippled code.

Bad API behavior put aside, it is very inefficient implementation because i=
t
unnecessarily recurses tpm_transmit(), which makes extending the driver to
any direction so much involved process, but we don't really need this as a
rationale.

This needs to be fixed in a way or another. That is dictated by the API
cotract so for that I do not really even need feedback because it is
force majeure. I'm cool with alternatives or suggestions to the current
fact, so please focus on that instead of asking question that kernel
documentation provides you already all the answers.

BR, Jarkko
