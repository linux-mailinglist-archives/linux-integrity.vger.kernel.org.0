Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA91D1BF0
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2020 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEMRK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 13:10:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:63447 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgEMRK4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 13:10:56 -0400
IronPort-SDR: 0hTt0cAY60henrsGYPna8ZyLQUltXfPBytJVPVU4RMdGZIwzIHasOXAogAlgvVtPTTEsq/IY1I
 VCvGiPQlHoAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 10:10:55 -0700
IronPort-SDR: Y0p2d4uHIPRbyKg7GPaaBBya+Lv3aVf85wGwmxKO7VtAj/9YvixRTkMpTTgExEozzPN9DLeFyZ
 oT1ZgD48Rt4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="298428700"
Received: from tvladisl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.129])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2020 10:10:53 -0700
Date:   Wed, 13 May 2020 20:10:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200513171052.GD25598@linux.intel.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505222731.whnkisag7tlrbcie@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 05, 2020 at 03:27:31PM -0700, Jerry Snitselaar wrote:
> On some systems we've had reports of the value of pcr5 doesn't match the digests in the tpm event log.
> It looks like I'm able to reproduce here with 5.7-rc4 on a dell system using this parser:
> 
> https://github.com/ValdikSS/binary_bios_measurements_parser
> 
> Any thoughts on where to start digging? Is there another tool I should use to parse this?

ExitBootServices() extends PCR5. My 1st intuition would be to look at
final event table handling, which I documented here:

https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst

It is somewhat quirky how it nees to be managed (had to read that
myself to recall how it went).

/Jarkko
