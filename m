Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B724FAD02
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Apr 2022 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiDJJF2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Apr 2022 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDJJFY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Apr 2022 05:05:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E796BDCD;
        Sun, 10 Apr 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649581382;
        bh=PP14lou5/93ZSwesKhs/aFkM74lBQAXbbozD+ZJY6U4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZkwGSJuNfcFO7nTjEEvntg+JMEeyHNAK9nZ+ZZimKMp8Gq6y6pg8/om/eqhKTLUlR
         ozJm+O5ukBlOFSBeyc5D41uC+BsWweSN6dihEgvpSQwX87SuPq45qxBm+gTFjGEU1s
         2P5EOKEiDqIrg0DRO6x4uBPGwu+3b0ewU4kzlfW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.230]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1o3Z4v1Mln-010g6J; Sun, 10
 Apr 2022 11:03:02 +0200
Subject: Re: [PATCH 1/5] tpm: add functions to set and unset the tpm chips
 reset state
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-2-LinoSanfilippo@gmx.de>
 <20220407142526.GW64706@ziepe.ca>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <caf9dc77-8d81-9f79-9c4b-4b9e4fdf5b92@gmx.de>
Date:   Sun, 10 Apr 2022 11:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220407142526.GW64706@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITy5SCgzF2q6XF6Ozh6e95KHI6g1E9Q2aEPU72b+QaVsae4rdFe
 UpWzx90EakqwrUVtrwPxgBfrd/AF2Uq3k1ZUoGc9lZBi6z+51nCotcC518HIH7Slqxu2iYC
 /iXgE8U4Tc2howXJiTkrJveCP2SjrFv0/16udH+8886gib3VavEuoS+mVTCn0sCVpfzORpO
 yo0kp2eVgafG1lL19CwTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:shEpdg1hFZI=:KaypvA4/ER9yIL6Rp6c2LD
 dMogNUJvuk5kBMe24Hv3CkktxEqBXRHwfOAkIro9PXr4JJRj2B+Tawgn9FQVlsJiz4lYyogwc
 dlOgiKoP1jB7ww91GUvDfLREmRL4KN9iDtTYcIDG5nfLNJR4tBW9jfQbwA1ss3S2NTfDDarmw
 AGSS59fTsPZACkfuZaVqYclOPY2RzkKVu7mHVq4gKhRAYlW2qBx6lvi2WzsxgnHbRol/5SXXX
 f/eVgy+rKvc1JAF8XpruDKbAhGYG1PPaklQ4tEuWUINX3BFEOYMCST11VRuKj65wNrLAl56JA
 I9kL9lB8+X72CpwveVEX0/MRyXcrpK2Bbqz3RL7hcZbYOEP9gOTaElqasd3VgXY0jROsllaMt
 mV1Cxjt0kd2e6JwD6wz1VyZmQogqVNnhVwyrVeMk0Xlpggw9YYQZoeQ+/MaOSRHQd2yXnE1ui
 COr85dYcdUBy2mVoXZBkc/Q8fGS85nnKgh6uduaw83AeSFfyu/wauDvzuVKL7hnJC1gk4IpkP
 S4OUBPZuqB/9kucbwnblhUSR1/7i0lel7Zdfu3mi+2D577dvdUZO3Z+NNRF81SwmjbJz12Li7
 NgFIYsueUqmVvl4YPkhHjKLa/T0Nj/nkI9TBgANWjc3nP9qXVbONdCYx1F+nNi/XZ9yr7aDUI
 P5EkFg8S++SZqX6OHB4IU0X7JvHa67qI5eyAjX6mu8n8RsCYX3Wh7H5cBPYPGs17p8A2AYNTq
 NrUHszI+seXjLeicAjCBHldiU0fTyGdxQqukeJ4m7fBjmqdHm9WkxAsCSRQe2lw+19vpykbR8
 emRUADabTz2Mc3bM55jIfpareb4x5W9HMPPaXSbnecar4RyBKlhCFDoLzPQL4b3Na2CbFdD9m
 9d8CIhnYwl2/fmawhQtwpU2DlrFUeP/Ig2Nea2P2JwFhrYO6w3ILS3uPrH9ytHGIb/ELPqck/
 EkLEr0OD55fzIpqVyNNo4GgKvoFP2VU1bnswy1T98cmsw7VgBgaoc9XbCr/i3Ykupgay1uPi2
 Rm7QjcR1qsgjikDpt6ZzfW7UJ397/nN+ZS0nCw60EcGsf5ldkTpP1tBpgNlLBPzAd3Qbl3Kxt
 XTt6csB/4I590M=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 07.04.22 at 16:25, Jason Gunthorpe wrote:
> On Thu, Apr 07, 2022 at 01:18:45PM +0200, Lino Sanfilippo wrote:
>> Currently it is not possible to set the tpm chips reset state from with=
in
>> the driver. This is problematic if the chip is still in reset after the
>> system comes up. This may e.g. happen if the reset line is pulled into
>> reset state by a pin configuration in the device tree.
>
> This kind of system is badly misdesigned.
>
> TPM PCRs fundementally cannot work if the TPM reset line is under
> software control.
>
> Jason
>


you may be right about the misdesign, but as a matter of fact
there are systems which have the TPMs reset line connected to a GPIO and n=
ot
the system reset. For those systems we should provide a way to let at leas=
t the
driver put the TPM out of reset (note that on those systems the TPM reset =
can
be triggered by software anyway by asserting/deasserting the GPIO line).


Regards,
Lino
