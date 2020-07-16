Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76A2229D6
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGPR07 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:26:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:47165 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPR06 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:26:58 -0400
IronPort-SDR: TT9U2tITExq6glngydUbOW098uKgTrSTt0B0NM5Vk6WsJN0uTeXckBiWpoqUhlKWirDTjvAcPU
 hAR78bensUoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167581557"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="167581557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:26:57 -0700
IronPort-SDR: 1EgqbbYetW10P22ZL8G4vZYdleHkGnBPhVmHwNUM+4T1k6hUCCSY7nFVgpC1lQcbaMJhbq0ici
 HLXDoxrUEcMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="326589129"
Received: from unknown (HELO localhost) ([10.249.34.156])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 10:26:54 -0700
Date:   Thu, 16 Jul 2020 20:26:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200716172652.GA14135@linux.intel.com>
References: <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
 <20200707040325.GB143804@linux.intel.com>
 <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
 <20200708140753.GC538949@linux.intel.com>
 <e42cb59d-6a3d-12be-bb51-88aa8c5dba23@linux.ibm.com>
 <20200714112030.GA1448526@linux.intel.com>
 <69907c30-62c2-b4bd-e84f-11612bba9c95@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69907c30-62c2-b4bd-e84f-11612bba9c95@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 14, 2020 at 08:09:03AM -0400, Stefan Berger wrote:
> On 7/14/20 7:20 AM, Jarkko Sakkinen wrote:
> > On Wed, Jul 08, 2020 at 10:17:17AM -0400, Stefan Berger wrote:
> > > > ❯ swtpm-mvo.swtpm socket --tpmstate dir=/tmp/mytpm1 \
> > > >     --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> > > >     --log level=20
> > > > swtpm: Could not open UnixIO socket: No such file or directory
> > > 
> > > Did you create the directory '/tmp/mytpm1' ?
> > Yes. It's the socket file that it is complain because it does
> > not exist beforehand.
> 
> 
> The socket file is created by the swtpm program.

I got this tested with real hardware, i.e. tested that TPM 1.2 works.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
