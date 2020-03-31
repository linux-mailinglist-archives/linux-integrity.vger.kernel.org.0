Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7801E1995C9
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgCaLwB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 07:52:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:16460 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbgCaLwB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 07:52:01 -0400
IronPort-SDR: OuvjWB2A1SUEB6WsaMANGzdXSoQwErJATQtJkyGbwlYpvFq2sW/WYQmctseIGjaugNwDcMntEy
 nRtDWJCvTXnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:52:01 -0700
IronPort-SDR: CCiV2C3BLfu4WjlpWRpmuCRCN0rCAxHpkGfOspFO4kJ9QrSopUNfuAScS1BPeweI4raBhu+Tvw
 xtBems0hiaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="272719219"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 04:51:58 -0700
Date:   Tue, 31 Mar 2020 14:51:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tpm: Rearrange ACPI log code to easier extend for
 TPM2 case
Message-ID: <20200331115157.GB8295@linux.intel.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-3-stefanb@linux.vnet.ibm.com>
 <20200330193144.GD1384380@linux.intel.com>
 <2474521e-909c-d8b4-077b-2043ce587130@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2474521e-909c-d8b4-077b-2043ce587130@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 30, 2020 at 05:12:24PM -0400, Stefan Berger wrote:
> On 3/30/20 3:32 PM, Jarkko Sakkinen wrote:
> > On Mon, Mar 30, 2020 at 11:15:35AM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Rearrange the ACPI table based log code to allow for easier extension
> > > for the TPM2 case.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > I think this change does not do anything useful.
> 
> I know. So it's easy to see what's happening and harmless. But I'll squash
> it.

Yeah, well files aren't getting moved or anything and overally
the change is still somewhat scoped.

/Jarkko
