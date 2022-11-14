Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3A62816F
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiKNNgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 08:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiKNNgB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 08:36:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9218355;
        Mon, 14 Nov 2022 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668432945; bh=J28N5W5FAUm241m4ZDitkCO4N8V6HZQiliVkLmMyHpw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=b6Kb1SfB/0u8MYKTlcqkPPH0S/HJ4+42gjBXb5oPJA4DeHKZbsPwyVbf9omEY4xLj
         X10re83Y2zXNHRh1WkkHw0oGXEIfu9j0t1QfoMU3VuICV1JNu/lkXeH9vwivxdNUlG
         wl9zuIgcTJhvsYDB33l+WUA0t6F88hhOoczMmTBKZB9sGW6X0M++e7gcYMZbTu5sfj
         cL0evw/slxMTxK/PSoGfAzBNZGscLXsk1hE7G87NYlzDd7OgqTGG+ZItjhR7lNdk8e
         9ErFKDtFJpa/eK0FkS7geVYnpaaMufqDJG8NB7QzLMALnJJbalJLbF4eBW7tS+p844
         vcg/EIdEaGilA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.83] ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1oswnP2QiU-008Hdo; Mon, 14
 Nov 2022 14:35:45 +0100
Message-ID: <6ab8b468-44ee-a488-0f74-eb9dccdd0247@gmx.de>
Date:   Mon, 14 Nov 2022 14:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v9 12/12] tpm, tpm_tis: Enable interrupt test
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
 <20221110152533.24243-13-LinoSanfilippo@gmx.de>
Content-Language: en-US
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20221110152533.24243-13-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njTaZgst5Y9u+100/BoRiTIMgGlNmYB6JpsieeVdTIb6TOKcSts
 T7gOrieUNwUFCTWdnKzp6cHO5k8yeucAWnbhUWrqKSjbMt8tQ/bOL4mKq949D3mgYzz60lD
 lrOylPc3GQvuukCzkDsHvyWLiFrPQFy3O08BNjv/lvLGCeKxSJ2906zDcnltN5SiXzg23Qo
 zE+jKbGgCTK80jivgQNpg==
UI-OutboundReport: notjunk:1;M01:P0:s51Kaw7iSjY=;uU+POoeyTnWG+Q1E/BBeATDyqdc
 YqDmqcbM8jYLypOaDS2ZDY8wONocgpOray4tX4XFbhXSI7J5LIRkoZO760mr1sFzJ4Nm6KMv6
 tMXTb89EbeeRum7NYqfP6+wFUbZKPi7qdw/YTQL6Q0m1B7NCIfOseSCq/Cksj/hjjN9DxsFbn
 BomcbK+KxIKB4fBj9hBKH9HWYZtXOatIwwmGbj/lojR1K/C4sL0xGsjODKYlCrqGZRjQ70UUs
 3L1xuHee/hTzZELpvDBII8vv9q1puJLix/vc/v0MJkd+ofrG879kwS16iYUNOzNeTV2QeC6uj
 oWHGP8JD340JKW5yNox7neMFTZJT8j2/Phhu7bztlBETFwY3vq5LWyZNlNO8R334EbE/uhVAT
 4SMQmwQSwp4GEOWD/MXfIwXwBpTHay9Mg6V5oThcNyctiHadEGHHUmZtNF138QbGxCZqmeReN
 +QJgF2jIfLRoiWLRZTZiIXzU6tArNI47SiPSKabpfmAehHcFBHJnhJOxas1XAsnZuRHHgCoz5
 lEN+tCJQsYcaEBtAMhgU1zjOYTHfLjyphxeUoXjQ/RFPWVXSAnSE5dYU9zA2GKZXmYLo34JPa
 eQmvrYixuxNV/RzxQkFuXNBAqzU5XIl56A1A4pIPcwIDxGlxBWJHHJqgzAxuXuek3Tojlf9V/
 YnBfXMHRYtbxtD5Je0BKdWYvGVWFCQipZaALSzT4dFcb358dGAJXpTK2BjIwoxFdFWyUPGvSz
 AKAKh6o4Mwt6XnM8JxSk2BqUcD8uHdFRxUuscCGQD5j3GMr2c1f9u5AUXs+I5s/xN/OdxSZj1
 afWPSC8of8urKjwN2pLf0E56fbjwqZb4OOhd0jnE9i3/PsClM2DfV41sslsFzGe4EuKSQcK9n
 N4IWIYaej22IdlaPiQdRoXqvHOJdKD4XAz9cESlGA6uEPAiBjuwdZk6JSKcpahkwtm7nQUz/I
 jH1wvgteX3nxxpg+O2Znwi7dS1Y=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10.11.22 16:25, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> The test for interrupts in tpm_tis_send() is skipped if the flag
> TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> initially the test is never executed.
>
> Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> interrupts have been enabled and before the test is executed.
>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_=
core.c
> index 469a1db95941..1f78582264eb 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -793,6 +793,8 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *ch=
ip)
>  	if (ret < 0)
>  		return ret;
>
> +	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		ret =3D tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>  	else

Please ignore this patch. I will send another version in a v10 of this ser=
ies.

Regards,
Lino
