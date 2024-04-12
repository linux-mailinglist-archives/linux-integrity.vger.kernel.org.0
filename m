Return-Path: <linux-integrity+bounces-2056-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25558A31D0
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DE1C2126C
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F71465BD;
	Fri, 12 Apr 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAwZOfoY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3385285
	for <linux-integrity@vger.kernel.org>; Fri, 12 Apr 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934550; cv=none; b=qZE5wgCBRcmM2OiO1twN3pXjIIk3azGsbeFb9rlRGEo47ToiksK6E9GVd4tIL/O097gt52JdYPfXYB9gUqcoen84c1YntRL8gUh307BPQ3QUZfcZOVxb1W/RIrzndN8GNB1nniXucw/BuFVWhFP+uV0IF1VQgeabwysjsVv4eSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934550; c=relaxed/simple;
	bh=Ujj1GT1OiwJhZvMrv50V4ObpLTLWi9ndUBKpX9UYgR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdaVdIVPAKtwzmG5MlZwYhB3KnmAgZTbm5gYqnzpWrYpZGKmetkJUzsEctvpfatE5EoxNX82ZPr/MgoKtTbr1uyB+joLZPn82VvUWj+hwkeGcNpVcRWsziVsznNEMqESF3ZYk7P5ic/rujCk6WALg8B8stLL5J2bwgBGI2sAfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAwZOfoY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712934548; x=1744470548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ujj1GT1OiwJhZvMrv50V4ObpLTLWi9ndUBKpX9UYgR0=;
  b=IAwZOfoYCEE7SfpxdRffiOCJlk9gLlPHm2+MdWDPFVvPncE11BPLStFe
   /gECenFHeOW3YC/We7Cli7XaZ+944Q4nc31xfNgsidRFRR+Gq3AOx5V7j
   LC8aKKNtWvQaXOwQ1tqRiUIpokBX/Ey346jjQ3E5gN4H4jtbAppOXDv2P
   lCJUXyuhuTGRJbeNQZjSFrRPGEhV9G/NmLxYs4JFlQcOMwo/EtKt5tNn1
   XE0NJlb7UQyPv2DrXmSmvXtbwijTBLIx/zEjCwBm1b0yi2A7medYjE66G
   VHK1wHqbGANtUHRZVXbT3VVsuvtaPHkhC3CjqQ+gNjmRMh/z5SAZq3wmx
   A==;
X-CSE-ConnectionGUID: QDivR3OnQHOwj912IVh30A==
X-CSE-MsgGUID: ShVhiQGwRJGwOXoGDDMv0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8568413"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8568413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:09:07 -0700
X-CSE-ConnectionGUID: ysHXEuhpRcSeiN00rU6Cbg==
X-CSE-MsgGUID: 3QXTbJ5WQzGFmQMqU3Koog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25802571"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 12 Apr 2024 08:09:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1011)
	id 79984E7; Fri, 12 Apr 2024 18:09:02 +0300 (EEST)
Date: Fri, 12 Apr 2024 18:09:02 +0300
From: "Svahn, Kai" <kai.svahn@linux.intel.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
	Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	Ken Goldman <kgold@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bruno Meneguele <bmeneg@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	George Wilson <gcwilson@linux.ibm.com>,
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>,
	Andr?? Draszik <git@andred.net>,
	Frank Sorenson <sorenson@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <ZhlOjunocFKwYENP@black.fi.intel.com>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>

Hi,

On Mon, Mar 18, 2024 at 05:07:24PM +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
> 
> This patch includes all acks received so far.
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Vitaly Chikunov <vt@altlinux.org>
> Acked-by: Ken Goldman <kgold@linux.ibm.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: George Wilson <gcwilson@linux.ibm.com>
> Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> Acked-by: Andr?? Draszik <git@andred.net>
> Acked-by: Frank Sorenson <sorenson@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> Acked-by: Eric Biggers <ebiggers@google.com>
> Acked-by: Alberto Mardegan <a.mardegan@omp.ru>
> Acked-by: Eric Biggers <ebiggers@google.com> # all Google contributions
> Acked-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Acked-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>  # all IBM contributions
> Acked-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---

Acked-by: Kai Svahn <kai.svahn@linux.intel.com>

Cheers,
Kai

