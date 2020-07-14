Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0921EF22
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGNLUn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 07:20:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:10830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgGNLUg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 07:20:36 -0400
IronPort-SDR: lSxUzVJBfFnX+XKu5B9yefceayGdeAP5xO1ELQHL1H/h/3ZjyK8AToDX0vl621t1Y6w6RevuUp
 PW4lzE9ptVwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146349943"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146349943"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 04:20:34 -0700
IronPort-SDR: B5BSpZgOdkfuAEIuDBr1rtuqVEsHQIemWCTJzzjDQUC8llN9zkJYda/njPIPKbKVCga2E4SBko
 QYsSxABJp2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="299508857"
Received: from rmarti11-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.57])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 04:20:32 -0700
Date:   Tue, 14 Jul 2020 14:20:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200714112030.GA1448526@linux.intel.com>
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
 <20200707040325.GB143804@linux.intel.com>
 <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
 <20200708140753.GC538949@linux.intel.com>
 <e42cb59d-6a3d-12be-bb51-88aa8c5dba23@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e42cb59d-6a3d-12be-bb51-88aa8c5dba23@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 08, 2020 at 10:17:17AM -0400, Stefan Berger wrote:
> > ❯ swtpm-mvo.swtpm socket --tpmstate dir=/tmp/mytpm1 \
> >    --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> >    --log level=20
> > swtpm: Could not open UnixIO socket: No such file or directory
> 
> 
> Did you create the directory '/tmp/mytpm1' ?

Yes. It's the socket file that it is complain because it does
not exist beforehand.

/Jarkko
