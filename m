Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA7FCD93
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNSam (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 13:30:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34982 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKNSam (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 13:30:42 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6DD0F20110C5;
        Thu, 14 Nov 2019 10:30:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DD0F20110C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573756241;
        bh=e34wBcGrkzium9S0nLXTM8zcP/I7IMpdThpV/SvpLXo=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=M42MiLqFiMb/kxpyHFHubuIHG1d4k97HJDOUGJ2iRF7z7rl1MmPhT11Jye515ar9u
         6m6yhmTvqsCDlLdkP1gpISLKpiPUnRdBA9YYvQduQ4sRJpTEkZGh7I40dzeEJOeWj+
         hPj3TIitM/qY0QN16gxwz9U6JnCW89ukk/hjIyA8=
Subject: Re: [PATCH v7 2/5] IMA: Define an IMA hook to measure keys
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-3-nramas@linux.microsoft.com>
Message-ID: <56718c81-86db-c72b-19b7-c563838838d6@linux.microsoft.com>
Date:   Thu, 14 Nov 2019 10:30:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114031202.18012-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/13/19 7:11 PM, Lakshmi Ramasubramanian wrote:

> The IMA hook is defined in a new file namely ima_asymmetric_keys.c
> which is built only if CONFIG_KEYS is enabled.

I think instead of CONFIG_KEYS I should use 
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE for ima_asymmetric_keys.c since 
this config is enabled only when both CONFIG_ASYMMETRIC_KEY_TYPE and 
CONFIG_KEYS are enabled.

Please see below taken from "crypto/asymmetric_keys/Kconfig"

# SPDX-License-Identifier: GPL-2.0
menuconfig ASYMMETRIC_KEY_TYPE
         bool "Asymmetric (public-key cryptographic) key type"
         depends on KEYS
         help
           This option provides support for a key type that holds the 
data for
           the asymmetric keys used for public key cryptographic 
operations such
           as encryption, decryption, signature generation and signature
           verification.

if ASYMMETRIC_KEY_TYPE

config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
         tristate "Asymmetric public-key crypto algorithm subtype"

endif # ASYMMETRIC_KEY_TYPE

thanks,
  -lakshmi
