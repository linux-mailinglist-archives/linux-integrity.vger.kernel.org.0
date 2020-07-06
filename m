Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204622161DE
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGFXJT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 19:09:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:46986 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgGFXJS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 19:09:18 -0400
IronPort-SDR: +IhuSwzNJk1zfvF2st+AMGCt1NcQGDes6Zpee7yKSV3h34GY0BLwSaaKTBzluow1CDGtm+Bryz
 J5bosXuSrSzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127107447"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="127107447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 16:09:18 -0700
IronPort-SDR: Oja8NwTouCdDLO8zKrRSzzVd8altTd2s8tHLU05KbmFl7R63l2eXcBw9YDKpRvuisXQzfQzUp8
 s/rmRDBFHWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="297158063"
Received: from hartmaxe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.13])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 16:09:15 -0700
Date:   Tue, 7 Jul 2020 02:09:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200706230914.GC20770@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
way to test this?

I'm anyway more worried about breaking existing TPM 1.2 functionality
and that requires only QEMU without extras.

/Jarkko
