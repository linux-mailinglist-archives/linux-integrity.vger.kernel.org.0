Return-Path: <linux-integrity+bounces-4923-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA57A3D4C4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C933B3A9F76
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10591EF0B6;
	Thu, 20 Feb 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKkoeuA7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55951EB1A3;
	Thu, 20 Feb 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043820; cv=none; b=Q/yrGcR6CvsWSOwn71eUwQOzIjV73CGzuGmnrvyn4jaUaE4WBj8oS/WqeFsfDaf6HC0+nwtPEhLNlMgYVIsJrrUx0Mrjmo5CUg18NGyRrF0E2ltAIANHPAc8yiqAHHnsUx6JbFRPP7OncKvVHP0q4/N9sP7PJLaiHRYZKi1xQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043820; c=relaxed/simple;
	bh=F8sHSdDiGOAJStv8uxWi3qIBaQqEJ20QIqAF2G4aNec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P94svss+45p8j66U3TKzk1stiiT1Z+HbfQhJgNHvbTBWEXaZDKxN+mDA125SlKyNjgSqV1SMllJhu33lDkey4lXAkyUfJ9QFE7PBcNpDvTEEm+vTdBJCHpn64YB8fYadWaEqKl6m3adX/pjL2JTWztU/37gW8CpzY/BKevZFSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKkoeuA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1EEC4CED1;
	Thu, 20 Feb 2025 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043820;
	bh=F8sHSdDiGOAJStv8uxWi3qIBaQqEJ20QIqAF2G4aNec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKkoeuA7ttTVhU/uyGYvLRshRKIqN1hK2wJJkKBWeNkhAfkJ1AsmF/RtTObeW2gd9
	 MvMmpJsWx1e99aZeDmLWT5XI62lsZxTYvQcxJLGyHS1K4Hxb4dW4d7Xw+q2OI7WMLG
	 DEounBqCvzK7uE9r6xqjT/TV4CRJX9Wz/f8M7Tly4Y5JhnVy+4wS9u2GVGtKIEMJaE
	 gGTEdynnYC+ifkLNV/tyeUrLKbCnRVpwU4ZgZP5qXYYF6oVaizwm2iF7n/IgxZNmA0
	 scFHivLr85VXX2kJWmcp87dirkSOVI9pM4H+fHyBye4BTcMvmYU+yACg0esXpmcrXi
	 gXPUjiuKh538A==
Date: Thu, 20 Feb 2025 11:30:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] Documentation: tpm: add documentation for the CRB
 FF-A interface
Message-ID: <Z7b2J2tcaF96QGud@kernel.org>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-6-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219201014.174344-6-stuart.yoder@arm.com>

On Wed, Feb 19, 2025 at 02:10:14PM -0600, Stuart Yoder wrote:
> Add documentation providing details of how the CRB driver interacts
> with FF-A.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  Documentation/security/tpm/tpm_ffa_crb.rst | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
> 
> diff --git a/Documentation/security/tpm/tpm_ffa_crb.rst b/Documentation/security/tpm/tpm_ffa_crb.rst
> new file mode 100644
> index 000000000000..0184193da3c7
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_ffa_crb.rst
> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +TPM CRB over FF-A Driver
> +========================
> +
> +The TPM Command Response Buffer (CRB) interface is a standard TPM interface
> +defined in the TCG PC Client Platform TPM Profile (PTP) Specification [1]_.
> +The CRB provides a structured set of control registers a client uses when
> +interacting with a TPM as well as a data buffer for storing TPM commands and
> +responses. A CRB interface can be implemented in:
> +
> +- hardware registers in a discrete TPM chip
> +
> +- in memory for a TPM running in isolated environment where shared memory
> +  allows a client to interact with the TPM
> +
> +The Firmware Framework for Arm A-profile (FF-A) [2]_ is a specification
> +that defines interfaces and protocols for the following purposes:
> +
> +- Compartmentalize firmware into software partitions that run in the Arm
> +  Secure world environment (also know as TrustZone)
> +
> +- Provide a standard interface for software components in the Non-secure
> +  state, for example OS and Hypervisors, to communicate with this firmware.
> +
> +A TPM can be implemented as an FF-A secure service.  This could be a firmware
> +TPM or could potentially be a TPM service that acts as a proxy to a discrete
> +TPM chip. An FF-A based TPM abstracts hardware details (e.g. bus controller
> +and chip selects) away from the OS and can protect locality 4 from access
> +by an OS.  The TCG-defined CRB interface is used by clients to interact
> +with the TPM service.
> +
> +The Arm TPM Service Command Response Buffer Interface Over FF-A [3]_
> +specification defines FF-A messages that can be used by a client to signal
> +when updates have been made to the CRB.
> +
> +How the Linux CRB driver interacts with FF-A is summarized below:
> +
> +- The tpm_crb_ffa driver registers with the FF-A subsystem in the kernel
> +  with an architected TPM service UUID defined in the CRB over FF-A spec.
> +
> +- If a TPM service is discovered by FF-A, the probe() function in the
> +  tpm_crb_ffa driver runs, and the driver initializes.
> +
> +- The probing and initialization of the Linux CRB driver is triggered
> +  by the discovery of a TPM advertised via ACPI.  The CRB driver can
> +  detect the type of TPM through the ACPI 'start' method.  The start
> +  method for Arm FF-A was defined in TCG ACPI v1.4 [4]_.
> +
> +- When the CRB driver performs its normal functions such as signaling 'start'
> +  and locality request/relinquish it invokes the tpm_crb_ffa_start() funnction
> +  in the tpm_crb_ffa driver which handles the FF-A messaging to the TPM.
> +
> +References
> +==========
> +
> +.. [1] **TCG PC Client Platform TPM Profile (PTP) Specification**
> +   https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
> +.. [2] **Arm Firmware Framework for Arm A-profile (FF-A)**
> +   https://developer.arm.com/documentation/den0077/latest/
> +.. [3] **Arm TPM Service Command Response Buffer Interface Over FF-A**
> +   https://developer.arm.com/documentation/den0138/latest/
> +.. [4] **TCG ACPI Specification**
> +   https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

