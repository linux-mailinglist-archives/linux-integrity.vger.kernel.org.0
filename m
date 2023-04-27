Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09326F0482
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjD0KwK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbjD0KwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 06:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378F45597;
        Thu, 27 Apr 2023 03:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66AD63C9A;
        Thu, 27 Apr 2023 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A974EC433EF;
        Thu, 27 Apr 2023 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682592724;
        bh=JEApmjwGLRl7v3N0K80I/2jiNxLa1XTYM07BGgXeKIo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OBKOmB5QTWVjMDIP5nDMeixZwaOMe0UbzRs18P0ufF8IsG5KaS5b9GS2pcSp4a35m
         MP1fiqZOcK5pV0hcfzkUvT6j+cMoxdBkF9sJCxe4uju/8Dfv5IgcTnrGx1w3xLcESZ
         srneqsGB+gE2u3gcMx2vajX7rh1RyE10AZW2wIYr4cVOhEFQ75bx3zbansxoJdKotk
         jtGeXd4uw3MMC4dyGOBQOAuSfvF08IrI3AipdRJm7ueWSSgPvUQH4OD1MHPT2UThhf
         6A6TNtpgTMfRpUuQvH6b2az1LV3IA/2FhuZObBKJCjmYS3qYDTgxQ6JSlgZvyf0Ldq
         GEvL+GYd4rT/g==
Message-ID: <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
Subject: Re: [PATCH] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM
 drivers
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org, heng.su@intel.com
Date:   Thu, 27 Apr 2023 13:52:00 +0300
In-Reply-To: <ZEnWykDF6kbZ8nVi@xpf.sh.intel.com>
References: <20230426185833.289868-1-jarkko@kernel.org>
         <ZEnWykDF6kbZ8nVi@xpf.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
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

On Thu, 2023-04-27 at 09:58 +0800, Pengfei Xu wrote:
> On 2023-04-26 at 21:58:33 +0300, Jarkko Sakkinen wrote:
> > TPM chip bootstrapping was removed from tpm_chip_register(), and it
> > was relocated to tpm_tis_core. This breaks all drivers which are not
> > based on tpm_tis because the chip will not get properly initialized.
> >=20
> > Take the corrective steps:
> > 1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-sh=
ot.
> > 2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts the
> >    things  as tehy used to be.
>            ^ two space and one typo "they"
> 	   Thanks for your fixed patch in short time!
>=20
>   And I tested this patch, it could not be reproduced in 155s, and the pa=
tch
>   fixed this issue.
>   Fixed dmesg is in attached.
>=20
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks a lot! I'll take immediate action to send PR to Linus.

Lino: no worries. It was expected that such a large refactorization
could break a thing or two. You did a good job in any case.

BR, Jarkko
