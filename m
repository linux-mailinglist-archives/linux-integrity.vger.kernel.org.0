Return-Path: <linux-integrity+bounces-6384-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC25AD283D
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D2E18867A0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF37221DB0;
	Mon,  9 Jun 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvJlV8Fk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAE207A20;
	Mon,  9 Jun 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502781; cv=none; b=Y9stBw2RPy3+9xEJKTPpJ9xdxF+FVppSpB2KWJnmzpxYwdEC/Sgl0caZifVr+BCHHXr8vdqOogFcoXO3+JMWdBRKuM/atxF17u+DscFYnmEi59GCcaOSh7+RZbjv+On8Cceg7rnYrh5gG4VDBcJFW2mXiEYDCmfATJdY6iqYKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502781; c=relaxed/simple;
	bh=Q8wlcxSfI2C49/3WlyqJcY/1pWE9xD8JeXXXOkS61Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAgIdh4aLCzqjiy0oMZU+BRAUwcmwQh/cPY3pNijndWNlq2hh6cCP90qNzzN0XpRI2r6Z5Aiz6O1F3FGSY7aTms9jLMyAcMRftCr02zF86LoAn+Sh/K1q74ExRThVB2IivvpCU97Fih3BwkaezrgdhAr8SDHcLMsIU+sP2BT/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvJlV8Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897AEC4CEEB;
	Mon,  9 Jun 2025 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749502780;
	bh=Q8wlcxSfI2C49/3WlyqJcY/1pWE9xD8JeXXXOkS61Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvJlV8FkqEHOwffmigf9MVhomFOyzEqxs99x41Zi6PcTsgfOcCp/7yI7ZrFQHgjHM
	 sZ77HvPjPHRMgjGRhKPqfeB6jl2H+x5cEX9Zufj00QY7aiRC6qKfmCsz0+iAkalLd+
	 oUKf7OKBQ+bfJhct2DK/RPSdhefLG3Arng8x7b9E5migJp8p8Ij+BtaWWk304522Ww
	 GyIZtLDWA316nC2c2o2kfmtHK0EOCKfH0Z9St6VmTCNIcpC6qtZAda2notHVQndouY
	 n0iRb/Q6xoT00NoFbfb67cyC6mfOEfUwUJLTS5fcWmD7/eP26e1zJoQdcabI6IyDTN
	 c46/LMxGH/vpw==
Date: Mon, 9 Jun 2025 23:59:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa
 driver when it's built-in
Message-ID: <aEdLOb3V3EgBZJof@kernel.org>
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

Your description in the cover letter and commit messages in unclear
and convoluted. Please describe exact causalities instead of something
not defined could cause "failure" (which is also abstract concept).

I'll check the next round.

> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun

BR, Jarkko

