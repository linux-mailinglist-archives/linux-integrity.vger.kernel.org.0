Return-Path: <linux-integrity+bounces-7702-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C6C8F9EC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48ADA34A6F8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119A2DF717;
	Thu, 27 Nov 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkVDnroB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C17082D;
	Thu, 27 Nov 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263667; cv=none; b=JERTRdA/FvPLqEkz35O0knpCjBqorEqjkGcamX4WK7JAOLDwCsjvRrL/UTbq+MBuOIeB3MWN/sMO3Pts3QTa3dXxgvIgPLi+mCwXy9vhZhnUieWzDJGr5FsKvp5x3oS8VC0Sxsa1Eu6rbYmyrBmpLn/KtjelkRzk7v2jdVPPGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263667; c=relaxed/simple;
	bh=OMlbKwSL2u86U8byH2ReW6ig0EKqF86G2QwgQsLkTaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om2/Lmc6YQmeU90YPt3Fd6qIceeDHtcLW8Irejq/xLhJqxMR/tbgOFtAPBSkKYHO+gyLPKIJvyQqtH6jVIjgsuHWRErZqs4Di4NEjXgCRZ1zEgsNDnwh13I1kkT5MaE5WSt1rMwNPvmgSba7mGSVJ/zOKCVPog7chdZTRgbt17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkVDnroB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E06C4CEF8;
	Thu, 27 Nov 2025 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764263666;
	bh=OMlbKwSL2u86U8byH2ReW6ig0EKqF86G2QwgQsLkTaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkVDnroBg+yMwmfa9GDYQjY6e23sSsjr8OKGMWxIgV2nnsDBxFIK659vJ+cQnfulF
	 2Q7VUJZ/WoxSgFv1XGZES+URgXnTUNcIM5nwC+5f1yT2Dcz0Bkh9ffJB+B1lZZ+8AK
	 r/ylcDxZOpxn6SzbMMDEDymlLwn5+iv6iLXHFyCJcTD7/wheNn4nsurhg6Y0uPMmBU
	 MLMpLWuZmxu0/c9ncXGSXrNckgJE+UApA9e8RQxYpzkPW9kUPs7tHo0VG0LGqPzbL/
	 3nliSjm/+HJIVhFD2/QxuVuZ15n/WQ5uqs7H2yx4MJnR0G+qIgDUiRuJ/8w4vJdfgP
	 8mc7PcJg4ElGw==
Date: Thu, 27 Nov 2025 19:14:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
Message-ID: <aSiG7l_1E12r_56c@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
 <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>

On Thu, Nov 27, 2025 at 05:09:38PM +0100, Roberto Sassu wrote:
> On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > banks. Cap the limit to eight banks so that out of bounds values coming
> > from external I/O cause on only limited harm.
> > 
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Sorry, I realized that you are expecting me to review.
> 
> I have a couple of questions:
> - Could you explain better how out of bounds would occur, since one
>   could check the number of PCR banks?
> - Is dynamic allocation that bad? And if yes, why?
> - Couldn't you just check that the number of available PCR banks is 
>   below the threshold you like and keep dynamic allocation?
> - Is removing tpm1_get_pcr_allocation() improving code readability?

nr_possible_banks is read from external source i.e., neither kernel nor
CPU fully control its value. This causes *uncontrolled* dynamic
allocation. Thus, it must be capped to some value.

> 
> Thanks
> 
> Roberto

BR, Jarkko

