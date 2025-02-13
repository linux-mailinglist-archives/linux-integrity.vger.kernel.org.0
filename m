Return-Path: <linux-integrity+bounces-4822-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3ACA35242
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 00:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178971888818
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328F51C84BB;
	Thu, 13 Feb 2025 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmvL+KPv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF02753F0;
	Thu, 13 Feb 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489930; cv=none; b=FVlO4BblfAq4iTG46ER4cJs41weMeiUcmaEom3gVRUjDzikm79tqCnIBHrpBlW3JtKhSdGHJ9+Cq/qkQ3nxQoByS0HlJzTgyOXMYuPW1N+uPcBb6cKSQoOetuuFJQdyN/5sNE/JLoaBba6iYxY3cPa9VrZ5e6ua435FpqDcy87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489930; c=relaxed/simple;
	bh=v6IHM/pxIvxj98+aTOVZqxpx5vGcbXDyQaxvorp5I7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzEeYiAVZCR1a6iw8DXZzPfFNJBZRQAJEyrq1G0pASNGiaFWy1+r7SvWhl8czXa28Ld/1cnSpCJHkCxhZ+jT7JJOpoc1CWIYeGsrrgf18z8f70E/oRdBa+5Uv5UCZPoPiGq8hnVg3JFgrfiPI+eTRZvLC/rd9/gNOFArHrSVyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmvL+KPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FBC4CED1;
	Thu, 13 Feb 2025 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489929;
	bh=v6IHM/pxIvxj98+aTOVZqxpx5vGcbXDyQaxvorp5I7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmvL+KPv4oNJUNysvNVXIBnEIyY8flT2991GHnnh9UPZBUqt6goLe27jyMT7dR9JZ
	 uX5BZ3mH0B0HWyEdu5e8B+u3uxYkb3mfoGWbOfGJnKrVqxAoJlZFA3B9RJujRm9gJH
	 0G8tsDF9kRFtLvShjhQMM7lOMSAi/MucIHlUIZgZrQwOmKk79gMI/DuqAqUIW5fTX/
	 0E6O/kMwPWhoaFco68hRP7PdT2tmmAb5lHx2p034i/svSF1RbFnUj9szIWiMHptyXc
	 GM50RpNkasNFmzwzMb9L0gVfcQ68AXDWdMRpLG1VsvjfCjO4I6rDbuw8/JTv6MVCgY
	 9HWV77KaJLupQ==
Date: Fri, 14 Feb 2025 01:38:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] Documentation: tpm: add documentation for the CRB
 FF-A interface
Message-ID: <Z66ChI32MRi2q0xT@kernel.org>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-6-stuart.yoder@arm.com>
 <Z65uKkt2f0WYxjHi@kernel.org>
 <b9a7d98a-2723-45e0-bb3b-19cd31473251@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a7d98a-2723-45e0-bb3b-19cd31473251@arm.com>

On Thu, Feb 13, 2025 at 04:17:56PM -0600, Stuart Yoder wrote:
> 
> 
> On 2/13/25 4:11 PM, Jarkko Sakkinen wrote:
> > On Wed, Feb 12, 2025 at 04:05:48PM -0600, Stuart Yoder wrote:
> > > Add documentation providing details of how the CRB driver interacts
> > > with FF-A.
> > > 
> > > Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> > > ---
> > >   Documentation/security/tpm/tpm_ffa_crb.rst | 65 ++++++++++++++++++++++
> > >   1 file changed, 65 insertions(+)
> > >   create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
> > > 
> > > diff --git a/Documentation/security/tpm/tpm_ffa_crb.rst b/Documentation/security/tpm/tpm_ffa_crb.rst
> > > new file mode 100644
> > > index 000000000000..c70f8904a93d
> > > --- /dev/null
> > > +++ b/Documentation/security/tpm/tpm_ffa_crb.rst
> > > @@ -0,0 +1,65 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +========================
> > > +TPM CRB over FF-A Driver
> > > +========================
> > > +
> > > +The TPM Command Response Buffer (CRB) interface is a standard TPM interface
> > > +defined in the TCG PC Client Platform TPM Profile (PTP) Specification [1]_.
> > > +The CRB provides a structured set of control registers a client uses when
> > > +interacting with a TPM as well as a data buffer for storing TPM commands and
> > > +responses. A CRB interface can be implemented in:
> > > +
> > > +- hardware registers in a discrete TPM chip
> > > +
> > > +- in memory for a TPM running in isolated environment where shared memory
> > > +  allows a client to interact with the TPM
> > > +
> > > +The Firmware Framework for Arm A-profile (FF-A) [2]_ is a specification
> > > +that defines interfaces and protocols for the following purposes:
> > > +
> > > +- Compartmentalize firmware into software partitions that run in the Arm
> > > +  Secure world environment (also know as TrustZone)
> > 
> > Does that also cover ARM CCA? Just a question (not a review question).
> 
> No, CCA is for confidential VMs which is a separate trusted execution
> environment and FF-A is not used there.

OK, cool, just plain interested :-)

> 
> Thanks,
> Stuart

BR, Jarkko

