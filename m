Return-Path: <linux-integrity+bounces-4617-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4815A1A12F
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761D77A41DD
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E820CCFB;
	Thu, 23 Jan 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFB6q7e5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6F20CCE4;
	Thu, 23 Jan 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625846; cv=none; b=CqVnkcQavTGxyya2VitDnkUn7Qo0AyJyIF3Z1E1/24PlI148pjRPxVSvRS12dmnHBzDYs7sG/ffYUsHgDJRxjfR7jeQmswfiwVO6HiaGvMqBdHFO5n6oxpUg/1EvO7hJx5GL3yg50Jc3pgpHcOduZl9uEf2VcplvlavdHjYNjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625846; c=relaxed/simple;
	bh=l3G4zaFnVKze3aUnY1RMk3kB+rM/zQJx7o7qCtrqwRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fezVi7hAAJU47C81/XelyYp2jeaFlGHtuFwJtP1a8fODggqP7kwVyuMSB+5PC7XYDFFZ6eG/ebVFqP2SKge6fTTqOhELp0iQ/Zru8s4PceZ9+TfpAywMGDA/A7f+gwDLwuZoAExIOh0pO8zawqWaQtFFREUXr2jzQhuEv8ZE3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFB6q7e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5319DC4CED3;
	Thu, 23 Jan 2025 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737625846;
	bh=l3G4zaFnVKze3aUnY1RMk3kB+rM/zQJx7o7qCtrqwRc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EFB6q7e5Qy/QS0Bt4kyK5cbgb7aN4tz5B1qmerPQC8GRkeYIAy2Xba7vh3ony9fNN
	 EVugiqZQkyMGRK2K6Y3Hq1EO5jpM8F2FpRm8Rz1W6dVuHKEflxVxD0JZCWN7640VCp
	 /BMqf5QDc0DOlfXs+fmcdv07wcK8WR8GdpCca7Vu9rPWmpfLT25ZPj+eopTFXVFyCq
	 EXka363+HJ8DIE03xX7u+r+RSGVksj77OSNaLep6vVaJ9EWFWPWKY9FGj2IQvKaIYD
	 ZWC2OHbrOZF//S3wNkjYt14BappAGXV5HyIPm16TXehuROXJEveAmW73SwLqMLeSTC
	 VW9w0wiP2kwfA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 11:50:40 +0200
Message-Id: <D79CYAVX0LAZ.1MIYNOM6J7MMM@kernel.org>
Cc: "Stefano Garzarella" <sgarzare@redhat.com>, "Jarkko Sakkinen"
 <jarkko.sakkinen@iki.fi>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <james.bottomley@hansenpartnership.com>,
 <linux-coco@lists.linux.dev>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Peter Huewe" <peterhuewe@gmx.de>,
 "H. Peter Anvin" <hpa@zytor.com>, <linux-integrity@vger.kernel.org>,
 <x86@kernel.org>, "Joerg Roedel" <jroedel@suse.de>,
 <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Claudio Carvalho"
 <cclaudio@linux.ibm.com>, "Dov Murik" <dovmurik@linux.ibm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dionna Amalie Glaze" <dionnaglaze@google.com>
X-Mailer: aerc 0.18.2
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>
 <D725V628UV87.31SUEYVF9IUUC@kernel.org>
 <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
 <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>
In-Reply-To: <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>

On Wed Jan 22, 2025 at 11:29 PM EET, Dionna Amalie Glaze wrote:
> I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
> paper to me, which solves some interesting problems we need to solve
> in SVSM too. So thanks for that.
>
> Just to clarify, you're not asking for SVSM to implement the TIS-MMIO
> interface instead, but rather to use the fTPM stack, which could make
> SVSM calls a TEE device operation?

I don't really know what I'm asking because this is barely even a
PoC, and I state it like this knowingly.

You should make the argument, and the case for the solution. Then
it is my turn to comment on that scheme.

That said, I would not give high odds for acceptance of a duplicate
TPM stack succeeding.

BR, Jarkko

