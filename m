Return-Path: <linux-integrity+bounces-4815-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2615A35100
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D01890E4C
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0BB269888;
	Thu, 13 Feb 2025 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpD+aPU6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FB266B59;
	Thu, 13 Feb 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484719; cv=none; b=t5tkMKzdZmv+yCPzkHB+LNh8i6FnnMM86TWbRNWK8GrGgQ5b03xy5pkXzFErLsOysWfLV1vVWOjAcivyLyE/8XFYNwaekdde/sdVmVbh1WYwfEZ0x0C9xhvzKOs2R2TKqEBo6V6zcbJnXAlwoePg+U4YJi306F0WG0dcc1y4mWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484719; c=relaxed/simple;
	bh=nUCB4UGq7ePZy1BiBPUZDVa+hD7IMg8C6YWpC4h6VQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBqzE+2jMz50rl5hEFOgznYe14x85dFdz+8wu7VgK+oF03V5fa/L4Rm2mnUuftyTgBuEYfjH1kDzyMDJh38JbRIUjVCTZfccJflHc+VZSKC75bZN52G+oBwCCLJ2jAwa6IJ9pRQxwPAs5RELQ9U/UfQowNJZvEeX/yNVfGNhdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpD+aPU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F105C4CED1;
	Thu, 13 Feb 2025 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484719;
	bh=nUCB4UGq7ePZy1BiBPUZDVa+hD7IMg8C6YWpC4h6VQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpD+aPU6qif8QR0k7Y7z7qV8NuUKQ0C4q4+p5IELGw+1/4mufiGTJxRysuDzKPusO
	 rdbyYTpMNWdMqtek2n+CFWxOzLMWCXQWCX3Wx3ALv5KifAA7DyMHNtGW4hQJ322lIt
	 OvtZQZhEfP9cEn1+l6HWRs5EGYq763hcS8GNVSBnBWeLWu/hHIYjZ6IeLG/vD9/IjT
	 7VM3wI12iBR5nCldZTaWFkHnWDRWRr6t8H/oAfXeY/qt1YWTzb8Anva3G80G/aF/DC
	 QnTaLGZ3XEoJ38Q8J2qDrh0zkr2UhEBlMvz3F0M6YmkD6tjfJEOgdQ9tWvohZNyZLq
	 0wl2dlXkBRkLg==
Date: Fri, 14 Feb 2025 00:11:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] Documentation: tpm: add documentation for the CRB
 FF-A interface
Message-ID: <Z65uKkt2f0WYxjHi@kernel.org>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-6-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212220548.400447-6-stuart.yoder@arm.com>

On Wed, Feb 12, 2025 at 04:05:48PM -0600, Stuart Yoder wrote:
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
> index 000000000000..c70f8904a93d
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

Does that also cover ARM CCA? Just a question (not a review question).

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
> +- The tpm_ffa_crb driver registers with the FF-A subsystem in the kernel
> +  with an architected TPM service UUID defined in the CRB over FF-A spec.
> +
> +- If a TPM service is discovered by FF-A, the probe() function in the
> +  tpm_ffa_crb driver runs, and the driver initializes.
> +
> +- The probing and initialization of the Linux CRB driver is triggered
> +  by the discovery of a TPM advertised via ACPI.  The CRB driver can
> +  detect the type of TPM through the ACPI 'start' method.  The start
> +  method for Arm FF-A was defined in TCG ACPI v1.4 [4]_.
> +
> +- When the CRB driver performs its normal functions such as signaling 'start'
> +  and locality request/relinquish it invokes the ffa_crb_start() funnction
> +  in the tpm_ffa_crb driver which handles the FF-A messaging to the TPM.
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


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

