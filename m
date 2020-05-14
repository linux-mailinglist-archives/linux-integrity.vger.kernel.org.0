Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41D1D23B3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 02:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbgENAfw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 20:35:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:56104 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733040AbgENAfv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 20:35:51 -0400
IronPort-SDR: ANGjQfhfvRBH11WCS7x3TIBpaZyS+X1EZ6XfM8uad9SAltzd/JoqGXylrMsG/Ik2QhF8ZG+3Ga
 HdxZ/TkQ8ntw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:35:51 -0700
IronPort-SDR: qWZ3dOBL4TSN8JHurlrHYwreU6MqZgJdMSS3aPfhUJPRgmGOaTvSzv8XYi3T0+pATI4ThhDdvr
 oqKRbHNutSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="280681247"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2020 17:35:44 -0700
Message-ID: <2d7d0293e51c38fe6b557eba193cf30bb8d53e80.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
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
Date:   Thu, 14 May 2020 03:35:43 +0300
In-Reply-To: <1588758017-30426-5-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-5-git-send-email-sumit.garg@linaro.org>
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
> Add MAINTAINERS entry for TEE based Trusted Keys framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

