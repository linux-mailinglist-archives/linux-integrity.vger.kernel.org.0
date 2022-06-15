Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3254D54B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 01:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbiFOXbB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiFOXaz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 19:30:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AAD192B5;
        Wed, 15 Jun 2022 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655335828;
        bh=fJpKWfjPw4yXjZfJL9Hj+n1PhzBhGLJ/rI0WGDhjV10=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fPleUF/dvG/B264MG/yMH+rR5Jmzxn8IjIDQG/Cknbe++ffCrZ73KrBavOstOipYN
         Ez9LN4pkzwge+tZhFF/9Jp/rPnxySAT1BY+VuPfLf9nkG9cTiaHdSM8ZhA78RTWJdQ
         92JySZ85qrcP1UtiJSnz0z9cEMRb7WGkcZIq48Fs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1nVapf18Ih-00hs0W; Thu, 16
 Jun 2022 01:30:28 +0200
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James.Bottomley@hansenpartnership.com,
        twawrzynczak <twawrzynczak@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-11-LinoSanfilippo@gmx.de> <YqokW/cNLrrsZ2ib@iki.fi>
 <c610a318258198f72a53541c551c0c595a205329.camel@mniewoehner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <1c90aba2-5874-7251-ff19-4b6c5bc19962@gmx.de>
Date:   Thu, 16 Jun 2022 01:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c610a318258198f72a53541c551c0c595a205329.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5bqKLG2yEju7Htztep1S9suzxDRr+iP1xCUz8I/lQbOfh2BQlrH
 00Jp6iWqNJ2qivU2uQarqDTD5yYoQxbITOAGj+dGND2s0IbGhU8EXtoJQVjvTXXnDci9iEV
 uSxXT8/Trp2ErIHmNmYXgoVq9geoqQrKHGuDLAb/EVDA+EnIUh0rnhQUUFf5/cBGYmfeAhK
 V/C+Opa1KXzSA8mNNAX1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QSQ0IEDTlQ=:lPhR7H2yO8iwLtr++qAWBt
 BBg4aYW02FEwlc7lLcbtfRWoj4peT1VBoigPX4Ueqek7pNWi4Mfvf0f0F2TXAlkwpOaQnCOF0
 +ReANXjQLyT6gp4vbUsi5YzJctQi9abzG0dy8pntdOkfP/vJu+kH8/266UkQeMh+xzShpnKY1
 XkFKMHbP6phqL4Dm0mr+qYsDQY9xh+tsMdwiExjFPyj62A28uYff+bTnqJLJEioYUwVt6tuzU
 NXNqcp/Yx+k6KXXCFLZSy47MKs3QsKHqVGZYYfgP4s2trEJb6RRiGkAcf/Mzcvw6wpADQIBUU
 Aro/tp5BR6RAuSzazgTCppKce5U9t680ygtnuwigFHT832ETshOlbUWfD8bgzmxOvK4gfFsmo
 LMBAcd8NzV5tTthm80P2iV6xIhnjpn4xK1/i7P/x+XHguT/9JU1hXXYx7t0qtTK1zgFQS1GlM
 FZFMh+foi+IQFqeB5C+DR6go2Lf+VU729eXITkPlYFM5Sw8uuJW9XFXMAtSmvrpvWOuBLHLkA
 er3TwH4XJeKAYSRSDjrcTgzmMoB9AgXGYcDy/Q99OFwDJYrW+mKcU/giv7oVcoKnysfPWfvY0
 IsN2xzVTojRbYHDm7Wg3tImDoYkkpv1F608Fl5p+rtSQb68L2JDbQYvQ/lGMP0GuRj5shkYJO
 7RmwnxZnAl+6TYgAcX8DH4rYAN+p5YgNR6ZkzcOVyRyJ7X7BReAWFOWvEA1edkpM3+RNrPIEz
 38NG1PJGJZUX6Chu2Kdpn3eYuoRWo83+vTBf7fufQo9TfQFMcReRu6jkFzCobQ80j4XLcSFbl
 Vo96yWQpyca0xAVIeSyXzUg9c4SXXa7ZUUF74hcKsjFYzmLc1HrSqml9dKrtS7TOjDYy+WcyV
 FEf14Q+83W4XkW6COzCLoC25kfKyoJhzuvLfPr4uD+W3bTiSvY0LMYYPh++G0HYS5iSP3Pems
 i9wKfV2RS/9zowi5hcmREA/taE5j+lnE3m7odh7YR/sMynxkVm+rja1HqFImi7viuduL6QYC5
 b72k5lEwyvjpBYPXxribSMPNC3YZbwQdU9z9rmtlSp0m0j6woc9hTKHEH+0YaqMimiizmUsKM
 9vxB3kWLIR2Ak5n9i+kG+2R35jAL0Mz/HL4y9VnqF0guImj6bTFFr7Y1w==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Michael,

On 15.06.22 at 23:54, Michael Niew=C3=B6hner wrote:

>
> Hi guys,
>
> for me this series causes boot problems - somehow feels like an interrup=
t
> storm...


Thanks for this info. Which hardware do you use?

> Not sure yet, which commit is causing that
> @Tim could you test on any of your devices, please?
>
> BR
> Michael
>

Regards,
Lino
