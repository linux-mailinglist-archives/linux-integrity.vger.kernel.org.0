Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBA2189D4
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgGHOH7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 10:07:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:29263 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgGHOH7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 10:07:59 -0400
IronPort-SDR: vmTDpWZTKkevxrFqlxBi71OawkZWrQcoY5aa5uOdxWccq+6D4Aln8z6653tDb3O7L6R5tNplUh
 wGfeIyUoSg7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="136027091"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="136027091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 07:07:58 -0700
IronPort-SDR: /qeY/VuRKlFc+ez7PhFZz0m79tIeqkwYka6UISwhCTNiQf7Gl2A6cfELVsSKoz0gWSZGV6g9YT
 eOPFAZnugEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="283807420"
Received: from jschirra-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.201])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2020 07:07:55 -0700
Date:   Wed, 8 Jul 2020 17:07:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200708140753.GC538949@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
 <20200707040325.GB143804@linux.intel.com>
 <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 07, 2020 at 12:09:11AM -0400, Stefan Berger wrote:
> On 7/7/20 12:03 AM, Jarkko Sakkinen wrote:
> > On Mon, Jul 06, 2020 at 11:08:12PM -0400, Stefan Berger wrote:
> > > On 7/6/20 10:24 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Jul 06, 2020 at 07:55:26PM -0400, Stefan Berger wrote:
> > > > > On 7/6/20 7:09 PM, Jarkko Sakkinen wrote:
> > > > > > On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
> > > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > > 
> > > > > > > In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> > > > > > > to get the event log from ACPI. If one is found, use it to get the
> > > > > > > start and length of the log area. This allows non-UEFI systems, such
> > > > > > > as SeaBIOS, to pass an event log when using a TPM2.
> > > > > > > 
> > > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> > > > > > way to test this?
> > > > > Yes.
> > > > Is the emulator bundled with QEMU or does it have to be installed
> > > > separately?
> > > It has to be installed separately. On Fedora 31 it would just be a `sudo dnf
> > > -y install swtpm-tools` and you should be good to go with libvirt /
> > > virt-manager.
> > Is there some packaging for Debian/Ubuntu available?
> 
> 
> So far may not be available yet. I had *experimented* with a PPA once:
> https://launchpad.net/~stefanberger/+archive/ubuntu/swtpm-focal

There is a snap available:

name:      swtpm-mvo
summary:   Libtpms-based TPM emulator
publisher: Michael Vogt (mvo)
store-url: https://snapcraft.io/swtpm-mvo
license:   unset
description: |
  Libtpms-based TPM emulator with socket, character device, and Linux
  CUSE interface.
commands:
  - swtpm-mvo.swtpm
services:
  swtpm-mvo.swtpm-sock: simple, enabled, active
snap-id:      HNl1TwHRBk3OtXQ8OriRB93FDZ6vman7
tracking:     latest/edge
refresh-date: today at 02:05 EEST
channels:
  latest/stable:    –                         
  latest/candidate: –                         
  latest/beta:      0.1.0 2019-07-26 (11) 3MB -
  latest/edge:      0.1.0 2020-07-08 (75) 3MB -
installed:          0.1.0            (74) 3MB -

This is the version information:

❯ swtpm-mvo.swtpm --version
TPM emulator version 0.4.0, Copyright (c) 2014 IBM Corp.

However, if I try to run the first example from [*], I get:

❯ swtpm-mvo.swtpm socket --tpmstate dir=/tmp/mytpm1 \
  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
  --log level=20
swtpm: Could not open UnixIO socket: No such file or directory

[*] https://www.qemu.org/docs/master/specs/tpm.html

/Jarkko
