Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7018A1DF8
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfH2Ox3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 10:53:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:43200 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2OxZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 10:53:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 07:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="188567592"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2019 07:53:17 -0700
Date:   Thu, 29 Aug 2019 17:53:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [PATCH v5 4/4] KEYS: trusted: move tpm2 trusted keys code
Message-ID: <20190829145221.owvmet5iyjoy4baw@linux.intel.com>
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-5-git-send-email-sumit.garg@linaro.org>
 <20190827141742.6qxowsigqolxaod4@linux.intel.com>
 <CAFA6WYPnoDoMWd=PT4mgXPhg1Wp0=AFDnWd_44UMP7sijXzAZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPnoDoMWd=PT4mgXPhg1Wp0=AFDnWd_44UMP7sijXzAZA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 10:58:11AM +0530, Sumit Garg wrote:
> So you mean to say we should use upper-case letters for 'TPM2' acronym?

Yes.

/Jarkko
