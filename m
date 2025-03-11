Return-Path: <linux-integrity+bounces-5231-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90CA5C734
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3878188515A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA725DCFA;
	Tue, 11 Mar 2025 15:28:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516715820C;
	Tue, 11 Mar 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706912; cv=none; b=rcb458GFQnYGCBvQBfRCbrT2fCQ6llfzyGiIK6NcT1f+oGnKNqC6McI++jTrGcIz8IT3YSeKcNGnN9vbayNqH0C978/ywvY69KT001Yb+Pneeu8KjZ+VOeBAwsUMVqxbuKlB6TkMjrvuEKMsjNuZI8yPT2An+zx8rZEhQrFqIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706912; c=relaxed/simple;
	bh=2FS3l7u8g+AHWYik8SjVKDbEhzWBEA1CV/erV0Oargo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsLjeJNT++cDMtNK04WgaeWSP6JENuLggw4AsY8pCyCFYWUfVOeErxQohzXeiEHb4+6WuYZRBqLD69HRbVtF4OxB07h5s0HsfDnaQhYbHnAs+WLBJ/M23JNnjfOxMtg7DZ6pdXLjHno46v3n0FNt8/89MucZ/tvXBImflUG7YJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294E2152B;
	Tue, 11 Mar 2025 08:28:41 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78CDF3F694;
	Tue, 11 Mar 2025 08:28:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 15:28:25 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add support for the TPM FF-A start method
Message-ID: <Z9BWmf_bM9JJ9ajl@bogus>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <Z87KyTbL0Xi89jEr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87KyTbL0Xi89jEr@kernel.org>

On Mon, Mar 10, 2025 at 01:19:37PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 05, 2025 at 11:36:06AM -0600, Stuart Yoder wrote:
> > Firmware Framework for Arm A-profile (FF-A) is a messaging framework
> > for Arm-based systems, and in the context of the TPM CRB driver is used
> > to signal 'start' to a CRB-based TPM service which is hosted in an
> > FF-A secure partition running in TrustZone.
> > 
> > These patches add support for the CRB FF-A start method defined
> > in the TCG ACPI specification v1.4 and the FF-A ABI defined
> > in the Arm TPM Service CRB over FF-A (DEN0138) specification:
> > https://developer.arm.com/documentation/den0138/latest/
> > 
> > The first patch adds an FF-A driver to handle the FF-A messaging when
> > communicating with a CRB-based TPM secure partition built on FF-A.
> > The driver is probed when the TPM secure partition is discovered by
> > the Linux FF-A infrastructure.
> > 
> > The second patch consolidates the check for idle support in the CRB
> > driver to one place.
> > 
> > The third patch defines the new ACPI start method enumeration for
> > CRB over FF-A.
> > 
> > The fourth patch adds support for the FF-A ACPI start method to
> > the TPM crb driver.
> > 
> > The fifth patch adds documentation explaining how the CRB driver
> > and FF-A relate.
> > 
> > Version 6
> > -in tpm_crb removed unnecessary brackets from if statement and
> >  fixed comment style
> > -noticed and fixed bug in patch 2, polarity of return value
> >  from tpm_crb_has_idle() was wrong and wasn't caught in past
> >  testing
> > -added Reviewed-by tag to patches 2 and 5
> > 
> > Version 5
> > -tpm_ffa_crb patch: removed module version
> > -tpm_ffa_crb patch: fixed module description
> > -tpm_ffa_crb patch: updated comment on mutex declaration
> > -reworded commit message for patch 2 as per Jarkko's 
> >  suggestion
> > -added Acked tag by Sudeep to patch 1 for FF-A changes 
> > -added Reviewed-by tag to patches 3 and 4
> > 
> > Version 4
> > -fix warning from kernel test robot in patch 1
> > -fix warnings from checkpatch.pl --strict
> > -clean up unnecessary parenthesis usage
> > -update variable declaration to be reverse tree order
> > -document exported functions in tpm_crb_ffa driver
> > -remove unnecessary author and maintainer info in tpm_crb_ffa driver
> > -fix declaration of variables to be in reverse tree order
> > 
> > Version 3
> > -changed prefixes used throughout patch series to tpm_crb_ffa*
> > 
> > Version 2
> > -updates to cover letter to define FF-A
> > -added new patch with documentation
> > -created pull request in ACPIA and added link to the patch
> >  updating actbl3.h
> > -added tpm_ prefix to the FF-A CRB driver
> > 
> > Stuart Yoder (5):
> >   tpm_crb: implement driver compliant to CRB over FF-A
> >   tpm_crb: clean-up and refactor check for idle support
> >   ACPICA: add start method for Arm FF-A
> >   tpm_crb: add support for the Arm FF-A start method
> >   Documentation: tpm: add documentation for the CRB FF-A interface
> > 
> >  Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
> >  drivers/char/tpm/Kconfig                   |   9 +
> >  drivers/char/tpm/Makefile                  |   1 +
> >  drivers/char/tpm/tpm_crb.c                 | 105 +++++--
> >  drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
> >  drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
> >  include/acpi/actbl3.h                      |   1 +
> >  7 files changed, 535 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
> >  create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
> >  create mode 100644 drivers/char/tpm/tpm_crb_ffa.h
> > 
> > -- 
> > 2.34.1
> > 
> 
> Check this out:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> 

It is good to get a nod for ACPICA from Rafael as this is not the usual
pattern. It deviates from normal procedure for ACPICA changes.

-- 
Regards,
Sudeep

