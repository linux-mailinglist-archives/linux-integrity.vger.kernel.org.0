Return-Path: <linux-integrity+bounces-6397-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD33AD3BF4
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641913AAF98
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9023498F;
	Tue, 10 Jun 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDmztUpV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7112343C2;
	Tue, 10 Jun 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567552; cv=none; b=LV6lV9GQdVm2RxGMmNWhqqV+SXmgwQAQivmcCTi9YvX+7Wm35xCfV/YYx0ZPDBgKwZh4LBMoH+M1qoLzL9rmAtNSV4/h6JwvPJ2hNCfiY4cT+1ZjNHgkR62jfQ15xDVmM0mJ3iW8GZdWS7eIGNY87sUBmLhUDZsUMvEgjtEiZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567552; c=relaxed/simple;
	bh=K3ckKoOxDuvv4TatnpC5VMgUIUhUlljKqOBxiBCiL24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoOGFypLRuTSms4PJiLN0T7hgAxlwneQDN3rHyXlTSGKFePvN6lsncvV1cd8QD15MzvZk/nMEOyc02TXj5GN3tClh6G+Pcp8KF1gaPdwrtn0fwKs+g+99l8TFR8I+APPDOQXfF0+kV8AOzFprxkZiO3+GUbysaHz6LPemAn6Vv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDmztUpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA8C4CEED;
	Tue, 10 Jun 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749567552;
	bh=K3ckKoOxDuvv4TatnpC5VMgUIUhUlljKqOBxiBCiL24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDmztUpV+pmuz2CDYqmmwZhJsmv96tBvw6sVQgLo6Y4mZf07iW7vN2aqNf2W+ZI+J
	 9Ah2vpwvf+4pr1UqAerNoO63vgwvsq9gR7m2UDWs1BsR3mX2DxpYFZFzINkEDhw/u1
	 RnJaRGVpYEaFrnuMIo5N/ZvLNLswE+F9zFhHJAwN/hx48gjiCL1eN3wPeiImJeRnX+
	 Ym3jIXTk/ywZ40Q6lQSbs1eu8JfDPfQXx1mfCX0qoSFXvY/1xoMA/CntLARBrt8ovF
	 1Wvu1uCNZakBBfOVVcM6FMM1MPaOsvbCMJ07vHHoo6fSrLbItsBOtw3QMeNfMVm6UR
	 jzG/AaYG9caAg==
Date: Tue, 10 Jun 2025 17:59:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEhIPC95FisptBO5@kernel.org>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
 <aEhDY4VlkIPYAjPE@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhDY4VlkIPYAjPE@e129823.arm.com>

On Tue, Jun 10, 2025 at 03:38:27PM +0100, Yeoreum Yun wrote:
> Unfortunately, when these components are built as built-in drivers,
> the functions ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> all executed during the device_initcall phase.
> As a result, if crb_acpi_driver_init() is called before the ffa_device exists or
> has been probed, it returns -EPROBE_DEFER,

Please mention exactly this in the commit explicitly and then it should
be in detail enough.

> causing the probe to be deferred and retried later
> during the deferred_probe_initcall phase.

OK, if ffa_init() is leveled up in the initcall hierarchy, shouldn't
that be enough as long as ko's can be found from initramfs?

BR, Jarkko

