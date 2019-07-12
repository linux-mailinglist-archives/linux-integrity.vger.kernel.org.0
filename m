Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2576671B9
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGLOzS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 10:55:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLOzS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 10:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jyTpDF2cJguc7T2D7cN+higCLbj4x3NEYIIGAv7Vb1k=; b=d5q+mx+54zYN9fEzyPrr6e6Vn
        P+OWHB81xK0z3+qq7SCsblGLnd3AIuBWLZO+8ZK/C8M7+LXeBC4T/0yyPKLV3LgbYMZD8LP42dMaR
        2IIM9M5Zqu+Xu0JxZE+MzZIeriI/CapP7cTjO3VdiTwIN94g44p8vVr9UhhFoOr4jZEuZcaBkvFl4
        18GFjroBpeu30gq9eVebugXvsVX+v7tn30COaNknA7ZlDAN8et9NsDu6ORa85NEDw4yG0fyHaHUq+
        mVtrXsEfzksrItP+jJcDlg+J5+GKIJhEsoH+ZoUqPRrYhqsg2Lez4SgIkNoFqDkcQpCSPaoVO4vjK
        r2N1yvaWA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlwxA-0008UU-2R; Fri, 12 Jul 2019 14:55:16 +0000
Subject: Re: [PATCH v3] tpm: Document UEFI event log quirks
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        jorhand@linux.microsoft.com, Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>
References: <20190712124912.23630-1-jarkko.sakkinen@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c974f53-6dca-33fd-5aca-056ab8b274ed@infradead.org>
Date:   Fri, 12 Jul 2019 07:55:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712124912.23630-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/12/19 5:49 AM, Jarkko Sakkinen wrote:
> There are some weird quirks when it comes to UEFI event log. Provide a
> brief introduction to TPM event log mechanism and describe the quirks
> and how they can be sorted out.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> v3: Add a section and use bullet list for references. Remove (invalid)
>     author info.
> v2: Fixed one type, adjusted the last paragraph and added the file

is that         typo  or type?

(one more below)

>     to index.rst
>  Documentation/security/tpm/index.rst         |  1 +
>  Documentation/security/tpm/tpm_event_log.rst | 55 ++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_event_log.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index 15783668644f..9e0815cb1e7f 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -4,5 +4,6 @@ Trusted Platform Module documentation
>  
>  .. toctree::
>  
> +   tpm_event_log
>     tpm_ftpm_tee
>     tpm_vtpm_proxy
> diff --git a/Documentation/security/tpm/tpm_event_log.rst b/Documentation/security/tpm/tpm_event_log.rst
> new file mode 100644
> index 000000000000..068eeb659bb9
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_event_log.rst
> @@ -0,0 +1,55 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +TPM Event Log
> +=============
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

[again:]                                                    Unfortunately,

> +the events generated by ExitBootServices() don't end up in the table.
> +
> +The firmware provides so called final events configuration table to sort
> +out this issue. Events gets mirrored to this table after the first time
> +EFI_TCG2_PROTOCOL.GetEventLog() gets called.
> +
> +This introduces another problem: nothing guarantees that it is not called
> +before the Linux EFI stub gets to run. Thus, it needs to calculate and save the
> +final events table size while the stub is still running to the custom
> +configuration table so that the TPM driver can later on skip these events when
> +concatenating two halves of the event log from the custom configuration table
> +and the final events table.
> +
> +References
> +==========
> +
> +- [1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> +- [2] The final concatenation is done in drivers/char/tpm/eventlog/efi.c
> 


-- 
~Randy
