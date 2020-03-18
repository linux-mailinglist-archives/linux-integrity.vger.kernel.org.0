Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4918A345
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 20:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCRTmy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 15:42:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:61347 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRTmy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 15:42:54 -0400
IronPort-SDR: oqfRly6rBHPbi7QKXbwIZhRlPAFkiTlbIpTBjXx40WpQenTg7ypflbqxsoE7a5p/JS8VM+hENL
 nfVfXdbwczTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 12:42:53 -0700
IronPort-SDR: Suav0KM2ojYrxipcrlkmBmqgkdJt9MoK6XuOeygK+vUXd09ADpQG18cojbOlMEEpsFJ67Q6Qap
 UbLZ2rE+Eekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="418064574"
Received: from mbeldzik-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.127])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 12:42:49 -0700
Date:   Wed, 18 Mar 2020 21:42:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sachinp@linux.vnet.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
Message-ID: <20200318194247.GC48177@linux.intel.com>
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 17, 2020 at 09:08:19AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch fixes the following problem when the ibmvtpm driver
> is built as a module:
> 
> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1298: modules] Error 2
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Hi, wrong tag (we use "tpm:"), missing fixes tag and please cc stable.
Thanks.

/Jarkko
