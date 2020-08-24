Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E9250993
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHXTpB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 15:45:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:61182 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXTpB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 15:45:01 -0400
IronPort-SDR: +WFN9bGTv+uM4UmRfVIkWxwfVYPfwBQaSr60ENFr7QfFDpHwlseU/FDPAsjmvPRxTVNXwSRZh3
 YqntP1wFvG2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="220246447"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="220246447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 12:45:00 -0700
IronPort-SDR: gQktOFjmmH0jJ5FDSgYzCFl6isROnI8mcMsCG4PTBPj6WyCUvEukeri8IzpugWf9+iYNoYoBg/
 TIUBYqohQEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="322461320"
Received: from skapitza-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.25])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2020 12:44:59 -0700
Date:   Mon, 24 Aug 2020 22:44:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200824194457.GA7391@linux.intel.com>
References: <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
 <20200821193847.GA2811093@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821193847.GA2811093@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:
> 
> > > eg we can't do it because we can't access /dev/tpm for permissions or
> > > something.
> > 
> > I already said that: we can't it's root.root 0600 currently.  All the
> > TSSs seem to change at least /dev/tpmrm to tpm.tpm 0660 but we can't do
> > that in the kernel because there's no fixed tpm uid/gid.
> 
> Permissions is a pretty good reason to add a sysfs file.
> 
> Jason

I'm not sure why suid/sgid utility to read pcrs would be worse.

/Jarkko
