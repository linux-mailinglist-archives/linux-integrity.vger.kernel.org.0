Return-Path: <linux-integrity+bounces-1453-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051408620CD
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Feb 2024 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961061F213A0
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15C14DFC6;
	Fri, 23 Feb 2024 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lyd6JYVx";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lyd6JYVx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F414DFC4
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732286; cv=none; b=WwEPNzpuQLHfhDsJYDOwVO6E9R8BK10pCcFYqFw0ZVotvT2AI8AecvzB+GC28ZqL0SB3yj4r+vxczZ372meg+j8M+TQHzIG3AElt/mGVuUoO0saFS/Io8jTEr4CPRRYFJicwok71jAu+NvYhYhb25kupn4Ls/epxPPPPvNQToMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732286; c=relaxed/simple;
	bh=e9/k19P38Ibdkh5cbAo+EOuMJyB2qz1jcuTJgakKteU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u13LGCHbKGxqKQxPsHGHeFleUekt3+sDIlMh3ftZ8+Lo7kbbuwANqK3JIKathndpB6MGk37jwUFwUo4CMZN1W51wogh8ip9dAyOPV+mTmoXhoFiI0OZvSPtuNrLx6FE5d+EnEqlNjGwcoCp0Fwy3uTlQg7Fu1Z8gch4hYaWfI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lyd6JYVx; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lyd6JYVx; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708732283;
	bh=e9/k19P38Ibdkh5cbAo+EOuMJyB2qz1jcuTJgakKteU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lyd6JYVxBDjTiqixYCaIPSm+tkOndsI52bWfN4fwECE1OyzMZ1FE2ICy9ezrjWOfe
	 EyuIAjgHWqXZ0TjaNpkbmeusIYnp4HB/JmKbGwmfvcNPVIddWSWKUT7AivmRh9GskN
	 SsoV6LfXNjU2VVwhYjGY4AAV5qjbP9JHr9e1SHMM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4A03E12806BE;
	Fri, 23 Feb 2024 18:51:23 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id by3odHIl7UgL; Fri, 23 Feb 2024 18:51:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708732283;
	bh=e9/k19P38Ibdkh5cbAo+EOuMJyB2qz1jcuTJgakKteU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lyd6JYVxBDjTiqixYCaIPSm+tkOndsI52bWfN4fwECE1OyzMZ1FE2ICy9ezrjWOfe
	 EyuIAjgHWqXZ0TjaNpkbmeusIYnp4HB/JmKbGwmfvcNPVIddWSWKUT7AivmRh9GskN
	 SsoV6LfXNjU2VVwhYjGY4AAV5qjbP9JHr9e1SHMM=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 044C312801C9;
	Fri, 23 Feb 2024 18:51:15 -0500 (EST)
Message-ID: <f0a2660dd230c3e26012396105a5589f8c9178e6.camel@HansenPartnership.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin
	 <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org
Cc: a.mardegan@omp.ru, git@andred.net, dbaryshkov@gmail.com,
 ebiggers@google.com,  sorenson@redhat.com, gcwilson@linux.ibm.com,
 kgoldman@us.ibm.com,  mjg59@srcf.ucam.org, patrick.ohly@intel.com,
 patrick@puiterwijk.org,  petr.vorel@gmail.com, roberto.sassu@huawei.com,
 stefanb@linux.ibm.com,  stephen.smalley.work@gmail.com,
 tianjia.zhang@linux.alibaba.com, vt@altlinux.org,  vgoyal@redhat.com,
 z.jasinski@samsung.com
Date: Sat, 24 Feb 2024 06:51:12 +0700
In-Reply-To: <5dd2108599f11c9f9ea73a4f127ec969347bc78f.camel@linux.ibm.com>
References: 
	<9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
	 <5dd2108599f11c9f9ea73a4f127ec969347bc78f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-02-23 at 12:42 -0500, Mimi Zohar wrote:
> On Wed, 2024-02-21 at 10:11 +0200, Dmitry Kasatkin wrote:
> > Currently libimaevm provided by this project is used by the tool
> > evmctl,
> > which is also provided by this project.
> > 
> > An issue was reported about using libimaevm with other software.
> > Its
> > GPL2-only license makes it incompatible to use with other licenses,
> > in
> > particular GPL3-only.
> > 
> > To address this issue, change the project license to GPL-2.0-or-
> > later
> > and libimaevm to LGPL 2.0 or later.
> > 
> > Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> 
> Thanks, Dmitry!
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James


