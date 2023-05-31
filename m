Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8F7187B7
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEaQpe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaQp3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 12:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB012C;
        Wed, 31 May 2023 09:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 838FC63851;
        Wed, 31 May 2023 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9F9C433EF;
        Wed, 31 May 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685551525;
        bh=Hy1IR3hg3CQ4YA2fKy592V6UhvERAjkIBBjrjPHOw9A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RZwbXF8xPVqOrus3y4kNwajSUfeUEnrIywPVwmXzPBdINBWuSMGWBO2cLQgp82Ymp
         ut0k4U0BGSgcikiUHkn3ybDEJW+WCz4GMYsC0h/yHTN9VQqrDO7ovcti8GfgC8UNIZ
         hoLBvwa2AM056Zma7m/xGbxkiEjzfwl8+7prSKVYICybxfKYEg2R5vqL5rtc3PawQ1
         vV87wl17DaAY0QWDIh1vi1QQW3l1IKk31oAU3gwcny0oi/4KdbydOYUuYXpVqFbQrO
         kIqOanRrHgSt0/am3IyBSkJvQ/7DOZPacGK3tRfVQw1koC51CpQQWGx7zMV1tNRmQo
         Gp8+gdGh3Xn2A==
Message-ID: <f07c0d348ec293dee1f8fe25583ee30ea21971f0.camel@kernel.org>
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
Date:   Wed, 31 May 2023 19:45:22 +0300
In-Reply-To: <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
References: <20230530205001.1302975-1-jarkko@kernel.org>
         <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
         <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
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

On Wed, 2023-05-31 at 19:32 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-05-31 at 11:20 -0400, Stefan Berger wrote:
> >=20
> > On 5/30/23 16:50, Jarkko Sakkinen wrote:
> > > From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> > >=20
> > > vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
> > > copy_from_user() and copy_to_user().
> >=20
> > And what is the problem with that? Is it not working?
>=20
> It is API contract and also clearly documented in the kernel documentatio=
n.
>=20
> This should be obvious even if you have've consulted that documentation b=
ecause
> both functions have 'user' suffix, and also the pointer is __user tagged.
>=20
> To make things worse it is architecture specific. I'm worried that it wil=
l
> break in one of the 23 microarchitectures. Have you actually ever checked=
 it
> does not?
>=20
> I'm not also an expert of how all the possible CPUs in the world empower
> Linux to further restrict the move between different memory spaces. I'm
> quite sure that this does conflict neither with SMAP or SMEP on x86
> (because I know x86 pretty well), but who knows what they add in the
> future to the microarchitecture.
>=20
> > > Factor out the crippled code away with help of an internal API for
> > > managing struct proxy_dev instances.
> >=20
> > What is crippled code?
>=20
> Code that behaves badly, i.e. does not meat the expectations. Illegit use=
 of
> in-kernel functions easily fits to the definition of crippled code.
>=20
> Bad API behavior put aside, it is very inefficient implementation because=
 it
> unnecessarily recurses tpm_transmit(), which makes extending the driver t=
o
> any direction so much involved process, but we don't really need this as =
a
> rationale.
>=20
> This needs to be fixed in a way or another. That is dictated by the API
> cotract so for that I do not really even need feedback because it is
> force majeure. I'm cool with alternatives or suggestions to the current
> fact, so please focus on that instead of asking question that kernel
> documentation provides you already all the answers.

I have to add that it has not been too critical because afaik tpm_vtpm_prox=
y
is for the most part for development use, and less of so production. This i=
s
just to say that overally we've been happy with the driver in its use cases
but any snippet of code always has an expiration date.

BR, Jarkko
