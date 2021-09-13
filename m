Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E22409EE3
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbhIMVLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 17:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhIMVLo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 17:11:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF4860FC1;
        Mon, 13 Sep 2021 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631567428;
        bh=5bdCCTygd91fQIytnh4lqUemAO4kuKMYzwmLEv44tvo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tnmGMWWIiXSL0/IB+sPHdGhSQuNbkRoSnCJGahZa3iFVZJFEJpMHLPK3OFRSkQC/K
         HxX0QBKiXkc3H6BAI+y+HO4sgUEibLLRYFl0eLVMMaF7gOcinA0rSYBzDxvAMk6C1h
         2o96dGLi5r7Tw/bKMJPM9/PXQhwKCAU0/OBmXJ6O0VpXvpW5e4FTubyYxattb+n6O5
         F2xj1KzsZM6xvP6cRAdiB+wWbtzSGck7rxgZT7Qtcq9WAzzvFSezTrLXQo3TlDJKXM
         isoY/Y8vBRNkHwyB8NfK0gbo/vfMsd5sTzdCD6LjW5k9PU2UYhEd0tmilFAH4Lm6cY
         gNw/YYH+TpKXA==
Message-ID: <5659e538b806c64cd738b13d89663890034447d0.camel@kernel.org>
Subject: Re: [PATCH v14 2/7] tpm: tpm_tis: Fix expected bit handling and
 send all bytes in one shot without last byte in exception
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
Date:   Tue, 14 Sep 2021 00:10:26 +0300
In-Reply-To: <20210913144351.101167-3-amirmizi6@gmail.com>
References: <20210913144351.101167-1-amirmizi6@gmail.com>
         <20210913144351.101167-3-amirmizi6@gmail.com>
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
> Detected an incorrect implementation of the send command.
> Currently, the driver polls the TPM_STS.stsValid field until TRUE; then i=
t
> reads TPM_STS register again to verify only that TPM_STS.expect field is
> FALSE (i.e., it ignores TPM_STS.stsValid).
> Since TPM_STS.stsValid represents the TPM_STS.expect validity, both field=
s
> fields should be checked in the same TPM_STS register read value.
>=20
> This fix modifies the signature of 'wait_for_tpm_stat()', adding an
> additional "mask_result" parameter to its call and renaming it to
> 'tpm_tis_wait_for_stat()' for better alignment with other naming.
> 'tpm_tis_wait_for_stat()' is now polling the TPM_STS with a mask and wait=
s
> for the value in mask_result. The fix adds the ability to check if certai=
n
> TPM_STS bits have been cleared.

Use imprative form, e.g. "Modify the signature...".

>=20
> This change is also aligned to verifying the CRC on I2C TPM. The CRC
> verification should be done after the TPM_STS.expect field is cleared
> (TPM received all expected command bytes and set the calculated CRC value
> in the register).

What does it mean when you "align to verifying"?

> In addition, the send command was changed to comply with
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
> - send all command bytes in one loop
> - remove special handling of the last byte
>=20
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>


I don't think the rename is important enough to be done, and it
definitely should not be melded into another patch.

/Jarkko

