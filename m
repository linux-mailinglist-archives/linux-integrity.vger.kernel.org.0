Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F53D178
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiFCSdP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbiFCSdJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 14:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D38E1A1;
        Fri,  3 Jun 2022 11:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB60EB82461;
        Fri,  3 Jun 2022 18:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901BBC3411D;
        Fri,  3 Jun 2022 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654280369;
        bh=AKP1J+1j86MsDU30/l9xw5gmZtjPSuVq9IYDsmcm1yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1hI1HIE1hi6gYqrNl/2z7OJovjvqO5OUKQWPJ6pAh7AE68ktuEbPWDf8/zqsH2P2
         Xl9rsxNzO8w4eNVUYUeq4TrLlsw++cM5Xjl01EY56WTmJ/uGsXkuK8ZLWdZKlzsR6B
         ncHcpW3oAoz3eCLsetAkdaJ88ExbpayBQiWxTNjXqZEaxTifmlOY602BCjGOO5+67z
         MDz0SizcYuR5isul7uAJfrd8wVREXJc3uE7avMaedOET7CJzbKDDqM7WaZgokgrkBi
         9Z1pnKVpsvSbJEOEBzfUG6CSWJlWFPKU8zMNJG9BwltAK52MwGVHdmP1o6aeaMYv7+
         wSnSsRzVZ021w==
Received: by mail-vk1-f177.google.com with SMTP id bs5so3762974vkb.4;
        Fri, 03 Jun 2022 11:19:29 -0700 (PDT)
X-Gm-Message-State: AOAM533ivNX4y40U+qd1aqcg4yxVMQMIG1vPjUcFWfV+nH9eGG53Bc5A
        /Hptkbl1Kh2QeNy3dW8B0kUYHwA/MkeJ448aYg==
X-Google-Smtp-Source: ABdhPJwh1UGsiub0fkA5rgY7ZXQQ7STjVOpo/uLoefNfIXTYEkvJHTFpOG3dnE3b6MFeBTZvHTPs//qBfZY1d95df10=
X-Received: by 2002:a1f:b253:0:b0:35d:1225:2dfb with SMTP id
 b80-20020a1fb253000000b0035d12252dfbmr6330997vkf.19.1654280368525; Fri, 03
 Jun 2022 11:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
 <20220525165849.7789-2-Alexander.Steffen@infineon.com> <8c4941a1-e047-1352-32ba-8595cd0143f0@linaro.org>
 <20220602134848.GA2178372-robh@kernel.org> <aa5a8e73-b9b4-38e7-4f85-2bf309a346e0@infineon.com>
In-Reply-To: <aa5a8e73-b9b4-38e7-4f85-2bf309a346e0@infineon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Jun 2022 13:19:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0Tk9O4=UAvqxxCbt95+ATqXe6S=W54ArWDqx9b747xA@mail.gmail.com>
Message-ID: <CAL_Jsq+0Tk9O4=UAvqxxCbt95+ATqXe6S=W54ArWDqx9b747xA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Add two I2C TPM devices
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jarkko@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        devicetree@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 2, 2022 at 10:34 AM Alexander Steffen
<Alexander.Steffen@infineon.com> wrote:
>
> On 02.06.22 15:48, Rob Herring wrote:
> > On Thu, May 26, 2022 at 02:29:56PM +0200, Krzysztof Kozlowski wrote:
> >> On 25/05/2022 18:58, Alexander Steffen wrote:
> >>> Both are supported by the upcoming tpm_tis_i2c driver.
> >>>
> >>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> index 550a2e5c9e05..dc52822331dd 100644
> >>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> @@ -135,6 +135,8 @@ properties:
> >>>             - infineon,slb9635tt
> >>>               # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> >>>             - infineon,slb9645tt
> >>> +            # Infineon SLB9673 I2C TPM 2.0
> >>> +          - infineon,slb9673
> >>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
> >>>             - infineon,tlv493d-a1b6
> >>>               # Infineon Multi-phase Digital VR Controller xdpe11280
> >>> @@ -323,6 +325,8 @@ properties:
> >>>             - st,24c256
> >>>               # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> >>>             - taos,tsl2550
> >>> +            # TCG TIS-compliant TPM with I2C interface
> >>> +          - tcg,tpm_tis-i2c
> >>
> >> One flavor uses tpm-tis, another tpm_tis... I guess it is too late to
> >> make it consistent, but let's stick to the one more reasonable, so:
> >> "tpm-tis-i2c".
> >
> > Neither should be used except perhaps as a fallback.
>
> That is the intention, yes.

Then it is not a trivial device as those don't have more than 1
compatible string.

> > Does 'TCG TIS-compliant TPM' encompass every property of a device? Power
> > supplies, resets, interrupts, quirks, etc.?
>
> In an ideal world, yes. In practice, of course implementations do have
> bugs that might require different workarounds. By selecting
> tcg,tpm-tis-i2c instead of anything more specific, you promise that the
> device is fully compliant to the TCG specification and does not require
> any such workarounds.

We don't want broken promises. The problem is you can't know up front
whether you will need a work-around. Adding a compatible later is not
ideal as that would require a DT update which may be in your firmware
(separate from the OS).

Rob
