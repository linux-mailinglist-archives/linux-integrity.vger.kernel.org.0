Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266D62163EC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgGGCYW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:24:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:27758 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGGCYW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:24:22 -0400
IronPort-SDR: 0x24jGBqdrplazmtLmUkJdDXx2ng6UT2XcjJw9ZG4nfcoJyK7FUScHLQZ3/4LluqK5ZlmPitJw
 7EfsK0xefT2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165601487"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="165601487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:24:23 -0700
IronPort-SDR: JgjDRV1j+503vd3yNnhIYrWnUTWeLcHiYEx70sz3Ly4ErUKQnVvr57ccRLmIMNWrAMHFTjTjN5
 oyzUVi2AFYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="323392818"
Received: from pakumpul-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.16])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 19:24:18 -0700
Date:   Tue, 7 Jul 2020 05:24:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200707022416.GC112019@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 07:55:26PM -0400, Stefan Berger wrote:
> On 7/6/20 7:09 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> > > to get the event log from ACPI. If one is found, use it to get the
> > > start and length of the log area. This allows non-UEFI systems, such
> > > as SeaBIOS, to pass an event log when using a TPM2.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> > way to test this?
> 
> 
> Yes.

Is the emulator bundled with QEMU or does it have to be installed
separately?

/Jarkko
