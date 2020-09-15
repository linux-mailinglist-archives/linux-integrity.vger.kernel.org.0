Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8E269C21
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 04:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIOCwR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 22:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOCwR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 22:52:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FFC06174A
        for <linux-integrity@vger.kernel.org>; Mon, 14 Sep 2020 19:52:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so986950pjb.2
        for <linux-integrity@vger.kernel.org>; Mon, 14 Sep 2020 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Wqkt9Rd2y6mVMbemGD5EcDI/JVPDhBj+dqOapa15qU=;
        b=RhHzyHuxruc6qux4oxB5Vb0zC4FRJrmAH57HABt9YfzumFlYMyb5f+NwesiUnaKYFA
         mpBXuilzi3DixLoUC4PaLnLAbmawCidcpq3glQiDg/n2rumpC+kQNWWBQYrxibkTsIzf
         sgR84Njz8czYh3cJZUMA/tiAGLNxch9vrI9/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Wqkt9Rd2y6mVMbemGD5EcDI/JVPDhBj+dqOapa15qU=;
        b=QgM0d3VWZW0VwBsdVu53PQW34qYXU8yAlwF0f4O57Dz4KdDJltCmat8WgAaC433G5x
         3XzKtWc9qkeTxGLo3KRP4TRqC61tTSdN0sv5lifBnvlVGjkk0XAzO/qOv0Wxzq6q53zJ
         KY3F0PBGx4r/5xPr1IMQeMEgfUMCYSUVifQLO4fvbFqVsqLthzE2I+x9xNZdEEauWtLu
         mtReCIuwE0x+pg/PxO97KDLDtMl5qEtLeltYZQgaubtVBxPDEUpmOxrYTzhu8N3XVnz3
         q/7QHt5ZyvalPfI7A8hSCVzAIwQWeQV83AEVQBHjoQY021ACaqme26uir96Yk16rs3/+
         b3ig==
X-Gm-Message-State: AOAM530G9fTJIuJhaWeIS37ZmYBHDyhEELoXI/ycXRpWj/pBHzfAgjrD
        xqp57lxLlupNSE60BVzU5i/3fQ==
X-Google-Smtp-Source: ABdhPJw1epT5XKOkLydEhUy38sEK3RRqDz82FjzmPTgcz897/C7Z2ToXldENi9XIC0xlV3F8yMXsVA==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr17187522plc.108.1600138336639;
        Mon, 14 Sep 2020 19:52:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:e90c:6654:7f88:72c0? ([2601:647:4200:3be0:e90c:6654:7f88:72c0])
        by smtp.gmail.com with ESMTPSA id r4sm10404264pjf.4.2020.09.14.19.52.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 19:52:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20200914061343.79018-1-hao.wu@rubrik.com>
Date:   Mon, 14 Sep 2020 19:52:14 -0700
Cc:     linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, seungyeop.han@rubrik.com,
        shrihari.kalkar@rubrik.com, anish.jhaveri@rubrik.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4DE1642-B6A1-4870-92D6-F1CE3BEAD934@rubrik.com>
References: <20200914061343.79018-1-hao.wu@rubrik.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, hamza@hpe.com,
        james.l.morris@oracle.com
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Applied the fix on 5.9-rc4, but it looks like it is not enough to fix =
the issue. There should be other TPM timing changes since 4.15 (where we =
have tested and ensure it works). Need to look into it a bit to see what =
should be the fix in the master branch.

Thanks
Hao

> On Sep 13, 2020, at 11:13 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
> Since kernel 4.14, we fixed the TPM sleep logic
> from msleep to usleep_range, so that the TPM
> sleeps exactly with TPM_TIMEOUT (=3D5ms) afterward.
> Before that fix, msleep(5) actually sleeps for
> around 15ms.
> The fix is =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>=20
> That fix uncovered that the TPM_TIMEOUT was not properly
> set previously. We recently found the TPM driver in kernel 4.14+
> (including 5.9-rc4) crashes Atmel TPM chips with
> too frequent TPM queries.
>=20
> The TPM crash signature is
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl, code=3D0087 (135), =
I/O error
>=20
> $ sudo dmesg | grep tpm0
> [59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
> [59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
> ```
>=20
> =46rom the error code "-62", it looks similar to another bug
> https://patchwork.kernel.org/patch/10520247/
> where the "TPM_TIMEOUT_USECS_MAX" and "TPM_TIMEOUT_USEC_MIN"
> is too small, which causes TPM get queried too frequently,
> and thus crashes.
>=20
> This patch fix the TPM_TIMEOUT to 15ms which was
> the actual timeout TPM chips use before the fix
> from msleep to usleep_range. Thus fixed the crash.
>=20
> Test Plan:
> - Run fixed kernel on system with Atmel TPM chips
>  and ensure crash does not happen
> - Run fixed kernel on system with other TPM chips
>  (IFX / WEC / STM) ensure not breakages from tpm-tool
> ---
> drivers/char/tpm/tpm.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..73259ac0a997 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -37,7 +37,7 @@
> #define TPM_RETRY		50
>=20
> enum tpm_timeout {
> -	TPM_TIMEOUT =3D 5,	/* msecs */
> +	TPM_TIMEOUT =3D 15,	/* msecs */
> 	TPM_TIMEOUT_RETRY =3D 100, /* msecs */
> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
> --=20
> 2.17.1
>=20

