Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C33D8366
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfJOWQV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 18:16:21 -0400
Received: from namei.org ([65.99.196.166]:54404 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389268AbfJOWQV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 18:16:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9FMFdwG018373;
        Tue, 15 Oct 2019 22:15:39 GMT
Date:   Wed, 16 Oct 2019 09:15:39 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     James Morse <james.morse@arm.com>
cc:     prsriva <prsriva@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, zohar@linux.ibm.com,
        yamada.masahiro@socionext.com, duwe@lst.de, bauerman@linux.ibm.com,
        tglx@linutronix.de, allison@lohutok.net, ard.biesheuvel@linaro.org
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
Message-ID: <alpine.LRH.2.21.1910160914090.11167@namei.org>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com> <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com> <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com> <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 15 Oct 2019, James Morse wrote:

> > The IMA logs are event logs for module load time signature validation(based on policies)
> > which are backed by the TPM. No SecureBoot information is present in the log other than
> > the boot aggregate.
> 
> Okay, so SecureBoot is optional with this thing.

Correct. Verified boot is one alternative.


-- 
James Morris
<jmorris@namei.org>

