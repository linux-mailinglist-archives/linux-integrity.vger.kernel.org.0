Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75011E21DC
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfJWRfA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 13:35:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfJWRfA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 13:35:00 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 77F5220106BE;
        Wed, 23 Oct 2019 10:34:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77F5220106BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571852099;
        bh=vqQGCbajvg6tqXYaZDPRkvd/epy9EBlB+JVvTXS6jQA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=j6z1WeObOALb27C7iDRzG4wPZqcwVGNUh1P4LtXHp+HGbkTypLgpORQIJ23yZaCQJ
         J7iqhkI5q75gg/uB+y/fKJBye0NhlgHGemY+oZRf0sL2UZSejk617HCbed5imFn7zr
         95TU5QubcPetP850MWP2G5mo2BOsafnXV2fwsF6A=
Subject: Re: [PATCH v1 5/6] KEYS: measure queued keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
 <20191023001818.3684-6-nramas@linux.microsoft.com>
 <1571836990.5104.96.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
Date:   Wed, 23 Oct 2019 10:34:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571836990.5104.96.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/23/19 6:23 AM, Mimi Zohar wrote:

> The ordering of this patch set is awkward.  It should first introduce
> a generic method for measuring keys based on the keyring.  Then add
> the additional support needed for the specific builtin_trusted_keys
> keyring usecase.

Would the following ordering of the patch set be acceptable:

  => PATCH 0/5: Cover letter

  => PATCH 1/5: Define the enum "hook(BUILTIN_TRUSTED_KEYS)" in ima.h

  => PATCH 2/5: Define ima hook
                This will initially do nothing if ima is not yet
                initialized.
                Call process_buffer_measurement() if ima is initialized.

  => PATCH 3/5: key_create_or_update change and the call to ima hook

  => PATCH 4/5: Queue\De-Queue of key measurement requests.
                Enable queuing of key in the ima hook if ima is not
                initialized.

  => PATCH 5/5: ima policy to enable measurement of keys which will
                enable end-to-end working of this feature.

thanks,
  -lakshmi
