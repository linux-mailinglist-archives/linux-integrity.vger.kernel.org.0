Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49DFE8AA9
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfJ2OWa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 10:22:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:40857 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfJ2OW3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 10:22:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 07:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="202858277"
Received: from jkenneal-mobl.ger.corp.intel.com (HELO localhost) ([10.252.31.252])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 07:22:26 -0700
Date:   Tue, 29 Oct 2019 16:22:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029142225.GC7415@linux.intel.com>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
 <20191029124342.GB6128@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029124342.GB6128@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
> > > > > +	return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> > > > > +		       ? "2.0" : "1.2");
> > > > 
> > > > This is not right. Should be either "1" or "2".
> > > > 
> > > > /Jarkko
> > > 
> > > Okay I will fix that up. Do we have a final decision on the file name,
> > > major_version versus version_major?
> > 
> > Well, I don't see how major_version would make any sense. It is
> > not as future proof as version_major. Still waiting for Jason's
> > feedback for this.
> 
> $ find /sys/ -name  "*version*"
> /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahci_host_version
> /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
> /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
> /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
> /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
> /sys/firmware/efi/esrt/entries/entry0/fw_version
> /sys/module/acpi/parameters/acpica_version
> 
> etc..
> 
> Not a single example of the backward version.
> 
> Most likely it should be called 'tpm_version'

The postfix gives tells the part of the version number that the file
reports. If you really want to add the prefix, then the appropriate
name would be tpm_version_major.

I'd still go with just version_major as tpm_ prefix is somewhat
redundant.

/Jarkko
