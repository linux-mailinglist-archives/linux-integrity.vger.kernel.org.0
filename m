Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CB15ABB3
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 16:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBLPIQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 10:08:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:33488 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgBLPIQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 10:08:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 07:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="226891155"
Received: from mlinda-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.9.85])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2020 07:07:44 -0800
Date:   Wed, 12 Feb 2020 17:07:42 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v3 1/7] char: tpm: Make implementation of read16 read32
 write32 optional
Message-ID: <20200212150742.GA13248@linux.intel.com>
References: <20200210162838.173903-1-amirmizi6@gmail.com>
 <20200210162838.173903-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210162838.173903-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 10, 2020 at 06:28:32PM +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Only tpm_tis has a faster way to access multiple bytes at once, every other
> driver will just fall back to read_bytes/write_bytes. Therefore, move this

Describe exactly what you mean instead of "faster way" and "multiple
bytes".

> common code out of tpm_tis_spi into tpm_tis_core, so that it is
> automatically used when low-level drivers do not implement the specialized
> methods.
> 
> This commit is based on previous work by Alexander Steffen.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

You are missing commas in the short summary message when you list bunch
of things.

We prefer "tpm:" instead of "char: tpm:" as the tag for this subsystem.
You are also implying that this would be something global for the TPM
driver whereas it is only scoped to tpm_tis:

Rephrase it something like:

  "tpm: tpm_tis: Make 32-bit reads and writes optional"

Please, first, take this away:

"
This commit is based on previous work by Alexander Steffen.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
"

Then, replace it with:

Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

/Jarkko
