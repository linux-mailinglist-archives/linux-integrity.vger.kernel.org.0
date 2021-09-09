Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486CE405C21
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhIIRdv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhIIRdv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:33:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8634C061574
        for <linux-integrity@vger.kernel.org>; Thu,  9 Sep 2021 10:32:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2055802pjw.2
        for <linux-integrity@vger.kernel.org>; Thu, 09 Sep 2021 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xXAUXrLhMkMn6VhpiJU5BiksuV5wlrfB1eUUZokaP+A=;
        b=IKy7qJsolw+oD9DJFno6Jv5NYhYhLtg196DqFBphWJuigfgnPHIY4xdnRdy2QCDdgm
         S9uJLIlU1i452Ksw/RhNAWNDcqghTxSvLT7cWCa8ddn2Q98bG19h2JWWodWEZvBL0W1I
         8UK1LY71Absf0GnPVCL3ZdPz9wNVK6hORcx6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xXAUXrLhMkMn6VhpiJU5BiksuV5wlrfB1eUUZokaP+A=;
        b=kIGK4jcXDS31D0Ws5jlEdDG/z5HzL9oP6a9jbP6WeNMG+MNERKiHJ6Wda5NWZYvZpP
         LUpyUsEzuqYrhvL4sp1Z+Knqd1FNKKIGLvUrJwCV0OOntG9Svabouyqz98tISoyHRH5t
         JVdr9hPXesj/LL2vuo+OgKGUORAiHwas9p86k2R7S1FDiGLYtYyPu6ZHlxEkxoIPCIFl
         fqSU24nLT69cAUW9LbIktAFJZwLGO0M6ztC4G+PfIlioBAr/8QVF96ufYggD1i8i8o68
         3hwAHWR9h0TpTuGXcSQTalzv+bOvZormxNs4Mz6f/rxtVzoqrYXDd3RhN6xOCwr9sFd7
         sYSg==
X-Gm-Message-State: AOAM530Zb0Ep/OkmUqJH7M8wWVdkKAVoi6u6IjUQTi3QdXU6O1LjkQ4G
        Bm1hyw1djuqZyqnHPMRPvEwoqA==
X-Google-Smtp-Source: ABdhPJxPTLcv/6sVkgKJ+eYyzGO39P/rqCZwWGlsYmqnamxBi71uB5sCoAqWTctYeamDhR/SfPJwXA==
X-Received: by 2002:a17:90a:69a4:: with SMTP id s33mr4693529pjj.217.1631208761128;
        Thu, 09 Sep 2021 10:32:41 -0700 (PDT)
Received: from smtpclient.apple (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id m18sm2945878pjq.32.2021.09.09.10.32.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:32:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v6] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <3f3d10544a3f83e4a940896abeb80da948cba827.camel@kernel.org>
Date:   Thu, 9 Sep 2021 10:32:31 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6531E571-CC29-4F27-A210-2AEE8E21B3B0@rubrik.com>
References: <20210908092606.96115-1-hao.wu@rubrik.com>
 <3f3d10544a3f83e4a940896abeb80da948cba827.camel@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 9, 2021, at 7:08 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, 2021-09-08 at 02:26 -0700, Hao Wu wrote:
>> The Atmel TPM 1.2 chips crash with error
>> `tpm_try_transmit: send(): error -62` since kernel 4.14.
>> It is observed from the kernel log after running `tpm_sealdata -z`.
>> The error thrown from the command is as follows
>> ```
>> $ tpm_sealdata -z
>> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
>> code=3D0087 (135), I/O error
>> ```
>>=20
>> The issue was reproduced with the following Atmel TPM chip:
>> ```
>> $ tpm_version
>> T0  TPM 1.2 Version Info:
>>  Chip Version:        1.2.66.1
>>  Spec Level:          2
>>  Errata Revision:     3
>>  TPM Vendor ID:       ATML
>>  TPM Version:         01010000
>>  Manufacturer Info:   41544d4c
>> ```
>>=20
>> The root cause of the issue is due to the TPM calls to msleep()
>> were replaced with usleep_range() [1], which reduces
>> the actual timeout. Via experiments, it is observed that
>> the original msleep(5) actually sleeps for 15ms.
>> Because of a known timeout issue in Atmel TPM 1.2 chip,
>> the shorter timeout than 15ms can cause the error described above.
>>=20
>> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
>> reduced the timeout to less than 1ms. With experiments,
>> the problematic timeout in the latest kernel is the one
>> for `wait_for_tpm_stat`.
>>=20
>> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
>> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
>> for Ateml TPM 2.0 chip, and chips from other vendors.
>> As explained above, the chosen 15ms timeout is
>> the actual timeout before this issue introduced,
>> thus the old value is used here.
>> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
>> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
>> the existing TPM_TIMEOUT_RANGE_US (300us).
>> The fixed has been tested in the system with the affected Atmel chip
>> with no issues observed after boot up.
>>=20
>> References:
>> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
>> 1.2/2.0 generic drivers
>> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
>> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
>> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
>> granularity
>>=20
>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>=20
> Thanks!
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> /Jarkko

Thanks Jarkko for the review. What is the next step on my side?=20

Hao

