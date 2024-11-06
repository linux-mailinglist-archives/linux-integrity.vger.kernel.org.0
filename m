Return-Path: <linux-integrity+bounces-4040-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D519BFA4B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC91C216FA
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3C20E007;
	Wed,  6 Nov 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwH0kuOl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08720CCF9;
	Wed,  6 Nov 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936553; cv=none; b=aygLsfjJTJ3ISDgCfmjXWyGq7Wc6HB7c7SgSfUmU+h/ePxRbzkXIQl/7lKBle1IydoZCsdTaeMkM5SujtBRzCk4/mluaYNVJjEi2YAgL4TivmC0zRKUkIb0/+dt5csWl8cEz6WXaSQ08R+qtRmGTSL9LIBZlFC4r3ik+RTNFzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936553; c=relaxed/simple;
	bh=B1q7o+npEoONKwZmnr+KFAXAIsKTSD/0UKSdelMk7Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=XDtmrlONR/laRtAIUf2TnTLdUnGmjgtNVaA/WQzuHrrLhzhIIYfm22mMgHWrpDHN/1IcxL7QE3dxPebHoe4emaQJbA8aQg/T9S0zdauvLZLW8CCwGihn20K2lJyQ6GrLS9I8b15uBU2sM4m/T2PJn8Rn2q7O6zlWO2mp580dEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwH0kuOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E15EC4CEC6;
	Wed,  6 Nov 2024 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730936552;
	bh=B1q7o+npEoONKwZmnr+KFAXAIsKTSD/0UKSdelMk7Rs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iwH0kuOl6SbK91wua1CEGvb9JBuxe2cxK8n/n9kZUc5L8fzfw5wYuRirzPkDrGZek
	 KdwDNVRDDDTWAb9e3kbg5JLHJVpSxwyzKkRhYI9AL70zGB1l6WfpiQR4etzY11307u
	 adBO2eHBuIiCaqQYTL2Vhwm7Mc8/V5icEDQMAJ9De+fswN+KsItcD0m43hpMsJIlIP
	 G/xlttdEJ24HVxhDkdeNrsh6JtxLF2wWTK+i5zgTBXm+BclywfXI9/3c7jyo0yfANr
	 /Mqa39d5fm+n5A2bHd/qR0GODhSfXXES3pVRbZlrOvyUtbgjH/INsSy7lz3pZIku92
	 PW/v8KdGFk43g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 01:42:28 +0200
Message-Id: <D5FHSOW7V440.36E1YDA8Q2698@kernel.org>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
 <christian@heusel.eu>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
 <D5FHR6UVEH4G.1OE6D5PDU26X5@kernel.org>
In-Reply-To: <D5FHR6UVEH4G.1OE6D5PDU26X5@kernel.org>

On Thu Nov 7, 2024 at 1:40 AM EET, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 1:22 AM EET, Jarkko Sakkinen wrote:
> > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble wi=
th
> > > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> > >
> > > The random number generator reseed occurs in a kernel thread that fir=
es
> > > about once a minute, so it doesn't show up in really any of the boot
> > > timings.  Plus even with sessions added, what there now isn't a
> > > significant overhead even to the running kernel given it's asynchrono=
us
> > > and called infrequently.
> >
> > Ah, right then we need the boot flag, and my earlier comments to the
> > parameter apply. I've never used IMA so I don't actually even know in
> > detail how it is using TPM.
> >
> > Now that I did some seek I mixed this up with the report:
> >
> > https://chaos.social/@gromit/113345582873908273
> >
> > Anyway concerning this issue and patch, my earlier comments still apply=
.
>
> Makes me wonder tho why do we then export tpm_get_random() in the first
> place? HWRNG does not needed that export, and the code does not have any
> of the mentioned features.

I mean specifically the code for tpm_get_random() and tpm2_get_random().

BR, Jarkko

