Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1611B71884E
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEaRR5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEaRR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 13:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3FBE;
        Wed, 31 May 2023 10:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEB260FB0;
        Wed, 31 May 2023 17:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745E0C433EF;
        Wed, 31 May 2023 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685553472;
        bh=x/GPcLs6ey60EzKJnq2le2H323Qjwtqmu6Zef90S1yA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wb7KVz/3gI5c9flwBpagKmGpNv1JcYqziIyxJfKRs6sw/0SzA5BPztkmO2XEmyKZ1
         vu5dysDTY/pspTeB4qk+CZyfBp6iuTZbJJyQ5HTa3k79c4tFMO4GdyW9/z0E7/LcDR
         mHOS269aPu5rCUsLuoUMlKGGIiV6ez2NGkdc4+Aanz96z5/2DX5eX26yeOfNcI0P0J
         dyk+kFTLJzIzU/6F/isWTB6D716WvFHXJlUdS0f3TZQJdjcscO6QdMEW6A/rGV6+cs
         2kvksal2PGwmjTyE7Co/2u7Y+eLescmjIlZ2zK8ee4xOM56mJLKW4bUfC0+1tQBX6H
         gX9ZWXCsNnFvg==
Message-ID: <83c010a7b8821309a023e41efbabb7e96f156eec.camel@kernel.org>
Subject: Re: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 May 2023 20:17:49 +0300
In-Reply-To: <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
References: <20230530020133.235765-1-jarkko@kernel.org>
         <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-05-30 at 13:45 -0400, Stefan Berger wrote:
>=20
> On 5/29/23 22:01, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> >=20
>=20
> > -	rc =3D copy_to_user(buf, proxy_dev->buffer, len);
> > +	if (buf)
> > +		rc =3D copy_to_user(buf, proxy_dev->buffer, len);
> > +
>=20
> Looking through other drivers it seems buf is always expected to be a val=
id non-NULL pointer on file_operations.read().
>=20
>=20
> https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/tlb.c#L1279   =
simple_read_from_buffer will pass the pointer to the user buffer along and =
it ('to') ends up in copy_to_user(to, ...);
>=20
>=20
> Same here: https://elixir.bootlin.com/linux/latest/source/security/integr=
ity/ima/ima_fs.c#L41

It is good to mention here that IMA uses __user tagged pointers
correctly, and it does not really compare to the vtpm driver code
by any possible means. So let's not add illegit comparison points.

BR, Jarkko
