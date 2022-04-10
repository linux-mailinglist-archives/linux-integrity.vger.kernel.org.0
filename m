Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BC4FAFDA
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Apr 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiDJTrN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Apr 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDJTrM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Apr 2022 15:47:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44D5D5F2;
        Sun, 10 Apr 2022 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649619888;
        bh=0b150G6BrvAci/6qIgV9dOcDSR6KYc3RHxHU8xPDus0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ul8XQ3zhOwkrGvPbXl6Qh1pCcpgTgQ0urdJ//KTpUQxLlPkTei9THqUxK1Llt2qbM
         IGaD4+ECMNxsy+lINyxo6QJSWVRF4oBwSpXCKjzmKVNizOgm83eBy2GuckgF0wHyM5
         TwMX5WNcR86XK5x2LA6W/lY3gUi/fPne0t5MpDNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.230]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1nxNCT0dwX-00tPw9; Sun, 10
 Apr 2022 21:44:48 +0200
Subject: Re: [PATCH 5/5] tpm: tpm_tis_spi_slb_9670: implement set_reset and
 unset_reset functions
To:     Lukas Wunner <lukas@wunner.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, p.rosenberger@kunbus.com
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-6-LinoSanfilippo@gmx.de>
 <20220410171826.GB24453@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <1229fbc4-0abd-376e-a9d7-ccdd6d56c2ae@gmx.de>
Date:   Sun, 10 Apr 2022 21:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220410171826.GB24453@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mSm71vcc1o0VqmXNuuRUwbw/0qJB1BZH90rQsG55VU+wQkrfCzm
 6pMOb4LSwaOycSFvCkcGxMT2vtoKI8dHgBX8DafWOZuTCdbeMImfFlhS787f40Nsbnmq7K9
 rtZ6wNQdXdrOXMxelkvqU9lQV6dnS1PxlitRFnZhR52IFntqBH6DqucbrETE36Ibh1fJ4Ka
 dvZIAuXaMCWYzm8Juzj1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LfGMUcy+Qhw=:8gNvMHcSLwyqzQTM/qdGPb
 kBSyA2A5Cx6VsCLx+8vIAGBPGC4m4S0qQNtwRKSzicgmdHOq40GKo2QB8Gpteca2dNtjzYPfM
 +92jHFlvLP7DGYuKM607uevtj4wMjnAUQJSHzugRwLpkFzyGQV3VB+GtfGn0htN3xu4oUhZGp
 3D4uniB+JZDOtqCGQhzKnTLz9D8AkNGMPguIGeY95bjMerBQZ7nm+mp9Yc+PLmOdf8zSYlQby
 AxkQWRjAmJsqOOcK0JElMrHgw0/2k6NQZf+3LcvshTgzfbFOfhoWvaNCyEo/43QQbOaDPKeSu
 P9wqUR1GZKjuaJ86aNYpN0T6xpGkB/YZvK2IgbfBlgLHS1cURmCznaI2C0sE0sIkPcAKj4kuK
 0FlUCglZI8Y7Puwf0hTQ2qLds3ouFr6QNT4GYvNWQylNw4q2OI2m2ehm4c9CPS5aRi7ZlpQ3x
 6x9edZ9Q1o/xyaWTLV019zX5t35h5CeM1qlKIc5BTn8zHIcR2lWcI1wqZW3zevXzKGao+/0hx
 DRWE7L66MwkOigV2HmQXgkJpgD0iSlGEI8lgL4rt8jx8rWLavsauxiu+A7QCSJagf0YuJngrJ
 fEsV1OR6HP71bWUyf4d+JGKB/RjzOzjgdlh/oaNM5NTtncTZHShbCFTNzECoWcPqBfFFE+kW0
 skY6zK2DRnMqJ8QxiMmSM0EsDMihe7a63uo1JWHYUEUNrb7eHGlwf9+2BJFflc8j18LUPUXPu
 wm6Ku0KD37UjMkOgQjvJEqG45YjBT0XQxExfGAoKfHxqpnozhzIAUEUufgTj7guzkKYYo8a6Q
 Lc71jkSZSxzsk43xffTn7qOhusa2XY+UoQYlLFO/92rC/SDjD/DhjGnSTqN8cYKAvStk/bwGy
 0QejNLQsrqEw4RLX8hGAgjXD3jtYQa3DMGpOX5wt7mhylF6FAFaoGTwqwW6hFMn3Y0LgzaNp/
 gIltBiVlDXVFyHdEZlH9KDHPT+lupXTV2QZ+5MPT22pG85Uso40b+y268pziBtCGARaOkQ529
 ez3e5EiKKaoVhJjXDVkGs43FcVFfhF+G16wqiJwE77W22B7G+AhFRcUpG97SsZx1C/0un5te0
 PBbzspKhssoLAM=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10.04.22 at 19:18, Lukas Wunner wrote:
> On Thu, Apr 07, 2022 at 01:18:49PM +0200, Lino Sanfilippo wrote:
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_tis_spi_slb9670.c
> [...]
>> +int slb9670_spi_unset_reset(struct tpm_tis_data *data)
> [...]
>> +int slb9670_spi_set_reset(struct tpm_tis_data *data)
> [...]
>> +static const struct tpm_tis_phy_ops slb9670_spi_phy_ops =3D {
>> +	.read_bytes =3D tpm_tis_spi_read_bytes,
>> +	.write_bytes =3D tpm_tis_spi_write_bytes,
>> +	.read16 =3D tpm_tis_spi_read16,
>> +	.read32 =3D tpm_tis_spi_read32,
>> +	.write32 =3D tpm_tis_spi_write32,
>> +	.set_reset =3D slb9670_spi_set_reset,
>> +	.unset_reset =3D slb9670_spi_unset_reset,
>> +};
>
> 0-day is complaining that slb9670_spi_set_reset() / slb9670_spi_unset_re=
set()
> are not declared static:
>
> https://lore.kernel.org/all/202204081357.8SfjQosI-lkp@intel.com/
>
> Thanks,
>
> Lukas
>

Right, I will fix this in the next version, thanks!

Regards,
Lino

