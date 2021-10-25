Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB37943A870
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhJYXqb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 19:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231536AbhJYXqb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 19:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29ECF603E5;
        Mon, 25 Oct 2021 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635205448;
        bh=rZ7biUPY94zqCXiTe14aw4ZrVEvHsGTcVZleNzWkImw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rMXyePu1FlybppPafa8lFxKoWJQ2xUWDwt4qSbWw2JV+GB/Y261ODxuwJbrrWycAJ
         1m1GTpLBjQz8ypGiJoYzZPu+M3yuzyFjaBWy9iZ5PxjLQ4c184BK2ij0ggKV1K7bwR
         3NcYrlx+/SQsNQZdWuHRQbNAeiH4JMn5/MMmueaLGe+DpIRy5piNLLJu4ucORdj+P8
         8VWHM1Cqet0goLOPh+cN0WR3Eyi9eTJD31h9p8+uUYVX3T8b6eSns6Mmv4a6pO7PZ0
         92MENQm78vLg96IJVLM5wqb8Wqt+Iz9Oi3Nj6N8nPD+rgcK+WUfmOdOZfUeTNIRa0b
         Dc962FWEd/pWA==
Message-ID: <ea36844431da0a181510254f6027a63a6f0c4c29.camel@kernel.org>
Subject: Re: [PATCH v17 4/6] tpm: tpm_tis: Verify TPM_STS register is valid
 after locality request
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
Date:   Tue, 26 Oct 2021 02:44:06 +0300
In-Reply-To: <20211024164855.250362-5-amirmizi6@gmail.com>
References: <20211024164855.250362-1-amirmizi6@gmail.com>
         <20211024164855.250362-5-amirmizi6@gmail.com>
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
> This issue could occur when the TPM does not update TPM_STS register afte=
r

What is "this issue"?

/Jarkko

