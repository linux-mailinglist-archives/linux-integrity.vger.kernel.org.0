Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719CE409ED0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhIMVH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 17:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhIMVH0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 17:07:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F06860698;
        Mon, 13 Sep 2021 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631567169;
        bh=WHMsQg43LJV/PJPmoR45EGXsHwrBzbGcrTUUq7+QIko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QhKEJQSZqQOBUPe7mrFobpvYGKu4U9GlGuYK1KGijlUeJh2kxyCufhTx1V9om34Xr
         Eb1TxEScN7BudefEeBbimqLJIkHmBUuu7LhyIkfDYb9GANRy2ZCWaIyBspF2SZ0kL5
         liTQeEV4IzJwGT/YMdyeaKZDIeYxMpv4Sj3ZKLEVm0mt3o72YNdjRSkWU+x1C1xJh2
         ljMz6ctwuGdIsz8AXW2fJIR6Y5wK+qVoez4rBeaWFJ/d3phKhpNaCZafht5NkjqRPz
         xMMKD+ipEZxL7476tNPWxlwqmf+IW0jMYy5iP96dF8Iqo/AAaCKBHwviYGi90qVyL1
         S5aq1FwhZRl0Q==
Message-ID: <dd7fbcaafad3259a307f1a2d8a72127e7bcc0630.camel@kernel.org>
Subject: Re: [PATCH v14 1/7] tpm: Make read{16, 32}() and write32() in
 tpm_tis_phy_ops optional
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
Date:   Tue, 14 Sep 2021 00:06:07 +0300
In-Reply-To: <20210913144351.101167-2-amirmizi6@gmail.com>
References: <20210913144351.101167-1-amirmizi6@gmail.com>
         <20210913144351.101167-2-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-13 at 17:43 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Only tpm_tis can use memory-mapped I/O, which is truly mapped into the
> kernel's memory space. Therefore, using ioread16/ioread32/iowrite32 turns
> into a straightforward pointer dereference.
> Some drivers, such as tpm_tis_spi, require more complicated operations to
> read more than one byte at a time and, as a result, will revert to
> read_bytes/write_bytes.
> Therefore, re-implement tpm_tis_{read, write}_{16, 32}, so that they chec=
k
> if implementations for {read, write}_{16, 32} in tpm_tis_phys_ops  exist;
> if they do not exist, then revert to {read, write}_bytes().
>  static int tpm_tis_spi_probe(struct spi_device *dev)

This is otherwise good but lacks explanation why this makes sense, other th=
an
somewhat obvious benefit of having less calbacks, which BTW should be state=
d
explicitly in the commit message too.

You must answer what is your by doing this change, e.g. what you are unable
to do, if the callbacks are removed (just an example).

I get the change, but motivation to do it needs to be there.

/Jarkko

