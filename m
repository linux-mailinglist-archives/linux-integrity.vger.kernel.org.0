Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7149EEB8AD
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJaVEl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 17:04:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:18371 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfJaVEl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 17:04:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 14:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; 
   d="scan'208";a="231008754"
Received: from epobrien-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.10.103])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2019 14:04:38 -0700
Date:   Thu, 31 Oct 2019 23:04:37 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191031210437.GB10507@linux.intel.com>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
 <20191029124342.GB6128@ziepe.ca>
 <20191029142225.GC7415@linux.intel.com>
 <1572361008.4812.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572361008.4812.2.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 29, 2019 at 07:56:48AM -0700, James Bottomley wrote:
> On Tue, 2019-10-29 at 16:22 +0200, Jarkko Sakkinen wrote:
> > On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
> > > > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> > > > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > > > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar
> > > > > > wrote:
> > > > > > > +	return sprintf(buf, "%s\n", chip->flags &
> > > > > > > TPM_CHIP_FLAG_TPM2
> > > > > > > +		       ? "2.0" : "1.2");
> > > > > > 
> > > > > > This is not right. Should be either "1" or "2".
> > > > > > 
> > > > > > /Jarkko
> > > > > 
> > > > > Okay I will fix that up. Do we have a final decision on the
> > > > > file name,
> > > > > major_version versus version_major?
> > > > 
> > > > Well, I don't see how major_version would make any sense. It is
> > > > not as future proof as version_major. Still waiting for Jason's
> > > > feedback for this.
> > > 
> > > $ find /sys/ -name  "*version*"
> > > /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahc
> > > i_host_version
> > > /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
> > > /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
> > > /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
> > > /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
> > > /sys/firmware/efi/esrt/entries/entry0/fw_version
> > > /sys/module/acpi/parameters/acpica_version
> > > 
> > > etc..
> > > 
> > > Not a single example of the backward version.
> > > 
> > > Most likely it should be called 'tpm_version'
> > 
> > The postfix gives tells the part of the version number that the file
> > reports. If you really want to add the prefix, then the appropriate
> > name would be tpm_version_major.
> > 
> > I'd still go with just version_major as tpm_ prefix is somewhat
> > redundant.
> 
> You have to be careful with overly generic names in sysfs ... this is
> what happened to us in SCSI:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42caa0edabd6a0a392ec36a5f0943924e4954311
> 
> That's not to say version_major is wrong ... plenty of sysfs files have
> generic names like this, it's just that tpm_version_major might be more
> future proof.

I'm cool with that name as long as the postfix also stays.

/Jarkko
