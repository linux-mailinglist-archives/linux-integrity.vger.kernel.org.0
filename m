Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1322158727
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0Qct (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 12:32:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:21015 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0Qct (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 12:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 09:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="170472750"
Received: from unknown (HELO jsakkine-mobl1) ([10.252.36.47])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2019 09:32:44 -0700
Message-ID: <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Date:   Thu, 27 Jun 2019 19:32:45 +0300
In-Reply-To: <20190627133004.GA3757@apalos>
References: <20190625201341.15865-1-sashal@kernel.org>
         <20190625201341.15865-2-sashal@kernel.org>
         <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
         <20190626235653.GL7898@sasha-vm>
         <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
         <20190627133004.GA3757@apalos>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-06-27 at 16:30 +0300, Ilias Apalodimas wrote:
> is really useful. I don't have hardware to test this at the moment, but once i
> get it, i'll give it a spin.

Thank you for responding, really appreciate it.

Please note, however, that I already did my v5.3 PR so there is a lot of
time to give it a spin. In all cases, we will find a way to put this to
my v5.4 PR. I don't see any reason why not.

As soon as the cosmetic stuff is fixed that I remarked in v7 I'm ready
to take this to my tree and after that soonish make it available on
linux-next.

/Jarkko

