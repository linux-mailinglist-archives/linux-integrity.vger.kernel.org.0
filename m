Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0D44373D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBU0U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 16:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhKBU0U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 16:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4034D60462;
        Tue,  2 Nov 2021 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635884624;
        bh=5/wUb1AWpBNaKON4oOaqQttekyeoARbnRgqGLCkMou0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ww7CID6qUi7oaozin+hVUniWUALaUwIHE9B3OUCTIiKGh6QG6Ktb+0jML8xT/Gz4Y
         niYd1WI2051WzDINfKvIfM83O4T2xtKnnjtj9Xgxsw8jLJTZ2wHs6Mlt5bK9XlVRvq
         S2Xo5dvBXcciT4IabfPft7JGWPHHNTCkXbSBhR6U1d2PDr0LGneTtzL5k4YEI8DlPU
         l8UJut50WAIjlHP2fkw/ddB4uh+FncZ4aJzIHXg4ubjcXE5++DrgldoQgyAI7fGk3a
         NSSsk6PCpYmN9zaNMRjJlvYnZs/7G7/oQttr31z+RhBY+QpB8K5P6zmuRrvM5hNvgQ
         yVwSolQV/oSQg==
Message-ID: <67f172376783be95d4ae8ee049f3b27b2b519cf9.camel@kernel.org>
Subject: Re: [PATCH v18 1/6] tpm_tis: Fix expected bit handling and send all
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
Date:   Tue, 02 Nov 2021 22:23:42 +0200
In-Reply-To: <20211102152056.241769-2-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
         <20211102152056.241769-2-amirmizi6@gmail.com>
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
> Currently, the driver polls the TPM_STS.stsValid field until TRUE; then i=
t
> reads TPM_STS register again to verify only that TPM_STS.expect field is
> FALSE (i.e., it ignores TPM_STS.stsValid).
> Since TPM_STS.stsValid represents the TPM_STS.expect validity, a check of
> only one of these fields is wrong. Fix this condition so that both fields
> are checked in the same TPM_STS register read.
>=20
> Modify the signature of wait_for_tpm_stat() to tpm_tis_wait_for_stat(),
> adding an additional "expected" parameter to its call.
> tpm_tis_wait_for_stat() is now polling the TPM_STS with a mask and waits
> for the value in "expected". This modification adds the ability to check =
if
> certain TPM_STS bits have been cleared.
> For example, use the new parameter to check in status that TPM_STS_VALID
> is set and also that TPM_STS_EXPECT is zeroed. This prevents a racy
> check.
>=20
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

Thank you, this looks legit now!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
