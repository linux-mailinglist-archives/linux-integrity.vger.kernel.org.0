Return-Path: <linux-integrity+bounces-6415-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51059AD5C7B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326583A8984
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35AB1FE45A;
	Wed, 11 Jun 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0yes6/m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C11C8632;
	Wed, 11 Jun 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660012; cv=none; b=JcCHrlubOX3T7Dk7Yc/qOoiXR/3w5XRkcu/Py+UiGcetYk0p9EPEqbS/jPTTrxQfpyg18IglAJY3ow6Bv/oliwjC5KgxBFKyG3Dvr3pBJp6Zs0utlbhpb2VYj62huFxBJm/wvthCxoi0HIGYQDB0tBonGE3zwGvxu+23/3/QXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660012; c=relaxed/simple;
	bh=TqlQzmTCsnQRMQq+SYvGGb4qf8vY2W39tOrtj8jKeCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua8ae5obTFExYam0udfY2ItIBfIcnRfIAFVofua0dquNYa1w6xoZTqINLuPgUjKaRT0UbakWnvKHXijxPpJwVyyN9hevn0dT3uyDMhbVBG0Fmujg3uXliOiudXG65EJxods2XzRbWU3ovYKWX8PJakgYfQMmvy/ZTNjcCt9bHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0yes6/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67C6C4CEE3;
	Wed, 11 Jun 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660012;
	bh=TqlQzmTCsnQRMQq+SYvGGb4qf8vY2W39tOrtj8jKeCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0yes6/mOGsZwNR36De45p0AXo8bgF/d3Lsy5MV3CpXXXkJqD25wWAJVbCF4oR9ey
	 Wqlv10yXvQT1ZBw+Pf3wDLAX0WpjrLCZW71WWxcrDQFjpNhXwff1Wzy7ec2FbtlltJ
	 qi0+1NJd2uU+I09mugwMdLJhBPkU4CbpN7biYR0ObjMlW4kjPYFti+z2xKHDMay18W
	 sSxr2ClV9TMGztKGtC4HuF9oTrlNVSsXd8lf8rdtUCRUDUebbDwdeUqFRnNGCBBVMh
	 jW0yIexgIad1U6HHbtHYGioPfOo/zD1vsqBFOsSmXlXUjiXdu0M5fX5mKDP0R2Oj13
	 n75pghFXrgmqg==
Date: Wed, 11 Jun 2025 19:40:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEmxaJQNfYJwSCd0@kernel.org>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
 <aEhDY4VlkIPYAjPE@e129823.arm.com>
 <aEhIPC95FisptBO5@kernel.org>
 <aEhNnAxlToRMteA2@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhNnAxlToRMteA2@e129823.arm.com>

On Tue, Jun 10, 2025 at 04:22:04PM +0100, Yeoreum Yun wrote:
> > OK, if ffa_init() is leveled up in the initcall hierarchy, shouldn't
> > that be enough as long as ko's can be found from initramfs?
> 
> As you mentioned, this is handled in Patch #1.
> However, although ffa_init() is called first,
> unless tpm_crb_ffa_init() is also invoked,
> crb_acpi_driver_init() will fail with -EPROBE_DEFER.
> 
> Please note that IMA is always built-in and cannot be built as a module.

Sure but if one needs IMA, then tpm_crb_ffa can be compiled as built-in
with zero code changes.

BR, Jarkko

