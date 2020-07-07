Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05552164FE
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 06:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgGGEDa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 00:03:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:21957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgGGEDa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 00:03:30 -0400
IronPort-SDR: nAnDiC2pzrszc8O5ingc2IlOy7z6iMSreRMK66eshGUJqWc0Jd6cL30vTVx5BAYGAasa01VEpJ
 u2NYnz29LIIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135001042"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="135001042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 21:03:29 -0700
IronPort-SDR: 9QftieGaTePgysf8PsOk6elMAa2ZpPKOnn/j3vBI93Dw8P/wuXmFFdZ7G8K9JAwqkmigw558Gr
 o/Il6RW7Rrow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="268077386"
Received: from apiccion-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.45.178])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2020 21:03:26 -0700
Date:   Tue, 7 Jul 2020 07:03:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200707040325.GB143804@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 11:08:12PM -0400, Stefan Berger wrote:
> On 7/6/20 10:24 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 06, 2020 at 07:55:26PM -0400, Stefan Berger wrote:
> > > On 7/6/20 7:09 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> > > > > to get the event log from ACPI. If one is found, use it to get the
> > > > > start and length of the log area. This allows non-UEFI systems, such
> > > > > as SeaBIOS, to pass an event log when using a TPM2.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> > > > way to test this?
> > > 
> > > Yes.
> > Is the emulator bundled with QEMU or does it have to be installed
> > separately?
> 
> It has to be installed separately. On Fedora 31 it would just be a `sudo dnf
> -y install swtpm-tools` and you should be good to go with libvirt /
> virt-manager.

Is there some packaging for Debian/Ubuntu available?

/Jarkko
