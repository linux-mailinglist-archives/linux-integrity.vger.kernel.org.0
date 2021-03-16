Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1038533E1E6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCPXLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCPXLG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 19:11:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E4C06174A;
        Tue, 16 Mar 2021 16:11:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u7so100443qtq.12;
        Tue, 16 Mar 2021 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/UaZC+XXVUcVdTveyndzmJ58HNMu0OJHwUaCal2y4I=;
        b=DWIL2oGg7zQM/EYvfmH+wg1SfR48ysllZF1J4pLop4dQhVRrYYZ+27DsrMmrMqfZNk
         lwIksI+Z9vmnWeE4i2C9m+95ayXZvdr2E5Yt/A/rVBxKZ5iMPFSDVopZFzK17v8xlNta
         Q1n5CEtyRnvPRClsZ/XS3BLdcRLMzh45zVBoPafx7skLLIOX95CKDTy8JseNCLSiDs9r
         SGDhYWajiaBY+qYrZ37wZqCRh/dOvxhUBOdyJTiQBRxm+L9f/pMXN6UMwyj10ON4gelV
         RirPhySNpMVXgzw2y1tGBd1AucsKVn5V7B/S0ERKDL1vR4u18IoMWXvyiYSoi+8x/tSo
         6reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/UaZC+XXVUcVdTveyndzmJ58HNMu0OJHwUaCal2y4I=;
        b=fcu2G+moP4pR7s9eqGMbdA+aoZYiFIALoGvjHVf0FLw9WZvx2iMZJ0YqzNaD1/sOe2
         vz8Vcnd2uii76N2ovY9zrEIEQQxWvg0847xgYaRFKT1iZsYAxx6UROaC2qSJ/0NbHG1Y
         t8/3TJiQ6r1a6/b7+6LBGMrKUQJvnQzO2QOanxDOiWq57X62lP1UcldHeqf5NF4lmo9s
         MrJUR3baXXpIJ+IZ1j8h2e8c0n1VEqlRhaMu2SopHQzpRSwP0IErkmiLpdGOVU33nYli
         85SKsadvdDRQO035YZmvmg+UewbkTuQVGjl10oUEb3QB52UZua/D42Gd8kMhUK9o7tnP
         p8WA==
X-Gm-Message-State: AOAM531NjIK7UQNuOVCFh41skrv9pxCsE6QyRAXFcTMFGnJJWDp0r5iZ
        4qqVzvKMEOBmnIl4npaW/WCIDr+Roedydsk/SD0=
X-Google-Smtp-Source: ABdhPJxBFEdBNeCzBmhwsG1aiJERpTBfwg0fFaw3iI8a5NkF1tW33vYv8sNXVeRPlYiFnXqtWtTHy9R3MmjOrn3/z5c=
X-Received: by 2002:ac8:544:: with SMTP id c4mr1170921qth.245.1615936265576;
 Tue, 16 Mar 2021 16:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 17 Mar 2021 00:10:54 +0100
Message-ID: <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

On Tue, Mar 16, 2021 at 6:24 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key. There has been multiple
> discussions on how to represent this within the kernel:
>
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
>
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit added[2] a new "secure" key type with the CAAM as backend. The key
>    material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not specific
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>    basis for TEE-backed keys.
>
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. The key
>    material stays within the kernel only, but can optionally be user-set
>    instead of coming from RNG. James voiced the opinion that there should
>    be just one user-facing generic wrap/unwrap key type with multiple
>    possible handlers. David suggested trusted keys.
>
>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends with
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
>
> This patch series builds on top of Sumit's rework to have the CAAM as yet another
> trusted key backend.
>
> The CAAM bits are based on Steffen's initial patch from 2015. His work had been
> used in the field for some years now, so I preferred not to deviate too much from it.
>
> This series has been tested with dmcrypt[5] on an i.MX6DL.

Do have this series also in a git repo to pull from?
I'd like to give it a test on various systems.

> Looking forward to your feedback.

Thanks for working on this! David and I will have a closer look these days.

-- 
Thanks,
//richard
