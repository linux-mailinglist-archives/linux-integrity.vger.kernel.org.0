Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C505E975
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGCQp0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 12:45:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38366 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 12:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rpaCNZdtbwhwVN7hY9VZeOvZhvhLdEBGPEjtKH2aYAg=; b=WkQhINbqKZP35fqFn/9DS0Nppd
        tunzEg+4cywUqCx84mnosjqNuckYUAyC4VvwXd62Hix7AUhsaISWcNo+KnnkWVPf1sqPRhomcZQfD
        vRAmcDgQe4qzc2gkRlJ7eu6TJn1/vcSIzjXi18m54vNKwDVRN/bkjiZHb4rnC2YZ1uQ1npPnJzFIU
        baOM6/bbZbRJZmfmDf2Vl4Lz1BQMtKobo6+sWtWvvRjyW57KBXY3vwf9B7pRITeXOQSCjvpkZInxi
        3mG4Rq+AuPj6FxL8Wug3efYLk8K/Z5onN8Pp4NQrEMv52yMQzbta7qenJ6KGLDVHDIZTH9YSUlYXI
        RYTeRzYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiiNl-0008Kj-Fx; Wed, 03 Jul 2019 16:45:21 +0000
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6acf78df-b168-14d3-fea4-9a9d2945e77f@infradead.org>
Date:   Wed, 3 Jul 2019 09:45:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/3/19 9:11 AM, Jarkko Sakkinen wrote:
> There are some weird quirks when it comes to UEFI event log. Provide a
> brief introduction to TPM event log mechanism and describe the quirks
> and how they can be sorted out.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  Documentation/security/tpm/tpm-eventlog.rst | 53 +++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm-eventlog.rst
> 
> diff --git a/Documentation/security/tpm/tpm-eventlog.rst b/Documentation/security/tpm/tpm-eventlog.rst
> new file mode 100644
> index 000000000000..2ca8042bdb17
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm-eventlog.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +TPM Event Log
> +=============
> +
> +| Authors:
> +| Stefan Berger <stefanb@linux.vnet.ibm.com>
> +
> +This document briefly describes what TPM log is and how it is handed
> +over from the preboot firmware to the operating system.
> +
> +Introduction
> +============
> +
> +The preboot firmware maintains an event log that gets new entries every
> +time something gets hashed by it to any of the PCR registers. The events
> +are segregated by their type and contain the value of the hashed PCR
> +register. Typically, the preboot firmware will hash the components to
> +who execution is to be handed over or actions relevant to the boot
> +process.
> +
> +The main application for this is remote attestation and the reason why
> +it is useful is nicely put in the very first section of [1]:
> +
> +"Attestation is used to provide information about the platform’s state
> +to a challenger. However, PCR contents are difficult to interpret;
> +therefore, attestation is typically more useful when the PCR contents
> +are accompanied by a measurement log. While not trusted on their own,
> +the measurement log contains a richer set of information than do the PCR
> +contents. The PCR contents are used to provide the validation of the
> +measurement log."
> +
> +UEFI event log
> +==============
> +
> +UEFI provided event log has a few somewhat weird quirks.
> +
> +Before calling ExitBootServices() Linux EFI stub copies the event log to
> +a custom configuration table defined by the stub itself. Unfortanely,

                                                            Unfortunately,

> +the events generated by ExitBootServices() do end up to the table.
> +
> +The firmware provides so called final events configuration table to sort
> +out this issue. Events gets mirrored to this table after the first time
> +EFI_TCG2_PROTOCOL.GetEventLog() gets called.
> +
> +This introduces another problem: nothing guarantees that it is not
> +called before the stub gets to run. Thus, it needs to copy the final
> +events table preboot size to the custom configuration table so that
> +kernel offset it later on.

?  kernel can offset it later on.

> +
> +[1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> +[2] The final concatenation is done in drivers/char/tpm/eventlog/efi.c
> 


-- 
~Randy
