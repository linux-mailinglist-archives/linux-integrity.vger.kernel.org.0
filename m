Return-Path: <linux-integrity+bounces-5153-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C8A55A14
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 23:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3169E3B2216
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372227CB0C;
	Thu,  6 Mar 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhMuz/73"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761527C85A;
	Thu,  6 Mar 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301130; cv=none; b=Jdng1kya0/vaU0T8tJ5Dzy3DDRrsxEGU3gdd4fik+Rb0V9T8fgYTp1L4awsMqW0tF7ZRwCrGcFHjMIBWwnL302bqmyCGyQzp5QU3ZYVNdOtFtmnDBYk2VzlSKCC2TGez6gx9S0dJfKfU06nXNC2KlI3wyfOaFQOQCcVq99Xunvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301130; c=relaxed/simple;
	bh=dRqBjZfr1fXlMejHsbClzoQ6w1YoGqQ/3NTNTQlJWeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpAb3ZHzldSZsTofFs4MPwezUtJpYxAlJMNTR70CCAEGTxXVH9UnJeDeysvDEtyaoKfgy+OYnW8rgO86/LIRvm6kmxARyHNdPrgCVVLsdX0vOKx/5BUBfPrYPnujg5DbdMMSwhd4y1L2TJkbLLWqwS3rROY/CRUTWtF5x3C6FAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhMuz/73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED4C4CEE0;
	Thu,  6 Mar 2025 22:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741301130;
	bh=dRqBjZfr1fXlMejHsbClzoQ6w1YoGqQ/3NTNTQlJWeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhMuz/73165BArBD3Wg6C2NmMzv5tOkLCrFCT9BaMEKlLhL85e+jIu57jYOM4zzL8
	 ey0OLbuxvki1gJYTJz+AmIoctEH4AxoHADCskd3+qUXzvJE1boQsztDd8l0nAuk2z/
	 CW9HZypkzSJ1NPmao56zKjDGdiWtt6GSmrFvKU6t1jHACywwTJhxBpRHc57GTgTzkw
	 Rhf6oIC6uBGMwxV1qySuXp7tTRs8QOc1h+tQabR+G2RslvtPQv3Lx1SBaPt+OMg0fa
	 toMjdb30U5mQLaq8LMdXexsdtSKvDYzkAmUcZQNmf/WIiriYSkty8LtuadEKSGa6iK
	 yZQgjzXjcnEHA==
Date: Fri, 7 Mar 2025 00:45:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add support for the TPM FF-A start method
Message-ID: <Z8olhSPAX0cyten5@kernel.org>
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

OK, I guess we can apply this? Any objections? I'll apply
this over the weekend if nothing alarming comes up.

Thanks for the effort and patience!

BR, Jarkko

