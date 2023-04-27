Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106A6F087F
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbjD0Pia (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbjD0Pi3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 11:38:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13DA26BA
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 08:38:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94ef0a8546fso1411459066b.1
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682609906; x=1685201906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7uiTmpUlfL81ZU9AzSI0GBW5946jNS5Utc+TlhKUqY=;
        b=BF8k0gsGCynf3Aschz2b6YGMo5KEVMtqbqXm/NtTeTwR8Lt9X+D1gnm7GmWlchSfdz
         5QoRUYrWwomsEZHFhpFgcmIqqw7Q+lnpQIPlG3hMVMoznFCy/R1z2gYNEVWj+TRaHK70
         7VY5oHrvBVRcXAMEQNT3+FrZKg9hE+R6Fu0zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609906; x=1685201906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7uiTmpUlfL81ZU9AzSI0GBW5946jNS5Utc+TlhKUqY=;
        b=CaLhIv3JdOQdN7onoKFZS0ZROC2J4I0SzrnekJhGc+f56MJE1KcAkNhRACPb/Bbimg
         ko9gllbbUD3j2KNXPhBSWvK89GRuBv2F+vK5EZ/sF0YOJIIkkZFOrrOz3DS8FJcex4bH
         hUipovRLR7ErkITf6WbCOT+tiIxbqGZT20iF89doSKdLPEO6fDb6zbXzPA1uRORMXltz
         ahhcMfG87oHijt8AjQ50mH22bGl8ziC/Sfq8f+NOMv4r37qYftdPQmkeVK6eG563pDg4
         J9JQRE4x4jhQ9ijpWELW04QIIKhXpB/MvZ4rAw9Sh8eD6Lt6P0Kub9qNwfnHJxigawnu
         PEpQ==
X-Gm-Message-State: AC+VfDxu1fcmGTSTmOKzjw6WJS7SxSiuDv4nZMx3NYYt/gqL/8W7NvV5
        Fc1s7vedYMw9hFmZMy0K/OgiwfzJy00ZOhfVHWddAA==
X-Google-Smtp-Source: ACHHUZ51fEHOifNaQW1dB7mshU89g4Z6gw8cOnDpDTd7Vod4KB1qy7AJNK0ema5gn3FXdzYgTEdqnA==
X-Received: by 2002:a17:906:9c82:b0:94f:6058:4983 with SMTP id fj2-20020a1709069c8200b0094f60584983mr2226183ejc.76.1682609905867;
        Thu, 27 Apr 2023 08:38:25 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id oq27-20020a170906cc9b00b0094f410225c7sm9773220ejb.169.2023.04.27.08.38.25
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:38:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso12591540a12.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 08:38:25 -0700 (PDT)
X-Received: by 2002:a05:6402:403:b0:50a:1604:f04c with SMTP id
 q3-20020a056402040300b0050a1604f04cmr1972054edv.4.1682609904880; Thu, 27 Apr
 2023 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230427111125.13769-1-jarkko@kernel.org>
In-Reply-To: <20230427111125.13769-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
Message-ID: <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 27, 2023 at 4:11=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> This PR fixes a critical bug in my first pull request.

That doesn't work AT ALL.

You have this duplicated line

-       TPM_CHIP_FLAG_FIRMWARE_UPGRADE  =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),

in that patch (presumably due to some edit-time fat-fingering), which
causes lots and lots of

  ./include/linux/tpm.h:285:9: error: redeclaration of enumerator
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
    285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/tpm.h:284:9: note: previous definition of
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99 with type =E2=80=98int=E2=
=80=99
    284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/tpm.h:286:9: error: redeclaration of enumerator
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
    286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

errors.

While I could easily just remove the duplicated lines in my merge,
that would make things non-bisectable, so I unpulled this instead.

             Linus
