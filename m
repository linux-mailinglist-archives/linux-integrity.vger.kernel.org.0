Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C744375C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBUfB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 16:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhKBUfA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 16:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 224A7604DA;
        Tue,  2 Nov 2021 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635885145;
        bh=e4utj3G1gFXB02nvKZGU8ND61mIXEnitmSz+lIcMEEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Myw64kPSbRKgiUs8lyMTqaeaAOkZDnP+x9libw20U1KhWNT3H0tD6LJL9IMMMzEMK
         lurszMyad1SI9CyzOL2PoEtFNf2jkulViOapx/94sWbfhyNMWTi0NovC609atTJf52
         arXbhZp3uQgvAcnCSMSCF6WBFWEr7fz4Bv30WkbQuh8bzItAv/l1MaLMspQhhNBZod
         oDO/tAKxbQGzTImPWm0U6NdMWJE3MYflMpc5NvWaAArhfqrpx3360P1QSxxODBDRL0
         F+xiqNOYUsBGBajvZGzFseqhMQUYJKG7Tf6Za89AKBKFUITWj4gRyqw0zwegz5mfyA
         JYz0d3EBbhLVQ==
Message-ID: <cde74ac682e031a033b506f4f5505f0587e8c8d2.camel@kernel.org>
Subject: Re: [PATCH v18 3/6] tpm: Handle an exception for TPM Firmware
 Update mode.
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
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Borys Movchan <borysmn@axis.com>
Date:   Tue, 02 Nov 2021 22:32:23 +0200
In-Reply-To: <20211102152056.241769-4-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
         <20211102152056.241769-4-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-11-02 at 17:20 +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Add a condition to enable communication with the TPM while the TPM is in
> firmware update mode.
> In such a case if power was cut during the TPM firmware update, the drive=
r
> should ignore the "selftest" command return code (TPM2_RC_UPGRADE or
> TPM2_RC_COMMAND_CODE) and skip the rest of the TPM initialization
> sequence.
>=20
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

This is a half-baked handling of the FW upgrade mode.

There's another patch in progress that aims to do proper handling
for it:

https://lore.kernel.org/linux-integrity/20210930160241.9691-1-borysmn@axis.=
com/

I CC'd Borys for further comments/discussion.

/Jarkko
