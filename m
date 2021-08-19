Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62C23F2319
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhHSWaH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHSWaG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 18:30:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B605C061575;
        Thu, 19 Aug 2021 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=O+s8N+HuBQBiEOl3YX2aQaRweMse82grIvWCocQWrfQ=; b=BlMw8LgPuKcACOUqPXm7IugCUh
        iOgGH01JP/8OTXTxkFBcbOGhSQSdkyFE1yjFkAlpfMlzvdxtA3dgf4zaIOFrJquhfeVAQUGx7dgFz
        skXitLH+Sl4Qed0DYdPi/qbTw6uDJTozePKa2PjLVXM+T7dCVZ34dCMDV/SFdspZwfDcCqkqpxErO
        A7mnFFTGHA2Z4cYN3/J3tHI4thUTpCJ4fydTAYqjtY95TTyE85VnDS9F+WABaY80j9J+uW4FCIOJA
        IycNAWP9RX9IpFTAgG56gMJaVsiqLkt27gUEq50UQNgZKYlvPLwGyWtjw3j0kgdvZF/DqtmOODqsx
        NM3s6xZw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGqXQ-009eOW-Vy; Thu, 19 Aug 2021 22:29:29 +0000
Subject: Re: [PATCH v3 1/1] NAX LSM: Add initial support
To:     Igor Zhbanov <izh1979@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        linux-kernel@vger.kernel.org
References: <adc0e031-f02d-775c-1148-e808013c1b97@gmail.com>
 <3f7db609-6393-163f-287f-2211ed6239a5@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6def250e-b615-0543-69c8-4dce2ab0fdfe@infradead.org>
Date:   Thu, 19 Aug 2021 15:29:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3f7db609-6393-163f-287f-2211ed6239a5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi--

On 8/19/21 3:13 PM, Igor Zhbanov wrote:
> diff --git a/security/nax/Kconfig b/security/nax/Kconfig
> new file mode 100644
> index 000000000000..f0777cc38e17
> --- /dev/null
> +++ b/security/nax/Kconfig
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_NAX
> +	bool "NAX support"
> +	depends on SECURITY
> +	default n

'default n' is the default value and hence it is redundant.
We usually omit it.

> +	help
> +	  This selects NAX (No Anonymous Execution), which extends DAC
> +	  support with additional system-wide security settings beyond
> +	  regular Linux discretionary access controls. Currently, the only
> +	  available behavior is restricting the execution of anonymous and
> +	  modified pages.
> +
> +	  The module can restrict either privileged or all processes,
> +	  depending on the settings. It is possible to configure action,
> +	  performed when the violation is detected (log, log + block,
> +	  log + kill).
> +
> +	  Further information can be found in
> +	  Documentation/admin-guide/LSM/NAX.rst.
> +
> +	  If you are unsure how to answer this question, answer N.
> +
> +choice
> +	prompt "NAX violation action mode"
> +	default SECURITY_NAX_MODE_LOG
> +	depends on SECURITY_NAX
> +	help
> +	  Select the NAX violation action mode.
> +
> +	  In the default permissive mode the violations are only logged
> +	  (if logging is not suppressed). In the enforcing mode the violations
> +	  are prohibited. And in the kill mode the process is terminated.
> +
> +	  The value can be overridden at boot time with the kernel command-line
> +	  parameter "nax_mode=" (0, 1, 2) or "kernel.nax.mode=" (0, 1, 2)
> +	  sysctl parameter (if the settings are not locked).
> +
> +	config SECURITY_NAX_MODE_LOG
> +		bool "Permissive mode"
> +		help
> +		  In this mode violations are only logged (if logging is not
> +		  suppressed by the "kernel.nax.quiet" parameter). The
> +		  violating system call will not be prohibited.
> +	config SECURITY_NAX_MODE_ENFORCING
> +		bool "Enforcing mode"
> +		help
> +		  In this mode violations are prohibited and logged (if
> +		  logging is not suppressed by the "kernel.nax.quiet"
> +		  parameter). The violating system call will return -EACCES
> +		  error.
> +	config SECURITY_NAX_MODE_KILL
> +		bool "Kill mode"
> +		help
> +		  In this mode the violating process is terminated on the
> +		  first violation system call. The violation event is logged
> +		  (if logging is not suppressed by the "kernel.nax.quiet"
> +		  parameter).
> +endchoice
> +
> +config SECURITY_NAX_MODE
> +        int
> +        depends on SECURITY_NAX
> +        default 0 if SECURITY_NAX_MODE_LOG
> +        default 1 if SECURITY_NAX_MODE_ENFORCING
> +        default 2 if SECURITY_NAX_MODE_KILL
> +
> +config SECURITY_NAX_CHECK_ALL
> +	bool "Check all processes"
> +	depends on SECURITY_NAX
> +	help
> +	  If selected, NAX will check all processes. If not selected, NAX
> +	  will check only privileged processes (which is determined either
> +	  by having zero uid, euid, suid or fsuid; or by possessing
> +	  capabilities outside of allowed set).
> +
> +	  The value can also be overridden at boot time with the kernel
> +	  command-line parameter "nax_check_all=" (0, 1) or
> +	  "kernel.nax_check_all=" (0, 1) sysctl parameter (if the settings

	   kernel.nax.check_all ?

> +	  are not locked).
> +
> +config SECURITY_NAX_ALLOWED_CAPS
> +	hex "Process capabilities ignored by NAX"
> +	default 0x0
> +        range 0x0 0xffffffffffff

Indent above line with tab + 2 spaces instead of all spaces.

> +	depends on SECURITY_NAX
> +	help
> +	  Hexadecimal number representing the set of capabilities
> +	  a non-root process can possess without being considered
> +	  "privileged" by NAX LSM.
> +
> +	  The value can be overridden at boot time with the command-line
> +	  parameter "nax_allowed_caps=" or "kernel.nax.allowed_caps=" sysctl
> +	  parameter (if the settings are not locked).
> +
> +config SECURITY_NAX_QUIET
> +	bool "Silence NAX messages"
> +	depends on SECURITY_NAX
> +	help
> +	  If selected, NAX will not print violations.
> +
> +	  The value can be overridden at boot with the command-line
> +	  parameter "nax_quiet=" (0, 1) or "kernel.nax_quiet=" (0, 1) sysctl

	                                    kernel.nax.quiet

> +	  parameter (if the settings are not locked).
> +
> +config SECURITY_NAX_LOCKED
> +	bool "Lock NAX settings"
> +	depends on SECURITY_NAX
> +	help
> +	  Pevent any update to the settings of the NAX LSM. This applies to

	  Prevent

> +	  both sysctl writes and the kernel command line.
> +
> +	  If not selected, it can be enabled at boot time with the kernel
> +	  command-line parameter "nax_locked=1" or "kernel.nax_locked=1"

	                                            kernel.nax.locked

> +	  sysctl parameter (if the settings are not locked).


-- 
~Randy

