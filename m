Return-Path: <linux-integrity+bounces-5828-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911BA8562E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C54691F4
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503F28EA7A;
	Fri, 11 Apr 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIfCmXGf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA971DDC04;
	Fri, 11 Apr 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358884; cv=none; b=PvTTBobm/ObYQllmYWqIiZGAIxykR0gF8umSVjctpCs4kv4If8WTKH7QTGd/zYsYRs6QjA5k0+d/XLlBzF8KiW4JmOWhAILX/WxfrIjoB6YWEZir1VIRFf5MMm30XvwTNvH5QlJWjIl7IbRA1Hc3Z1iT5xdc9UDHd/uZHXhESnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358884; c=relaxed/simple;
	bh=RKpuRM9HPlFVDOBUnsmTmzF4uMGBZHYlkGWTm8FKOx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpfZguvNGtkwfmO9NZaqoNqddpeWpJeoklNsFXf7b0PySnBWGPafefSMnAdiq6OciC4dtH8elGVDrAbi0Ks4VEJVegz5hr1Yhx/cG5dkIeBeKaYTKPkMeNdjJfkyWu5bcEVF4DD3nmSt0GhpKYu7f71BWoI/zssgQ/rjhUd28LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIfCmXGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EACC4CEE2;
	Fri, 11 Apr 2025 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744358883;
	bh=RKpuRM9HPlFVDOBUnsmTmzF4uMGBZHYlkGWTm8FKOx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIfCmXGfeja4+ERryJFQPCn88YlH6CwXcffCvKSC/JMhmrasR9OjmpkmBiyazQsor
	 HJ2OO10nYvGZ9RcomaoADUJt0/IVZSrz1I/dvTdIzjQ6fUmhEdDgXBu8AO0QtiU3b7
	 keqyTic7MGruWLtyz2mgPYzYE3latfq1tIi70MGIEj0ujGsCA+IzZpmQQId2IFJ1HK
	 GJhbk63+9B3/HEhnHQt0mL5Te8WE+RQzGmon7qvilsFpAm/xQSJMrIlUb5wCrVE4c6
	 EcloCO7gctyBRrnpHc6ANrVTTbo+9VYTmPQ05MmQHdUnDV/hRNx60EYA96uCJtj9kM
	 qkFDNfUsgTgDg==
Date: Fri, 11 Apr 2025 11:07:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_ffa_crb: access tpm service over FF-A direct message
 request v2
Message-ID: <Z_jN3pRlv1PuwHGn@kernel.org>
References: <20250410110701.1244965-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410110701.1244965-1-yeoreum.yun@arm.com>

On Thu, Apr 10, 2025 at 12:07:01PM +0100, Yeoreum Yun wrote:
> @@ -277,7 +301,8 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> 
>  	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
> 
> -	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> +	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> +			!ffa_partition_supports_direct_req2_recv(ffa_dev)) {

	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {

BR, Jarkko

