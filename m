Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4117C572
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFSdK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 13:33:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:18865 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgCFSdJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 13:33:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="442031421"
Received: from wbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.27.142])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2020 10:33:06 -0800
Date:   Fri, 6 Mar 2020 20:33:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 3/3] tpm: ibmvtpm: Add support for TPM2
Message-ID: <20200306183305.GA7472@linux.intel.com>
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
 <20200304132243.179402-4-stefanb@linux.vnet.ibm.com>
 <a54d6cffe536d568a9fde46f1f32616e89a42d30.camel@linux.intel.com>
 <8dcd22c1-b05f-d619-58c5-fd2248c75b9e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcd22c1-b05f-d619-58c5-fd2248c75b9e@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 05, 2020 at 08:58:15AM -0500, Stefan Berger wrote:
> On 3/5/20 6:21 AM, Jarkko Sakkinen wrote:
> > On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
> > > version of TPM is connected through the vio_device_id.
> > > 
> > > In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
> > > and get the command codes attributes table. The driver does
> > > not need the timeouts and durations, though.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > There is huge bunch of people in the cc-list and these patches
> > have total zero tested-by's. Why is that?
> 
> 
> I cc'ed them because of their involvement in other layers. That's all I can
> say.

OK, so there is no one who can test this?

/Jarkko
