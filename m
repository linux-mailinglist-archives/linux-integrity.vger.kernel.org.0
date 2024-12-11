Return-Path: <linux-integrity+bounces-4357-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AD9ED304
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883AA281C0D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F21DE2BA;
	Wed, 11 Dec 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k4IbfY3s";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k4IbfY3s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E71D934B;
	Wed, 11 Dec 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936574; cv=none; b=JQ4JEgZwaMLcibKd7y/xfDJ80iqV1WnQJ7NAsYqLDy80yiQEFsxC9jafBaRnjhIioOI7Muo0vVSBIfOIaYKv/WfUlEHToBVtMnE1AIfo8/phPOAHeLN/hp7o5ZPrEOKzB9cGSUerDsERkldtNJeaafufsqKqLOKDTKvhm3hSfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936574; c=relaxed/simple;
	bh=9FBHdM5vw9ed3NmvDQfzEc4hChmQSrZEU3I0PFW8D/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrnV4kZosW2np7jwTrhQxM0jld8YiOb83REP4Q6tATsv4PuaNpQc+yFs/GqP7IeG4sWiee4zfsuPrr+0NnQvTeKzZL8sX1Ajg5G+SFIMCeL4Qr9H1xJd8vv7h2mTGGifdtlVoJamyEKFocttYvsXGOBS6IqDbaQgmaRBICc3Mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k4IbfY3s; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k4IbfY3s; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733936571;
	bh=9FBHdM5vw9ed3NmvDQfzEc4hChmQSrZEU3I0PFW8D/Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k4IbfY3sBVufrN53CdC4Ny5AyHCQkg/t0Nl+Wt8Jcz5p6KVOZ4xlf1ICtQ91P55DR
	 LfVYdF1rjx7vtiwO8D8Pd7t/lSUB43dYZxHxQ6syYRXP1pQ7AMre393eoOqEbbYQrL
	 YSRocspkK6EAga3ISIZ5LqXC1KI4l4V9VxEZHsaA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E16DC128B0EE;
	Wed, 11 Dec 2024 12:02:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id haiLfIhCz8St; Wed, 11 Dec 2024 12:02:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733936571;
	bh=9FBHdM5vw9ed3NmvDQfzEc4hChmQSrZEU3I0PFW8D/Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k4IbfY3sBVufrN53CdC4Ny5AyHCQkg/t0Nl+Wt8Jcz5p6KVOZ4xlf1ICtQ91P55DR
	 LfVYdF1rjx7vtiwO8D8Pd7t/lSUB43dYZxHxQ6syYRXP1pQ7AMre393eoOqEbbYQrL
	 YSRocspkK6EAga3ISIZ5LqXC1KI4l4V9VxEZHsaA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3EB6A128B0ED;
	Wed, 11 Dec 2024 12:02:50 -0500 (EST)
Message-ID: <9083d4cd50649ea1971e31445c554f44e8d12bf9.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Stefano Garzarella
	 <sgarzare@redhat.com>, linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>,  Peter Huewe <peterhuewe@gmx.de>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org,  x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,  Jarkko
 Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho
 <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>
Date: Wed, 11 Dec 2024 12:02:49 -0500
In-Reply-To: <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
	 <20241210143423.101774-4-sgarzare@redhat.com>
	 <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-11 at 10:30 -0600, Tom Lendacky wrote:
> On 12/10/24 08:34, Stefano Garzarella wrote:
[...]
> > +static bool is_svsm_vtpm_send_command_supported(void)
> > +{
> > +       struct svsm_call call = {};
> > +       u64 send_cmd_mask = 0;
> > +       u64 platform_cmds;
> > +       u64 features;
> > +       int ret;
> > +
> > +       call.caa = svsm_get_caa();
> > +       call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > +
> > +       ret = svsm_perform_call_protocol(&call);
> > +
> > +       if (ret != SVSM_SUCCESS)
> > +               return false;
> > +
> > +       features = call.rdx_out;
> > +       platform_cmds = call.rcx_out;
> > +
> > +       /* No feature supported, it must be zero */
> > +       if (features)
> > +               return false;
> 
> I think this check should be removed. The SVSM currently returns all
> zeroes for the features to allow for future support. If a new feature
> is added in the future, this then allows a driver that supports that
> feature to operate with a version of an SVSM that doesn't have that
> feature implemented. It also allows a version of the driver that
> doesn't know about that feature to work with an SVSM that has that
> feature.
> 
> A feature added to the vTPM shouldn't alter the behavior of something
> that isn't using or understands that feature.

I actually don't think this matters, because I can't see any reason to
use the SVSM features flag for the vTPM.  The reason is that the TPM
itself contains a versioned feature mechanism that external programs
already use, so there's no real need to duplicate it.

That said, I'm happy with either keeping or removing this.

Regards,

James


