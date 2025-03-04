Return-Path: <linux-integrity+bounces-5071-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C94A4E8B0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 18:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6386B8C0742
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BCF2D3A8F;
	Tue,  4 Mar 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLNC1RX2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226127D763;
	Tue,  4 Mar 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107367; cv=none; b=HImkErZmyaQScNZVS2zfY0Kb/nbHWrNCXCQEpCCbBPi+qzWbVwbpiC4IGmkY2dAB5CK9vs4R4ia5/1UVM4P1BQ6lIC+mDOPOqA5Xvni03iqsmG9wNne/OIpmXp5PHKKTaeaiA3kBicJ6TfNkPxnBfp/uwD2ifnfzSVm2WYv4jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107367; c=relaxed/simple;
	bh=hnuVQHcISgnPrz28CUmLXrSIfzs3nEzmNy8Xa28V/S4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqIbEyJvjlhXE2U15lamqG7/ZDIiObEzLeac/bVDBSSEmJbaFBUgyFZjIuRJSvIbD1VqTiP4rXazj95eynt3hQ9dvNXvP1bU8zMRw44ChzVoQMiQCNOQ+hiVy9cca52Xo/Z90FWJ8b39Lq8BrS8YZ6ekJpwz4UZ8bnGtwV11KZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLNC1RX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55AC4CEEC;
	Tue,  4 Mar 2025 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107367;
	bh=hnuVQHcISgnPrz28CUmLXrSIfzs3nEzmNy8Xa28V/S4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RLNC1RX2WCbRpU5Xv5Y185YLUdYLv+QX3XDw90vIHszAijwgDCuGLm05T1G8U5SKp
	 aBQzttZjFTVJ5hhkepFV1G+BvcXgPWQfmltMz53Ay9eX0EpVfQjI6xTR9DnUIcyeFZ
	 HbUfcv8kCiW4o9Yl9PsFTNY38i9QD/C6d5kq9NYMj5WtqMd+XHQ2ccri1nbAwsbNmX
	 y+V1Lsx5SxNSDjPf4mD2iEO9+u0LWGulwu0IP8JT1oWqsm9mVAQxK77TcYtxNNIUOn
	 /5UoElygJb/r5YtchJHg3gewAuFTUYRoUaHmaR6H8rwIQIxuaxG/CYLEFsQpO9D4UQ
	 7jHdbm/bb5C6g==
Message-ID: <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho	
 <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
 Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, Dionna
 Glaze	 <dionnaglaze@google.com>, James Bottomley	
 <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, 
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, 	linux-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 04 Mar 2025 18:56:02 +0200
In-Reply-To: <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
References: <20250228170720.144739-1-sgarzare@redhat.com>
	 <20250228170720.144739-4-sgarzare@redhat.com> <Z8Jmps6AF_geaHUw@kernel.org>
	 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
> On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
> > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
> > > buf_len,
> > > +			 size_t to_send);
> >=20
> > Please describe the meaning and purpose of to_send.
>=20
> Sure, I'll add in the commit description.

It's always a command, right? So better be more concerete than
"to_send", e.g. "cmd_len".

I'd do instead:

if (!chip->send)
	goto out_recv;

And change recv into:

int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
	    cmd_len);

Those who don't need the last parameter, can ignore it.

This also reduces meaningless possible states for the ops structure
such as "send_recv and send or recv defined", i.e. makes it overall
more mutually exclusive.


>=20
> Should I add documentation in the code as well?
>=20
> The other callbacks don't have that, but if you think it's useful we
> can=20
> start with that, I mean something like this:
>=20
> 	/**
> 	 * send_recv() - send the command and receive the response
> on the same
> 	 * buffer in a single call.
> 	 *
> 	 * @chip: The TPM chip
> 	 * @buf: A buffer used to both send the command and receive
> the response
> 	 * @buf_len: The size of the buffer
> 	 * @to_send: Number of bytes in the buffer to send
> 	 *
> 	 * Return: number of received bytes on success, negative
> error code on
> 	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 failure.
> 	 */
> 	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
> buf_len,
> 			 size_t to_send);

I would not document in callback level as their implementation is not globa=
l.
This is probably stance also taken by file_operations, vm_ops and many othe=
r
places with "ops" structure.

>=20
> Thanks,
> Stefano
>=20
>=20

BR, Jarkko

