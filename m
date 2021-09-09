Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD04058A5
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbhIIOKI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 10:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351483AbhIIOJi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 10:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 594AB6115A;
        Thu,  9 Sep 2021 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631196508;
        bh=yP+ysKgI6gksJztduaF0K0VhsMtgg2xjeDMysyA7SgE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=GaqjbqpanNTMgd+gx5NhvbUoJjxpmdKXbak4y3Y7DRP8b3R41qf+QEBYlpiyeNmc6
         Wk8FQBRcBB3//Cg76sPVIm54YJL615K+HZRX7JFVdZPLU2tGExJscCcGkH0zzXmNSw
         6CrF4jzePXCXwWSr+JCccTY36aPBE/t3NN+6quy7dIJytdHjC9XZma5Q0etvv2J7Lz
         DCaHxd49uyRYFBry7cjTPmft7RgxyimGj/R41UJAvNhiDk5iDz6wiby0OEHOQpp1JZ
         E52ZCuDs2OQayj12sw10sWA3oicK727lw6D2hytImehjT9+vIPdzfHy+dCd5xJlXwB
         M/1mUmq45/1ZA==
Message-ID: <3f3d10544a3f83e4a940896abeb80da948cba827.camel@kernel.org>
Subject: Re: [PATCH v6] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        pmenzel@molgen.mpg.de, kgold@linux.ibm.com,
        zohar@linux.vnet.ibm.com, why2jjj.linux@gmail.com, hamza@hpe.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        nayna@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com
Date:   Thu, 09 Sep 2021 17:08:26 +0300
In-Reply-To: <20210908092606.96115-1-hao.wu@rubrik.com>
References: <20210908092606.96115-1-hao.wu@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 02:26 -0700, Hao Wu wrote:
> The Atmel TPM 1.2 chips crash with error
> `tpm_try_transmit: send(): error -62` since kernel 4.14.
> It is observed from the kernel log after running `tpm_sealdata -z`.
> The error thrown from the command is as follows
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
> code=3D0087 (135), I/O error
> ```
>=20
> The issue was reproduced with the following Atmel TPM chip:
> ```
> $ tpm_version
> T0  TPM 1.2 Version Info:
>   Chip Version:        1.2.66.1
>   Spec Level:          2
>   Errata Revision:     3
>   TPM Vendor ID:       ATML
>   TPM Version:         01010000
>   Manufacturer Info:   41544d4c
> ```
>=20
> The root cause of the issue is due to the TPM calls to msleep()
> were replaced with usleep_range() [1], which reduces
> the actual timeout. Via experiments, it is observed that
> the original msleep(5) actually sleeps for 15ms.
> Because of a known timeout issue in Atmel TPM 1.2 chip,
> the shorter timeout than 15ms can cause the error described above.
>=20
> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
> reduced the timeout to less than 1ms. With experiments,
> the problematic timeout in the latest kernel is the one
> for `wait_for_tpm_stat`.
>=20
> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
> for Ateml TPM 2.0 chip, and chips from other vendors.
> As explained above, the chosen 15ms timeout is
> the actual timeout before this issue introduced,
> thus the old value is used here.
> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
> the existing TPM_TIMEOUT_RANGE_US (300us).
> The fixed has been tested in the system with the affected Atmel chip
> with no issues observed after boot up.
>=20
> References:
> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
> 1.2/2.0 generic drivers
> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
> granularity
>=20
> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.=
2/2.0 generic drivers")
> Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926=
223150.109645-1-hao.wu@rubrik.com/
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>

Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

