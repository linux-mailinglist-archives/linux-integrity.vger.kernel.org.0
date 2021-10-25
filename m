Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4543A860
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 01:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhJYXnj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 19:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbhJYXni (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1AAE60F46;
        Mon, 25 Oct 2021 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635205275;
        bh=b6yzRw6y3szzb3teMW+pIa+6jSMxXb0jApFQqeZq+KI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q5pMuiMUVVNU3132HWIGgWlwLUev5BufYFfOwttq08e23Mp2hxwL5y8ryeZCWYMn0
         JO/524YevlEbm0/pf9zGBQvNMA/6ywedbMCRdCYxFRTSdtPayoCmkN7XDKFKAxJBA2
         l1+RWlBpNCF35p2lEhRojDp6UX0ZHh635GQqhp5TghfP4ecG1LjbM3i4QR+TT+nM7e
         SwKxxIemueZVcPWzIhpRL+gLNfREos2wtSiWg6O8d4N/N678NUJznK9/bMBP83O4e8
         eGIn5WkmWhdHenTZP9YEEGSu90ezE19AjifDlGQ+O6n5/kKGbL6+pZevewfTraQO7r
         f2szc8XPTuKFA==
Message-ID: <cdeec193f1c1f5294581f349253e8863e64c9f5b.camel@kernel.org>
Subject: Re: [PATCH v17 1/6] tpm_tis: Fix expected bit handling and send all
 bytes in one shot without last byte in exception
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
Date:   Tue, 26 Oct 2021 02:41:12 +0300
In-Reply-To: <20211024164855.250362-2-amirmizi6@gmail.com>
References: <20211024164855.250362-1-amirmizi6@gmail.com>
         <20211024164855.250362-2-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-10-24 at 19:48 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Currently, the driver polls the TPM_STS.stsValid field until TRUE; then i=
t
> reads TPM_STS register again to verify only that TPM_STS.expect field is
> FALSE (i.e., it ignores TPM_STS.stsValid).
> Since TPM_STS.stsValid represents the TPM_STS.expect validity, a check of
> only one of these fields is wrong. Fix this condition so that both fields
> are checked in the same TPM_STS register read.
>=20
> Modify the signature of wait_for_tpm_stat(), adding an additional
> "result" parameter to its call.
> wait_for_tpm_stat() is now polling the TPM_STS with a mask and waits
> for the value in result. This modification adds the ability to check if
> certain TPM_STS bits have been cleared.
> For example, use the new parameter to check in status that TPM_STS_VALID
> is set and also that TPM_STS_EXPECT is zeroed. This prevents a racy
> check.
>=20
> Fixes: 27084efee0c3 ("tpm: driver for next generation TPM chips")

Where does this failure occur in practice? If nowhere, this can be
dropped, and the patch can be considered as a feature. Defining it
as a fix makes only sense, if it needs to be backported to stable
kernels. This requires something to be actually broken.

The commit message does not contain a real bug report. It is just
referring to the specification, which is not a workload.

> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
> =C2=A0drivers/char/tpm/tpm_tis_core.c | 59 ++++++++++++++++++------------=
-----------
> =C2=A01 file changed, 26 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 69579ef..98de2fd 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -44,9 +44,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chi=
p, u8 mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> =C2=A0}
> =C2=A0
> -static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0unsigned long timeout, wait_queue_head_t *queue,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0bool check_cancel)
> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, u8 result,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long timeout,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_queue_head_t *queue, bool chec=
k_cancel)

I would consider renaming this as, given that you are changing the
signature anyway:

tpm_tis_wait_for_stat()

This would be more consistent with the other naming, and make e.g.
grepping kernel tree easier.

How did you end up to the name "result"? I have hard time deriving
from that name the actual semantics. E.g. "expected" would already
a way more sane name.

/Jarkko

