Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16171E4E64
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0TmK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 15:42:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:63547 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0TmK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 15:42:10 -0400
IronPort-SDR: Q00KUKvtNhuHszcP0YCJv52JhE7tcieR8leCsagWXCXLs7X/OCPZJ8jENGz+DY+aWDLL8A+wvi
 nfiBaZSTGzmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 12:42:09 -0700
IronPort-SDR: W4jtM1/u653BoRgasjXEejeq1aqAtFU/BySfySt0SCF3aGn9VhSSvODMP8BefSpUISr6Cm9MKq
 X4NV1tABA8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="468835945"
Received: from lkakolx-mobl.ger.corp.intel.com ([10.249.43.73])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 12:42:04 -0700
Message-ID: <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 27 May 2020 22:42:03 +0300
In-Reply-To: <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
         <20200521064743.4769-4-maxim.uvarov@linaro.org>
         <20200522171451.GD10319@linux.intel.com>
         <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
         <20200522200346.GB150221@linux.intel.com>
         <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-25 at 09:50 +0300, Maxim Uvarov wrote:
> Jakko,
> tee-supplicant application provides state machine over callbacks with
> RPC messages.
> https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> It also allocates shm. Without running tee-supplicant
> tee_client_open_session() will fail.
> optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> Optee team wanted to remove some dependencies from tee-supplicant with
> moving code
> to the kernel. But for now I think that should be out of the scope of
> current patches due to
> they fix driver initialization on tee bus without breaking current
> functionality.

So what is the role in high-level for tee-supplicant? Why does it
exist? No time to dive into code unfortunately.

These kernel commits do not explain in simple terms enough how all
of these entities connect with each other, if you don't have that
understanding beforehand.

/Jarkko

