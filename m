Return-Path: <linux-integrity+bounces-6391-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF53AD35DB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 14:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE663188FE2D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F232900B6;
	Tue, 10 Jun 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYbxBWcR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3932900B4;
	Tue, 10 Jun 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557843; cv=none; b=n8+cLhOjVKTV7JgQfL+Y1EzhWBCVp3XiTH9QN8uQMuro36RgDklbu1fu5OWThZHLZiYfTZoGeedkpMscovrP3USJC6W1xZGlF7Xqze3F9hJXSdOgYj/3hhgGLKcDotRXvMqcdJdI2LxhSCskrpHmFUKoTMbqfyGXhG9/p5ghYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557843; c=relaxed/simple;
	bh=7jJB4h0R3QNPQ8a6Ja40SBAdt7xUL9onTatms1ozg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7BCFbh/eOCmrIawURHck/wvbwUAqI6QwZS5gqzAS0cX1EMPQLaVQ2kgbMRFyTZIirOL29hSg5gry3PNzB6vVA4mXO/UcJG6VViDn+tLCWsWTiyCkcT/4n9dXCVehx2T2Ay0eYzAYWKSrVWE51sziJRlKmhGGQXb/vrOpa1fk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYbxBWcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF266C4CEF2;
	Tue, 10 Jun 2025 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749557843;
	bh=7jJB4h0R3QNPQ8a6Ja40SBAdt7xUL9onTatms1ozg1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYbxBWcRSJJKoAk1/lqabLgIJCJDRVy0bg03y0iND/vOQx5+GOeaG2SPoKq1r4GOh
	 eE5jdGfVsTsE9dmB/rJN0vB+zqRSOmIy/TgSD9zOgvImUuU+rv3s1gRtBuLrrRminV
	 IZWJjQY3b3Dp4EXnMRfvXzlYpMGKltcpiR5Wbr4E0U86sHw7NwF8Y6EGEcivoU49Jf
	 m9Fuj8F/EPWTqbHBWRMXz7iQgeBTsoDsGojvPT7Wg0OsVTh/rz0XaV6EGOEzMEf0jj
	 D2mvs16UV0kEOS7gnlKhHFhRXtzA+TEo3JWex/t/Z2LQIJ6Ax507rTsT0UjD+vwumD
	 LTyoVgUrcRI7Q==
Date: Tue, 10 Jun 2025 15:17:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa
 driver when it's built-in
Message-ID: <aEgiT8Pco-Cs8Kpa@kernel.org>
References: <20250606105754.1202649-1-yeoreum.yun@arm.com>
 <20250606105754.1202649-3-yeoreum.yun@arm.com>
 <aEMdGXXBSym7cXmK@kernel.org>
 <aEMvm2MW9bBXf2gM@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMvm2MW9bBXf2gM@e129823.arm.com>

On Fri, Jun 06, 2025 at 07:12:43PM +0100, Yeoreum Yun wrote:
> Hi Jarkko,
> 
> > > To integrate tpm_event_log with IMA subsystem,
> > > tpm_crb and tpm_crb_ffa driver should be built as built-in
> > > (CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y).
> > >
> > > However, this could make failure for ima_init() gets tpm chip when
> > > each initcall function deployed like:
> > >
> > > 0000000000000888 l       .initcall6.init	0000000000000000 crb_acpi_driver_init
> > > 000000000000088c l       .initcall6.init	0000000000000000 tpm_crb_ffa_driver_init
> >
> > The only failure I see is the patch 1/2 which changes init call level,
> > and leaves kernel Git to a broken state.
> >
> > It breaks the famous "zero regressions policy".
> >
> > BR, Jarkko
> 
> Sorry, would you let me know what is broken more detail?
> IMHO, by changing the init call level for ffa_init()
> it's called early than before device_initcall() and it seems not to
> break anything.
> 
> What breaks do you mean?

Let's start from very beginning. Why this change is needed and not just
1/2?

IMA intializes as a late initcall, which after TPM has initialized.

> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun

BR, Jarkko

