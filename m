Return-Path: <linux-integrity+bounces-4921-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03FA3D4AF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A7A1886DE5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2B1EE7C2;
	Thu, 20 Feb 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGQlFxR6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BF1B0F20;
	Thu, 20 Feb 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043737; cv=none; b=PtcdwcqwH0356REtXNIuiOqhkSzIxFGU40Q/9oscZPUgRTdUgpBFDus79geoXnLkDr41CswgWCfOrIgKloh0wc5ixIzVWmKeh5Cv7wlAoADPVgX3A2LooDHu4sQhrWpus3EYicw7NG4QgoRAsAGebLapCtn7UMLCxSYJqK/r0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043737; c=relaxed/simple;
	bh=Ox1rnkX2MnB4obYe/XcY/kDNaBcnB3zGRCGhmljxVps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdG/4EB+aiLNgkn8729/fb5lhfiS8UctdT1jM81HSkTXyST5Zk+QzpPpzZ1qDAzAKPJvyxmA1iF8hfE5uvNJqWKqRitRKwTHBCzNJ+o1kWyMlKlzloX+aVE887dVaA/sZa4V1xgcyOAw4fhovoNkvfoSN7jdT0QZz8ruuebBqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGQlFxR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F763C4CED1;
	Thu, 20 Feb 2025 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043736;
	bh=Ox1rnkX2MnB4obYe/XcY/kDNaBcnB3zGRCGhmljxVps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGQlFxR6c6mDIYSazSwsGrFYRlVvHIWZ0RshG78axPEQSWuHy7QucBy6jyXUrC34/
	 py8kdju76/CuGjQOCJatAJYNmXxZDhrw1WYlhLZkJrWfsmvSZPIWWvLYF7lsFNSIkt
	 tJJqpST9CrCz9izvFYO+MTJI0wDCD3Is8vSBtexAjifMSYMtoSDVHveLS9XA/FfSRw
	 U/50RX/azjsEeyn55Wt2fEhno4vCPktdnVgHqsKMk7lb/iHJqXI4bKnuaGrPKCULYX
	 YqK7RyqzgT1ZAmuPchjZC7HpzCLcxLvRyV+4Tp82ZSGTumvR6hL9nv/WNxaMOTtouD
	 I6kUwJjW+u+xQ==
Date: Thu, 20 Feb 2025 11:28:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
Message-ID: <Z7b11Kahh7JXDq9E@kernel.org>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-2-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219201014.174344-2-stuart.yoder@arm.com>

On Wed, Feb 19, 2025 at 02:10:10PM -0600, Stuart Yoder wrote:
> The Arm specification TPM Service CRB over FF-A specification
> defines the FF-A messages to interact with a CRB-based TPM
> implemented as an FF-A secure partition.
> 
> Spec URL:
> https://developer.arm.com/documentation/den0138/latest/
> 
> This driver is probed when a TPM Secure Partition is
> discovered by the FF-A subsystem. It exposes APIs
> used by the TPM CRB driver to send notifications to
> the TPM.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>

Cutting hairs now but as I cannot test this and this is 1/5:
can this patch be run without 2/5-4/5?

The policy is that every patch should leave kernel tree to
a state where it compiles and runs.

BR, Jarkko

