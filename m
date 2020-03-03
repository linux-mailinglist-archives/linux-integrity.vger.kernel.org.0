Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC31783BA
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 21:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgCCULl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 15:11:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:18461 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgCCULl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 15:11:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 12:11:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233869732"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2020 12:11:35 -0800
Date:   Tue, 3 Mar 2020 22:11:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200303201104.GG5775@linux.intel.com>
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
 <20200228030330.18081-4-stefanb@linux.vnet.ibm.com>
 <20200302111514.GC3979@linux.intel.com>
 <2f8a9519-c1ab-8d46-18c4-4e0f9d53e3ff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8a9519-c1ab-8d46-18c4-4e0f9d53e3ff@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 02, 2020 at 11:21:27AM -0500, Stefan Berger wrote:
> On 3/2/20 6:15 AM, Jarkko Sakkinen wrote:
> > On Thu, Feb 27, 2020 at 10:03:30PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
> > > version of TPM is connected through the vio_device_id.
> > I'd prefer "TPM2" over "TPM 2".
> Fixed.
> > 
> > > In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag
> > > and get the command codes attributes table. The driver does
> > > not need the timeouts and durations, though.
> > A TPM2 what? TPM2 is not a thing.
> 
> 
> I don't know what you mean? Is it the word 'found' and it should be
> 'present' ? Otherwise a TPM2 is a 'thing' / object / device, at least to me.

TPM2 chip would be better. TPM2 can refer either to the protocol or to a
chip.

/Jarkko
