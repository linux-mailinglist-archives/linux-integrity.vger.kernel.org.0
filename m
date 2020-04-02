Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5719CA75
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 21:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgDBTqG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 15:46:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:47751 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgDBTqF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 15:46:05 -0400
IronPort-SDR: fARqAckMVVJuOcvyV373XZsIpZuLANdr285266EhI7jNE1NTZQwUXL8W7uf8v2cW1W2xL4E32o
 /1fGt8gGpDgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:46:04 -0700
IronPort-SDR: 1cGXrf6MKe+sp0HXx7kRvJNuro2XfYky6wlP6rOF0FNrJ6JM1bDtkZyICMsFAiArGfGJ9I8Em2
 hRbDZ5up9kXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="268127977"
Received: from hbriegel-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.101])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2020 12:46:02 -0700
Date:   Thu, 2 Apr 2020 22:46:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Add support for event log pointer found in TPM2
 ACPI table
Message-ID: <20200402194600.GD10314@linux.intel.com>
References: <20200331215100.883860-1-stefanb@linux.vnet.ibm.com>
 <20200401084913.GF17325@linux.intel.com>
 <06477336-7ca0-1c72-6881-e443e922a01b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06477336-7ca0-1c72-6881-e443e922a01b@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 01, 2020 at 08:20:28AM -0400, Stefan Berger wrote:
> On 4/1/20 4:49 AM, Jarkko Sakkinen wrote:
> > On Tue, Mar 31, 2020 at 05:51:00PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> > > to get the event log from ACPI. If one is found, use it to get the
> > > start and length of the log area. This allows non-UEFI systems, such
> > > as SeaBIOS, to pass an event log when using a TPM2.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Check the kbuild bot complain. I think otherwise this is sustainable.
> > Thank you.
> The kbuild bot did this due to the split of the patch series...

Please resend them two patch series.

/Jarkko
