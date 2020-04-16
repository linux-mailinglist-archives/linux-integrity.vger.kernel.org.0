Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2A1ACCE5
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504275AbgDPQLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 12:11:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:59774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbgDPQLp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 12:11:45 -0400
IronPort-SDR: GDEFM96pkWk7SITHruncP6SCCHuoCEc4+tNp9fBWpTAU/C1tpfYG72y1Yw7Mkp3VlXsHk7ubIr
 zQfHV1RD5GyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:11:44 -0700
IronPort-SDR: q5OWoPoACa6Z3qbloJMXeX+bcgoLmhw37ndlmffyLuRUZLNvt/iYRC/1fjvi6j0MpupWgYVHQd
 c0dpwSj3rnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="272118808"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2020 09:11:42 -0700
Date:   Thu, 16 Apr 2020 19:11:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200416161141.GA181141@linux.intel.com>
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
 <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
 <20200414193542.GB13000@linux.intel.com>
 <20200414202615.stnurisucqxblenj@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414202615.stnurisucqxblenj@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 14, 2020 at 01:26:15PM -0700, Jerry Snitselaar wrote:
> On Tue Apr 14 20, Jarkko Sakkinen wrote:
> > On Tue, Apr 14, 2020 at 11:55:43AM +0000, Roberto Sassu wrote:
> > > > -----Original Message-----
> > > > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > > > owner@vger.kernel.org] On Behalf Of Tianjia Zhang
> > > > Sent: Tuesday, April 14, 2020 1:42 PM
> > > > To: peterhuewe@gmx.de; jarkko.sakkinen@linux.intel.com; jgg@ziepe.ca;
> > > > arnd@arndb.de; gregkh@linuxfoundation.org; zhang.jia@linux.alibaba.com
> > > > Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > tianjia.zhang@linux.alibaba.com
> > > > Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
> > > >
> > > > For the algorithm that does not match the bank, a positive
> > > > value EINVAL is returned here. I think this is a typo error.
> > > > It is necessary to return an error value.
> > > 
> > > Yes, thanks.
> > > 
> > > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Happen to have the commit ID at hand for fixes?
> > 
> > Thanks.
> > 
> > /Jarkko
> > 
> 
> 9f75c8224631 ("KEYS: trusted: correctly initialize digests and fix locking issue")

Thanks.

Also added:

Cc: stable@vger.kernel.org # 5.4.x

/Jarkko
