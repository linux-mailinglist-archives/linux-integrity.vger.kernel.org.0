Return-Path: <linux-integrity+bounces-2008-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631E898AA2
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C701F21CF9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283C1C2A1;
	Thu,  4 Apr 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRtyVNf1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CB17BA8
	for <linux-integrity@vger.kernel.org>; Thu,  4 Apr 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243165; cv=none; b=X+FOzW1RSV7K3KtDa4LwXfajHRlMu01wlpctswtaUVeC2VOz3nnf5/9N844SI1yHa0vOrlDAWQD3THtvB1K4Lz4uiqvaSfKy4wtAw7TXJwvfRFteEoSEDLLaUSJ4HNIXJw0YRn7J0/Rk9rxNzTgHdvmxzNguc1qN9vlvwF+CyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243165; c=relaxed/simple;
	bh=3DmJ+BJHBv93GF65JWtBHgSNuuvJezge2C1rLsBxN5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SiGYWb5UrPnFgu+9iZKr58TG/yewORJ1N2Il8QRje8fQ7kJHIjBHvWgjHtVekEg6OL64ImstRFnOWB3lGFTFWy7yICVR/iLEUq5+YqnKJ4EB/deiDCKThOGcljFt1OPIQsFAE9MQ8UQGwHZKBNwTBnUFKX/Z8rGqSb0iL8OYXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRtyVNf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47051C433C7;
	Thu,  4 Apr 2024 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243165;
	bh=3DmJ+BJHBv93GF65JWtBHgSNuuvJezge2C1rLsBxN5w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NRtyVNf1tDRe2ZYd+gKGsZZbfBlJfQAmoAQaVx623CgAJftzGLG8SgzLAE2UV0/aM
	 ijUl79hbJRTT652mMgTG3AQsYBYnwfkNou+YB6DoNFkSCPUwZ4qLeAD32xDc+q29gr
	 2Q1Frq4XFtaceJRMT6D8tQ0Kr8RkB9MlUQf6omdoO0pcxFIzaK5zDryGQBNscIi8If
	 +whzn6uHC8YjquvbW/zzGw/DyO8uzUv8Rk/7zAd222+zOtSi8Jp1spEoJBUkx+cd8T
	 OdP4RgBGzYAHy7mSwthis2ApHNT+OnRcSd8JKviylrCZ4+P00lGYzhzr9o6GTco/+2
	 5/eC5GOd4WoRw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 18:06:02 +0300
Message-Id: <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
Cc: <peterhuewe@gmx.de>, <jgg@ziepe.ca>, "Takashi Iwai" <tiwai@suse.de>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "William Brown" <wbrown@suse.de>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
In-Reply-To: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>

On Thu Apr 4, 2024 at 5:19 AM EEST, William Brown wrote:
> Hi all,
>
> I've been recently working on enabling TPM support within a number of PAM=
 modules. I'm certainly not a TPM expert, but I have noticed some issues wh=
en testing.
>
> We have a number of tests/examples in the rust-tss-esapi project, such as=
 an example that shows how to hmac a value:
>
> ```
> # TCTI=3Ddevice:/dev/tpmrm0 cargo run --example hmac --features generate-=
bindings
>     Finished dev [unoptimized + debuginfo] target(s) in 0.07s
>      Running `target/debug/examples/hmac`
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [] })
> hmac1 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, 158,=
 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, 64, 23=
3, 163, 47, 254, 1]))
> hmac2 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, 158,=
 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, 64, 23=
3, 163, 47, 254, 1]))
> ```
>
> When this test program is run repeatedly, it begins to fail with:
>
> ERROR:tcti:src/tss2-tcti/tcti-device.c:197:tcti_device_receive() Failed t=
o get response size fd 3, got errno 14: Bad address
> ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:238:Esys_FlushContext_Fi=
nish() Received a non-TPM Error
> ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:89:Esys_FlushContext() E=
sys Finish ErrorCode (0x000a000a)
> thread 'main' panicked at tss-esapi/examples/hmac.rs:170:48:
> called `Result::unwrap()` on an `Err` value: TssError(Tcti(TctiReturnCode=
 { base_error: IoError }))
> stack backtrace:
>
> This is associated with dmesg erros such as:
>
> [83754.340909] tpm tpm0: tpm2_save_context: failed with a TPM error 0x090=
1
> [83754.343680] tpm tpm0: A TPM error (459) occurred flushing context
> [83754.345650] tpm tpm0: tpm2_commit_space: error -14

0x0901 is TPM_RC_CONTEXT_GAP, which means according to TCG spec that:

"This response code can be returned for commands that manage session
contexts. It indicates that the gap between the lowest numbered active sess=
ion
and the highest numbered session is at the limits of the session tracking l=
ogic.
The remedy is to load the session context with the lowest number so that it=
s
tracking number can be updated."

Since the code is accessing /dev/tpm0 and not /dev/tpmrm0 this issue
should be mitigated by the user space resource manager.

[1] Section 6.2 in https://trustedcomputinggroup.org/wp-content/uploads/TPM=
-2.0-1.83-Part-3-Commands.pdf

BR, Jarkko

