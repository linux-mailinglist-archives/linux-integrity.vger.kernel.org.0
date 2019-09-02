Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E71A5853
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfIBNqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 09:46:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:32119 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfIBNqf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 09:46:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="211690834"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2019 06:46:30 -0700
Date:   Mon, 2 Sep 2019 16:46:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Parse event log from TPM2 ACPI table
Message-ID: <20190902134628.yaqvdur4utnjrj3d@linux.intel.com>
References: <20190831051027.11544-1-jorhand@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831051027.11544-1-jorhand@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 10:10:27PM -0700, Jordan Hand wrote:
> For systems with a TPM2 chip which use ACPI to expose event logs, retrieve the
> crypto-agile event log from the TPM2 ACPI table. The TPM2 table is defined
> in section 7.3 of the TCG ACPI Specification (see link).
> 
> The TPM2 table is used by SeaBIOS in place of the TCPA table when the system's
> TPM is version 2.0 to denote (among other metadata) the location of the
> crypto-agile log.
> 
> Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
> Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>

Where is the changelog for v2 and v3 i.e. what happened in those
updates?

/Jarkko
