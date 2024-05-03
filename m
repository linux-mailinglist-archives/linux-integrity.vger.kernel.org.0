Return-Path: <linux-integrity+bounces-2303-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806418BABC9
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2024 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373DB1F21D44
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2024 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19C14534A;
	Fri,  3 May 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWMXXmRo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE441C93
	for <linux-integrity@vger.kernel.org>; Fri,  3 May 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736411; cv=none; b=Sns/jqIZ9A76i/2O/BTr/68ihCXw7UiS50m5wFweTvTqOHAAy0yk6YV/9LrGUPL6VWh2eGE/vfJDexXe+Fx73MByDB0Odu/Vz4tHJY3pZzDgza+t0bQYuQ1Gkd8EDIFcDwlhb4rx5+48acmBkxF+U79Q4zuaxgBqAYA+m0FC4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736411; c=relaxed/simple;
	bh=HVIlwxj1XlUjmUkbZ9DQiwhFjKBdSzGbrBwbUVQ8olM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM08n9jlLax97y8n+QLqjGGlQlPZ5hql/qYcxRlBN498YP/h9CjDGycaHPonP9r32OKM2euWOHyX4px/iBxlL4bUjDlsfY7HE+nGDc8PT5Xtzb0hky46kGJtWO3cjs7WB7j5u54vVS4gnqkyayZsYkf6no+BV9l7vFfNElE0bPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWMXXmRo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714736408; x=1746272408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVIlwxj1XlUjmUkbZ9DQiwhFjKBdSzGbrBwbUVQ8olM=;
  b=UWMXXmRo1jGG/JGqy9cbfGOXsMQ+LrBiQk5q9FkaxNsJ9cqwHopmh8nK
   cJHfby995VIHobx9Y/g+FbO57sYumi6wG2PfWy1wNw7dGPz/gmtgk9ztT
   IOaTnS/zX3RuJRqMxmWDEZZyYLTlGTChSnx9KjniVTz40xqgs4VWtAIsM
   lfIqmXnDyVzP7KTo629AeyQxzWYkKUVmG9dbtqlY3tB+geQa0WCG0jfii
   VVpvRp1HtByISxL8/5ITT6EjqUC+6m6WQLZ95zTcIa7CTRwsovdbgkvRM
   rt7DDp6cpjAxktQVSxNBSi+nI0gpt8+IfVDXZWkCvCbmyEyblCIlVXCZ2
   A==;
X-CSE-ConnectionGUID: U4FyA5myTXyWRZ0tRf5UQA==
X-CSE-MsgGUID: MemVaQnZSO6dmcY64nB4AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21955124"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21955124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 04:40:07 -0700
X-CSE-ConnectionGUID: L+eeVZwFTTKBhjwzfWm9DA==
X-CSE-MsgGUID: +LnsvirOT6CziPhXH2NSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="31937756"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 03 May 2024 04:40:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1011)
	id 7CA4D19E; Fri,  3 May 2024 14:40:01 +0300 (EEST)
Date: Fri, 3 May 2024 14:40:01 +0300
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
Message-ID: <ZjTNEbrDZvLxzV5h@black.fi.intel.com>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <ZhlOjunocFKwYENP@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlOjunocFKwYENP@black.fi.intel.com>

Hi,

On Fri, Apr 12, 2024 at 06:09:02PM +0300, Svahn, Kai wrote:
> Hi,
> 
> On Mon, Mar 18, 2024 at 05:07:24PM +0200, Dmitry Kasatkin wrote:
> > Currently libimaevm provided by this project is used by the tool evmctl,
> > which is also provided by this project.
> > 
> > An issue was reported about using libimaevm with other software. Its
> > GPL2-only license makes it incompatible to use with other licenses, in
> > particular GPL3-only.
> > 
> > To address this issue, change the project license to GPL-2.0-or-later
> > and libimaevm to LGPL 2.0 or later.
> > 
> > This patch includes all acks received so far.
> > 
> > Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> > Acked-by: Petr Vorel <pvorel@suse.cz>
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Vitaly Chikunov <vt@altlinux.org>
> > Acked-by: Ken Goldman <kgold@linux.ibm.com>
> > Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> > Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: George Wilson <gcwilson@linux.ibm.com>
> > Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> > Acked-by: Andr?? Draszik <git@andred.net>
> > Acked-by: Frank Sorenson <sorenson@redhat.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > Acked-by: Eric Biggers <ebiggers@google.com>
> > Acked-by: Alberto Mardegan <a.mardegan@omp.ru>
> > Acked-by: Eric Biggers <ebiggers@google.com> # all Google contributions
> > Acked-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> > Acked-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com>  # all IBM contributions
> > Acked-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> 
> Acked-by: Kai Svahn <kai.svahn@linux.intel.com>

Acked-by: Kai Svahn <kai.svahn@linux.intel.com> # all Intel contributions 

Cheers,
Kai

