Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7723A554942
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jun 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiFVJxR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jun 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiFVJxR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jun 2022 05:53:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82691BF76;
        Wed, 22 Jun 2022 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655891583;
        bh=9cEw9FMLBn4W5pgHYOQdSlww+YpqE/CuIHU5Q+i/17A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HQRd0reRnmkalF5Nlv1fL+D9ySw6cRDCl67K5L2ZnfaVAAYB6M5E+TSpiLZDr3ubN
         6AkOhh40U+uSUTWihMGup+g8tazDQ4VD30PxnbFegPm951KiUVq3ep5FX7zjGIcbeF
         LVT3nhapmClj0fugm2jSMSq/2nCQylaY2EO1ZwYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.22]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1nswXX0cq8-00FQVG; Wed, 22
 Jun 2022 11:53:03 +0200
Subject: Re: [PATCH v6 9/9] tpm, tpm_tis: Enable interrupt test
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-10-LinoSanfilippo@gmx.de>
 <822cad1aa73867ea36c5428cb929a00aa0e82bc9.camel@mniewoehner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <573d1c1a-cff2-4b45-6ec0-bd32f5312a16@gmx.de>
Date:   Wed, 22 Jun 2022 11:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <822cad1aa73867ea36c5428cb929a00aa0e82bc9.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ppv3eukWPslFcTbhTkTqi3dgA/tijvgsEE14CGSoqVrtwKkYmZp
 Mxa1uUjWTytXRXGHd0n0yRRpf3MhXbH60V5Hz3dtq0FXoDW1d/YIZnHl15TXdsvTkm+5KQc
 ewiw7CbQ/I2QrQL3psU2KdMtwAVgZ0pwskvArXUm2F4s7wxwKE9/Dv/cPI7zoI/oUvmilPf
 N6ezkVp+PCjHO1s1748qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sPL2QIr2apI=:Oh4KaDzPLhM5B6nwdxLbmT
 ln+qQYbCqkC2Rr1o2aghdvV8VDO+4m+Xtk0lCfXj41tagDI8Hhn/bzlf2Z3JzmNpmIwrbyiz8
 m6RF5UaqrPNo4AYKMq/stxpYAjNONhIfbZcjAeUeLe29wat2H7geJrawZU+CgncNuQhF79PPW
 6ocNvjYjnKUz24cVUd99YCMLlaLU9f/iyhjBrb7jUfX/oXUJP2H23wNKf53QQYrP6jS5bvyJR
 M+g+K8MEDWBo/DY/bSpjftmnCKDR9obTPKFblGg0gpv37lGNrGZbFcFJyD4Pcc/Vry5VB6twL
 Wufu0KnggGgGaXpX1E8dGsnd9O/vjbkBlAYYiBcEmbmWtl7J3+g/sPjYUUsvCMfY5rlgVFo2q
 KXH6g2lMkSqTEtPTANY/lymoz/akoNE/kEiDjvRpZ5J319ZbieBRA4P9eV/EQ3kHhW+kAjysS
 vGrLAQOU8IdzLUTV2KpEeg9B/hzAxEPWOIYVmhCFX4yW8uqfJpTJTSzDlt7U051MGKblgNsKM
 FTJzuGD07GaSrevsGIUSDsxZq32iMD4ZzvqgyUo4ZjSWD/9Kf/1kZ1/THPUTFavsII0tRBU+V
 reO/dVppBmgP+xuoeAcsAMC1LH3rEAQRUMQZl1osrvhFs6YvH9BKPx2giFGAFHhklRQ0jljH2
 W6ZnFxjXOaUiXYE8beG8zWrycvG3+n9MThwArWB/5Me1zjeG+rF70klaSHp1LCYGhSsGT0/9Q
 KJhKeMgEvIO1O53kORoi+qgF0R0vkZduGo3I5kTSL5tkSLefqDdvwwVq++8od0v64Dni8adWO
 KkzNfZT4V/SR/tz9Lmjgaxz63yHqQ8XzosqpmuZsEJ4wFbiA5sT9BCKPQHMtkdOOKe8LVKHsp
 V74sZdGLD8rq4gecebhzOiRnzOrZaH2/Nj6Kn6ISJN/aXc5OoqcmTZ92tvbn2j+eC21d7/KGQ
 FuYlR6yYZG49XRl1UZ9bYRFWMzufx0ffLbPbjlZMaHZzjhbhI54eUvDkJpvPP0BX8d8qbMBn/
 esH4X+K9ytLmB3OUtyVGdJhoEnOWbV3qDL8gARzghuRPcztm+GG+80PgrZfoefzFzQNbbeTGG
 XTQTZJ4+03+QCQdxmVRGq+J7UNS8PSkOiwmoENmwZdgG34PdwofEWjMXw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 22.06.22 at 00:39, Michael Niew=C3=B6hner wrote:
> On Tue, 2022-06-21 at 15:24 +0200, Lino Sanfilippo wrote:

>
> Tested-by: Michael Niew=C3=B6hner <linux@mniewoehner.de>
>

Thanks Michael!

Regards,
Lino

