Return-Path: <linux-integrity+bounces-4259-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E951B9DEEC0
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 03:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC09281799
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BA27447;
	Sat, 30 Nov 2024 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMlX06WB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1629B0;
	Sat, 30 Nov 2024 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732934666; cv=none; b=Ojsd9NPI0+vn8QzPl3VDUoAUyTL3ycUcv+uvzKDCiNtlLdF+VGUAvgoQiM+MQMnMs5fDVBYIKVFDYfofbLFEdj7sGx0ZJJCptcsz1JXMuJhDVNtbJLqbFF6RjVMb6PPasihZ2fUBU4ShghEGzSxFFoaGhrDvMWP6xIemQFwh+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732934666; c=relaxed/simple;
	bh=x07AbXnYtdGORKpShT3ofiSwhdl9R8Rkyj5bJS57toQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O7HmntDFREW/X3isWcIndhJxADUUx/5APV6/Q+UUubeEfEfnb4+phy/adwW42gRiwJ7heafKy6Sm60KaLK0xHFfrWexJfnqzWkrtREZgaKRiXIUV/ZX1MfDUkF+peRN8Yjc5luKLlHibSbUj5H3TmJ0yGdILvj+N6mlkNmJzmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMlX06WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46163C4CED2;
	Sat, 30 Nov 2024 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732934665;
	bh=x07AbXnYtdGORKpShT3ofiSwhdl9R8Rkyj5bJS57toQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aMlX06WBJ5JAfV2v66xaao5eHkN8N/mogdEl82PyQpERsrGuaeAxrG2OaUFgJL0/p
	 SbfglhMBB/+c0PufctWiwPMGI3VoNUrYNWL+16dPOUlG8xvkSklmvVlD95xriKb0MC
	 t5cpUIFT2MOBGiqFwo6HwTrv9EZrh5O5RhMrsEICpwDAWZE9h3mu8VCDP9IAIO03aR
	 C1UXK6DBg+NUyDxEJ6I0hEceRcNQ3tO696hNOOLqiKMcXmvdSl4/4wlaHYn8Ymu/SS
	 YnfrgRrSsqftY5GfgwmAZU3xIojsE3VdgxEW3pyRZ0nfBs8emhxBYVcROn+dKMHzJe
	 FzMrFl2OZUiSQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Nov 2024 04:44:21 +0200
Message-Id: <D5Z62H0XCOQM.J4V5ZDH9E7C7@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones
 since 1b6d7f9eb150
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Christian Heusel" <christian@heusel.eu>
X-Mailer: aerc 0.18.2
References: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
 <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
 <b3a01060-f59b-430d-afcc-48c5ec628bcb@heusel.eu>
In-Reply-To: <b3a01060-f59b-430d-afcc-48c5ec628bcb@heusel.eu>

On Tue Nov 26, 2024 at 1:42 PM EET, Christian Heusel wrote:
> On 24/10/25 05:47PM, Jarkko Sakkinen wrote:
> > Yeah, this is on the list.
> >=20
> > See: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383#c5
> >=20
> > I had a fix for the AMD boot-time issue already over a month ago
> > but unfortunately took time to get enough feedback.
> >=20
> > BR, Jarkko
>
> I'm not sure if this is supposed to be fixed, but AFAIK we hoped that
> the patchset that was mentioned in bugzilla also helped this issue.
>
> The reporter said that the bug is still present in 6.12.1, so this might
> need further poking =F0=9F=A4=94

I'd suggest a workaround for the time being.

In 6.12 we added this for (heavy) IMA use:

tpm.disable_pcr_integrity=3D [HW,TPM]
                        Do not protect PCR registers from unintended physic=
al
                        access, or interposers in the bus by the means of
                        having an integrity protected session wrapped aroun=
d
                        TPM2_PCR_Extend command. Consider this in a situati=
on
                        where TPM is heavily utilized by IMA, thus protecti=
on
                        causing a major performance hit, and the space wher=
e
                        machines are deployed is by other means guarded.

Similarly it might make sense to have "tpm.disable_random_integrity"
that disables the feature introduced by the failing commit.

What do you think?

>
> Cheers,
> Chris

BR, Jarkko

