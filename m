Return-Path: <linux-integrity+bounces-1321-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E085D286
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 09:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC04B1C21622
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEF3BB4C;
	Wed, 21 Feb 2024 08:27:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8573C47E
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504057; cv=none; b=ixzSs0aNtStT6+xFdxyjUc1g4Ox89+RiVtrkFWPdHVHzP0DHA0/6Nbhc4ikT82CrE6gN9M1nKNxR55I49MSbJ6MaP+LZWuGO4Wd+ZArflbf4cljdkFOmuU+DJVhDCg6lFAm23WYAx3Tmpq+FmzuoAGTUsGm7l9B7fFkOB61S3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504057; c=relaxed/simple;
	bh=ffO6P+jAfnU6vI42j/iJ8WCQrnm5queApNT736xN67c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOPfiwiYcw81V5zJwOfswMZ32nFePfxfB+bQBBDwyY6hAH7qyCRtVSVuiSNJW5y2O/DMYzLW+2Y+MonICARW3MnKuMIRHKN8kA70dIPrw4ToJMQgUlqsPHxSQyw+GG7+FMCnPqPqJYCA54XlFSiSzu2DIT0aeBxiqJRpcH9xXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2B06E40691; Wed, 21 Feb 2024 08:18:40 +0000 (GMT)
Date: Wed, 21 Feb 2024 08:18:40 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net,
	dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com,
	gcwilson@linux.ibm.com, James.Bottomley@hansenpartnership.com,
	kgoldman@us.ibm.com, zohar@linux.ibm.com, patrick.ohly@intel.com,
	patrick@puiterwijk.org, petr.vorel@gmail.com,
	roberto.sassu@huawei.com, stefanb@linux.ibm.com,
	stephen.smalley.work@gmail.com, tianjia.zhang@linux.alibaba.com,
	vt@altlinux.org, vgoyal@redhat.com, z.jasinski@samsung.com
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <ZdWx4CyUrnsMlzwA@srcf.ucam.org>
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>

On Wed, Feb 21, 2024 at 10:11:34AM +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.

I'm completely supportive of this, but do you need explicit permission 
from every copyright holder? I don't think I have any code in the 
library, but if I did it probably technically belongs to a former 
employer and I'd need to figure out who's still employed in the relevant 
office to get them to agree.

