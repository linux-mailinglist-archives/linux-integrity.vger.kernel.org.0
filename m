Return-Path: <linux-integrity+bounces-5038-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF5CA4B46C
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Mar 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C45B16A901
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Mar 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1551EB1A1;
	Sun,  2 Mar 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s34lyGOq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DC1C5D59;
	Sun,  2 Mar 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944044; cv=none; b=RN0ZK+3ll8JCOpZnuvaCaPKy9v6tMi8ePZ0JUkQhqJo/nIxBcCochGYLSgQDSSVZMQ1RdhIMmVUN6dmGV/GdYA0ED22gJ2MgLERFVEdEmwXH4qvoNm6fVMq510jGVvcmOxmnB+xxPIsxxIwFXUiHKKTuZJFePO67FwPqrGif7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944044; c=relaxed/simple;
	bh=jRIZ66izVEc6x6rr0wMoZknqyuXGoVKgcubPBYG3ou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqdoe0w2pQarVi1za2ET7rNdIJsMXCI0Y8v2+ENCbP16blUwB7uwkhlF2lKNVXGt5yqn/DxiolNOEmMmMbcXk/nkxFjnV/IoE3+koRF7HStNITZ1nV2G0IMZ2hdoyuKwb2G/OGRbr2ZN4l4GQZwmhBKe33SsLP4cQ2NAj8JcXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s34lyGOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741ECC4CED6;
	Sun,  2 Mar 2025 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740944044;
	bh=jRIZ66izVEc6x6rr0wMoZknqyuXGoVKgcubPBYG3ou4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s34lyGOq77q3oqDIZISqWpUoe+18jRlmRBAbEZON22EJgCMD2v3/5RBJNP/1U5PGk
	 A12xwB8rBm2i1bwWvsYB2sMxux27v4n3Vvk8Ru4b5oRImkeTi6G/napSKXKo98XRuR
	 hAmblV+JMpATlH7mJtajpxRkfTAzXsILwsDogxVZzwszkLjF5o931PLOGPaJ30ft30
	 DMyApiNdEm+7OXpLT2aMlKa6cRn+xdpuuTJvOloW0VROqt1gRWLyDRwIsDnQjlDwXu
	 UnDMiu9qRlXZdyfa/lN04Lot5M7LwYWAQ7dG8vI+R3JzLtKByu/Whtcs8lM9MLm6Z2
	 oyTyhH5zvEVIw==
Date: Sun, 2 Mar 2025 21:33:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
Message-ID: <Z8SypwnbJR4g8Bho@kernel.org>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217224946.113951-1-stuart.yoder@arm.com>

On Mon, Feb 17, 2025 at 04:49:41PM -0600, Stuart Yoder wrote:
> Firmware Framework for Arm A-profile (FF-A) is a messaging framework
> for Arm-based systems, and in the context of the TPM CRB driver is used
> to signal 'start' to a CRB-based TPM service which is hosted in an
> FF-A secure partition running in TrustZone.
> 
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification:
> https://developer.arm.com/documentation/den0138/latest/
> 
> The first patch adds an FF-A driver to handle the FF-A messaging when
> communicating with a CRB-based TPM secure partition built on FF-A.
> The driver is probed when the TPM secure partition is discovered by
> the Linux FF-A infrastructure.
> 
> The second patch consolidates the check for idle support in the CRB
> driver to one place.
> 
> The third patch defines the new ACPI start method enumeration for
> CRB over FF-A.
> 
> The fourth patch adds support for the FF-A ACPI start method to
> the TPM crb driver.
> 
> The fifth patch adds documentation explaining how the CRB driver
> and FF-A relate.
> 
> Version 4
> -fix warning from kernel test robot in patch 1
> -fix warnings from checkpatch.pl --strict
> -clean up unecessary parenthesis usage
> -update variable declaration to be reverse tree order
> -document exported functions in tpm_crb_ffa driver
> -remove unnecessary author and maintainer info in tpm_crb_ffa driver
> -fix declaration of variables to be in reverse tree order
> 
> Version 3
> -changed prefixes used throughout patch series to tpm_crb_ffa*
> 
> Version 2
> -updates to cover letter to define FF-A
> -added new patch with documentation
> -created pull request in ACPIA and added link to the patch
>  updating actbl3.h
> -added tpm_ prefix to the FF-A CRB driver
> 
> Stuart Yoder (5):
>   tpm_crb: implement driver compliant to CRB over FF-A
>   tpm_crb: clean-up and refactor check for idle support
>   ACPICA: add start method for Arm FF-A
>   tpm_crb: add support for the Arm FF-A start method
>   Documentation: tpm: add documentation for the CRB FF-A interface
> 
>  Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
>  drivers/char/tpm/Kconfig                   |   9 +
>  drivers/char/tpm/Makefile                  |   1 +
>  drivers/char/tpm/tpm_crb.c                 | 105 +++++--
>  drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
>  drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
>  include/acpi/actbl3.h                      |   1 +
>  7 files changed, 535 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
>  create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
>  create mode 100644 drivers/char/tpm/tpm_crb_ffa.h
> 
> -- 
> 2.34.1
> 

checkpatch.pl --strict reported me some issues.

The first one is:

WARNING: please write a help paragraph that fully describes the config symbol
#41: FILE: drivers/char/tpm/Kconfig:213:
+config TCG_ARM_CRB_FFA
+       tristate "TPM CRB over Arm FF-A Transport"
+       depends on ARM_FFA_TRANSPORT
+       default y if (TCG_CRB && ARM_FFA_TRANSPORT)
+       help
+         If the Arm FF-A transport is used to access the TPM say Yes.
+         To compile this driver as a module, choose M here; the module
+         will be called tpm_crb_ffa.
+

To be totally honest with I've never fully grabbed what checkpatch means
by that message, i.e. what is the threshold for "fully described" :-)

So if someone can give advice on this, awesome, and let's do +1 round
of the patch, but with my limited knowledge I have no legit reason to
block this.

Nit: checkpatch could improve a bit that error message because "fully
describe" is not unambiguous terminology.

The second issue:

CHECK: Alignment should match open parenthesis
#378: FILE: drivers/char/tpm/tpm_crb_ffa.c:309:
+       if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
+          (tpm_crb_ffa->minor_version > 0 &&

if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
    (tpm_crb_ffa->minor_version > 0 &&

I think it should be like this.

The final issue reported:

WARNING: line length of 102 exceeds 100 columns
#764: FILE: drivers/char/tpm/tpm_crb.c:821:
+                               FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",

You could put that into two separate lines but maybe it would
even make sense to create helper for the branch given the deep
levels of nesting.

I.e. maybe it would make sense to encapsulate this into a helper:

		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_ffa))) {
			dev_err(dev,
				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
				buf->header.length,
				ACPI_TPM2_CRB_WITH_ARM_FFA);
			rc = -EINVAL;
			goto out;
		}
		crb_ffa = ACPI_ADD_PTR(struct tpm2_crb_ffa, buf, sizeof(*buf));
		priv->ffa_flags = crb_ffa->flags;
		priv->ffa_attributes = crb_ffa->attributes;
		rc = tpm_crb_ffa_init();
		if (rc) {
			if (rc == -ENOENT) {  // FF-A driver is not available yet
				rc = -EPROBE_DEFER;
			}
			goto out;
		}


I looked at tpm_crb_ffa_init() too, and it's somewhat trivial, not very
useful and has only single call site in kernel:

/**
 * tpm_crb_ffa_init - called by the CRB driver to do any needed initialization
 *
 * This function is called by the tpm_crb driver during the tpm_crb
 * driver's initialization. If the tpm_crb_ffa has not been probed
 * yet, returns -ENOENT in order to force a retry.  If th ffa_crb
 * driver had been probed  but failed with an error, returns -ENODEV
 * in order to prevent further retries.
 *
 * Return: 0 on success, negative error code on failure.
 */
int tpm_crb_ffa_init(void)
{
	if (!tpm_crb_ffa)
		return -ENOENT;

	if (IS_ERR_VALUE(tpm_crb_ffa))
		return -ENODEV;

	return 0;
}
EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);


Some questions arise here:

1. Wouldn't it be better idea to implement the code block residing
   in tpm_crb here?
2. Why it needs to be exported? Why it is not in the same compilation
   unit with tpm_crb? Cross-compilation unit calls extrapolates
   complexity and should have strong reasoning behind...

So yeah, this is area where we definitely need some rework. Sorry
about this boomerang. Sometimes checkpatch opens up new thoughts
and ideas :-) It's better to take step back always and do right
thing right. It's much more time consuming for all of us to fixup
things and backport fixes etc.

BR,  Jarkko

