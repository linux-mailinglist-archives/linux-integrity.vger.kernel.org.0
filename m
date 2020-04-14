Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51AD1A7044
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 02:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbgDNAvj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Apr 2020 20:51:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53455 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390589AbgDNAvh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Apr 2020 20:51:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 491Rkp6QyRz9sSk;
        Tue, 14 Apr 2020 10:51:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1586825491;
        bh=Lu+lnFaV1xSDWR81mSR54x4nl15RVb3+4B7MuYkt1g0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YlEB2G4L51G4Z0CbLAgGzQc/vGjKnbCq9KXxcegdigB4DRQklBa7IBu8dK4izaEb6
         v687sHdCGAZpeS1DxBs5R9kJrF9bdDIhPhGazL0Nd+K/ssVh+gdzWUIb/hBEoszcHE
         frEaMXbSFVIubwOihvFtfknrgbSbdhdEBk3reW2RBYIV3VbLfOupyyrSG4OiTvIFNG
         wdE1E0IOpqH91p7JNhYelJMCtg8VXhzuAZkqds3a403iWenYza6oqoaZcMf/LT22i0
         JCPFbkrKzEyFveJh+Y5gP183qZX4QyjkK8fB7vlb+2sINn1sq1ABQRbYVogPBcdw0h
         Yd78MVLfPPHew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2] qtpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as module
In-Reply-To: <20200402193134.GC10314@linux.intel.com>
References: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com> <20200319195706.GD24804@linux.intel.com> <2BF66599-184A-4647-BC57-105A1512F119@linux.vnet.ibm.com> <20200402193134.GC10314@linux.intel.com>
Date:   Tue, 14 Apr 2020 10:51:37 +1000
Message-ID: <87k12ikhye.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> On Wed, Apr 01, 2020 at 02:40:30PM +0530, Sachin Sant wrote:
>> > On 20-Mar-2020, at 1:27 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>> > 
>> > On Wed, Mar 18, 2020 at 09:00:17PM -0400, Stefan Berger wrote:
>> >> From: Stefan Berger <stefanb@linux.ibm.com>
>> >> 
>> >> This patch fixes the following problem when the ibmvtpm driver
>> >> is built as a module:
>> >> 
>> >> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
>> >> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
>> >> make: *** [Makefile:1298: modules] Error 2
>> >> 
>> >> Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")
>> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> >> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> >> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> > 
>> 
>> Ping. This failure can now be seen in mainline (cad18da0af) as well.
>
> It is in my tree

Can you please send it to Linus?

cheers
