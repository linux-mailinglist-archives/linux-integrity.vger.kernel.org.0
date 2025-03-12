Return-Path: <linux-integrity+bounces-5240-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B2A5D5E0
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6013B40F1
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE51DE4CE;
	Wed, 12 Mar 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t77lLnZV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0A35947;
	Wed, 12 Mar 2025 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759593; cv=none; b=WuZrStEI64vR5YDAsttQ6Eot8Wiby2uwPrE38YyZiZAOFsp/wQ864WzIq7arZ0LAmvLpy+fk8t3msxmV/vmTm/CuCvRAW4+rgtC/UrasoBFUQKx5qbDxNHFiuu+iZ2a/VedHYS1jexKpP1yzkzhbAmzaXyjoM0t5RVTi0tDXshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759593; c=relaxed/simple;
	bh=e+VtGzJMvj0O7DYhgrQQCsJnR2VrN7bIu0exYkhoJMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTRD89+ATHQsjm4R7bFbLKqkBrLnRie9KeTv0uRy1VsfBWavKAJ01lh5UpEAqYZWeSWDDeuuXAFcN3yTATfllt1l0viiQQaDKJbt9MFiYKOlFjyFhT6OMztCR/r/PO+T/wP5sEVldgFDsMhPwr2XoyN1fmQERUlUQofMDOQRZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t77lLnZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592B7C4CEE3;
	Wed, 12 Mar 2025 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741759592;
	bh=e+VtGzJMvj0O7DYhgrQQCsJnR2VrN7bIu0exYkhoJMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t77lLnZVOyisMoqDQOS4lDhlEKF93dvapA1OrRrrhoRWwqvtcyHzbcdcnsuin3jUa
	 Vss1w4KDJls76PXZRAyYROs/xqE8IKm668Ce8Off6c/7glvYe9xLqNMkNdOGW6MM3v
	 Xj9K/iMML9AQmvgeC2A08gPo4flePnbKkGU7qWkixZ1X1H9VjJ9WVo0CDrsDjN1hdO
	 f/mWtDVmOUB6h8Pdlm0e17Sr5tpUrnLuXr0V10pxLsyLEw57oT6lmA3cEGHca/ql9O
	 sq2/OW2T0kN5HikIGhQoXgtYJwkG6pBYP3SngZlCiw4xu0b7ijGXWJo/vf/fYi0uaS
	 6ja4539G48KDw==
Date: Wed, 12 Mar 2025 08:06:29 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add support for the TPM FF-A start method
Message-ID: <Z9EkZcX2LmVkNAbq@kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <Z87KyTbL0Xi89jEr@kernel.org>
 <Z9BWmf_bM9JJ9ajl@bogus>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9BWmf_bM9JJ9ajl@bogus>

On Tue, Mar 11, 2025 at 03:28:25PM +0000, Sudeep Holla wrote:
> On Mon, Mar 10, 2025 at 01:19:37PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 05, 2025 at 11:36:06AM -0600, Stuart Yoder wrote:
> > > Firmware Framework for Arm A-profile (FF-A) is a messaging framework
> > > for Arm-based systems, and in the context of the TPM CRB driver is used
> > > to signal 'start' to a CRB-based TPM service which is hosted in an
> > > FF-A secure partition running in TrustZone.
> > > 
> > > These patches add support for the CRB FF-A start method defined
> > > in the TCG ACPI specification v1.4 and the FF-A ABI defined
> > > in the Arm TPM Service CRB over FF-A (DEN0138) specification:
> > > https://developer.arm.com/documentation/den0138/latest/
> > > 
> > > The first patch adds an FF-A driver to handle the FF-A messaging when
> > > communicating with a CRB-based TPM secure partition built on FF-A.
> > > The driver is probed when the TPM secure partition is discovered by
> > > the Linux FF-A infrastructure.
> > > 
> > > The second patch consolidates the check for idle support in the CRB
> > > driver to one place.
> > > 
> > > The third patch defines the new ACPI start method enumeration for
> > > CRB over FF-A.
> > > 
> > > The fourth patch adds support for the FF-A ACPI start method to
> > > the TPM crb driver.
> > > 
> > > The fifth patch adds documentation explaining how the CRB driver
> > > and FF-A relate.
> > > 
> > > Version 6
> > > -in tpm_crb removed unnecessary brackets from if statement and
> > >  fixed comment style
> > > -noticed and fixed bug in patch 2, polarity of return value
> > >  from tpm_crb_has_idle() was wrong and wasn't caught in past
> > >  testing
> > > -added Reviewed-by tag to patches 2 and 5
> > > 
> > > Version 5
> > > -tpm_ffa_crb patch: removed module version
> > > -tpm_ffa_crb patch: fixed module description
> > > -tpm_ffa_crb patch: updated comment on mutex declaration
> > > -reworded commit message for patch 2 as per Jarkko's 
> > >  suggestion
> > > -added Acked tag by Sudeep to patch 1 for FF-A changes 
> > > -added Reviewed-by tag to patches 3 and 4
> > > 
> > > Version 4
> > > -fix warning from kernel test robot in patch 1
> > > -fix warnings from checkpatch.pl --strict
> > > -clean up unnecessary parenthesis usage
> > > -update variable declaration to be reverse tree order
> > > -document exported functions in tpm_crb_ffa driver
> > > -remove unnecessary author and maintainer info in tpm_crb_ffa driver
> > > -fix declaration of variables to be in reverse tree order
> > > 
> > > Version 3
> > > -changed prefixes used throughout patch series to tpm_crb_ffa*
> > > 
> > > Version 2
> > > -updates to cover letter to define FF-A
> > > -added new patch with documentation
> > > -created pull request in ACPIA and added link to the patch
> > >  updating actbl3.h
> > > -added tpm_ prefix to the FF-A CRB driver
> > > 
> > > Stuart Yoder (5):
> > >   tpm_crb: implement driver compliant to CRB over FF-A
> > >   tpm_crb: clean-up and refactor check for idle support
> > >   ACPICA: add start method for Arm FF-A
> > >   tpm_crb: add support for the Arm FF-A start method
> > >   Documentation: tpm: add documentation for the CRB FF-A interface
> > > 
> > >  Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
> > >  drivers/char/tpm/Kconfig                   |   9 +
> > >  drivers/char/tpm/Makefile                  |   1 +
> > >  drivers/char/tpm/tpm_crb.c                 | 105 +++++--
> > >  drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
> > >  drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
> > >  include/acpi/actbl3.h                      |   1 +
> > >  7 files changed, 535 insertions(+), 19 deletions(-)
> > >  create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
> > >  create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
> > >  create mode 100644 drivers/char/tpm/tpm_crb_ffa.h
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Check this out:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> > 
> 
> It is good to get a nod for ACPICA from Rafael as this is not the usual
> pattern. It deviates from normal procedure for ACPICA changes.

There's still time for further reviewing this as I dropped the existing
version:

https://lore.kernel.org/all/Z9EiRDuWfPOkcjXN@kernel.org/

> 
> -- 
> Regards,
> Sudeep


BR, Jarkko

