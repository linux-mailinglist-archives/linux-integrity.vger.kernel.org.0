Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6833E1F0
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 00:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCPXPZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhCPXPC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 19:15:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B0C06174A;
        Tue, 16 Mar 2021 16:15:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m7so109832qtq.11;
        Tue, 16 Mar 2021 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdxv2gEJ6NgRGsYoTFeE+bXdNCpfPV/ug1iqUQGuyWs=;
        b=I+Juq/fA7D46g+cZuc71bhSV0g0OVRQu1A93eJc+s8DYgtXURo9Mv47FobjHzYthC2
         csQrEUlxfCxMyAzaPhssL3tuKHz8iRoghRqENHS61qdMGCgU/JQ7m/gGD+AbJ67C4Ym+
         x37zGDX0Gdi7xWlYnx8+7Vi/QWHyRcQ/3RoEG51ZjMcTCPx+E+H2MpCXLYx892MSM0Z3
         bFSWCg2VqQy769wdZ829cDzcGDxd6FGmuRKpwzNfOxq8gfSChrc13wxnT1Gh5vpXJ29P
         D8f3PKvsxlWm1JTg3CF1Z9J76d49C42Dy9ia42dILj5pEAHwqJxHXLmw+hcL+1ZOo8un
         tdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdxv2gEJ6NgRGsYoTFeE+bXdNCpfPV/ug1iqUQGuyWs=;
        b=WmA9PITm8OGVF9V2ffUPD/xaX2okedqh0vwweS0K3g7tOsLSbPWwYMAgoi67/iiw6d
         WIO0cdK/NkHGekjUW/tVG+siJn8cpnHWwsnjkiGsuLNODdLspgrIoCLW8VID1tnE76AM
         XlDueAt8/sSP02+ln/Cz6A7Veab00brv4dqfJIMiRFsyaD6I4H7CUrQtChVWJ1KiNNOL
         3WneWDjE7grbOzgz8egqOXhbNxC34vjb6WBE0AYvFK+BxtmyaqrODnZpOwEdRIdZmJ92
         usGvDMwbio2fWnFYO6G3FFzm4nl2d/stnzk/WBjEBWn5iJhxwMOKT87MZV5i5403Kcto
         jaig==
X-Gm-Message-State: AOAM532XYQ+UBL9Mf7pRXwt/CBwDdrYbSEqp8+WeM4/SCY4WeQkU59ga
        gWX2Y10QhI9H7mhlDazv7KFJ+w9MTrTvm1s4Ex8=
X-Google-Smtp-Source: ABdhPJwSFSqoHDR8eyiSz11ijj/2UuGYRbaQnoudReFeMhDR6IrY2/TG4DcGrS0dkJAifeY0YoopbnEbIffDmuGrwPk=
X-Received: by 2002:ac8:4d59:: with SMTP id x25mr1251534qtv.82.1615936500550;
 Tue, 16 Mar 2021 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 17 Mar 2021 00:14:49 +0100
Message-ID: <CAFLxGvxmRcvkweGSRSLGEm5MJDM4M7nzkp9FwOwmhZ+h2RE0vA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

On Tue, Mar 16, 2021 at 6:24 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> +#include <keys/trusted_caam.h>
> +#include <keys/trusted-type.h>
> +#include <linux/build_bug.h>
> +#include <linux/key-type.h>
> +#include <soc/fsl/caam-blob.h>
> +
> +struct caam_blob_priv *blobifier;

Who is using this pointer too?
Otherwise I'd suggest marking it static.

>  module_param_named(source, trusted_key_source, charp, 0);
> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)");

I didn't closely follow the previous discussions, but is a module
parameter really the right approach?
Is there also a way to set it via something like device tree?

-- 
Thanks,
//richard
