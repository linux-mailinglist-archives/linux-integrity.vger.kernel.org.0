Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361975A5BD5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiH3G3q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 02:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiH3G3p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 02:29:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D497B1D;
        Mon, 29 Aug 2022 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661840969;
        bh=WpgEEn6MUf6DJ1NYH18nt11KqeVSMW+6kQbhTyNwqxE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jTa+kSoa/nBwKZr5abAdmSmRy5QhQHoGrB55f6/XmRdDyNu4NDSUcaTI8jupEoBr7
         8Z3iwRnZI0B4DltrEem0qEwutFF0GIRBCMsG4OkdMjx585KJwu4xAxFxDEG5LqDAS8
         oby8eJ88KN8KsGSqVDg+Cml9QeACM1h7+1LXI/Es=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.37] ([84.162.5.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1p1hXM0STB-00ZiJH; Tue, 30
 Aug 2022 08:29:29 +0200
Subject: Re: [PATCH v7 05/10] tpm, tpm_tis: Only handle supported interrupts
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
 <CAKf6xpsc9KRUKo5Z-kPqDcSCdpf9-tjf+ZdREnEiJUdHwyDQcA@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <bf42f6cc-dcc6-ba01-7208-de5df43f3919@gmx.de>
Date:   Tue, 30 Aug 2022 08:29:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKf6xpsc9KRUKo5Z-kPqDcSCdpf9-tjf+ZdREnEiJUdHwyDQcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WXoZzcBcfVA6OV5rwwR9Fg6hPWzh6LcZOmaAItebSDmrsGPW59w
 Uye+16N9OGrYcuGRYUpVkAPTXUdM5ViCOzShiAgw2CuxTpIhMRd4xVupZP/EzJg5TWh3tSG
 +EhQR+z7u/T+NoVF1M/+kE+4WPwzPckhqWlZQXLVrDaHu/Wtnt71FgaMaDRiYWCKXxjMIaa
 EA/OMb212wfYk9X0ox+mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B41wivnqFQI=:RrFk3NWRcC8gi3Oi3eq2h2
 8f9+X/ilt1MmuBOM6QMjY4UBXo1+gdr+agjW/ZqBDWtcZ+KAd+UyAZXmC7sfk5ez8FhvovVqf
 /egGQDbCos9EXdRhPPyAd/Mt856hip+owgeAGsXNbQjMC+HtCuqRfnJcyZ6pyaOjQJYPj9VRz
 KUZbgwzhyNEffCGdfv5zq7fLhLdZ88QY49FG8ChmMH2txfGNAoHpWTexHKmCBysKQiCWs+0JQ
 7D62PEvuNfLeAu8VLdoTga3SROklxvPyP2Dg3WrHLCx4t65rgcgyi1ytlIimAZX0CzikPNkOQ
 MbEgafT6V6Ebe2P4pTCaghRcbkQqv1tOWbWbSW7dZJYFls93Ac8OLLWpLjnXAPEQggxUo03qY
 /qM8jBYqgPdUedvLPM8AFtvdVdenYheOQhlou7UGBatWXFfpD/jLyrC3+1oE/oXbpYUKKlJmc
 Elhp6pB/rAs3kXFIZEcRqMMm/LfjKYaooCGV6jkOa6yXJQ3QShf5wWAkDgcuq3UtZkqS+q5GS
 BaOhvwFhId8i3KVu//7My64ADnAABWsa5zKauGRPxcbBv8XfVOU9P7fQ60K5t8Q2TBHiwGb8a
 2cKsp0kDP49YWGR80jA95MSJqymrtf1RP0AhodYf9X77vKqxSCd0nfO2+oIiMbnb2OoAdrIiH
 o62TXNQ711DtLflU7/oJFUAhhr/3IH4yMewI+W+jyBPv7B8OG3+DKEIvvk+DVnR44kLt2Rpq1
 qKyp/G5y3cEao2CNlds5L3luWv9zPMrKxNEJDX8qN/JImUvCxZt2xU/45YZQVFnXah2ggqR7X
 m22+VKD3VTce9q7Wx9ogrCi0PRPKpevF6q2NAm5+RgFpk9gg9fMgCw0VqTG6xVHxvBx1aV7vI
 eyGLt1IOb4J4ysJqfSQl/dhy9E585aKicoPT5FeunzckGt8RTNA8kY9jCYWlxhxMf9Sj0+ANu
 nvVhNncEHfhj8Oe3hrCn19o+y5ldKtoXHwOxhJf/kavBmcq1XP+OG+lrVFSuSmBfNr7E3OEVD
 9EMlMpPFbtLG08jfVzwaSjAilEiU4AG/DaaVJ175lzxJoENk+1P43WaG/fqT+KbmXPJjEBOCT
 ACI1NbW3uzNh92cvJOZak/MyvCEAGmrD8PVL5kK5mJtFuCYhM1IshBzUw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Jason,

On 26.08.22 at 19:43, Jason Andryuk wrote:
> On Wed, Jun 29, 2022 at 7:28 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> =
wrote:
>
>> @@ -1007,8 +1029,39 @@ int tpm_tis_core_init(struct device *dev, struct=
 tpm_tis_data *priv, int irq,
>>         if (rc < 0)
>>                 goto out_err;
>>
>> -       intmask |=3D TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_=
INT |
>> -                  TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
>> +       /* Figure out the capabilities */
>> +       rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &int=
fcaps);
>> +       if (rc < 0)
>> +               goto out_err;
>> +
>> +       dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>> +               intfcaps);
>> +       if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
>> +               dev_dbg(dev, "\tBurst Count Static\n");
>> +       if (intfcaps & TPM_INTF_CMD_READY_INT) {
>> +               intmask |=3D TPM_INTF_CMD_READY_INT;
>> +               dev_dbg(dev, "\tCommand Ready Int Support\n");
>> +       }
>> +       if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
>> +               dev_dbg(dev, "\tInterrupt Edge Falling\n");
>> +       if (intfcaps & TPM_INTF_INT_EDGE_RISING)
>> +               dev_dbg(dev, "\tInterrupt Edge Rising\n");
>> +       if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
>> +               dev_dbg(dev, "\tInterrupt Level Low\n");
>> +       if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
>> +               dev_dbg(dev, "\tInterrupt Level High\n");
>> +       if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
>
> Hi, you may already have fixed this, but I just saw:
>
> error: this =E2=80=98if=E2=80=99 clause does not guard... [-Werror=3Dmis=
leading-indentation]
>  1144 |         if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
>       |         ^~
>
>> +               intmask |=3D TPM_INTF_LOCALITY_CHANGE_INT;
>> +               dev_dbg(dev, "\tLocality Change Int Support\n");
>
> You need { } for the block.
>

Thanks for pointing at this. I will fix it in the next version of the seri=
es.

Best Regards,
Lino


> Regards,
> Jason
>

