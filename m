Return-Path: <linux-integrity+bounces-7183-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43BB86F58
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 22:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3337E0112
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D182ECD39;
	Thu, 18 Sep 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVV2WfjC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156E264A72;
	Thu, 18 Sep 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228756; cv=none; b=fo0TmCk//WP1bxFTaATFuUziUwhKU7G2PyRca35SKCnqupux1dTNIHWbU/LvdNgQUfmipjvvsp5fgwY1yCSuDBRWOfffjwlB8xs0RPFetliKWlUEwnh+WXtTmVUzfKdOTpx0GcwtSwJXMvjQadBpRet63qPC8sgf6wpjEmL0yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228756; c=relaxed/simple;
	bh=ZkLGh94phtEema8WHbBi3csQqtKxGnStCf7APFvKzJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IijCFLCS5d5h1rWfXZ+nIIY/SmTQrXgtLCx7M6wmmiHMt3gL5Rw19i7IdH1BNfbfkYTVRnWZGchlvaiyQLMpKAT7f0G9h7TpMOXlkquYIRDTF/2+cVf4sjFPsUcmOzqw6xcdSNkeV5YnpaA4DB7qQhhOF2sKezpxOBVrDdzIjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVV2WfjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96CC4CEE7;
	Thu, 18 Sep 2025 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758228755;
	bh=ZkLGh94phtEema8WHbBi3csQqtKxGnStCf7APFvKzJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVV2WfjC5H1gdj4iSWHYx271IJeBQTrxvJmiRDclZyHbaniBt9KROllyoJ9XucerC
	 nWpb2S21nB6LeCdQjHbxhp16GVaVjXwXbPmRlm2NIAmPinOy6aeDzNhigfiQqDJCTf
	 pU3s1u3xt0mGO/P9mDcEVmv8oZJO6xTBTGUpdWIJbPdh83gQ/YXPJnuLH6Eb3Dm5Je
	 y78bCn/6uSd4nBMtJy1B5h4xydIouc0m+feX61ESKAphyetjGpVWyfGxAxv7FU+Qn/
	 9bn2iI9fIr7zq83rNXunyOewOZyAMdN7m49optUtLZOPtFUZ+biJamhObLYAtyZgk+
	 75pueFdQMlQEQ==
Date: Thu, 18 Sep 2025 23:52:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
	stable@vger.kernel.or, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
Message-ID: <aMxxD1QvAgZyQkaM@kernel.org>
References: <20250825203223.629515-1-jarkko@kernel.org>
 <aMxV9fB0E72QQY2G@earth.li>
 <aMxZlHn9bfa5LGEU@kernel.org>
 <CAMigqh2gJ+ALqxb8RcNFENJg-Z0FfKE2DZjaGdOER7G3AGZvKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMigqh2gJ+ALqxb8RcNFENJg-Z0FfKE2DZjaGdOER7G3AGZvKg@mail.gmail.com>

On Thu, Sep 18, 2025 at 12:50:57PM -0700, Chris Fenner wrote:
> Agreed, the feature needs some work in order to provide meaningful
> security value, and disabling it by default facilitates that work.
> 
> Reviewed-By: Chris Fenner <cfenn@google.com>

Thanks!

BR, Jarkko

