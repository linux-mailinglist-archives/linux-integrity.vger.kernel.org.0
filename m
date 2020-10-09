Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6909288DD7
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgJIQM1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 12:12:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:37918 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389144AbgJIQM1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 12:12:27 -0400
IronPort-SDR: 6fVO0YDroT2no6bkn/k8fBQ9h2bEofbWfyKj1fwPC+2RIL9Ia9yHHYrjE7coDZsxWY3hqXH48+
 oVH02fsnhj7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="250199352"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="250199352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 09:12:26 -0700
IronPort-SDR: 315Zpn8fC9r7g7Cx3tkkMLLGQbAIkqdkyF4LUlIuFmiGS9Qu6F+6EUHusW8KPZufKxZEVdJZb7
 B3TawkZgxk+w==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="298473056"
Received: from rgordani-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 09:12:23 -0700
Date:   Fri, 9 Oct 2020 19:12:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20201009161219.GB26881@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20201008114518.GB27671@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114518.GB27671@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 08, 2020 at 01:45:18PM +0200, Petr Vorel wrote:
> Hi,
> 
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > they'll break.
> 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> On both TPM 1.2 and TPM 2.0.
> /sys/class/tpm/tpm0/pcr-sha*/* is exporting well on both.
> James, thanks for implementing nice API!

OK, great thank you. Unfortunately too late for v5.10 but without doubt
going to v5.11.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

> BTW are all of these just TPM 1.2 specific?
> /sys/class/tpm/tpm0/device/enabled
> /sys/class/tpm/tpm0/device/pcrs
> /sys/kernel/security/tpm0/binary_bios_measurements

Yes.

> Kind regards,
> Petr

Thanks a lot for your feedback, easier to judge given that you actually
consume this :-)

/Jarkko
