Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB146F0AD5
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 19:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbjD0R07 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbjD0R0y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 13:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758AE2684;
        Thu, 27 Apr 2023 10:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10DBC61049;
        Thu, 27 Apr 2023 17:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA6C433D2;
        Thu, 27 Apr 2023 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682616412;
        bh=OWU4Y8lWvJKyUQGr36R/Qfwlu1aatmPvFSvBxHjKSyk=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=bray3vj7QBE7KrwCzyNrrUuBQUyrrutFvYzrO1OxO699DY1qpuf/PjCNt2bPjix8S
         T1dZzw5nii93ztrFLnH+L9OS3ggReUxMpziKox+WLTEtpkVS/dw7zw0uufXY9qig/W
         GSNiU+aOqMCSaDZ4iMxDjOv+wAcsFBtAQbcETlWN6THQVNrNKv0G6iAY6DeeWMJpOr
         udVYv2+kr0DsC5l6h/a8VeJPDEsdZp831TdYVueCLzuI+bdEJlxGVVXMzWGCjDslvI
         GUt+0wLi+R/Ubg7c2UVm7uZe+6GpYKF9uPoupmQI49ejkWvqNxf7KM1SJLoLGkhWAy
         zOzxFy+PmKUqQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Apr 2023 20:26:43 +0300
Message-Id: <CS7PQGHNLIGG.1PDQ1S2D9QG79@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM
 drivers
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Pengfei Xu" <pengfei.xu@intel.com>
Cc:     <linux-integrity@vger.kernel.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>
X-Mailer: aerc 0.14.0
References: <20230426185833.289868-1-jarkko@kernel.org>
 <ZEnWykDF6kbZ8nVi@xpf.sh.intel.com>
 <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
 <27e8289e-21a4-7d7a-231f-4a27334dd1f9@kunbus.com>
In-Reply-To: <27e8289e-21a4-7d7a-231f-4a27334dd1f9@kunbus.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Apr 27, 2023 at 6:33 PM EEST, Lino Sanfilippo wrote:
>
> Hi Jarkko,
>
> On 27.04.23 12:52, Jarkko Sakkinen wrote:
> > ATTENTION: This e-mail is from an external sender. Please check attachm=
ents and links before opening e.g. with mouseover.
> >=20
> >=20
> > On Thu, 2023-04-27 at 09:58 +0800, Pengfei Xu wrote:
> >> On 2023-04-26 at 21:58:33 +0300, Jarkko Sakkinen wrote:
> >>> TPM chip bootstrapping was removed from tpm_chip_register(), and it
> >>> was relocated to tpm_tis_core. This breaks all drivers which are not
> >>> based on tpm_tis because the chip will not get properly initialized.
> >>>
> >>> Take the corrective steps:
> >>> 1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-=
shot.
> >>> 2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts th=
e
> >>>    things  as tehy used to be.
> >>            ^ two space and one typo "they"
> >>          Thanks for your fixed patch in short time!
> >>
> >>   And I tested this patch, it could not be reproduced in 155s, and the=
 patch
> >>   fixed this issue.
> >>   Fixed dmesg is in attached.
> >>
> >> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> >=20
> > Thanks a lot! I'll take immediate action to send PR to Linus.
> >=20
> > Lino: no worries. It was expected that such a large refactorization
> > could break a thing or two. You did a good job in any case.
> >=20
> > BR, Jarkko
>
> I guess you are right, there will probably be more issues showing up
> in the next time. I will try my best to help fixing them.
> Thank you very much (also for fixing this issue)!

Yeah, no worries, that is my responsibility in the end to take care of
whatever I accept :-) And yeah, this was complicated change to do, I
think you did your best and that is good enough as far as I'm concerned.

BR, Jarkko
