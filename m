Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADD6F04CB
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbjD0LMy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbjD0LMx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 07:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC4BB;
        Thu, 27 Apr 2023 04:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1600663CA5;
        Thu, 27 Apr 2023 11:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0679C433D2;
        Thu, 27 Apr 2023 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682593971;
        bh=tYEMYoMNhaeglO+EUKp0svEVZqDr0bFUZOa8BJPNQOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S2YQ7Cc5uN0lnBjyYBWdVbkKeQ40o2ye7kW1CSYWeM8n19WHMe5vC4oj2V2rBg2s7
         nPZfd12wTF3IUw5v9jP9fJeJjv7q9rJ3Jm09TQD7bwUJmPnTL+Wyp10wITsdqxyJuf
         XSchTVaGaCWlmeR1fOro48QJSHjlWpYvVN9DEm00mjWvOqEOKMBq3+zRH7zg16jYD9
         YeIjaVp4DimalPa/IqJ5jKL7ntCi4ICJWnFrZE1OVysg0GEYUn2JCAZagDVswRUeq2
         XPEKIA++Ah0ZxhwfBUFAysWP0B1ytaLOXE94LG3Bms27oRVY4WJOn4OP1XvUak56yI
         x+yb34AcyhskA==
Message-ID: <6e61385de6044932aabfc407ed8bc368f7e9631f.camel@kernel.org>
Subject: Re: [PATCH] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM
 drivers
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org, heng.su@intel.com
Date:   Thu, 27 Apr 2023 14:12:47 +0300
In-Reply-To: <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
References: <20230426185833.289868-1-jarkko@kernel.org>
         <ZEnWykDF6kbZ8nVi@xpf.sh.intel.com>
         <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-04-27 at 13:52 +0300, Jarkko Sakkinen wrote:
> On Thu, 2023-04-27 at 09:58 +0800, Pengfei Xu wrote:
> > On 2023-04-26 at 21:58:33 +0300, Jarkko Sakkinen wrote:
> > > TPM chip bootstrapping was removed from tpm_chip_register(), and it
> > > was relocated to tpm_tis_core. This breaks all drivers which are not
> > > based on tpm_tis because the chip will not get properly initialized.
> > >=20
> > > Take the corrective steps:
> > > 1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-=
shot.
> > > 2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts th=
e
> > >    things  as tehy used to be.
> >            ^ two space and one typo "they"
> > 	   Thanks for your fixed patch in short time!
> >=20
> >   And I tested this patch, it could not be reproduced in 155s, and the =
patch
> >   fixed this issue.
> >   Fixed dmesg is in attached.
> >=20
> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>=20
> Thanks a lot! I'll take immediate action to send PR to Linus.
>=20
> Lino: no worries. It was expected that such a large refactorization
> could break a thing or two. You did a good job in any case.

Done: https://lkml.org/lkml/2023/4/27/297

BR, Jarkko

