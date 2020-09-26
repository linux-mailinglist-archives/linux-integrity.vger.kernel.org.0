Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47B279CDB
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Sep 2020 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIZXLB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 19:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZXLB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 19:11:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB94C0613CE
        for <linux-integrity@vger.kernel.org>; Sat, 26 Sep 2020 16:11:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so5283172pgi.1
        for <linux-integrity@vger.kernel.org>; Sat, 26 Sep 2020 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vxv2mB/F+K9oxCcvYmD2yUDwrYjdNsNpHQeG4PBLK9o=;
        b=L7tm2KqH7SSXWkCHCEwFRfP7qz3tBr7QnKO10H0HuiEHk7bas2v3Pv2nWlCTLLfR4J
         WPZor3MKxPLLyh1G20pUwYWNLOXoOl230ZAOu6gCjTHJv44BO2EMSLvO7JNo+cGmTAiY
         np8nccA+kumjfthR8Tfzo8/K26v4ipiNljRAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vxv2mB/F+K9oxCcvYmD2yUDwrYjdNsNpHQeG4PBLK9o=;
        b=KeUhcyFqdkf1GqfxhUmwnjnubZizNdK5zOapGYMJIWxDp9BrhNClDjYqaJzTxUkN6S
         9YcvRs//Oz470Oy3whD/4sslBnflejt4vvvVfE30Z7K4DBVJ4b11p6StXBiTpmdGGmww
         +QGli6CoU7C3cnbix8j9mPFRpAsRDZRrTqZRXIi5mCFon7/hiHDXRqqrFWJPTuFNlDrr
         yY07NWKUYx1KO2an+V9IIdayPBCB9gvnJBIkl6vcj1bYY4wRNFaejAdOCC+kd7mQ1ayW
         voFi2UzCHJAWt8Or/nrULymymannAFKOjnXEs491dIWxU+6t6+fq7CJEvDZnGTKqQMjh
         GCGw==
X-Gm-Message-State: AOAM53020d3JKoBacwgYjDdJxytPECL6krpbOtcn43U+4xdhnYYP5o8G
        ViGa4kTPDiX/4/5UoUFLlrbJcg==
X-Google-Smtp-Source: ABdhPJz98x2CBIxLF/L0g4iMF9amyfxv9IlpTE6w+CpEe0uEow4vZhzsfOkRSAT3NYgyP7fxYhwq0w==
X-Received: by 2002:a63:1312:: with SMTP id i18mr3961333pgl.441.1601161860265;
        Sat, 26 Sep 2020 16:11:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:1ce4:ad3:b588:7a42? ([2601:647:4200:3be0:1ce4:ad3:b588:7a42])
        by smtp.gmail.com with ESMTPSA id in10sm2592013pjb.11.2020.09.26.16.10.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 16:10:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
Date:   Sat, 26 Sep 2020 16:10:58 -0700
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Resending following email in plaintext.

----

Hi James,

Thanks for following up.

We have actually tried change=20
TPM_TIMEOUT_USECS_MIN / TPM_TIMEOUT_USECS_MAX=20
according to https://patchwork.kernel.org/patch/10520247/
It does not solve the problem for ATMEL chip. The chips facing crash is=20=

not experimental, but happens commonly in=20
the production systems we and our customers are using.
It is widely found in Cisco 220 / 240 systems which are using
Ateml chips.

Thanks
Hao =20

> On Sep 26, 2020, at 3:57 PM, James Bottomley =
<James.Bottomley@hansenpartnership.com> wrote:
>=20
> On Sat, 2020-09-26 at 15:31 -0700, Hao Wu wrote:
>> Since kernel 4.14, we fixed the TPM sleep logic
>> from msleep to usleep_range, so that the TPM
>> sleeps exactly with TPM_TIMEOUT (=3D5ms) afterward.
>> Before that fix, msleep(5) actually sleeps for
>> around 15ms.
>> The fix is=20
>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>>=20
>> That fix uncovered that the TPM_TIMEOUT was not properly
>> set previously. We recently found the TPM driver in kernel 4.14+
>> (including 5.9-rc4) crashes Atmel TPM chips with
>> too frequent TPM queries.
>=20
> I've seen this with my nuvoton too ... although it seems to be because
> my chip is somewhat experimental (SW upgrade from 1.2 to 2.0).  The
> problem with your patch is it reintroduces the massive delays that
> msleep has ... that's why usleep was used.  The patch I use locally to
> fix this keeps usleep, can you try it (attached).
>=20
> James
>=20
> ---
>=20
> =46rom d40a8c7691a72de28ea66a78bd177db36a79710a Mon Sep 17 00:00:00 =
2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Wed, 11 Jul 2018 10:11:14 -0700
> Subject: [PATCH] tpm.h: increase poll timings to fix tpm_tis =
regression
>=20
> tpm_tis regressed recently to the point where the TPM being driven by
> it falls off the bus and cannot be contacted after some hours of use.
> This is the failure trace:
>=20
> jejb@jarvis:~> dmesg|grep tpm
> [    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [14566.626614] tpm tpm0: Operation Timed out
> [14566.626621] tpm tpm0: tpm2_load_context: failed with a system error =
-62
> [14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14570.626605] tpm tpm0: tpm2_load_context: failed with a system error =
-62
> [14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> ...
>=20
> The problem is caused by a change that caused us to poke the TPM far
> more often to see if it's ready.  Apparently something about the bus
> its on and the TPM means that it crashes or falls off the bus if you
> poke it too often and once this happens, only a reboot will recover
> it.
>=20
> The fix I've come up with is to adjust the timings so the TPM no
> longer falls of the bus.  Obviously, this fix works for my Nuvoton
> NPCT6xxx but that's the only TPM I've tested it with.
>=20
> Fixes: 424eaf910c32 tpm: reduce polling time to usecs for even finer =
granularity
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> drivers/char/tpm/tpm.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..e4f4b98418ab 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -41,8 +41,8 @@ enum tpm_timeout {
> 	TPM_TIMEOUT_RETRY =3D 100, /* msecs */
> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
> -	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
> +	TPM_TIMEOUT_USECS_MIN =3D 750,      /* usecs */
> +	TPM_TIMEOUT_USECS_MAX =3D 1000,      /* usecs */
> };
>=20
> /* TPM addresses */
> --=20
> 2.26.2
>=20
>=20

