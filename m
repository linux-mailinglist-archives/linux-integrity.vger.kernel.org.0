Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4589EE75A1
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfJ1P45 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 11:56:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36340 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfJ1P45 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 11:56:57 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 282CA20F3BFA;
        Mon, 28 Oct 2019 08:56:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 282CA20F3BFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572278216;
        bh=0vTE/qkV4STG3iuGENrPgUCwQXT0AQDILjLoO16GOWg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lGKd8I/HWZ08jSVY9QbBMiIYNCiViY5cVGbBavRxR6xY9dCLaiIej2XLuZvXWnPSC
         PnA3SMOqatcRAaa1duOmX/7vsKWGFER7nVdRs2bjyGlUquYXvJE0I0Hypgh9Eup5tv
         LPtTp1jcbVutXmGfcjhYhb4Monjmc+PVnr7uvX70=
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure
 keys added to builtin_trusted_keys keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-4-nramas@linux.microsoft.com>
 <1572186810.4532.206.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0c81515a-0f0c-cec4-941f-3de4a8bc8a2c@linux.microsoft.com>
Date:   Mon, 28 Oct 2019 08:56:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572186810.4532.206.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/27/19 7:33 AM, Mimi Zohar wrote:

> Other examples of trusted keyrings are: .ima, .evm, .platform,
> .blacklist, .builtin_regdb_keys.  Instead of defining a keyring
> specific method of getting the keyring number, define a generic
> method.  For example, the userspace command "keyctl describe
> %keyring:.builtin_trusted_keys" searches /proc/keys, but the kernel
> shouldn't need to access /proc/keys.

"description" field in "struct key" is set to ".builtin_trusted_keys" 
for Built-In Trusted Keys keyring.

Similarly, for other keyrings such as .ima, .evm, .blacklist, 
.builtin_regdb_keys, etc.

 > # measure keys on the BUILTIN and IMA keyrings into a different PCR
 > measure func=KEYRING_CHECK keyring=".builtin_trusted_keys|.ima" pcr=11

With IMA policy set like above, the keyring to keyring number mapping 
can be set at IMA policy load.

My earlier point about mapping the "keyring" to "keyring number" at 
runtime (when the IMA hook is called) still needs to be done to know if 
the given keyring is in the policy or not.

void ima_post_key_create_or_update(struct key *keyring, struct key *key,
				   unsigned long flags, bool create)

thanks,
  -lakshmi
