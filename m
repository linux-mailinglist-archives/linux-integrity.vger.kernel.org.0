Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ADF6EB686
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Apr 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjDVBAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 21:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjDVBAE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 21:00:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4BB1FFD;
        Fri, 21 Apr 2023 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682125180; i=linosanfilippo@gmx.de;
        bh=soMbOVrVh9ersmvfy13xH+MBOn5JdTgn0EtoNx488K8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dPCwBrGMR4SitdcPpsheMqZoHUyaY7OQ95x1QolZRI+6mfXmZy9sk724biQdIlKUR
         jBPVSXTr7xeN4GSc639IL/cKi0tA9kl4P8bH8v6iAq4QKKD0HXJqS3A8aTV5LKamR+
         w3p9rze1APtGkWTfxkWqP5aJoCzDYZ4nlIVo9lMpqviPBS+30N0jYr1KFnRCxWii//
         Er99Rk1lIwh5SnDDqdnqDPCxrIiHgeiYcL/jhI5NekHZV+hyqPOAHy8u3GMBHQuXJI
         AvHUz6vIKwU80vw2nhvYV9NOQyP0NLBMsd3KditrXc7ewUOByZOFsgsSB/tkNzCCnt
         h1Y8FQBDdmWag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.2.106]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1qRqiq3fjT-00dWgp; Sat, 22
 Apr 2023 02:59:39 +0200
Message-ID: <a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de>
Date:   Sat, 22 Apr 2023 02:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
 <c02493fac223707de39e44d51b0a0ce512565250.camel@mniewoehner.de>
 <20230319135338.c7k6r3ws6lby5qgv@kernel.org> <ZEK+w3Q++vu4Kl5x@kernel.org>
Content-Language: en-US
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ZEK+w3Q++vu4Kl5x@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:92aRHdMLAlGf9uHK1BYRoDFwRLhzmrq3ieb2xvnGfPmsz7BMDm/
 09x3DMvYYd9Hxudklk+Pk8Xl28FsRUZqtK6Vr9oSVqBiGfvsPRaj/fYdyae/06dGPJVF3lJ
 RiskU6VBFEtx5rnZykeEVqOY0lqj9XHssb3j56J9wfY+7CnjCMnU0wKh2I2wAMxaIhfZIN9
 G0pUN0p+rUMDixKQ9LNfQ==
UI-OutboundReport: notjunk:1;M01:P0:YIHpyV6r4mo=;Hron2JugsuriYj2wswLrA18oTUH
 XO0NRErXQrwkB4VRALLx/S3FomZMuKEkin1oVRvBwsQpuU6ReaYZ0IYZxyOX8UzJ98ldYx0zR
 W0cPGd9Kye7v8j7jcIKAEVs8FCzghy5ufemwRVgPxPoeBDByEuxyxj/Uj3Nkfmp97WwWOs/ND
 bwmGO0+nYsff8uiGz7PB+S0oERDD0IR+gVCbyeQdAzDzkUEcG1trdjYPtC2VwjcusYf1YSqMf
 5jYa/XqBn6YEaCxPl2RlSWU+nBt+e9On0ax+WaPYWKirvGYBpWJqdvjky6UkIoyHeVHljlTPL
 e1cEWE4/KC4ST5l8QYiSJ8dT6zcym3+9YxeUn2v555gc0uPJpK4id2hu/NzpEdbtr8P/WYrHr
 5caK+frPWBvuLoN2+a7o1tRNsNBuJZanbJp4g3U4J4rgWkxDbkdXerk+T2fWDQgaMLJLPcRvq
 E2Eqfh0VcyBRgQdAxM9nj6jbN0dqT+5lLpGoW8tbw1ZW3PFv4kvotqc/zHinICtHz5UVfREbZ
 jZGsHUQh6LoaN18K97lvIbbekuFVVvYFRfFOpx8xC7ZUtpyKtIkXmU++2VbCHm3fsxUHNWz4l
 Fbf6/68D+k7mvl9+UngdkeVJnbOu6bakGEAAdjD4QV/4qQ2RSwGYssRiXwNV/jaxOx+9DFrMu
 Jec3wOqLV/osGEeRZhRKHFsYHUTv6QyDKwiO8ugx1Vc5QoZr65huobOMuGrVGgWU38K0k89sP
 epaQpW1jtY1MCj9mnzGNnQhjHSrOeoBxR5iJZammGjVmx/UckuJktp+zaAY/DPnoVOySTVIHE
 n85BEyNrERpQDDXUv3UMmt/MfhYyWopPxUkZwi7mxZkfvfcKXiGA6wL2Yk7MDvAFINR0lIJlK
 d6RKuhHoXvYVs8F9ht4VTW84+vpC/ToAovt7kWOfk3oTscmm3NrSsnCzj3/6ut5aLxLsDLoDh
 2MTxV9EGAfF+/DEOTFAyfoFZ+KE=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 21.04.23 18:50, Jarkko Sakkinen wrote:

>
> I tested this with libvirt/QEMU/swtpm and did the following tests:
>
> 1. TPM 1.2 suspend/resume.
> 2. TPM 2.0 kselftest.
> 3. TPM 2.0 suspend/resume + kselftest.
>
> I see no issues so I can pick this for my pull request.
>
> Tests were performed on top of v6.3-rc7.
>
> For all:
>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko

Thats great, thanks a lot for testing this!

Regards,
Lino
