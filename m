Return-Path: <linux-integrity+bounces-4785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F135A3173C
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544C21664FA
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A464264FB3;
	Tue, 11 Feb 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVTrX4Nz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB002641E8;
	Tue, 11 Feb 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308051; cv=none; b=gv/kC9aoU4BNU0oCEOj3z/lzbwp01uUt3Gs2QJBZ5MBqetQltNhKDc/GP+L7IUJwSafflAS1zE8Ys4lXExuz9eA6Y54hcKhm0TfB/SC4tGdGYOJAa4086hEGUCmcxd4PpaaeGziUeAENsXWAklB+LJrL8Pws0KY0uxwwAIC8Uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308051; c=relaxed/simple;
	bh=FI0dG1Wzq9Ch0PpL2X49WF6QMuz/ZYuzGVaB0NDPLOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC+sMxhn3gMvO0ic06f3IocKVHZdSTxuwQ1qwC8kyZF4K/MXY8NJIXtAOKokXnjNAsLVP+XrHACdG8szowiitMUoKrm+xOVfhX32709TU7ybb4H99iL8n00oPzE79xXUApuXfs4yQU8b0MW/wNTY/QGa5AyY7F96WifcEYCWFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVTrX4Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B6DC4CEDD;
	Tue, 11 Feb 2025 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739308050;
	bh=FI0dG1Wzq9Ch0PpL2X49WF6QMuz/ZYuzGVaB0NDPLOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVTrX4Nz2j9+0+Dppl6U78REZy/2zvBYhgu+kl0dnV2RlJgZ8Mbt1ag0oy84owQZD
	 YHBIkZDCZ6/R73K9EFq8lef30Gvai3uYlLucI66scPmOhc4hY37DlBKbnMy0hQrpy5
	 suQl4ZRp0tVi0FbQ6vaj6sdnTAiLFFf0d7dVinFLurJAFdefzhC+MXouw/W3UNgZQX
	 7FNh2qVRI/+RTndhCksPbeelbmxt2x7QEAW6eR0mDzw26kk+l+I7FaK8DwlyvoLRtt
	 AWOXVaZXyeTGQbRd5ZYVMsGCfx4PTbPueKHMbRNZ01i97BLQpZXD90IrCfRpw2K+Yc
	 +eync2dqHFgFg==
Date: Tue, 11 Feb 2025 23:07:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
Message-ID: <Z6u8DbOlZflmQ9i7@kernel.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210232227.97761-1-stuart.yoder@arm.com>

On Mon, Feb 10, 2025 at 05:22:23PM -0600, Stuart Yoder wrote:
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification. 
> (https://developer.arm.com/documentation/den0138/latest/)


It would bring a whole a lot of clarity to open up acronyms.
What are F, F and A? There's quite a few of these in this
industry.

Also, probably you could take the spec out of parentheses and
use double colon.

BR, Jarkko 

