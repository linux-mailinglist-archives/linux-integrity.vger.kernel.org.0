Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023151701C0
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBZPAz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 10:00:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:30051 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgBZPAz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 10:00:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 07:00:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="231425508"
Received: from avgorshk-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.15.208])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 07:00:51 -0800
Date:   Wed, 26 Feb 2020 17:00:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 2/4] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
Message-ID: <20200226150051.GA3407@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-3-stefanb@linux.vnet.ibm.com>
 <20200225165744.GD15662@linux.intel.com>
 <8b61d1b4-8503-88e7-271f-da2ea0fc437f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b61d1b4-8503-88e7-271f-da2ea0fc437f@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 25, 2020 at 01:14:32PM -0500, Stefan Berger wrote:
> On 2/25/20 11:57 AM, Jarkko Sakkinen wrote:
> > On Thu, Feb 13, 2020 at 03:23:27PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Synchronize with the results from the CRQs before continuing with
> > > the initialization. This avoids trying to send TPM commands while
> > > the rtce buffer has not been allocated, yet.
> > What is CRQ anyway an acronym of?
> 
> Command request queue.
> 
> 
> > 
> > > This patch fixes an existing race condition that may occurr if the
> > > hypervisor does not quickly respond to the VTPM_GET_RTCE_BUFFER_SIZE
> > > request sent during initialization and therefore the ibmvtpm->rtce_buf
> > > has not been allocated at the time the first TPM command is sent.
> > If it fixes a race condition, why doesn't it have a fixes tag?
> 
> Which commit should I mention?

The one that introduced the race condition if there is such.

/Jarkko
