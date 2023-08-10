Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC29778112
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHJTNc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjHJTNb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 15:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D32702
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 12:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341A666737
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 19:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC73C433C8;
        Thu, 10 Aug 2023 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691694810;
        bh=yWtGTFIdX49ULiRhczS0uuV8y/p7qgQz72dHMfMtTJg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=JQxtN7r4rs4gjnupv1PKirmXhMnX3JzD4c7f4cu9F5q8suc6vl9tIFWYQkAwiGuYH
         R3Mrbocw7Sg+lgpOTvhjq93pV8++FZADDCGsHMT7Y3EOTU9bevkg3UfRvH6X9tmrI2
         xCjOtiB4cBKNL98u6RNdmXjVcEaJaPdzMnC3ZnCYjPlXFgNMe5oGAK/XlUMFyay24a
         YasedFc1hQcgD3n93F0ucvFLmW935SHfwgy7t8qpLYSLf5scU6nICC6l+aMWdLmred
         xGY2XYVEotXhPMh84bmt1gBxPALwuUVTCjgmkL5DGrFQuv9CwXkkxmhkkd0r5cznIK
         +2yX4ySvaz8Lw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 22:13:25 +0300
Message-Id: <CUP3RD56HXOU.IECPU3ED1HF7@suppilovahvero>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Build failure on tpmdd master branch
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Nayna" <nayna@linux.vnet.ibm.com>
X-Mailer: aerc 0.14.0
References: <ebe1d154-962b-4a8b-ad08-b26e99804c1b@linux.vnet.ibm.com>
 <CUP3J2UX8SUI.3GHD0KUWB72YP@suppilovahvero>
In-Reply-To: <CUP3J2UX8SUI.3GHD0KUWB72YP@suppilovahvero>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 10, 2023 at 10:02 PM EEST, Jarkko Sakkinen wrote:
> On Tue Aug 8, 2023 at 4:40 PM EEST, Nayna wrote:
> > Hi Jarkko,
> >
> > I rebased the "Enable loading local and third party keys on PowerVM=20
> > guest"(=20
> > https://lore.kernel.org/linux-integrity/20230714153435.28155-1-nayna@li=
nux.ibm.com/)=20
> > on top of tpmdd master branch.
> >
> > The build is failing due to commit cfa7522f280a ("sysctl: set variable=
=20
> > key_sysctls storage-class-specifier to static"). A patch with the same=
=20
> > subject line is already in your tree. Refer to commit 0de030b30823=20
> > ("sysctl: set variable key_sysctls storage-class-specifier to static").
> >
> > Thanks & Regards,
> >
> >  =C2=A0=C2=A0=C2=A0=C2=A0 - Nayna
>
> Thanks for reporting, I rebased my tree and did:
>
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-linux-gnu- defconfig
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-linux-gnu-
>
> I get this now:
>
> security/integrity/ima/ima_crypto.c: In function =E2=80=98ima_pcrread=E2=
=80=99:
> security/integrity/ima/ima_crypto.c:785:13: error: too few arguments to f=
unction =E2=80=98tpm_pcr_read=E2=80=99
>   785 |         if (tpm_pcr_read(ima_tpm_chip, idx, d) !=3D 0)
>       |             ^~~~~~~~~~~~
> In file included from security/integrity/ima/ima.h:21,
>                  from security/integrity/ima/ima_crypto.c:23:
> ./include/linux/tpm.h:428:12: note: declared here
>   428 | extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>       |            ^~~~~~~~~~~~
>
> BTW, in future, please also provide both arch and .config. I made
> my guesses because I had neither (not meaning to complain, just
> telling what would be useful, no worries).

I fixed the issue. The invalid and malformed commit is now dropped.

BR, Jarkko
