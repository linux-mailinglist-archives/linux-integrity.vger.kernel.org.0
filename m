Return-Path: <linux-integrity+bounces-5069-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FFA4E5D7
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C8317E4A3
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF1292F85;
	Tue,  4 Mar 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjR0hx9n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393A291FB8;
	Tue,  4 Mar 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104165; cv=none; b=hju+YSkcKxlS3OqSKqgwj0GP84CVk5YLTPk9jksrGMA6V8lZqnQ9BwVVfjXHXeNFZk2LZlLUx4jL6aXJsqL95EhXMYl+k6HbUSRyecxSnXkABIpcFBsepb/tH6GbFY1Dkd0ZalKEdnsD/EL4caUbE3xuc5oXJ2LRCNssycE0gMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104165; c=relaxed/simple;
	bh=fODSOaI+FtI/eZFae3SdM/rtyBiDqJI9/Eb/fhEPB3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYKlmbrQ5msF3oGZ7L9O0v49HnChqIXR8J1c3oIg5CJn1ZiIc1bjBDyEi+O4DgZaoGi+MmZaXrImns4pzgQSmMg5YeM0f2rORDem7cRlYwmJC/1s6gDoRSQBfcl7FexOp/CTGAHJyGcKn05wa76+SP0vIJBBWYZ6aFOH5CUQH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjR0hx9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6442C4CEE5;
	Tue,  4 Mar 2025 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741104165;
	bh=fODSOaI+FtI/eZFae3SdM/rtyBiDqJI9/Eb/fhEPB3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FjR0hx9ngNJbUYJXiBZ8xYk1pPG81Qh3cxgju0KeVFNWdaX3zXcQssb/DrqPCnvi0
	 xe71ctKmEeNs3cx3QHmyqJHApzcnHrc3nZNp86Dtp2C4LEFCH4zY5UkCjetXXXXHb9
	 ImAXHDBl/e/Q1h8JrC+K6E8MESGNjVY5sOEmt9u9rVG7tALJXvyT5+ue0b5/SsEiPn
	 BI5Ws9mNXS6Bcqx8sh3YfGKATrnL7fSu2mkEltwPboiMLEnYAlXNfHl6Lze9XNQcId
	 lUQ+JaL4vUfzrRR8p6BDyzX1WJfAw9IeP1FoGRfWpRpstwBOJqyzYQYr22C26R95sW
	 Bkm1C946nWNEw==
Message-ID: <3b9141a372e9e787089a28beeb4bf11d5a144553.camel@kernel.org>
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, sudeep.holla@arm.com, rafael@kernel.org,
 lenb@kernel.org, 	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 18:02:40 +0200
In-Reply-To: <20250303165535.GT5011@ziepe.ca>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
	 <Z8SypwnbJR4g8Bho@kernel.org> <20250303165535.GT5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-03 at 12:55 -0400, Jason Gunthorpe wrote:
> On Sun, Mar 02, 2025 at 09:33:59PM +0200, Jarkko Sakkinen wrote:
> > WARNING: line length of 102 exceeds 100 columns
> > #764: FILE: drivers/char/tpm/tpm_crb.c:821:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0  FW_BUG "TPM2 ACPI table has wrong
> > size %u for start method type %d\n",
>=20
> Just ignore that, it is an error in checkpatch. Strings are required
> to
> be long. I suspect FW_BUG confused it.

Yep, as its own issue I think you are right.

I also noticed couple of additional style issues not picked
by checkpatch:

	if (rc =3D=3D -ENOENT) {  // FF-A driver is not available yet
		rc =3D -EPROBE_DEFER;
	}

I.e. extra curly braces and "//" comment.

Should be:

	/* If driver is not available yet, request probe retry: */
	if (rc =3D=3D -ENOENT)
		rc =3D -EPROBE_DEFER;

>=20
> Jason
>=20

BR, Jarkko

