Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4D1D23A0
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 02:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgENA2b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 20:28:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:33935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbgENA23 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 20:28:29 -0400
IronPort-SDR: M5RQcRsGeCJf2/Kw5ndBButO/XlYHR4bZ/sm8AapIvg/ECmWnF6ueDzCiQzZ6TiDA5Vz+0CTcq
 0EKMM6ss18xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:28:29 -0700
IronPort-SDR: 7awCP4M/tgMeg4kwkUxvILsbHi1BY8FwJxfJGLkKXoDNi21froW8VWHg1uvqmYs4No1WlvhUdM
 53tx8RhB32vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="266058564"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2020 17:28:20 -0700
Message-ID: <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org
Date:   Thu, 14 May 2020 03:28:18 +0300
In-Reply-To: <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

The implementation looks solid but how or who could possibly test this?

I do posses (personally, not from employer) bunch of ARM boards but my
TZ knowledge is somewhat limited (e.g. how can I get something running
in TZ).

/Jarkko

