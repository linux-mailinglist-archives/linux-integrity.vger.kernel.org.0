Return-Path: <linux-integrity+bounces-6524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A65AE8B11
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB38B188F2C1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B332D662D;
	Wed, 25 Jun 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5KggnoN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E5946A;
	Wed, 25 Jun 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870566; cv=none; b=M3u1zCDX8kvvD5Wo6wX5pcNTYm3zJwZbyv7MHCT4SjhM7RkGhx8kGHywuy30UOZzY0/pTa/AC+m0ybZ9Qboa11jq7pVBfr4Doa2Ilckug+xkr3cJBkcD1vwS5BHEusGAsnmxBVpXtc41/rxnDpKSCTsyikZ0Umf3qmRk09zo3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870566; c=relaxed/simple;
	bh=LRC0dit3N4Db3Q77f8HVZ5BfH7gvXp5ERShOZqe6Rpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVVK53JenuPm8SK0AIzEw4BIDD19CvpH/LqVlMiaBrMFbYA/XoNLpPwmtM0EMYe7T0zZhcJj7Q6FulYyJ4FsDztPHX82+jOmh2NZr8VA6FqCfnXwtjZVToF5KWGQHTO2pxfiSymR7YbbhQPmZiYqyX67B64Dx1zMY67eS8QV778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5KggnoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F59DC4CEEA;
	Wed, 25 Jun 2025 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870565;
	bh=LRC0dit3N4Db3Q77f8HVZ5BfH7gvXp5ERShOZqe6Rpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5KggnoNj5VbDCQIlc1wP1gr3w8AebofgkhEkgQiZ/pdt/wXXUBSbYnZ0BR8TO4cD
	 RaU8zxJmxOmkXuEPO9i0PBqnFe8PXhFs/vIguyXEBZNlN+V6+XoKpPTycdY01eMM0+
	 Go3hVPaEcLvT1Jbm30nlXNxHXnr2oAdIMMH/uoBcBX4Xgfad/JDMKRZV2TJdaKIRxR
	 3STnVS9WzmNWmioz/kX8XIKnZRvTGtA6jUKlC1UZnnuMhf4RZWlRGQwN2702XBTl9k
	 4uG7somOgokIFrSROXTApjqrJc0FcLh9o1WjkdaT+/paEv2WZ8gb+vjOQgX58rjSaX
	 K1GmkwBIiYh7A==
Date: Wed, 25 Jun 2025 19:56:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
Message-ID: <aFwqIqfFFrwg1vIm@kernel.org>
References: <20250625050346.11500-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625050346.11500-1-chelsyratnawat2001@gmail.com>

On Tue, Jun 24, 2025 at 10:03:46PM -0700, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
> Changes in v4: 
> - updated the commit message.
>  
>  drivers/char/tpm/tpm_ppi.c | 48 ++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)

$ scripts/checkpatch.pl --strict 0001-tpm-Replace-scnprintf-with-sysfs_emit-and-sysfs_emit.patch 
CHECK: Alignment should match open parenthesis
#36: FILE: drivers/char/tpm/tpm_ppi.c:91:
+                               size = sysfs_emit(buf, "%llu %llu\n", req,
                                    obj->package.elements[2].integer.value);

CHECK: Alignment should match open parenthesis
#50: FILE: drivers/char/tpm/tpm_ppi.c:102:
+                       size = sysfs_emit(buf, "%llu\n",
                                 obj->package.elements[1].integer.value);

CHECK: spaces preferred around that '-' (ctx:VxV)
#63: FILE: drivers/char/tpm/tpm_ppi.c:215:
+                                   info[ARRAY_SIZE(info)-1]);
                                                         ^

total: 0 errors, 0 warnings, 3 checks, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-tpm-Replace-scnprintf-with-sysfs_emit-and-sysfs_emit.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Can you fix these checkpatch errors?

BR, Jarkko

