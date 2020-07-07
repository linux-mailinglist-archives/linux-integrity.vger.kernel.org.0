Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D152163F3
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGCZD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:25:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:32345 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGGCZD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:25:03 -0400
IronPort-SDR: 0LqR8Wb5eY8/vl51YwQ8WdLPj5a9ML5aJOeZVRWOYsMtZz8OitYdUeuHs+k/iTwH4lUosIF2Ar
 4XUiDNYuEwUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145629222"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145629222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:25:02 -0700
IronPort-SDR: 1wYLUVuTMqVaskelX9SarE9+v2Xj8qmB6QfJkpS20xcYkOdYp971MRD90JjROQ79Dnmj14XuXQ
 9CnWYz7UHNnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="323392999"
Received: from pakumpul-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.16])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 19:24:58 -0700
Date:   Tue, 7 Jul 2020 05:24:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200707022457.GD112019@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <87mu4cjixj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu4cjixj.fsf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 04:57:28PM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-07-06 16:09 MST:
> 
> > On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >> 
> >> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> >> to get the event log from ACPI. If one is found, use it to get the
> >> start and length of the log area. This allows non-UEFI systems, such
> >> as SeaBIOS, to pass an event log when using a TPM2.
> >> 
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >
> > Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> > way to test this?
> >
> > I'm anyway more worried about breaking existing TPM 1.2 functionality
> > and that requires only QEMU without extras.
> >
> > /Jarkko
> 
> The 1.2 bits should be functionally the same as before, right?

Yes. You should be able to read event log with TPM 1.2 as before.

/Jarkko
