Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6486F43A86C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhJYXpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 19:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231536AbhJYXp3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 19:45:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAF4760ED4;
        Mon, 25 Oct 2021 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635205386;
        bh=nxx/LC6+UODVgts7PKa58lz63lw0L03R/xZXmKBo8RQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sXOdXZ9AjfIA0K0yo1z2O3Y1nDLaPoIMM3ujK+oxhnoUbEyrLy2v/xlzUifTWyqlr
         vSYV7pemPLlRPFeI9671x/Vq5NRcHsvkJ3kn0oCFeG9PyL/5rTe04xopzVdPnApMSj
         5Jw/fR4fViphJIiw0rRXIWuEUGqx03f8XGyxNchLBwF0KNyU/ts0cDSePEkyhkU66M
         Cty3XTdrK6/sR9yeCyGWWsNxspbEmIn6Pw6Vb3Zt9xjYxYb+VyREwJzzZU7JdRbWGy
         ln/VbvH0KWol6dFWs6vs7LP3NbuANPmpbx7YT03XbfePDtXVox2hDCbvGjrVbSGK1u
         ExuFF+QdnB9Gw==
Message-ID: <939315b0eea41b08f41fcc0a9b416e32db079ce0.camel@kernel.org>
Subject: Re: [PATCH v17 2/6] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
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
Date:   Tue, 26 Oct 2021 02:43:03 +0300
In-Reply-To: <20211024164855.250362-3-amirmizi6@gmail.com>
References: <20211024164855.250362-1-amirmizi6@gmail.com>
         <20211024164855.250362-3-amirmizi6@gmail.com>
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
> Fixes: 1f866057291f ("tpm: Fix cancellation of TPM commands (polling mode=
)")
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

Also here, I'm not sure about the fixes tag (same reasoning
as for 1/6).

/Jarkko
