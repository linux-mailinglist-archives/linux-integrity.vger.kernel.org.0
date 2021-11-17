Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E233B45424C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Nov 2021 09:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKQIHD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Nov 2021 03:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhKQIG7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Nov 2021 03:06:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCD836128E;
        Wed, 17 Nov 2021 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637136241;
        bh=53LIri9ceqQRfbR49DUvFwGparRn4PhQA7Foel/BK+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YIXeJ8t0V0OByv2YUHnyBo3um5VH3vV7JG2RnXV/1f/Yy4/OokwjyKy54eBZHuzMk
         Q2zwCUngN65dAEPiPJL2jpnoqDsJRlU0c4EsBN5gr8IpKJhDxDMBJAkjFsLbi0QSFP
         9gMt2/6EzTUlSmuCWvrS4rJSOugKU65Hwfta6QCa99tHSjIa8SRCSJV15Rm/7K4Dx5
         ZQuPY6WKeNpNFZ0b5OqK5Z0aCm01lStgz9HGcFwCd5zn5UgHXN1jR/qDfSaJjLCZC7
         0EJcwWneqvUbbIyYzVbqXH2g0S1tUhavpBWZfMZYT1FtX2hnpGQXWdJUBHl5j9gQ7e
         ZZRlrDeenlFyA==
Message-ID: <640dd9a5bdb4c28b7429a6ab9507d645de06c125.camel@kernel.org>
Subject: Re: [PATCH v19 2/5] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
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
Date:   Wed, 17 Nov 2021 10:03:58 +0200
In-Reply-To: <20211104140211.6258-3-amirmizi6@gmail.com>
References: <20211104140211.6258-1-amirmizi6@gmail.com>
         <20211104140211.6258-3-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-11-04 at 16:02 +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> tpm_tis_req_canceled() function is used to check if the caller requested
> to abort the current operation. It was found that in some cases
> tpm_tis_req_canceled() wrongly returned true.

Please, bring some context, i.e. please describe the scenarios.

> Since a cancel request sets the TPM_STS.commandReady field to TRUE, the=
=20
          ~~~~~~~~~~~~~~

What the heck is this? Please refer the exact things.


> tpm_tis_req_canceled() function should check only the TPM_STS.commandRead=
y
> field value.

Why?

> The case for TPM_VID_WINBOND is wrong and was therefore removed.

Why?

It is not removed in the existing mainline, so it definitely *was not*
removed.

> Also, the default comparison is wrong. Only cmdReady bit needs to be
> compared instead of the full lower status register byte.

You should split this into two patches, if it fixes two different
issues.

/Jarkko

