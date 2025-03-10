Return-Path: <linux-integrity+bounces-5199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD94A59298
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261BB3AB2E6
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDE22156B;
	Mon, 10 Mar 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYtHAf+E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC721D3F7;
	Mon, 10 Mar 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605582; cv=none; b=ABMQuWhiNIDn5+B4Cu3z6yvqhxPj43UmdF8J8fFHk4PrvSGj1OFmgwEjZKTntLPX525Gd+dKfo47o+1a26dgCsxL0ulWnCN941ynmPGimtOQ6H6/WvBCv9fc92j8H1m5uNStqSRRG1hySI1glCQ1hZEXHUK7Kgp+Y1fZl3VBN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605582; c=relaxed/simple;
	bh=XWVIqy9wk7otgQU2pGwNOKtJVNBViOOhWpTuBzczzNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHur1QmID9Q6mIs3+1pKdlfmOjnLYecdMIlVLGgHQNgsf6ilclLKG2sJONU3RFi0Ym1BHLM7SJZoYU30Dd54Rz60KQeh8v8McZVxYP8N4IFjpuv1x0up5NtbE7Y577efxufWE9H+6GG0fTRFplQ4x5ry252SpmSZw98sjiVtGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYtHAf+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98689C4CEE5;
	Mon, 10 Mar 2025 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605581;
	bh=XWVIqy9wk7otgQU2pGwNOKtJVNBViOOhWpTuBzczzNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYtHAf+ErfQMkoDwuFKslZ3pfupKVXFvrRMyChzbsFItZPTb6xQ+jVQECv7qmbma4
	 A4uWaQq4+Y8e6etjRje4Hw/URQqaFTWZ/5Da1Afub2Uf4rRWUh/eeKo5lzmaxblpdn
	 ueMZ0SKNb605mzDkhUvwqbCd/F9T/misC7HZetBp/1XxhPaClFGtRZTiuVIJwUnWA9
	 Ed6Pg93W5lzq7zAuMheZWLTS4JA46CnCavpXY02j8D72YDKX8YhLLWDPw86nMwaT9V
	 SSwPUl3ksb7+7Kjt9oc2gfmRlwhMeHsjIqi945FT3gRg1tkGNt3B/0tRDwV4+oECs5
	 +WNhp3BXKhwwQ==
Date: Mon, 10 Mar 2025 13:19:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add support for the TPM FF-A start method
Message-ID: <Z87KyTbL0Xi89jEr@kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305173611.74548-1-stuart.yoder@arm.com>

On Wed, Mar 05, 2025 at 11:36:06AM -0600, Stuart Yoder wrote:
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
> Version 6
> -in tpm_crb removed unnecessary brackets from if statement and
>  fixed comment style
> -noticed and fixed bug in patch 2, polarity of return value
>  from tpm_crb_has_idle() was wrong and wasn't caught in past
>  testing
> -added Reviewed-by tag to patches 2 and 5
> 
> Version 5
> -tpm_ffa_crb patch: removed module version
> -tpm_ffa_crb patch: fixed module description
> -tpm_ffa_crb patch: updated comment on mutex declaration
> -reworded commit message for patch 2 as per Jarkko's 
>  suggestion
> -added Acked tag by Sudeep to patch 1 for FF-A changes 
> -added Reviewed-by tag to patches 3 and 4
> 
> Version 4
> -fix warning from kernel test robot in patch 1
> -fix warnings from checkpatch.pl --strict
> -clean up unnecessary parenthesis usage
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

Check this out:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

Any tested-by's are welcome.

BR, Jarkko

