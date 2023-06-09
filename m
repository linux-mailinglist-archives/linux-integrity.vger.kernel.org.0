Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3C729FB1
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbjFIQKl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbjFIQKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 12:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737A35B3;
        Fri,  9 Jun 2023 09:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A86E865999;
        Fri,  9 Jun 2023 16:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E603C433EF;
        Fri,  9 Jun 2023 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686327035;
        bh=LZ87O9YEgC/OnNCZTn3TK2EOxt1ee+NrpyR27B0jCUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4OcAccl+9lpAjPGRWBchltt+c4ZLyw+Hqp5OOj5Oxm1SVxtEjJ0PB8MWZhxOY8GL
         ECgFhmMHfG+i0L0dK1XSywsHeKuFtLiEkvwitmcoioDogiqA9HuQazZHh4logXNpEY
         9tU4Z/ejM6osC+1IQl+AxWfgbkNZsW+tmYocaA2I3wwIg/4DhPZIy/Y8boRogC3nyU
         JDnd/4G+dT/lLVSlRaHM/qVvK2NGVj2LZZ5w4mK6Mnt2J1fdVv0tdAerhK0bPzKkQq
         vCP6n9sfJ8Oe8Jo9wrV+IudqvLsD4/hm/kMs6yhMjX2ayNoPpc8ix/hVnStZhwJYkv
         U7o0xY02hKiZg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 19:10:29 +0300
Message-Id: <CT891IJGM06C.2A2DCGQHX7KVV@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>,
        "kernel test robot" <yujie.liu@intel.com>
Subject: Re: [PATCH v2] tpm,tpm_tis: Handle interrupt storm
X-Mailer: aerc 0.14.0
References: <20230530174712.6989-1-LinoSanfilippo@gmx.de>
 <CT86Z65L4O9A.2FIOFZUI6BVB4@suppilovahvero>
 <550f0928-73dd-0dbf-0763-c9cc529847df@kunbus.com>
In-Reply-To: <550f0928-73dd-0dbf-0763-c9cc529847df@kunbus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 9, 2023 at 7:03 PM EEST, Lino Sanfilippo wrote:
>
> Hi,
>
> On 09.06.23 16:33, Jarkko Sakkinen wrote:
>
> >=20
> > On Tue May 30, 2023 at 8:47 PM EEST, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> After activation of interrupts for TPM TIS drivers 0-day reports an
> >> interrupt storm on an Inspur NF5180M6/NF5180M6 server.
> >>
> >> Fix this by detecting the storm and falling back to polling:
> >> Count the number of unhandled interrupts within a 10 ms time interval.=
 In
> >> case that more than 1000 were unhandled deactivate interrupts entirely=
,
> >> deregister the handler and use polling instead.
> >>
> >> The storm detection logic equals the implementation in note_interrupt(=
)
> >> which uses timestamps and counters stored in struct irq_desc. Since th=
is
> >> structure is private to the generic interrupt core the TPM TIS core us=
es
> >> its own timestamps and counters. Furthermore the TPM interrupt handler
> >> always returns IRQ_HANDLED to prevent the generic interrupt core from
> >> processing the interrupt storm.
> >>
> >> Since the interrupt deregistration function devm_free_irq() waits for =
all
> >> interrupt handlers to finish, only trigger a worker in the interrupt
> >> handler and do the unregistration in the worker to avoid a deadlock.
> >>
> >> Reported-by: kernel test robot <yujie.liu@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu=
@intel.com/
> >> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >> ---
> >=20
> > Sorry for the latency. I've moved home office to a new location,
> > which has caused ~2 week lag. Unfortunate timing.
> >=20
>
>
> No prob :)
>
>
> >>  drivers/char/tpm/tpm_tis_core.c | 93 ++++++++++++++++++++++++++++----=
-
> >>  drivers/char/tpm/tpm_tis_core.h |  4 ++
> >>  2 files changed, 85 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_ti=
s_core.c
> >> index 558144fa707a..7ae8228e803f 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *ch=
ip, const u8 *buf, size_t len)
> >>       return rc;
> >>  }
> >>
> >> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> >> +{
> >> +     struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> >> +     u32 intmask =3D 0;
> >> +
> >> +     tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> >> +     intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> >> +
> >> +     tpm_tis_request_locality(chip, 0);
> >> +     tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> >> +     tpm_tis_relinquish_locality(chip, 0);
> >> +
> >> +     chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> >> +}
> >> +
> >>  static void disable_interrupts(struct tpm_chip *chip)
> >=20
> > Add tpm_ prefix here too. It makes tracing/grepping/etc so much nicer.
>
> Ok.
>
> >=20
> >>  {
> >>       struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> >> -     u32 intmask;
> >=20
> > int_mask is more readable
>
> Ok.
>
> >=20
> >> -     int rc;
> >>
> >>       if (priv->irq =3D=3D 0)
> >>               return;
> >>
> >> -     rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &int=
mask);
> >> -     if (rc < 0)
> >> -             intmask =3D 0;
> >> -
> >> -     intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> >> -     rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), int=
mask);
> >> +     __tpm_tis_disable_interrupts(chip);
> >>
> >>       devm_free_irq(chip->dev.parent, priv->irq, chip);
> >>       priv->irq =3D 0;
> >> -     chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> >>  }
> >>
> >>  /*
> >> @@ -752,6 +759,53 @@ static bool tpm_tis_req_canceled(struct tpm_chip =
*chip, u8 status)
> >>       return status =3D=3D TPM_STS_COMMAND_READY;
> >>  }
> >>
> >> +static void tpm_tis_reenable_polling(struct tpm_chip *chip)
> >> +{
> >> +     struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> >> +
> >> +     dev_warn(&chip->dev, FW_BUG
> >> +              "TPM interrupt storm detected, polling instead\n");
> >> +
> >> +     __tpm_tis_disable_interrupts(chip);
> >> +
> >> +     /*
> >> +      * devm_free_irq() must not be called from within the interrupt =
handler,
> >> +      * since this function waits for running handlers to finish and =
thus it
> >> +      * would deadlock. Instead trigger a worker that takes care of t=
he
> >> +      * unregistration.
> >> +      */
> >> +     schedule_work(&priv->free_irq_work);
> >> +}
> >> +
> >> +static irqreturn_t tpm_tis_check_for_interrupt_storm(struct tpm_chip =
*chip)
> >> +{
> >> +     struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> >> +     const unsigned int MAX_UNHANDLED_IRQS =3D 1000;
> >=20
> > Please declare this in the beginning of file because it is non-empirica=
l
> > tuning parameter. I do not want it to be buried here. It is now as good
> > as a magic number.
> >=20
> > Or perhaps even tpm_tis_core.h?
> >=20
>
> For now that constant is only used in tpm_tis_core.c. So I would favor to=
 define it there.
>
> > Why MAX_UNHANDLED_IRQS is exactly 1000 and not 1? I would rollback eage=
rly.
>
>
> Because the IRQ line may be shared with another device which has raised t=
he
> interrupt instead of the TPM. So unhandled interrupts may be legit.

I understand that being exact here is impossible. So let's stick to this
but please move the constant to the tpm_tis_core.c with the TPM_ prefix
because it is an essential tuning parameter.

BR, Jarkko
