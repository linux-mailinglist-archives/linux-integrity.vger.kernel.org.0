Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5519A7C1
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDAIt5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 04:49:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:56685 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDAIt5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 04:49:57 -0400
IronPort-SDR: yO2XkCos9TIdgL6L1Mv6SOK7HHW0BHH1aqFTHi6JrdnkdC+4DMTUBP8vzR4WwzDAlMf8FLBqos
 sZT1P5YY+9Og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:49:55 -0700
IronPort-SDR: gJZs3sQbbFrjZiCxla4KYGSWxtN0YIED8UuDXraGjsa8Zotvi6/clXarrmjWDRcovwrgzrxKvk
 ly+4e9kXxnkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="238095823"
Received: from vikasjox-mobl.amr.corp.intel.com (HELO localhost) ([10.249.39.53])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2020 01:49:53 -0700
Date:   Wed, 1 Apr 2020 11:49:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3] tpm: Add support for event log pointer found in TPM2
 ACPI table
Message-ID: <20200401084913.GF17325@linux.intel.com>
References: <20200331215100.883860-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331215100.883860-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 05:51:00PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Check the kbuild bot complain. I think otherwise this is sustainable.
Thank you.

Does stock QEMU have all the support to test this?

/Jarkko
