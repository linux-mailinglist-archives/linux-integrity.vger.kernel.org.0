Return-Path: <linux-integrity+bounces-6104-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C3AA516E
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71259E123F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2225A658;
	Wed, 30 Apr 2025 16:18:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69449265629;
	Wed, 30 Apr 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029881; cv=none; b=tLnJs6/DCy+n2EqqOfXWSOkTgjt/7GlqtOcoj07JVR4j9mQwloCCMCOq78OYWqgbQspTf/zdPB/5g+Q6p3EP0WdmG3EDTYSjX+WaTc4+ELkNa0IH+X3z7owAKmlkzmqan8lugdyIwS5x8zGJu4gGGz96heFQ9UdZG8FEMkddX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029881; c=relaxed/simple;
	bh=Tbgdcv1Iv4vsXqovySHOgv8baFUO4hV80x404vOUDnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3461U71yq7iEJmETdoxgVJ9zkvBWxq9Gka+YthueBXrm8wJhA8UkvKCutvh06Iy1lD10hqJdzSkXG/AC3acHqJ1vfSiol3aiGzB9vArpSetFlxzUgYA79Xon6iV1IwuHvOsv3fQVLmm+2Rzr1Y7tgGMLOVe79mIyUO3sLy/Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C8C1063;
	Wed, 30 Apr 2025 09:17:51 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91B233F673;
	Wed, 30 Apr 2025 09:17:57 -0700 (PDT)
Date: Wed, 30 Apr 2025 17:17:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: <linux-integrity@vger.kernel.org>, <jarkko@kernel.org>,
	<peterhuewe@gmx.de>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_crb: ffa_tpm: fix/update comments describing the
 CRB over FFA ABI
Message-ID: <20250430-enormous-romantic-antelope-ecdce1@sudeepholla>
References: <20250430154723.1025101-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430154723.1025101-1-stuart.yoder@arm.com>

On Wed, Apr 30, 2025 at 10:47:23AM -0500, Stuart Yoder wrote:
> -Fix the comment describing the 'start' function, which was a cut/paste
>  mistake for a different function.
> 
> -The comment for DIRECT_REQ and DIRECT_RESP only mentioned AArch32
>  and listed 32-bit function IDs.  Update to include 64-bit.
> 

LGTM, FWIW

Reviewed-by Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

