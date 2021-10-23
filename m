Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36532438123
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Oct 2021 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhJWAsj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Oct 2021 20:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhJWAsi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Oct 2021 20:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D3560F8F;
        Sat, 23 Oct 2021 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634949980;
        bh=cek6200KKrJQeOeWvohRYgoT1zaZ5Fkr1h2AwNV8X4w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JLmO3c3d+9IK5NEcYTY2hh26mgtLDOY4neRDfPxYxhcXzE/rGB4ji2t65BfV7xXFT
         LKhvqSkJKt5lZZA/U17xktvvkf9WgY0y01if4sFaXXwO92aYONJLfc2d7DDEZhpuVo
         WUJdtanTuvsm/bG9In9IIbhI4AErudrLErHi/KyAw0BeuRxKKoG5/q/xcqGRHn6jFH
         4EU1bvXIDENzXepC0xasLCAsh3G4fJIwJyPQwjYNPgG5yD4NR1lCFow96uytQWDA7M
         XjdWY9D5jjxFSVyVwLQ+JDFFbYfVgdfrGqTdDuAgIGKkQsoyiDlPYCKRn1ENb2n5Tc
         AsZGf18sy05EQ==
Message-ID: <5d2b8d03837c000e4d605f7d79c81237c7dba00c.camel@kernel.org>
Subject: Re: [PATCH v16 2/6] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Sat, 23 Oct 2021 03:46:18 +0300
In-Reply-To: <20211021120557.69234-3-amirmizi6@gmail.com>
References: <20211021120557.69234-1-amirmizi6@gmail.com>
         <20211021120557.69234-3-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-10-21 at 15:05 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> tpm_tis_req_canceled() function is used to check if the caller requested
> to abort the current operation. It was found that in some cases
> tpm_tis_req_canceled() wrongly returned true.
> Since a cancel request sets the TPM_STS.commandReady field to TRUE, the
> tpm_tis_req_canceled() function should check only the TPM_STS.commandRead=
y
> field value.
> The case for TPM_VID_WINBOND is wrong and was therefore removed.
>=20
> Also, the default comparison is wrong. Only cmdReady bit needs to be
> compared instead of the full lower status register byte.
>=20
> Fixes: 1f866057291f (tpm: Fix cancellation of TPM commands (polling mode)=
)

Please go through the comments for 1/6 and fix the commit
for the rest of the patches.

/Jarkko
