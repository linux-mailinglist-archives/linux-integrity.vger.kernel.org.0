Return-Path: <linux-integrity+bounces-5243-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EDDA5D605
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BE4176F59
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740411E5B72;
	Wed, 12 Mar 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLqHZud9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43B1D86F2;
	Wed, 12 Mar 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760640; cv=none; b=ni4FNKwzMQBRD351j/sSWzvRrkyaUqYeahDYxIWIm8ijEdePEnJvWMJFzrXp7Q5LFq2qS+/JEC2OP0UQnyFlqmC93iM4No+MN+QtXUUEbXV69QmZ+zcOrqRN/nZnvgUJzDoxJPdX1xNSjeGqCzckO8SxcGYw9JUmMMYw9/oHZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760640; c=relaxed/simple;
	bh=9zvgvZkiaWoEZ55z6rTUOjWUlbOFQL48aHZbETK3QpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQuDcDOTotxf57c/Jpog9JIoNx70Cxx/Q8S/i8xZ6X/JBDPCfHZGjtF+Gapqa9nTfTWJ5fzu0VQKy/9uEIXZKlq0FJ5RZcRBd4LcLRIh/WhiCPclDTIX9p2L1A0w/atnRKicz7sxF9+ktmMPebdEOZhvhz7uF+5y7OxLXayMrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLqHZud9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAA4C4CEE3;
	Wed, 12 Mar 2025 06:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741760640;
	bh=9zvgvZkiaWoEZ55z6rTUOjWUlbOFQL48aHZbETK3QpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLqHZud9zOui7Eb7XCnrN6ap2r/mPUzlbkYz50OB4aUBrZtL949bKKEtIDQWp18Jq
	 /izDchkVJjBDozUe1/x3bE+6Dvjvm1hytznsCxmS185FW2Ls0MIEIySwKuijK4BFcu
	 cDzI7uZtlvJ9yz6gahRQbvoAdBp44Za+LS0OmceViBJ6CVyqX8ShYO3yoTuBgCEv6u
	 oHrO9Zw+WYuPxdY1KoK67oLbC9n4X0JZ8JUJGPgMO8fMcgjCrJHf9yvgJw+eo9jXoz
	 tACLwKojd0c8tGwhFJeBxCzmwLtMRP1ClX+v4uLXpXoLq73W/IL/HzetVO9x+qbTNM
	 pjFwK9jsQ5WsQ==
Date: Wed, 12 Mar 2025 08:23:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	stefanb@linux.ibm.com, ardb@kernel.org, roberto.sassu@huawei.com,
	viro@zeniv.linux.org.uk, gourry@gourry.net
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/tpm*.h to TPM maintainers
Message-ID: <Z9EofB1oLBUgu05C@kernel.org>
References: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>

On Tue, Mar 11, 2025 at 09:14:40PM +0800, WangYuli wrote:
> As of now, within include/linux, there are three header files
> pertaining to the TPM driver: tpm.h, tpm_eventlg.h and tpm_command.h.
> 
> Upon investigation when attempting code modifications, it has become
> evident that these files are currently without a maintainer.
> 
> In light of their intrinsic relationship with the TPM driver itself,
> stewardship of these files should fall under the TPM subsystem. So
> that scripts/get_maintainer.pl can provide more accurate output

[SNIP]

> 
> In passing, also include include/uapi/linux/vtpm_proxy.h for TPM
> maintainers, as it is facing a comparable plight.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

"Subnames" are separated with space, not with camel case.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ed7aa6867674..4a7b2e8b97de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24037,6 +24037,8 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>  F:	Documentation/devicetree/bindings/tpm/
>  F:	drivers/char/tpm/
> +F:	include/linux/tpm*.h
> +F:	include/uapi/linux/vtpm_proxy.h
>  F:	tools/testing/selftests/tpm2/
>  
>  TPS546D24 DRIVER
> -- 
> 2.47.2
> 

BR, Jarkko

